"""Convert the lexicon from cogs-lexicon to GF format."""
#!/usr/bin/env python3
from utils.cogs_lexicon import *

N = animate_nouns + inanimate_nouns + on_nouns + in_nouns + beside_nouns
PN = proper_nouns
pastV_unerg = V_trans_omissible + V_unerg
pastV_unacc = V_unacc
pastV2 = V_trans_omissible + V_trans_not_omissible + V_unacc
pastV3 = V_dat
pastVS = V_cp_taking
pastVV = V_inf_taking

VUnerg = V_inf
VUnacc, V2, V3, VS, VV = [], [], [], [], []
for word_list, lemma_word_list in zip(
        [pastV_unerg, pastV_unacc, pastV2, pastV3, pastVS, pastVV],
        [VUnerg, VUnacc, V2, V3, VS, VV]):
    for word in word_list:
        lemma_word_list.append(verbs_lemmas[word])
    # print("------")
    # for w in set(lemma_word_list):
    #     print(w)

# missing from cogs_lexicon
VUnerg.append("bake")
V2.append("bake")
verbs_lemmas["baked"] = "bake"

# adding three V2 to use as replacements for the PP in the PP to PV conversion
V2.extend(["wait", "impress", "accompany"])


# adjectives
A = [
    'big',
    'blue',
    'fast',
    'green',
    'happy',
    'loud',
    'quiet',
    'red',
    'slow',
    'small',
    'tall'
]

lexs = {
    "N": sorted(list(set(N))),
    "PN": sorted(list(set(PN))),
    # unaccusative: e.g. burn. All of these are also V2s in COGS (even though not generally
    # in English, e.g. arrive, happen, die).
    # Unaccusatives have different semantics than unergative verbs like "run", namely they
    # are the Patient/Theme instead of the Agent of the action.
    "VUnacc": sorted(list(set(VUnacc))),
    "VUnerg": sorted(list(set(VUnerg))), # unergative: e.g. run
    "V2": sorted(list(set(V2))),
    "V3doc": sorted(list(set(V3))), # double object construction
    "V3to": sorted(list(set(V3))), # same as V3 but with "to" preposition
    "VS": sorted(list(set(VS))),
    "VV": sorted(list(set(VV))),
    "A": sorted(list(set(A)))
}

#exclude = ["want"]

linfun = { # strings that need to be formatted with the word
    # constructors for regular and irregular verbs
    "N": ("mkN {}", "mkN {}"),
    "PN": ("mkPN {}", "mkPN {}"),
    "VUnacc": ("mkV {}", "irregV {}"),
    "VUnerg": ("mkV {}", "irregV {}"),
    "V2": ("mkV2 {}", "mkV2 (irregV {})"),
    "V3to": ("mkV3 (regV {}) noPrep toP",    "mkV3 (irregV {}) noPrep toP"), # gave a bone to a dog
    "V3doc": ("mkV3 (regV {}) noPrep noPrep", "mkV3 (irregV {}) noPrep noPrep"), # gave a dog a bone
    "VS": ("mkVS (regV {})", "mkVS (irregV {})"),
    "VV": ("mkVV (regV {})", "mkVV (irregV {})"),
    "A": ("mkA {}", "mkA {}")
}

verb_base2infls = {}
for listpairs in [(V_trans_omissible, V_trans_omissible_pp),
                  (V_trans_not_omissible, V_trans_not_omissible_pp),
                  (V_unacc, V_unacc_pp),
                  (V_dat, V_dat_pp)]:
    for past, pastpart in zip(*listpairs):
        verb_base2infls[verbs_lemmas[past]] = (past, pastpart)

# missing irregular verbs
verb_base2infls["say"] = ("said", "said")
verb_base2infls["know"] = ("knew", "known")
verb_base2infls["mean"] = ("meant", "meant")
# verb_base2infls["dream"] = ("dreamt", "dreamt") -- cogs uses dreamed so this is not needed
verb_base2infls["think"] = ("thought", "thought")
verb_base2infls["hear"] = ("heard", "heard")
verb_base2infls["sleep"] = ("slept", "slept")
verb_base2infls["run"] = ("ran", "run")
verb_base2infls["prefer"] = ("preferred", "preferred")

# shorten and redden need to be hadled as irregular because in ParadigmsEng.gf
# all verbs ending in a consonant get the last consonant duplicated, e.g. shortenned
verb_base2infls["shorten"] = ("shortened", "shortened")
verb_base2infls["redden"] = ("reddened", "reddened")



if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("path_to_cogs_lexicon", help="Path to the cogs-lexicon.py file.")
    parser.add_argument("--segment", action="store_true")
    args = parser.parse_args()


    if args.segment:
        SEG_TAG = "Seg"
        EXCLUDING = " - [want_VV]"

        # missing irregular verbs
        verb_base2infls["say"] = ("sai d", "sai d")
        verb_base2infls["know"] = ("knew", "know n")
        verb_base2infls["mean"] = ("mean t", "mean t")
        # verb_base2infls["dream"] = ("dreamt", "dreamt") -- cogs uses dreamed so this is not needed
        verb_base2infls["think"] = ("thought", "thought")
        verb_base2infls["hear"] = ("hear d", "hear d")
        verb_base2infls["sleep"] = ("slep t", "slep t")
        verb_base2infls["run"] = ("ran", "run")
        verb_base2infls["prefer"] = ("prefer r ed", "prefer r ed")

        # shorten and redden need to be hadled as irregular because in ParadigmsEng.gf
        # all verbs ending in a consonant get the last consonant duplicated, e.g. shortenned
        verb_base2infls["shorten"] = ("shorten ed", "shorten ed")
        verb_base2infls["redden"] = ("redden ed", "redden ed")

        verb_base2infls["break"] = ("broke", "broke n")
        verb_base2infls["freez e"] = ("froze", "froze n")
        verb_base2infls["grow"] = ("grew", "grow n")
        verb_base2infls["slid e"] = ("slid", "slid")
        verb_base2infls["draw"] = ("drew", "draw n")
        verb_base2infls["eat"] = ("ate", "eat e n")
        verb_base2infls["see"] = ("saw", "see n")
        verb_base2infls["throw"] = ("threw", "throw n")
        verb_base2infls["give"] = ("gave", "give n")
    else:
        SEG_TAG = ""
        EXCLUDING = ""

    # abstract lexicon
    with open(args.path_to_cogs_lexicon + "/CogsLexicon.gf", "w", encoding="utf-8") as f:
        f.write(f"abstract CogsLexicon = Cogs, Structural {EXCLUDING} **" + " {\ndata\n")
        for wordclass, wordlist in lexs.items():
            for word in wordlist:
                # if word in exclude:
                #     continue
                f.write(f"    {word.lower()}_{wordclass} \t\t: {wordclass.split('_')[-1]} ;\n")
            f.write("\n")
        f.write("    beside_Prep : Prep ;\n")
        f.write("\n}\n")


    # concrete lexicon LexiconEng
    # only lins needed, no lincat
    with open(args.path_to_cogs_lexicon + f"/CogsLexicon{SEG_TAG}Eng.gf", "w", encoding="utf-8") as f:
        f.write(f"concrete CogsLexicon{SEG_TAG}Eng of CogsLexicon = CogsEng{EXCLUDING} ** " \
                + f"open Paradigms{SEG_TAG}Eng, IrregEng, Prelude in" + " {\nlin\n")
        for wordclass, wordlist in lexs.items():
            for word in wordlist:
                # if word in exclude:
                #     continue
                # irregular
                # if not args.segment:
                if wordclass.startswith("V") and \
                        (word in verb_base2infls and \
                        verb_base2infls[word][0] != word + "ed" and \
                        verb_base2infls[word][0] != word[:-1] + "ed" and \
                        verb_base2infls[word][0] != word + word[-1] + "ed" and \
                        verb_base2infls[word][0] != word[:-1] + "ied"
                        ) or word in ["shorten", "redden", "freeze"]:
                        # verb_base2infls[word][0] != word + word[-1] + "ed":
                    
                    linf = linfun[wordclass][1]

                    if word == "freeze": # irregular that end in e that should be segmented (not "see")
                        forms = '"freez e" "froze" "froze n"'
                    elif word == "slide": # irregular that end in e that should be segmented (not "see")
                        forms = '"slid e" "slid" "slid"'
                    elif word in ["shorten", "redden"]:
                        forms = f'"{word}" "{word} ed" "{word} ed" "{word} ing"'
                        if wordclass == "VUnacc":
                            linf = "irreg4V {}"
                        elif wordclass == "V2":
                            linf = "mkV2 (irreg4V {})"
                    else:
                        forms = f'"{word}" "{verb_base2infls[word][0]}" "{verb_base2infls[word][1]}"'
                    
                # regular
                else:
                    linf = linfun[wordclass][0]
                    forms = f'"{word}"'
                    if wordclass.startswith("V"): # separate the e
                        if word[-1] in ["e", "y"]:
                            forms = f'"{word[:-1]} {word[-1]}"'
                    

                f.write(f"    {word.lower()}_{wordclass} \t\t= {linf.format(forms)} ;\n")
            f.write("\n")

        # structural words missing from gf-rgl/src/abstract/Structural.gf
        f.write("    beside_Prep = mkPrep \"beside\" ;\n")

        f.write("oper")
        f.write('    aboutP = mkPrep "about" ;\n')
        f.write('    atP = mkPrep "at" ;\n')
        f.write('    forP = mkPrep "for" ;\n')
        f.write('    fromP = mkPrep "from" ;\n')
        f.write('    inP = mkPrep "in" ;\n')
        f.write('    onP = mkPrep "on" ;\n')
        f.write('    toP = mkPrep "to" ;\n')
        f.write('    besideP = mkPrep "beside" ;\n')

        f.write("\n}\n")


    ##### for the logical forms
    with open(args.path_to_cogs_lexicon + "/CogsLexiconLF.gf", "w", encoding="utf-8") as f:
        f.write("concrete CogsLexiconLF of CogsLexicon = open Prelude in {\n")
        f.write("lin\n")
        for wordclass, wordlist in lexs.items():
            for word in wordlist:
                f.write(f'    {word.lower()}_{wordclass} \t\t= ss "{word}" ;\n')
            f.write("\n")

        f.write("    beside_Prep = ss \"beside\" ;\n")
        f.write("    in_Prep = ss \"in\" ;\n")
        f.write("    on_Prep = ss \"on\" ;\n")

        f.write("\n}\n")
