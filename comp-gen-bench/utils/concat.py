"""
From ReCOGS/second_looks.ipynb
"""
import pandas as pd

def reindex(LFs, initial_indexes):
    new_LF_prefix = []
    new_LF_body = []
    for i in range(len(LFs)):
        if initial_indexes[i] != 0:
            new_lf = []
            for item in LFs[i].split():
                if item.isnumeric():
                    new_i = int(item) + initial_indexes[i]
                    new_lf += [str(new_i)]
                else:
                    new_lf += [item]
            new_lf = " ".join(new_lf)
        else:
            new_lf = LFs[i]
        
        for item in new_lf.split(" ; "):
            if "*" in item:
                new_LF_prefix += [item]
            else:
                new_LF_body += [item]
        new_LF_body += ["AND"]
    new_LF_body = new_LF_body[:-1]
    return " ; ".join(new_LF_prefix) + " ; " + " ".join(new_LF_body)

data_folder = "cogs-from-orig/orig-data/"
output_folder = "cogs_concat/"
append_ks = [256, 512, 1024, 2048, 3072]
for append_k in append_ks:
    train_df = pd.read_csv(f"{data_folder}/train.tsv", sep="\t", names=['sentence', 'LF', 'type'])
    train_df_org = train_df.copy()
    train_df = train_df[train_df["type"] != "primitive"]
    dev_df = pd.read_csv(f"{data_folder}/dev.tsv", sep="\t", names=['sentence', 'LF', 'type'])
    test_df = pd.read_csv(f"{data_folder}/test.tsv", sep="\t", names=['sentence', 'LF', 'type'])
    gen_df = pd.read_csv(f"{data_folder}/gen.tsv", sep="\t", names=['sentence', 'LF', 'type'])
    dataset_postfix = f"k_{append_k}"
    append_data = []
    start_indexes = [i*6 for i in range(append_k)]
    sorted_train_df = train_df.sort_values(by="sentence", key=lambda x: x.str.len())
    for start_index in start_indexes:
        conj_1 = sorted_train_df.iloc[-2-start_index].sentence
        if conj_1.split()[0] in {'The', 'A'}:
            conj_1_first = conj_1[0].lower()
        else:
            conj_1_first = conj_1[0]

        conj_2 = sorted_train_df.iloc[-3-start_index].sentence
        if conj_2.split()[0] in {'The', 'A'}:
            conj_2_first = conj_2[0].lower()
        else:
            conj_2_first = conj_2[0]

        append_data += [
            [sorted_train_df.iloc[-1-start_index].sentence[:-1]+\
            conj_1_first+\
            sorted_train_df.iloc[-2-start_index].sentence[1:-1]+\
            conj_2_first+\
            sorted_train_df.iloc[-3-start_index].sentence[1:],
            reindex(
                [
                    sorted_train_df.iloc[-1-start_index].LF,
                    sorted_train_df.iloc[-2-start_index].LF,
                    sorted_train_df.iloc[-3-start_index].LF
                ],
                [
                    0,
                    len(sorted_train_df.iloc[-1-start_index].sentence[:-1].strip().split()),
                    len(sorted_train_df.iloc[-1-start_index].sentence[:-1].strip().split())+
                    len(sorted_train_df.iloc[-2-start_index].sentence[:-1].strip().split())
                ]
            ),
            'concat']
        ]
    append_df = pd.DataFrame(append_data, columns =['sentence', 'LF', 'type'])
    train_df = pd.concat([train_df_org, append_df])
    train_df.to_csv(f'{output_folder}/train_{dataset_postfix}.tsv', sep='\t', index=False, header=False)
    dev_df.to_csv(f'{output_folder}/dev_{dataset_postfix}.tsv', sep='\t', index=False, header=False)
    test_df.to_csv(f'{output_folder}/test_{dataset_postfix}.tsv', sep='\t', index=False, header=False)
    gen_df.to_csv(f'{output_folder}/gen_{dataset_postfix}.tsv', sep='\t', index=False, header=False)

    max_s = max(train_df['sentence'].str.split().apply(len))
    max_lf = max(train_df['LF'].str.split().apply(len))
    print(max_s, max_lf)
