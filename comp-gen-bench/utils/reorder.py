import argparse
from cogs_lexicon import verbs_lemmas

parser = argparse.ArgumentParser()
parser.add_argument("--input_file", type=str, default='cogs-from-orig/orig-data/dev.tsv')
parser.add_argument("--format", type=str, choices=['cogs', 'gf'], default='cogs')
parser.add_argument("--output_file", type=str)
args = parser.parse_args()

def read_sent_line(l, f):
    if f == 'cogs':
        return l.split('\t')
    return l.split('\t')

with open(args.input_file, 'r', encoding='utf-8') as f:
    lines = f.readlines()

data = []
for line in lines:
    sent, lf, _ = read_sent_line(line, args.format)

    presups = [p.strip() for p in lf.split(';')[:-1]]
    asserts = [p.strip() for p in lf.split(';')[-1].split('AND')]
    assertsvars = []
    for a in asserts:
        splitted = a.split('(')
        predicate = splitted[0].split('.')[0].split('(')[0].strip()
        vars = [v.replace('x _ ','').strip() for v in splitted[1].replace(')','').split(',')]
        assertsvars.append((predicate, a, vars))

    presupvars = []
    for p in presups:
        splitted = p.split('(')
        predicate = splitted[0].split('.')[0].split('(')[0].replace('*','').strip()
        vars = [v.replace('x _ ','').strip() for v in splitted[1].replace(')','').split(',')]
        presupvars.append((predicate, p, vars))

    wordidx2var = {}
    used_vars = set()
    for idx, word in enumerate(sent.split(' ')):
        if word in ['TV']: word = word.lower()
        for presupname, _, vars in presupvars:
            # common nouns with definite article
            if word == presupname and vars[0] not in used_vars:
                wordidx2var[idx] = vars[0]
                used_vars.add(vars[0])
                break
        for assertname, _, vars in assertsvars:
            # verbs and common nouns with indefinite article
            if (word == assertname or word in verbs_lemmas and verbs_lemmas[word] == assertname) and vars[0] not in used_vars:
                if idx not in wordidx2var:
                    wordidx2var[idx] = vars[0]
                    used_vars.add(vars[0])
                    break
            # proper names
            elif len(vars) > 1 and word == vars[1] and vars[1] not in used_vars:
                if idx not in wordidx2var:
                    wordidx2var[idx] = vars[1]
                    used_vars.add(vars[1])
                    break
    wordidx2var = {k:v for k,v in sorted(wordidx2var.items(), key=lambda item: item[0])}
    
    wordidx2semantics = {}
    lf_cogs_order = {'presups' : [], 'asserts' : []}
    for idx, idxvar in wordidx2var.items():
        for presupname, p, vars in presupvars:
            if idxvar == vars[0]:
                if idx not in wordidx2semantics:
                    wordidx2semantics[idx] = {}
                if 'presups' not in wordidx2semantics[idx]:
                    wordidx2semantics[idx]['presups'] = []
                wordidx2semantics[idx]['presups'].append(p)
                lf_cogs_order['presups'].append(p)

        for assertname, a, vars in assertsvars:
            if idxvar == vars[0]:
                if idx not in wordidx2semantics:
                    wordidx2semantics[idx] = {}
                if 'asserts' not in wordidx2semantics[idx]:
                    wordidx2semantics[idx]['asserts'] = []
                wordidx2semantics[idx]['asserts'].append(a)
                lf_cogs_order['asserts'].append(a)

    presups_str = ' ; '.join(lf_cogs_order['presups'])
    asserts_str = ' AND '.join(lf_cogs_order['asserts'])
    lf_cogs_order_str = presups_str + (' ; ' if presups_str != '' and asserts_str != '' else '') + asserts_str
    if lf_cogs_order_str != lf: print(f"\n{lf_cogs_order_str}\n!=\n{lf}\nin\n{sent}\n{wordidx2semantics}\n{wordidx2var}")
    data.append({
        'sent' : sent,
        'presups' : presups,
        'asserts' : asserts,
        'presupvars' : presupvars,
        'assertvars' : assertsvars,
        # 'tag' : tag.strip(),
        'wordidx2var' : wordidx2var,
        'wordidx2semantics' : wordidx2semantics,
        'lf_cogs_order' : lf_cogs_order_str,
    })
