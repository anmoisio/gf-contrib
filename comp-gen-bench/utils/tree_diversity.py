from __future__ import annotations

import argparse
import json
from collections import OrderedDict
from dataclasses import dataclass, field
from pathlib import Path

from nltk import Tree


@dataclass
class NodeStats:
    label: str
    count: int = 0
    positions: list[OrderedDict[str, "NodeStats"]] = field(default_factory=list)

    def ensure_position(self, index: int) -> OrderedDict[str, "NodeStats"]:
        """Ensure a child position dict exists at index and return it."""
        while len(self.positions) <= index:
            self.positions.append(OrderedDict())
        return self.positions[index]

    def to_value(self):
        """Return a compact representation: count or {count, args} if children exist."""
        if not self.positions:
            return self.count
        args = [
            OrderedDict(
                (child_label, child_stats.to_value())
                for child_label, child_stats in position.items()
            )
            for position in self.positions
        ]
        return OrderedDict([("count", self.count), ("args", args)])

    def to_dict(self) -> OrderedDict[str, object]:
        """Return a full ordered mapping for this node: label -> count and optional args."""
        data: OrderedDict[str, object] = OrderedDict([(self.label, self.count)])
        if self.positions:
            data["args"] = [
                OrderedDict(
                    (child_label, child_stats.to_value())
                    for child_label, child_stats in position.items()
                )
                for position in self.positions
            ]
        return data


def ingest_tree(tree: Tree, stats: NodeStats) -> None:
    """Accumulate frequencies from an NLTK Tree into the mutable NodeStats hierarchy."""
    stats.count += 1
    for index, child in enumerate(tree):
        position = stats.ensure_position(index)
        if isinstance(child, Tree):
            child_stats = position.get(child.label())
            if child_stats is None:
                child_stats = NodeStats(child.label())
                position[child.label()] = child_stats
            ingest_tree(child, child_stats)
        else:
            leaf_stats = position.get(child)
            if leaf_stats is None:
                leaf_stats = NodeStats(child)
                position[child] = leaf_stats
            leaf_stats.count += 1


def build_tree_stats(trees: list[Tree]) -> list[OrderedDict[str, object]]:
    """Build ordered frequency stats per root label across a list of Trees."""
    roots: OrderedDict[str, NodeStats] = OrderedDict()
    for tree in trees:
        root_stats = roots.get(tree.label())
        if root_stats is None:
            root_stats = NodeStats(tree.label())
            roots[tree.label()] = root_stats
        ingest_tree(tree, root_stats)
    return [stats.to_dict() for stats in roots.values()]


def read_trees(path: Path, root_labels: list[str] | None = None) -> list[Tree]:
    """Read one parse per line, optionally filter by root labels, and parse into Trees."""
    with path.open("r", encoding="utf-8") as fh:
        lines = [line.strip() for line in fh if line.strip()]
    if root_labels:
        lines = [
            line
            for line in lines
            if any(line.startswith(label) for label in root_labels)
        ]
    return [Tree.fromstring(f"({line})") for line in lines]


def reverse_index(stats: list[OrderedDict[str, object]]) -> OrderedDict[str, OrderedDict[str, int]]:
    """Return label -> parent label -> frequency by walking the stats structure."""

    parents: OrderedDict[str, OrderedDict[str, int]] = OrderedDict()

    for label, count, _, ancestors in _walk_stats(stats):
        parent_label = ancestors[-1] if ancestors else None
        if parent_label is not None:
            entry = parents.setdefault(label, OrderedDict())
            entry[parent_label] = entry.get(parent_label, 0) + count

    return parents


def parent_frequencies(tree_stats: list[OrderedDict[str, object]], label: str) -> OrderedDict[str, int]:
    """Lookup ordered parent frequencies for a given child label from tree stats."""
    return reverse_index(tree_stats).get(label, OrderedDict())


def reverse_ancestor_index(
    stats: list[OrderedDict[str, object]]
) -> OrderedDict[str, OrderedDict[str, int]]:
    """
    Return a mapping: child label -> ancestor label -> frequency.

    Walks the aggregated stats produced by build_tree_stats and, for each node,
    adds its count to the frequency of all ancestors along the path up to the root.
    """

    ancestors_map: OrderedDict[str, OrderedDict[str, int]] = OrderedDict()

    for label, count, _, ancestors in _walk_stats(stats):
        if ancestors:
            entry = ancestors_map.setdefault(label, OrderedDict())
            for ancestor in ancestors:
                entry[ancestor] = entry.get(ancestor, 0) + count

    return ancestors_map


def ancestor_frequencies(
    tree_stats: list[OrderedDict[str, object]],
    label: str,
) -> OrderedDict[str, int]:
    """
    Lookup ordered ancestor (recursive parent) frequencies for a given child label.

    Returns an OrderedDict mapping each ancestor label to the number of times it
    appears on any path from the given label up to a root across all trees.
    """
    return reverse_ancestor_index(tree_stats).get(label, OrderedDict())


def reverse_ancestor_lineages(
    stats: list[OrderedDict[str, object]]
) -> OrderedDict[str, OrderedDict[tuple[str, ...], int]]:
    """
    Return mapping: child label -> (ancestor lineage tuple to root) -> frequency.

    A lineage is an ordered tuple of ancestor labels starting from the direct parent
    up to the root (e.g., (Parent, GrandParent, Root)). Counts are aggregated per
    distinct lineage.
    """

    lineage_map: OrderedDict[str, OrderedDict[tuple[str, ...], int]] = OrderedDict()

    for label, count, _, ancestors in _walk_stats(stats):
        if ancestors:
            entry = lineage_map.setdefault(label, OrderedDict())
            lineage = tuple(ancestors)
            entry[lineage] = entry.get(lineage, 0) + count

    return lineage_map


def _walk_stats(
    stats: list[OrderedDict[str, object]],
):
    """
    Yield (label, count, args, ancestors) for every node in the aggregated stats.

    - label: current node label
    - count: frequency of the current node
    - args: list of child positions (each an OrderedDict child_label -> child_value)
    - ancestors: list of ancestor labels from parent up to root
    """

    def walk(label: str, value: object, ancestor_chain: list[str]):
        if isinstance(value, dict):
            count = int(value.get("count", 0))
            args = value.get("args", [])
        else:
            count = int(value)
            args = []

        # Yield this node
        yield label, count, args, ancestor_chain

        # Recurse into children, extending the ancestor chain with current label
        for position in args:
            for child_label, child_value in position.items():
                # Delegate recursion and yield child's results
                yield from walk(child_label, child_value, ancestor_chain + [label])

    # Each root entry in stats is an OrderedDict like {label: count, 'args': [...]}.
    for entry in stats:
        root_label = None
        root_count = None
        for key, value in entry.items():
            if key == "args":
                continue
            root_label = key
            root_count = value
            break
        if root_label is None or root_count is None:
            continue
        args = entry.get("args", [])
        value: object
        if args:
            value = {"count": root_count, "args": args}
        else:
            value = root_count
        # Root has no ancestors
        yield from walk(root_label, value, [])


def ancestor_lineages(
    tree_stats: list[OrderedDict[str, object]],
    label: str,
) -> list[tuple[list[str], int]]:
    """
    Get distinct ancestor lineages for a label with their aggregated frequencies.

    Returns a list of pairs (lineage, count) where lineage is a list of labels
    from parent up to root. The list preserves insertion order by discovery.
    """
    paths = reverse_ancestor_lineages(tree_stats).get(label, OrderedDict())
    return [ (list(lineage), count) for lineage, count in paths.items() ]


def _normalize_stats_value(value: object) -> dict:
    if isinstance(value, dict):
        count = int(value.get("count", 0))
        args = value.get("args", [])
        if not isinstance(args, list):
            args = []
        return {"count": count, "args": args}
    return {"count": int(value), "args": []}


def _merge_stats_values(dest: object | None, src: object) -> object:
    if dest is None:
        return src
    d_norm = _normalize_stats_value(dest)
    s_norm = _normalize_stats_value(src)
    merged_count = d_norm["count"] + s_norm["count"]
    d_args = d_norm["args"]
    s_args = s_norm["args"]
    if not d_args and not s_args:
        return merged_count
    max_len = max(len(d_args), len(s_args))
    merged_args: list[OrderedDict[str, object]] = []
    for idx in range(max_len):
        pos_map: OrderedDict[str, object] = OrderedDict()
        d_pos = d_args[idx] if idx < len(d_args) else OrderedDict()
        s_pos = s_args[idx] if idx < len(s_args) else OrderedDict()
        for child_label, child_val in d_pos.items():
            pos_map[child_label] = child_val
        for child_label, child_val in s_pos.items():
            if child_label in pos_map:
                pos_map[child_label] = _merge_stats_values(pos_map[child_label], child_val)
            else:
                pos_map[child_label] = child_val
        merged_args.append(pos_map)
    return OrderedDict([("count", merged_count), ("args", merged_args)])


def _compact_stats_value(value: object) -> object:
    if isinstance(value, dict):
        count = value.get("count", 0)
        args = value.get("args", [])
        if not args:
            return int(count)
        new_args: list[OrderedDict[str, object]] = []
        for position in args:
            new_args.append(OrderedDict((cl, _compact_stats_value(cv)) for cl, cv in position.items()))
        return OrderedDict([("count", int(count)), ("args", new_args)])
    return value


def descendant_frequencies(
    tree_stats: list[OrderedDict[str, object]],
    label: str,
    arg: int,
) -> OrderedDict[str, object]:
    """
    Return merged recursive frequency distributions of all child trees appearing
    at argument position 'arg' (0-based) of nodes with the given label.

    For example, descendant_frequencies(tree_stats, 'ComplV2', arg=1) returns an
    OrderedDict mapping each child label (occurring as the second argument of any
    'ComplV2' node) to either an int count (if leaf) or a dict with keys
    'count' and 'args' recursively describing its subtree distributions.
    """

    # Aggregated mapping: child_label -> merged value (int or {count, args})
    aggregated: OrderedDict[str, object] = OrderedDict()

    def normalize(value: object) -> dict:
        """Return dict form {count:int, args:list} for any value (int or nested dict)."""
        if isinstance(value, dict):
            count = int(value.get("count", 0))
            args = value.get("args", [])
            # Ensure args is list
            if not isinstance(args, list):
                args = []
            return {"count": count, "args": args}
        else:
            return {"count": int(value), "args": []}

    def merge_values(dest: object | None, src: object) -> object:
        """Merge two values (int or dict-with-count/args) recursively."""
        if dest is None:
            # Return src as-is
            return src
        d_norm = normalize(dest)
        s_norm = normalize(src)
        merged_count = d_norm["count"] + s_norm["count"]
        d_args = d_norm["args"]
        s_args = s_norm["args"]
        # If both have no children, return int
        if not d_args and not s_args:
            return merged_count
        # Merge args position-wise
        max_len = max(len(d_args), len(s_args))
        merged_args: list[OrderedDict[str, object]] = []
        for idx in range(max_len):
            pos_map: OrderedDict[str, object] = OrderedDict()
            d_pos = d_args[idx] if idx < len(d_args) else OrderedDict()
            s_pos = s_args[idx] if idx < len(s_args) else OrderedDict()
            # Preserve insertion order: first dest, then any new from src
            for child_label, child_val in d_pos.items():
                pos_map[child_label] = child_val
            for child_label, child_val in s_pos.items():
                if child_label in pos_map:
                    pos_map[child_label] = merge_values(pos_map[child_label], child_val)
                else:
                    pos_map[child_label] = child_val
            merged_args.append(pos_map)
        # Build merged dict (always in normalized form), then compact if leafless
        compact_args = merged_args
        if not compact_args:
            return merged_count
        return OrderedDict([
            ("count", merged_count),
            ("args", compact_args),
        ])

    # Walk stats and collect occurrences of the target label
    for node_label, _node_count, node_args, _ancestors in _walk_stats(tree_stats):
        if node_label != label:
            continue
        if arg < 0 or arg >= len(node_args):
            continue  # position doesn't exist
        position_map: OrderedDict[str, object] = node_args[arg]
        for child_label, child_value in position_map.items():
            aggregated[child_label] = _merge_stats_values(aggregated.get(child_label), child_value)

    return OrderedDict(
        (child_label, _compact_stats_value(child_val))
        for child_label, child_val in aggregated.items()
    )


def child_frequencies(
    tree_stats: list[OrderedDict[str, object]],
    label: str,
    arg: int,
) -> OrderedDict[str, int]:
    """Return frequency distribution of direct child labels at argument position 'arg' of 'label'.

    Aggregates only the immediate children's own counts (ignoring their descendants) across
    all occurrences of nodes with the given label. If the argument position doesn't exist
    for an occurrence it is skipped.
    """
    dist: OrderedDict[str, int] = OrderedDict()
    for node_label, _count, node_args, _ancestors in _walk_stats(tree_stats):
        if node_label != label:
            continue
        if arg < 0 or arg >= len(node_args):
            continue
        position_map: OrderedDict[str, object] = node_args[arg]
        for child_label, child_value in position_map.items():
            if isinstance(child_value, dict):
                child_count = int(child_value.get("count", 0))
            else:
                child_count = int(child_value)
            dist[child_label] = dist.get(child_label, 0) + child_count
    return dist


def sibling_frequencies(
    tree_stats: list[OrderedDict[str, object]],
    label: str,
) -> OrderedDict[str, object]:
    """Aggregate descendant frequencies for siblings of LABEL under any shared parent."""
    aggregated: OrderedDict[str, object] = OrderedDict()
    for _node_label, _count, node_args, _ancestors in _walk_stats(tree_stats):
        if not node_args:
            continue
        positions_with_label = {
            idx for idx, position_map in enumerate(node_args) if label in position_map
        }
        if not positions_with_label:
            continue
        for idx, position_map in enumerate(node_args):
            if idx in positions_with_label:
                continue
            for sibling_label, sibling_value in position_map.items():
                aggregated[sibling_label] = _merge_stats_values(
                    aggregated.get(sibling_label), sibling_value
                )
    return OrderedDict(
        (sibling_label, _compact_stats_value(value))
        for sibling_label, value in aggregated.items()
    )


def get_all_subtrees(tree: Tree) -> list[str]:
    """
    Return a list of string representations of all subtrees in the given tree.
    """
    subtrees = []
    for subtree in tree.subtrees():
        s = subtree.pformat(margin=float("inf"))
        if s.startswith("(") and s.endswith(")"):
            s = s[1:-1]
        subtrees.append(s)
        for child in subtree:
            if not isinstance(child, Tree):
                subtrees.append(str(child))
    return subtrees


def aggregate_subtrees(trees: list[Tree]) -> OrderedDict[str, int]:
    """
    Aggregate all subtrees from a list of trees into a frequency counter.
    """
    counter: OrderedDict[str, int] = OrderedDict()
    for tree in trees:
        for subtree in get_all_subtrees(tree):
            counter[subtree] = counter.get(subtree, 0) + 1
    return OrderedDict(sorted(counter.items(), key=lambda item: item[1], reverse=True))


def _tree_to_string(t: Tree | str) -> str:
    if isinstance(t, Tree):
        s = t.pformat(margin=float("inf"))
        if s.startswith("(") and s.endswith(")"):
            return s[1:-1]
        return s
    return str(t)


def aggregate_supertrees(trees: list[Tree]) -> OrderedDict[str, OrderedDict[str, int]]:
    """
    Aggregate supertrees for every subtree found in the list of trees.
    Returns mapping: subtree -> supertree -> count.
    """
    mapping: OrderedDict[str, OrderedDict[str, int]] = OrderedDict()

    for tree in trees:
        for subtree in tree.subtrees():
            parent_str = _tree_to_string(subtree)
            for child in subtree:
                if isinstance(child, Tree):
                    child_str = _tree_to_string(child)
                    if child_str not in mapping:
                        mapping[child_str] = OrderedDict()
                    mapping[child_str][parent_str] = mapping[child_str].get(parent_str, 0) + 1

    for subtree in mapping:
        mapping[subtree] = OrderedDict(sorted(mapping[subtree].items(), key=lambda item: item[1], reverse=True))

    return OrderedDict(sorted(mapping.items()))


def print_all_labels(tree_stats: list[OrderedDict[str, object]]) -> None:
    """Print every unique label encountered in tree_stats in discovery order."""
    seen: OrderedDict[str, None] = OrderedDict()
    for label, _count, _args, _ancestors in _walk_stats(tree_stats):
        if label not in seen:
            seen[label] = None
    for label in seen:
        print(label)


def main() -> None:
    """CLI entry point: read trees, build stats, print JSON, and a sample parent map."""
    parser = argparse.ArgumentParser(description="Compute child label diversity counts from GF parse trees.")
    parser.add_argument(
        "input",
        nargs="?",
        default=Path(__file__).resolve().parents[1] / "cogs-rgl" / "parsed-cogs-train-LangEng.txt.01",
        type=Path,
        help="Path to the file that contains one tree per line (default: parsed-cogs-train-LangEng.txt.01)",
    )
    parser.add_argument(
        "--root",
        dest="root_labels",
        nargs="+",
        default=["UseCl"],
        help="Keep only lines that start with one of these labels (default: UseCl). Pass an empty string to disable.",
    )
    parser.add_argument(
        "--no-filter",
        action="store_true",
        help="Do not filter by the root label; process every non-empty line.",
    )
    parser.add_argument(
        "--indent",
        type=int,
        default=2,
        help="Pretty-print JSON with the given indentation (default: 2).",
    )
    parser.add_argument(
        "--ts",
        action="store_true",
        help="Print the aggregated tree stats (TS = tree stats).",
    )
    parser.add_argument(
        "--pf",
        metavar="LABEL",
        action="append",
        default=[],
        help="Print parent frequencies for LABEL (PF = parent frequencies).",
    )
    parser.add_argument(
        "--af",
        metavar="LABEL",
        action="append",
        default=[],
        help="Print ancestor frequencies for LABEL (AF = ancestor frequencies).",
    )
    parser.add_argument(
        "--al",
        metavar="LABEL",
        action="append",
        default=[],
        help="Print ancestor lineages for LABEL (AL = ancestor lineages).",
    )
    parser.add_argument(
        "--cf",
        metavar=("LABEL", "ARG"),
        nargs=2,
        action="append",
        default=[],
        help="Print child frequencies for LABEL at argument index ARG (CF = child frequencies).",
    )
    parser.add_argument(
        "--df",
        metavar=("LABEL", "ARG"),
        nargs=2,
        action="append",
        default=[],
        help="Print descendant frequencies for LABEL at argument index ARG (DF = descendant frequencies).",
    )
    parser.add_argument(
        "--ls",
        action="store_true",
        help="Print the unique label set (LS = labels).",
    )
    parser.add_argument(
        "--sf",
        metavar="LABEL",
        action="append",
        default=[],
        help="Print sibling frequencies for LABEL (SF = sibling frequencies).",
    )
    parser.add_argument(
        "--subtrees",
        action="store_true",
        help="Print all subtrees for each tree.",
    )
    parser.add_argument(
        "--aggregated-subtrees",
        action="store_true",
        help="Print aggregated subtree counts.",
    )
    parser.add_argument(
        "--aggregated-supertrees",
        action="store_true",
        help="Print aggregated supertree counts (subtree -> supertree -> count).",
    )
    args = parser.parse_args()

    cf_requests = [(label, int(arg)) for label, arg in args.cf]
    df_requests = [(label, int(arg)) for label, arg in args.df]
    sf_requests = args.sf

    root_labels = None if args.no_filter else args.root_labels
    if root_labels == [""]:
        root_labels = None

    trees = read_trees(args.input, root_labels)
    print(f"{len(trees)} trees read from {args.input}")

    tree_stats = build_tree_stats(trees)

    def emit_json(title: str, payload: object) -> None:
        print(title)
        print(json.dumps(payload, indent=args.indent))

    if args.ts:
        emit_json("tree_stats", tree_stats)

    for label in args.pf:
        emit_json(f"parent_frequencies[{label}]", parent_frequencies(tree_stats, label))

    for label in args.af:
        emit_json(f"ancestor_frequencies[{label}]", ancestor_frequencies(tree_stats, label))

    for label in args.al:
        emit_json(f"ancestor_lineages[{label}]", ancestor_lineages(tree_stats, label))

    for label, arg_idx in cf_requests:
        emit_json(
            f"child_frequencies[{label}][{arg_idx}]",
            child_frequencies(tree_stats, label, arg_idx),
        )

    for label, arg_idx in df_requests:
        emit_json(
            f"descendant_frequencies[{label}][{arg_idx}]",
            descendant_frequencies(tree_stats, label, arg_idx),
        )

    for label in sf_requests:
        emit_json(
            f"sibling_frequencies[{label}]",
            sibling_frequencies(tree_stats, label),
        )

    if args.ls:
        print_all_labels(tree_stats)

    if args.subtrees:
        emit_json("all_subtrees", [get_all_subtrees(tree) for tree in trees])

    if args.aggregated_subtrees:
        emit_json("aggregated_subtrees", aggregate_subtrees(trees))

    if args.aggregated_supertrees:
        emit_json("aggregated_supertrees", aggregate_supertrees(trees))

    if not any([args.ts, args.pf, args.af, args.al, args.ls, sf_requests, cf_requests, df_requests, args.subtrees, args.aggregated_subtrees, args.aggregated_supertrees]):
        print("No statistics requested; use --ts, --pf, --af, --al, --ls, --sf, --cf, --df, --subtrees, --aggregated-subtrees, or --aggregated-supertrees.")


if __name__ == "__main__":
    main()
