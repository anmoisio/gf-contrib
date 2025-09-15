
# constants
orig_data=cogs-from-orig/orig-data/dev.tsv

filenumber=0
folder=cogs-rgl
grammar=LangEng
parsed=${folder}/parsed-cogs-dev-${grammar}.txt

# semantics=SemanticsLF
semantics=SemanticsCogsLF


# split dev.tsv into smaller files for parallel processing
split -d -l 500 \
    ${orig_data} \
    ${orig_data}.

screen -S parse${filenumber} -dm bash utils/parse-cogs.sh \
    ${orig_data}.0${filenumber} \
    ${folder}/${grammar}.gf \
    ${parsed}.0${filenumber}

# interpret
screen -S interpret${filenumber} -dm bash utils/interpret-trees.sh \
    ${folder}/${semantics}.gf \
    ${parsed}.0${filenumber} \
    ${parsed}.0${filenumber}.${semantics}.txt

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
