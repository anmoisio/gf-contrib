
# constants
# orig_data=cogs-from-orig/orig-data/dev.tsv
# orig_data=cogs-from-orig/orig-data/gen.tsv
# orig_data=cogs-from-orig/orig-data/train.tsv
orig_data=slog-data/dev.tsv
orig_data_folder=$(dirname ${orig_data} | sed 's/\//-/')
orig_data_filename=$(basename ${orig_data} .tsv)

filenumber=40
folder=cogs-rgl
grammar=LangEng
# grammar=LangRestrictedEng
parsed=${folder}/parsed-${orig_data_folder}-${orig_data_filename}-${grammar}.txt

# semantics=SemanticsLF
# semantics=SemanticsCogsLF
# semantics=SemanticsRestrictedCogsLF
semantics=SemanticsReCogsLF


# split dev.tsv into smaller files for parallel processing
split -d -l 100 \
    ${orig_data} \
    ${orig_data}.

# parse
for filenumber in {00..00}; do
    screen -S parse${grammar}-${filenumber} -dm bash utils/parse-cogs.sh \
        ${orig_data}.${filenumber} \
        ${folder}/${grammar}.gf \
        ${parsed}.${filenumber}
done

# interpret and linearise
for filenumber in {37..37}; do
    screen -S interpret${semantics}-${filenumber} -dm bash utils/interpret-trees.sh \
        ${folder}/${semantics}.gf \
        ${parsed}.${filenumber} \
        ${parsed}.${filenumber}.${semantics}.txt
done


# parse + interpret&linearise in one go
for filenumber in {37..39}; do
    screen -S parse${grammar}-and-interpret${semantics}-${filenumber} -dm bash -c "\
        bash utils/parse-cogs.sh \
        ${orig_data}.${filenumber} \
        ${folder}/${grammar}.gf \
        ${parsed}.${filenumber} \
        && bash utils/interpret-trees.sh \
        ${folder}/${semantics}.gf \
        ${parsed}.${filenumber} \
        ${parsed}.${filenumber}.${semantics}.txt"
done

# combine parsed files
cat ${parsed}.{00..05} \
    > ${folder}/parsed-cogs-dev-${grammar}-all.txt
rm ${parsed}.{00..05}

# combine interpreted files
cat ${parsed}.{00..05}.${semantics}.txt \
    > ${folder}/parsed-cogs-dev-${semantics}-all.txt
rm ${parsed}.{00..05}.${semantics}.txt



# concrete=cogs-rgl/SemanticsLF.gf
parsed=cogs-rgl/parsed-cogs-dev-all.txt
concrete=cogs-rgl/SemanticsCogsLF.gf
bash utils/interpret-trees.sh \
    ${concrete} \
    ${parsed} \
    ${parsed}.SemanticsCogsLF.interpreted.txt


# reorder and compare to original LFs
python3 utils/reorder.py \
    --format gf \
    --input_file ${parsed}.${filenumber}.${semantics}.txt \
    --gold_file ${orig_data}.${filenumber}


########################################################################
# SCAN structural generalisation data generation
########################################################################

# grammar=scan/ScanStructGen
# generated=scan/struct-gen/noopposites/trees.txt
# processed=scan/struct-gen/noopposites/

# grammar=scan/ScanStructGenMore
# generated=scan/struct-gen/5more/trees.txt
# processed=scan/struct-gen/5more/

grammar=scan/ScanStructGen12More
generated=scan/struct-gen/12more/trees.txt
processed=scan/struct-gen/12more/

number=10000

mkdir -p "$(dirname "$generated")"
echo "gt -depth=60 -number=10000000 | l -tabtreebank" | \
    gf --run ${grammar}Input.gf ${grammar}Output.gf > "$generated".all

# take a random subset of generated data for processing
shuf -n $number "$generated".all > "${generated}"

python utils/complement.py "$generated" "$processed"
