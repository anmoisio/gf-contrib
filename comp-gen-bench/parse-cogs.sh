 
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <grammar> <output_file>"
    echo "For example: $0 cogs-rgl/LangEng.gf cogs-rgl/parsed-cogs-dev.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    echo "$p" | cut -f1 >> "$2"
    sent=$(echo "$p" | cut -f1)
    lowercase="${sent/'The '/'the '}"
    lowercase2="${lowercase/'A '/'a '}"
    echo p \"${lowercase2}\" | tr -d '.' | gf --run "$1" >> "$2"

done <  "cogs-from-orig/orig-data/dev.tsv"
