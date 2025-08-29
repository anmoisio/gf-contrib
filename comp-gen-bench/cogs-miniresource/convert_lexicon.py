"""Convert the lexicon from cogs-lexicon to GF format."""
#!/usr/bin/env python3
import os
from cogs_lexicon import (
    animate_nouns,
    inanimate_nouns,
    on_nouns,
    in_nouns,
    beside_nouns,
    proper_nouns,
    V_trans_omissible,
    V_unacc,
    V_unerg,
    V_trans_not_omissible,
    V_dat,
    V_cp_taking,
    verbs_lemmas,
    lexicon
)

N = animate_nouns + inanimate_nouns + on_nouns + in_nouns + beside_nouns
PN = proper_nouns
pastV = V_trans_omissible + V_unacc + V_unerg
pastV2 = V_trans_omissible + V_trans_not_omissible
pastV3 = V_dat
pastVS = V_cp_taking

V, V2, V3, VS = [], [], [], []
for word_list, lemma_word_list in zip([pastV, pastV2, pastV3, pastVS], [V, V2, V3, VS]):
    for word in word_list:
        lemma_word_list.append(verbs_lemmas[word])
    print("------")
    for w in set(lemma_word_list):
        print(w)

lexs = {
    "N": sorted(list(set(N))),
    "PN": sorted(list(set(PN))),
    "V": sorted(list(set(V))),
    "V2": sorted(list(set(V2))),
    "V3": sorted(list(set(V3))),
    "VS": sorted(list(set(VS)))
}

# abstract lexicon
with open("Lexicon.gf", "w", encoding="utf-8") as f:
    f.write("abstract Lexicon = MiniGrammar ** {\n")
    f.write("fun\n")

    for wordclass, wordlist in lexs.items():
        for word in set(wordlist):
            f.write(f"    {word}_{wordclass} \t\t: {wordclass} ;\n")
        f.write("\n")
    f.write("\n}\n")

# concrete lexicon LexiconEng
# only lins needed, no lincat
linfun = {
    "N": "mkN",
    "PN": "mkPN",
    "V": "mkV",
    "V2": "mkV2",
    "V3": "mkV2", # V3 has the same lin as V2
    "VS": "mkV"   # VS has the same lin as V
}
exceptions = {
    "lend_V3": ["lend", "lent", "lent", "to"],
    "give_V3": ["give", "gave", "given", "to"],
}

with open("LexiconEng.gf", "w", encoding="utf-8") as f:
    f.write("concrete LexiconEng of Lexicon = MiniGrammarEng ** open MiniResEng in {\n")
    f.write("lin\n")
    for wordclass, wordlist in lexs.items():
        for word in set(wordlist):
            if f"{word}_{wordclass}" in exceptions:
                forms = exceptions[f"{word}_{wordclass}"]
                forms = ' '.join([f'"{form}"' for form in forms])
            elif wordclass == "V3":
                forms = f'"{word}" "to"' # all V3 (dative) verbs use the "to" preposition
            else:
                forms = f'"{word}"'
            f.write(f"    {word}_{wordclass} \t\t= {linfun[wordclass]} {forms} ;\n")
        f.write("\n")
    f.write("\n}\n")
