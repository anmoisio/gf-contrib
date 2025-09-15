

# parse and interpret in parallel
split -d -l 500 \
    cogs-from-orig/orig-data/dev.tsv \
    cogs-from-orig/orig-data/dev.tsv.

screen
filenumber=5
parsed=cogs-rgl/parsed-cogs-dev.txt
bash utils/parse-cogs.sh \
    cogs-from-orig/orig-data/dev.tsv.0${filenumber} \
    cogs-rgl/LangEng.gf \
    ${parsed}.0${filenumber}

bash utils/interpret-trees.sh \
    cogs-rgl/SemanticsLF.gf \
    ${parsed}.0${filenumber} \
    ${parsed}.0${filenumber}.interpreted.txt


# combine the results
cat ${parsed}.{00..05} \
    > cogs-rgl/parsed-cogs-dev-all.txt
rm ${parsed}.{00..05}

cat ${parsed}.{00..05}.interpreted.txt \
    > cogs-rgl/parsed-cogs-dev-all-interpreted.txt
rm ${parsed}.{00..05}.interpreted.txt



# concrete=cogs-rgl/SemanticsLF.gf
parsed=cogs-rgl/parsed-cogs-dev-all.txt
concrete=cogs-rgl/SemanticsCogsLF.gf
bash utils/interpret-trees.sh \
    ${concrete} \
    ${parsed} \
    ${parsed}.SemanticsCogsLF.interpreted.txt
