import re

with open("CogsCon-trees-and-sequences.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()

print(f"Original number of lines: {len(lines)}")
lines = list(set(lines))  # Remove duplicates
print(f"Number of lines after removing duplicates: {len(lines)}")


def check_tree(split_tree, max_pp_depth=2):
    # Check if the tree has more than 2 nested prepositional phrases (PP)
    for i, word in enumerate(split_tree):
        if word.startswith("(mkPP"):
            rest_of_nounsubtree = []
            for j, word in enumerate(split_tree[i+1:]):
                if not word.endswith(")"):
                    rest_of_nounsubtree.append(word)
                else:
                    rest_of_nounsubtree.append(word)
                    rest_of_tree = split_tree[j+i+1:]
                    break

            if sum(w.startswith("(mkPP") for w in rest_of_nounsubtree) > max_pp_depth - 1:
                return False
            else:
                check_tree(rest_of_tree)
    return True

with open("CogsCon-trees-and-sequences-postprocessed.txt", "w", encoding="utf-8") as f:
    for line in lines:
        tree, sequence = line.split("\t")
        if sequence.count("that") > 2:
            print(f"Skipping line due to CP recursion limit: {line.strip()}\n")
            continue
        if not check_tree(tree.split()):
            print(f"Skipping line due to PP recursion limit: {line.strip()}\n")
            continue
        f.write(line)
    