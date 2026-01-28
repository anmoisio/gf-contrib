
import random
import argparse

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument("--number_of_funs", nargs="+", type=int, help="Number of functions to generate")
# arg_parser.add_argument("--maxlen_of_funs", type=int, help="Maximum length of functions to generate")
# arg_parser.add_argument("--output_file_path", type=str)
args = arg_parser.parse_args()


funs3 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            fun = f"{w1}{w2}{w3}"
            word = ''.join([w[0].lower() for w in [w1, w2, w3]])
            output = '.s ++ '.join([w.lower() for w in [w1, w2, w3]]) + '.s'
            funs3[fun] = (word, output)

funs4 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            for w4 in ["Verb", "Adv"]:
                fun = f"{w1}{w2}{w3}{w4}"
                word = ''.join([w[0].lower() for w in [w1, w2, w3, w4]])
                output = '.s ++ '.join([w.lower() for w in [w1, w2, w3, w4]]) + '.s'
                funs4[fun] = (word, output)

funs5 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            for w4 in ["Verb", "Adv"]:
                for w5 in ["Verb", "Adv"]:
                    fun = f"{w1}{w2}{w3}{w4}{w5}"
                    word = ''.join([w[0].lower() for w in [w1, w2, w3, w4, w5]])
                    output = '.s ++ '.join([w.lower() for w in [w1, w2, w3, w4, w5]]) + '.s'
                    funs5[fun] = (word, output)

funs6 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            for w4 in ["Verb", "Adv"]:
                for w5 in ["Verb", "Adv"]:
                    for w6 in ["Verb", "Adv"]:
                        fun = f"{w1}{w2}{w3}{w4}{w5}{w6}"
                        word = ''.join([w[0].lower() for w in [w1, w2, w3, w4, w5, w6]])
                        output = '.s ++ '.join([w.lower() for w in [w1, w2, w3, w4, w5, w6]]) + '.s'
                        funs6[fun] = (word, output)


funs7 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            for w4 in ["Verb", "Adv"]:
                for w5 in ["Verb", "Adv"]:
                    for w6 in ["Verb", "Adv"]:
                        for w7 in ["Verb", "Adv"]:
                            fun = f"{w1}{w2}{w3}{w4}{w5}{w6}{w7}"
                            word = ''.join([w[0].lower() for w in [w1, w2, w3, w4, w5, w6, w7]])
                            output = '.s ++ '.join([w.lower() for w in [w1, w2, w3, w4, w5, w6, w7]]) + '.s'
                            funs7[fun] = (word, output)

funs8 = {}
for w1 in ["Verb", "Adv"]:
    for w2 in ["Verb", "Adv"]:
        for w3 in ["Verb", "Adv"]:
            for w4 in ["Verb", "Adv"]:
                for w5 in ["Verb", "Adv"]:
                    for w6 in ["Verb", "Adv"]:
                        for w7 in ["Verb", "Adv"]:
                            for w8 in ["Verb", "Adv"]:
                                fun = f"{w1}{w2}{w3}{w4}{w5}{w6}{w7}{w8}"
                                word = ''.join([w[0].lower() for w in [w1, w2, w3, w4, w5, w6, w7, w8]])
                                output = '.s ++ '.join([w.lower() for w in [w1, w2, w3, w4, w5, w6, w7, w8]]) + '.s'
                                funs8[fun] = (word, output)

# print(f"Generated {len(funs)} functions before filtering.", flush=True)

# exclude those that are already included in SCAN:
# opposite=AdvAdvVerb and around=AdvVerbAdvVerbAdvVerbAdvVerb
del funs3["AdvAdvVerb"]
del funs8["AdvVerbAdvVerbAdvVerbAdvVerb"]

# exclude also those that don't contain at least one Verb and one Adv
funs3 = {fun: v for fun, v in funs3.items() if "Verb" in fun and "Adv" in fun}
funs4 = {fun: v for fun, v in funs4.items() if "Verb" in fun and "Adv" in fun}
funs5 = {fun: v for fun, v in funs5.items() if "Verb" in fun and "Adv" in fun}
funs6 = {fun: v for fun, v in funs6.items() if "Verb" in fun and "Adv" in fun}
funs7 = {fun: v for fun, v in funs7.items() if "Verb" in fun and "Adv" in fun}
funs8 = {fun: v for fun, v in funs8.items() if "Verb" in fun and "Adv" in fun}

funs = {}
funs.update(funs3)
funs.update(funs4)
funs.update(funs5)
funs.update(funs6)
funs.update(funs7)
funs.update(funs8)

for number_of_funs in args.number_of_funs:
    # take random sample of functions
    # selected_funs = random.sample(list(funs.keys()), number_of_funs)
    # take a random sample of functions from all lengths, but each length
    # should be represented approximately equally
    selected_funs = []
    lengths = [3, 4, 5, 6, 7, 8]
    funs_by_length = {3: funs3, 4: funs4, 5: funs5, 6: funs6, 7: funs7, 8: funs8}

    funs_remaining = number_of_funs
    for i, length in enumerate(lengths):
        funs_of_length = funs_by_length[length]
        lengths_remaining = len(lengths) - i

        num_to_select = funs_remaining // lengths_remaining
        if funs_remaining % lengths_remaining > 0:
            num_to_select += 1

        num_to_select = min(num_to_select, len(funs_of_length))
        selected_funs.extend(random.sample(list(funs_of_length.keys()), num_to_select))
        funs_remaining -= num_to_select
    random.shuffle(selected_funs)

    # check that we have the correct number of functions
    assert len(selected_funs) == number_of_funs, f"Expected {number_of_funs} functions, but got {len(selected_funs)}"
    # check that all functions are unique
    assert len(set(selected_funs)) == number_of_funs

    filename = f"scan/ScanNoOpposite{number_of_funs}More"

    with open(filename + ".gf", "w", encoding="utf-8") as abs_file:
        abs_file.write(f"abstract ScanNoOpposite{number_of_funs}More = Scan - [OppositeVP] ** ")
        abs_file.write("{\n")
        abs_file.write("\tflags startcat = Utt ;\n\n")
        abs_file.write("\tcat VPopp ;\n\n")
        abs_file.write("\tdata\n")
        abs_file.write("\t\tUseVPopp\t\t: VPopp -> Utt ;\n")
        abs_file.write("\t\tOppositeVP\t\t: Verb -> Adv -> VPopp ;\n")
        for fun in selected_funs:
            abs_file.write(f"\t\t{fun}\t\t: Verb -> Adv -> VP ;\n")
        abs_file.write("\n}\n")

    with open(filename + "Input.gf", "w", encoding="utf-8") as lin_file:
        lin_file.write(f"concrete ScanNoOpposite{number_of_funs}MoreInput of ScanNoOpposite{number_of_funs}More = ScanInput ** \n")
        lin_file.write("{\n")
        lin_file.write("\tlincat VPopp = {s : Str};\n")
        lin_file.write("\tlin\n")
        lin_file.write("\t\tUseVPopp vpopp = vpopp ;\n")
        for fun in selected_funs:
            word = funs[fun][0]
            lin_file.write(f"\t\t{fun} verb adv = {{s = verb.s ++ \"{word}\" ++ adv.s}} ;\n")
        lin_file.write("}\n")

    with open(filename + "Output.gf", "w", encoding="utf-8") as lin_file:
        lin_file.write(f"concrete ScanNoOpposite{number_of_funs}MoreOutput of ScanNoOpposite{number_of_funs}More = ScanOutput ** \n")
        lin_file.write("{\n")
        lin_file.write("\tlincat VPopp = {s : Str};\n")
        lin_file.write("\tlin\n")
        lin_file.write("\t\tUseVPopp vpopp = vpopp ;\n")
        for fun in selected_funs:
            s = funs[fun][1]
            lin_file.write(f"\t\t{fun} verb adv = {{s = {s}}} ;\n")
        lin_file.write("}\n")
