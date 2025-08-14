"""Convert the original COGS grammar format into GF format."""
#!/usr/bin/env python3
import os
from cogs_lexicon import lexicon

with open("cogs-orig.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()

functions = []
lexical_funs = []
names = {}
for line in lines:
    splitted = line.split(" -> ")
    cat = splitted[0].strip()
    for function in splitted[1].split(" | "):
        if cat not in names:
            name = "mk" + cat
            names[cat] = 1
        else:
            names[cat] += 1
            name = f"mk{cat}{names[cat]}"

        if function.startswith("{"):
            wordclass = function.replace("{","").replace("}","").strip().replace("_str","")
            words = sorted(lexicon[wordclass])
            for word in words:
                lexical_funs.append({
                    "arg_types": [],
                    "value_type": cat,
                    "name": word + "_" + cat,
                    "prob": 1.0 / len(words)
                })
        elif function.startswith("'"):
            functions.append({
                "arg_types": [],
                "value_type": cat,
                "name": function.split("[")[0].replace("'","").strip() + "_" + cat,
                "prob": 1.0
            })
        else:
            fsplitted = function.split("[")
            functions.append({
                "arg_types": [t.strip() for t in fsplitted[0].split()],
                "value_type": cat,
                "name": name,
                "prob": float(fsplitted[1].replace("]", "").strip())
            })

# if os.path.exists("Cogs.gf"):
#     print("Cogs.gf already exists, not overwriting.")
# else:
#     print("Creating Cogs.gf...")


# the format of the Cogs.gf file is:
#
# cat
#     <category name> ;
#     <category name2> ;
#     ...
# fun
#     <function name> : <arg type1> -> <arg type2> -> <value_type> ;
#     ...
#
# the function name is "mk<category name>" and if there are multiple functions with
# the same category name, then "mk<category name>X" where X is a number starting from 2.

with open("../Cogs.gf", "w", encoding="utf-8") as f:
    f.write("abstract Cogs = {\n")
    f.write("cat\n")
    categories = set()
    for function in functions + lexical_funs:
        categories.add(function["value_type"])
    for category in sorted(categories):
        f.write(f"    {category} ;\n")
    f.write("fun\n")

    for function in functions:
        types = " -> ".join(function["arg_types"] + [function["value_type"]])
        prob = function["prob"]
        name = function["name"]
        f.write(f"    {name} \t\t: {types} ;\n")
        # f.write(f"    -- Probability: {prob}\n")
    f.write("\n}\n")

with open("../Lexicon.gf", "w", encoding="utf-8") as f:
    f.write("abstract Lexicon = Cogs ** {\n")
    f.write("fun\n")

    for function in lexical_funs:
        types = " -> ".join(function["arg_types"] + [function["value_type"]])
        prob = function["prob"]
        name = function["name"]
        f.write(f"    {name} \t\t: {types} ;\n")
        # f.write(f"    -- Probability: {prob}\n")
    f.write("\n}\n")

# the concrete syntax CogsEng.gf has the format:
#
# concrete CogsEng of Cogs = {
#     lincat
#         <category name> = {s : Str} ;
#         <category name2> = {s : Str} ;
#         ...
#     lin
#         <function name> = \x,y,...,z -> {s = x.s ++ y.s ++ ... ++ z.s} ;
#         ...
# }
#
# categories in lincat should be unique and should match the categories in the abstract Cogs.gf.
# the number of arguments in the lin function is equal to len(function['arg_types']).
# if the function has no arguments, then the lin is
# function['name'].split("_")[0], in quotes (the first part of the name before the underscore).

with open("../CogsEng.gf", "w", encoding="utf-8") as f:
    f.write("concrete CogsEng of Cogs = open Prelude in {\n")
    f.write("lincat\n")
    categories = set()
    for function in functions + lexical_funs:
        categories.add(function["value_type"])
    for category in sorted(categories)[:-1]:
        f.write(f"    {category},\n")
    f.write(f"    {sorted(categories)[-1]} = {{s : Str}} ;\n")

    # all lin functions simply concatenate the strings of their arguments,
    # so we define reusable functions for 1 to 7 arguments.
    varnames = ["x" + str(i) for i in range(1, 30)]
    f.write("\n")
    f.write("oper\n")
    for n in range(1, 8):
        args = [varnames[i] for i in range(n)]
        # e.g.: lin2args : (x1,x2 : {s : Str}) -> {s : Str} = \x1,x2 -> {s = x1.s ++ x2.s} ;
        f.write(f"\tlin{n}args : ({','.join(args)} : {{s : Str}}) -> {{s : Str}} = " + \
                f"\\{','.join(args)} -> {{s = {' ++ '.join([f'{arg}.s' for arg in args])}}} ;\n")

    f.write("\n")
    f.write("lin\n")
    for function in functions:
        if len(function["arg_types"]) == 0: # terminals
            lin = f'ss "{function["name"].split("_")[0]}"'
        else: # non-terminals
            n_args = len(function['arg_types'])
            lin = f"lin{n_args}args"
        f.write(f"    {function['name']} \t\t= {lin} ;\n")
    f.write("\n}\n")

# concrete lexicon LexiconEng
# only lins needed, no lincat
with open("../LexiconEng.gf", "w", encoding="utf-8") as f:
    f.write("concrete LexiconEng of Lexicon = CogsEng ** open Prelude in {\n")
    f.write("lin\n")
    for function in lexical_funs:
        lin = f'ss "{function["name"].split("_")[0]}"'
        f.write(f"    {function['name']} \t\t= {lin} ;\n")
    f.write("\n}\n")

# CogsLang.gf and CogsLangEng.gf combine the Cogs and Lexicon grammars
with open("../CogsLang.gf", "w", encoding="utf-8") as f:
    f.write("abstract CogsLang = Cogs, Lexicon ** {\nflags startcat = S ;\n}\n")

with open("../CogsLangEng.gf", "w", encoding="utf-8") as f:
    f.write("concrete CogsLangEng of CogsLang = CogsEng, LexiconEng ;\n")

# the probs go to a separate file probs.txt
with open("../probs.txt", "w", encoding="utf-8") as f:
    for function in functions:
        f.write(f"{function['name']} {function['prob']}\n")
