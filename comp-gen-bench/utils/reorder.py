"""Reorder conjuncts in the logical form."""
import argparse
from cogs_lexicon import verbs_lemmas

def getwordidx2var(sent_, presupvars_, assertsvars_):
    wordidx2var_ = {}
    used_vars = set()
    for idx, word in enumerate(sent_.split(' ')):
        if word == 'TV':
            word = 'tv'
        for presupname, _, vars in presupvars_:
            # common nouns with definite article
            if word == presupname and vars[0] not in used_vars:
                wordidx2var_[idx] = vars[0]
                used_vars.add(vars[0])
                break
        for assertname, _, vars in assertsvars_:
            # verbs and common nouns with indefinite article
            if (word == assertname or word in verbs_lemmas and verbs_lemmas[word] == assertname) \
                    and vars[0] not in used_vars:
                if idx not in wordidx2var_:
                    wordidx2var_[idx] = vars[0]
                    used_vars.add(vars[0])
                    break
            # proper names
            elif len(vars) > 1 and word == vars[1] and vars[1] not in used_vars:
                if idx not in wordidx2var_:
                    wordidx2var_[idx] = vars[1]
                    used_vars.add(vars[1])
                    break
    wordidx2var_ = dict(sorted(wordidx2var_.items(), key=lambda item: item[0]))
    return wordidx2var_

parser = argparse.ArgumentParser()
parser.add_argument("--input_file", type=str, default='cogs-from-orig/orig-data/dev.tsv')
parser.add_argument("--gold_file", type=str, default='cogs-from-orig/orig-data/dev.tsv')
parser.add_argument("--format", type=str, choices=['cogs', 'gf'], default='cogs')
parser.add_argument("--varnames", type=str, choices=['wordindex'], default='wordindex')
parser.add_argument("--order", type=str, choices=['cogs'], default='cogs')
parser.add_argument("--output_file", type=str)
args = parser.parse_args()

# read the gold standard
gold_sents_and_lf = []
with open(args.gold_file, 'r', encoding='utf-8') as f:
    for line in f.readlines():
        gold_sents_and_lf.append(line.split('\t'))

# read the data processed by GF
sents_and_lf = []
syntax_semantics = []
if args.format == 'cogs':
    with open(args.input_file, 'r', encoding='utf-8') as f:
        for line in f.readlines():
            sents_and_lf.append(line.split('\t'))
elif args.format == 'gf':
    with open(args.input_file, 'r', encoding='utf-8') as f:
        text = f.read()
    sent_blocks = text.split('sentence: ')
    for i, block in enumerate(sent_blocks):
        if not block.strip():
            continue
        sent = block.splitlines()[0]
        block = block[len(sent):].strip()
        sent = sent.strip()
        treeblocks = block.split('tree: ')
        for treeblock in treeblocks:
            if not treeblock.strip():
                continue
            tree_interp_lin = treeblock.split("interpretation and linearisation:\n")
            tree = tree_interp_lin[0].strip()
            interp_lin = tree_interp_lin[1].split('\n\n')
            if len(interp_lin) < 2:
                continue
            if len(interp_lin) > 2 and any(l.strip() for l in interp_lin[2:]): 
                print("Expected 2 parts after 'interpretation and linearisation',")
                print(f"got {len(interp_lin)} in block:\n{treeblock}")
            interpreted, linearised = [l.strip() for l in interp_lin][:2]

            linearised = linearised.split(' AND Anteriority')[0].strip() # todo: remove

            sents_and_lf.append((i, sent, linearised))
            syntax_semantics.append((i, tree, interpreted, linearised))
else:
    raise ValueError(f"Unknown format: {args.format}")


data = {}
for line_number, sent, lf in sents_and_lf:
    if not lf.strip():
        continue
    presups = [p.strip() for p in lf.split(';')[:-1]]
    asserts = [p.strip() for p in lf.split(';')[-1].split('AND')]
    assertsvars = []
    for a in asserts:
        splitted = a.split('(')
        predicate = splitted[0].split('.')[0].split('(')[0].strip()

        if predicate == 'TV':
            predicate = 'tv'

        vars = [v.replace('x _ ','').strip() for v in splitted[1].replace(')','').split(',')]
        assertsvars.append((predicate, a, vars))

    presupvars = []
    for p in presups:
        splitted = p.split('(')
        predicate = splitted[0].split('.')[0].split('(')[0].replace('*','').strip()

        if predicate == 'TV':
            predicate = 'tv'

        vars = [v.replace('x _ ','').strip() for v in splitted[1].replace(')','').split(',')]
        presupvars.append((predicate, p, vars))

    wordidx2var = getwordidx2var(sent, presupvars, assertsvars)
    var2wordidx = {v: str(k) for k, v in wordidx2var.items()}

    

    # change the variable names
    assertvars_orig = assertsvars
    assertsvars = []
    presupvars_orig = presupvars
    presupvars = []
    if args.varnames == 'wordindex':
        for assertname, a, vars in assertvars_orig:
            new_vars = []
            for v in vars:
                if v not in var2wordidx:
                    print(f"Warning: variable {v} not found in sentence '{sent}' with lf '{lf}'")
                    print(var2wordidx)
                    new_vars.append(v)
                    continue
                if v.startswith("v"):
                    a = a.replace(f" {v} ", f" x _ {var2wordidx[v]} ")
                    new_vars.append(v.replace(v, f"x _ {var2wordidx[v]}"))
                else:
                    new_vars.append(v)
            assertsvars.append((assertname, a, new_vars))

        for presupname, p, vars in presupvars_orig:
            new_vars = []
            for v in vars:
                if v.startswith("v"):
                    p = p.replace(f" {v} ", f" x _ {var2wordidx[v]} ")
                    new_vars.append(v.replace(v, f"x _ {var2wordidx[v]}"))
                else:
                    new_vars.append(v)
            presupvars.append((presupname, p, new_vars))

        wordidx2var_new = {k: f"x _ {k}" for k in wordidx2var.keys()}

    # change the order of the conjuncts
    if args.order == 'cogs': # the order in which each word appears in the text

        # order presupvars[:][1] and assertvars[:][1] based on presupvars[:][2] and assertsvars[:][2]
        # but only use elements in presupvars[:][2] if the variable starts with "x _"

        # TODO: this doesn't work if wordidx2var is not already mostly in the correct order

        wordidx2semantics = {idx: {'presups' : [], 'asserts' : []} for idx in wordidx2var_new}
        lf_reordered = {'presups' : [], 'asserts' : []}
        used_conjuncts = set()
        used_idxs = set()
        for idx, idxvar in wordidx2var_new.items(): # wordidx2var is ordered by word index
            for presupname, p, vars in presupvars:
                if idxvar == vars[0] and p not in used_conjuncts:
                    used_conjuncts.add(p)
                    wordidx2semantics[idx]['presups'].append(p)
                    lf_reordered['presups'].append(p)

            for assertname, a, vars in assertsvars:
                if idxvar == vars[0] and a not in used_conjuncts:
                    used_conjuncts.add(a)
                    wordidx2semantics[idx]['asserts'].append(a)
                    lf_reordered['asserts'].append(a)



    presups_str = ' ; '.join(lf_reordered['presups'])
    asserts_str = ' AND '.join(lf_reordered['asserts'])
    lf_reordered_str = presups_str + (' ; ' if presups_str != '' and asserts_str != '' else '')
    lf_reordered_str += asserts_str



    if line_number not in data:
        data[line_number] = []
    data[line_number].append({
        'sent' : sent,
        'presups' : presups,
        'asserts' : asserts,
        'presupvars' : presupvars,
        'assertvars' : assertsvars,
        # 'tag' : tag.strip(),
        'wordidx2var' : wordidx2var,
        'wordidx2semantics' : wordidx2semantics,
        'lf_reordered' : lf_reordered_str,
    })



results = {i+1: 0 for i in range(500)}
for sentnum, gold in enumerate(gold_sents_and_lf[:500]):
    try:
        sentnum += 1
        gold_sent, gold_lf, _ = gold
        for processed in data[sentnum]:
            assert gold_sent == processed['sent']

            lf_reordered       = processed['lf_reordered']
            sent                = processed['sent']
            wordidx2var         = processed['wordidx2var']
            wordidx2semantics   = processed['wordidx2semantics']

            if lf_reordered != gold_lf and lf_reordered.replace('TV', 'tv') != gold_lf:
                print(f"\nin '{sent}'\nprocessed:\t{lf_reordered}\ngold:\t\t{gold_lf}\nwordidx2semantics: {wordidx2semantics}\n{wordidx2var}")
            else:
                results[sentnum] = 1
                break
    except KeyError:
        # print(f"Warning: sentence number {sentnum} not found in processed data")
        pass

print(f"\n{sum(results.values())}/{len(data)} correct")
