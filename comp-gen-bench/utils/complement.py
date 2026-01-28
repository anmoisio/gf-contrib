
# write those sents from all-trees.txt that are not in the input file to a new file "test.txt"
# write sents from input file to "train.txt"
# first column of all-trees.txt and input file is tree, second is input sent and third is output sent

# with open('scan/all-trees.txt', 'r', encoding='utf-8') as all_trees_file:
#     all_trees_lines = all_trees_file.readlines()
#     all_trees = {}
#     for line in all_trees_lines:
#         parts = line.strip().split('\t')
#         if len(parts) >= 3:
#             tree = parts[0]
#             input_sent = parts[1]
#             output_sent = parts[2]
#             all_trees[tree] = (input_sent, output_sent)

def write_complement_trees(input_file_path, output_path):
    with open(input_file_path, 'r', encoding='utf-8') as input_file:
        input_lines = input_file.readlines()
        input_trees = {}
        for line in input_lines:
            parts = line.strip().split('\t')
            if len(parts) >= 3:
                tree = parts[0]
                input_sent = parts[1]
                output_sent = parts[2]
                input_trees[tree] = (input_sent, output_sent)

    # input_trees_set = set(input_trees.values())
    # complement_trees_set = {}
    # for tree, (input_sent, output_sent) in all_trees.items():
    #     if (input_sent, output_sent) not in input_trees_set:
    #         complement_trees_set[tree] = (input_sent, output_sent)

    with open(f'{output_path}/train.txt', 'w', encoding='utf-8') as train_file:
        for input_sent, output_sent in input_trees.values():
            train_file.write(f"{input_sent}\t{output_sent}\n")

    # with open(f'{output_path}/test.txt', 'w', encoding='utf-8') as test_file:
    #     for input_sent, output_sent in complement_trees_set.values():
    #         test_file.write(f"{input_sent}\t{output_sent}\n")

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python complement.py <input_file> <output_path>")
        print("e.g., python complement.py scan/struct-gen-trees.txt scan/struct-gen/")
    else:
        input_file_path = sys.argv[1]
        output_path = sys.argv[2]
        write_complement_trees(input_file_path, output_path)
