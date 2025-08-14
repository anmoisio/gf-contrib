
while IFS="" read -r p || [ -n "$p" ]
do
    echo "$p" | cut -f1 >> parsed-sents.txt
    sent=$(echo "$p" | cut -f1)
    lowercase="${sent/'The '/'the '}"
    lowercase2="${lowercase/'A '/'a '}"
    echo p \"${lowercase2}\" | tr -d '.' | gf --run CogsCon.gf >> parsed-sents.txt

done <  "/m/triton/scratch/morphogen/ComComGenBen-old/datasets/COGS/data/dev.tsv"
