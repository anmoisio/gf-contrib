

# parse and interpret in parallel
split -d -l 500 \
    cogs-from-orig/orig-data/dev.tsv \
    cogs-from-orig/orig-data/dev.tsv.
screen
filenumber=5
bash utils/parse-cogs.sh \
    cogs-from-orig/orig-data/dev.tsv.0${filenumber} \
    cogs-rgl/LangEng.gf \
    cogs-rgl/parsed-cogs-dev.txt.0${filenumber}

bash utils/interpret-trees.sh \
    cogs-rgl/SemanticsLF.gf \
    cogs-rgl/parsed-cogs-dev.txt.0${filenumber}


# combine the results
cat cogs-rgl/parsed-cogs-dev.txt.* \
    > cogs-rgl/parsed-cogs-dev-all.txt
rm cogs-rgl/parsed-cogs-dev.txt.*

cat cogs-rgl/parsed-cogs-dev.txt.*.interpreted \
    > cogs-rgl/parsed-cogs-dev-all.txt.interpreted
rm cogs-rgl/parsed-cogs-dev.txt.*.interpreted

