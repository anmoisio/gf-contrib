import collections
import sys

def find_non_unique_sequences(input_file_path):
    tree2inputoutput = collections.defaultdict(lambda: collections.defaultdict(set))
    with open(input_file_path, 'r', encoding='utf-8') as f:
        for line in f:
            parts = line.strip().split('\t')
            if len(parts) >= 3:
                tree, in_seq, out_seq = parts[0], parts[1], parts[2]
                tree2inputoutput[tree]['input'].add(in_seq)
                tree2inputoutput[tree]['output'].add(out_seq)

    return tree2inputoutput



if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python find_non_unique_sequences.py <file_path>")
        sys.exit(1)
    file_path_arg = sys.argv[1]
    result = find_non_unique_sequences(file_path_arg)

    # ambiguous trees
    ambiguous_trees = set()
    for tree, io in result.items():
        if len(io['input']) > 1:
            ambiguous_trees.add(tree)
            print(f"Ambiguous tree found for input sequences in tree {tree}:")
            for seq in io['input']:
                print(f" - {seq}")
        if len(io['output']) > 1:
            ambiguous_trees.add(tree)
            print(f"Ambiguous tree found for output sequences in tree {tree}:")
            for seq in io['output']:
                print(f" - {seq}")
