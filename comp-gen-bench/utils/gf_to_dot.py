#!/usr/bin/env python3
"""
Convert a GF abstract grammar (.gf) into a Graphviz DOT dependency graph.

Default behavior aims to be functionally identical to a hand-authored deps.dot:
- Categories are boxes (via node default) and printed on one line.
- Structural functions (arity >= 1):
  * unary with the same (result, arg) are grouped into a single edge with a
    combined label like "f1, f2, f3".
  * n-ary (n>=2): Result -> tiny point "fork" node labeled with function name,
    then fork -> each Arg (no arg labels). Secondary arg edges get
    [constraint=false] to avoid extra rank constraints. Fork node names are
    fork_<Result><N> (e.g., fork_B1), incrementing per result category.
- Lexical (arity 0, like e1 : E) are omitted by default to match deps.dot, but
  can be included with --include-lexical as circle nodes and edges
  ResultCategory -> lexicalNode labeled with the name.

Usage:
  python gf_to_dot.py Abstract.gf -o Abstract-deps2.dot
  # include lexical constants
  python gf_to_dot.py Abstract.gf -o Abstract-deps2.dot --include-lexical
"""
from __future__ import annotations
import argparse
import re
import sys
from typing import Dict, List, Tuple, Iterable, DefaultDict
from collections import defaultdict, OrderedDict

Decl = Tuple[List[str], List[str], str]
# (names, args, result)

COMMENT_RE = re.compile(r"--.*$")
CAT_START_RE = re.compile(r"\bcat\b")
DATA_START_RE = re.compile(r"\bdata\b")
IDENT_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")


def strip_comments(line: str) -> str:
    return COMMENT_RE.sub("", line)


def parse_gf(path: str) -> Tuple[List[str], List[Decl]]:
    with open(path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    in_cat = False
    in_data = False

    cats: List[str] = []
    decls: List[Decl] = []

    # We'll accumulate statements across lines until ';'
    stmt = ""

    for raw in lines:
        line = strip_comments(raw).strip()
        if not line:
            continue

        # Section state tracking
        if line.endswith("{") or line.startswith("abstract "):
            continue
        if CAT_START_RE.search(line):
            in_cat, in_data = True, False
            continue
        if DATA_START_RE.search(line):
            in_cat, in_data = False, True
            continue
        if line == "}":
            in_cat = in_data = False
            continue

        if in_cat:
            # Expect lines like: A ; or multiple separated by ';'
            parts = [p.strip() for p in line.split(";")]
            for p in parts:
                if not p:
                    continue
                tok = p.split()[0]
                if IDENT_RE.match(tok):
                    cats.append(tok)
            continue

        if in_data:
            stmt += (" " + line)
            while ";" in stmt:
                one, stmt = stmt.split(";", 1)
                one = one.strip()
                if not one:
                    continue
                if ":" not in one:
                    continue
                names_part, type_part = map(str.strip, one.split(":", 1))
                if not names_part or not type_part:
                    continue
                names = [n.strip() for n in names_part.split(",") if n.strip()]
                type_tokens = [t.strip() for t in type_part.split("->") if t.strip()]
                if not type_tokens:
                    continue
                result = type_tokens[-1]
                args = type_tokens[:-1]
                decls.append((names, args, result))

    # Deduplicate categories while preserving order
    seen = set()
    cats_unique = []
    for c in cats:
        if c not in seen:
            seen.add(c)
            cats_unique.append(c)

    return cats_unique, decls


def id_or_quote(s: str) -> str:
    # Use bare identifiers for simple names to match hand-written DOT
    return s if IDENT_RE.match(s) else '"' + s.replace('"', '\\"') + '"'


def write_dot(cats: List[str], decls: List[Decl], out: Iterable[str], include_lexical: bool) -> None:
    w = out.write
    w("digraph AbstractDeps {\n")
    w("  rankdir=LR;\n")
    w("  graph [fontname=\"Helvetica\"];\n")
    w("  node [shape=box, fontname=\"Helvetica\"];\n")
    w("  edge [fontname=\"Helvetica\"];\n\n")

    # Categories in a single line, like: A; B; C; ...
    w("  // Categories\n")
    if cats:
        w("  " + "; ".join(id_or_quote(c) for c in cats) + ";\n\n")
    else:
        w("\n")

    # Accumulate unary edges by (res,arg) preserving insertion order
    unary_labels: Dict[Tuple[str, str], List[str]] = OrderedDict()

    # Collect multi-arg decls grouped by (res, tuple(args)) preserving order
    multi_groups: "OrderedDict[Tuple[str, Tuple[str, ...]], List[Tuple[str, List[str]]]]" = OrderedDict()

    # Optional lexical
    lex: List[Tuple[str, str]] = []  # (name, res)

    for names, args, res in decls:
        arity = len(args)
        if arity == 0:
            if include_lexical:
                for name in names:
                    lex.append((name, res))
            continue
        if arity == 1:
            key = (res, args[0])
            labels = unary_labels.setdefault(key, [])
            labels.extend(names)
            continue
        # n-ary
        key = (res, tuple(args))
        lst = multi_groups.setdefault(key, [])
        for name in names:
            lst.append((name, args))

    # Write grouped unary edges in insertion order
    for (res, arg), labels in unary_labels.items():
        label_str = ", ".join(labels)
        w(f"  {id_or_quote(res)} -> {id_or_quote(arg)} [label=\"{label_str}\"];\n")

    if unary_labels:
        w("\n")

    # N-ary constructors section with comments per signature
    if multi_groups:
        w("  // Binary constructors as forked arrows (use tiny point nodes)\n")
    # per-result counters for fork node names
    per_res_counter: Dict[str, int] = defaultdict(int)

    for (res, args_sig), items in multi_groups.items():
        # Comment like: // B <- C C (two constructors)
        constructors_count = len(items)
        arglist = " ".join(args_sig)
        plural = "constructor" if constructors_count == 1 else "constructors"
        w(f"  // {res} <- {arglist} ({constructors_count} {plural})\n")
        for name, args in items:
            per_res_counter[res] += 1
            fork = f"fork_{res}{per_res_counter[res]}"
            w(f"  {id_or_quote(fork)} [shape=point, width=0.01, height=0.01, label=\"\"];\n")
            w(f"  {id_or_quote(res)} -> {id_or_quote(fork)} [label=\"{name}\"];\n")
            for i, a in enumerate(args):
                if i == 0:
                    w(f"  {id_or_quote(fork)} -> {id_or_quote(a)};\n")
                else:
                    w(f"  {id_or_quote(fork)} -> {id_or_quote(a)} [constraint=false];\n")
            w("\n")

    # Lexical constants (optional)
    if include_lexical and lex:
        for name, res in lex:
            lex_node = f"lex_{name}"
            w(f"  {id_or_quote(lex_node)} [shape=circle, label=\"{name}\"];\n")
            w(f"  {id_or_quote(res)} -> {id_or_quote(lex_node)} [label=\"{name}\"];\n")
        w("\n")

    w("}\n")


def main(argv: List[str]) -> int:
    ap = argparse.ArgumentParser(description="Convert GF abstract grammar to Graphviz DOT dependency graph")
    ap.add_argument("input", help="Path to .gf file")
    ap.add_argument("-o", "--output", help="Path to write .dot (defaults to stdout)")
    ap.add_argument("--include-lexical", action="store_true", help="Include lexical constants (arity 0) as circle nodes")
    args = ap.parse_args(argv)

    cats, decls = parse_gf(args.input)

    if args.output:
        with open(args.output, "w", encoding="utf-8") as f:
            write_dot(cats, decls, f, include_lexical=args.include_lexical)
    else:
        write_dot(cats, decls, sys.stdout, include_lexical=args.include_lexical)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
