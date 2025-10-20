
# constants
# orig_data=cogs-from-orig/orig-data/dev.tsv
# orig_data=cogs-from-orig/orig-data/gen.tsv
orig_data=cogs-from-orig/orig-data/train.tsv
orig_data_filename=$(basename ${orig_data} .tsv)

filenumber=0
folder=cogs-rgl
# grammar=LangEng
grammar=LangRestrictedEng
parsed=${folder}/parsed-cogs-${orig_data_filename}-${grammar}.txt

# semantics=SemanticsLF
# semantics=SemanticsCogsLF
semantics=SemanticsRestrictedCogsLF


# split dev.tsv into smaller files for parallel processing
split -d -l 500 \
    ${orig_data} \
    ${orig_data}.

# parse
for filenumber in {04..48}; do
    screen -S parse${grammar}-${filenumber} -dm bash utils/parse-cogs.sh \
        ${orig_data}.${filenumber} \
        ${folder}/${grammar}.gf \
        ${parsed}.${filenumber}
done

# interpret and linearise
screen -S interpret${semantics}-${filenumber} -dm bash utils/interpret-trees.sh \
    ${folder}/${semantics}.gf \
    ${parsed}.0${filenumber} \
    ${parsed}.0${filenumber}.${semantics}.txt

# parse and interpret in one go
for filenumber in {01..01}; do
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
