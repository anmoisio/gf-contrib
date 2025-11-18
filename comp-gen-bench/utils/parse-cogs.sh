
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <grammar> <output_file>"
    echo "For example: "
    echo "  bash $0 cogs-from-orig/orig-data/dev.tsv cogs-rgl/LangEng.gf cogs-rgl/parsed-cogs-dev.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    echo "$p" | cut -f1 >> "$3"
    sent=$(echo "$p" | cut -f1)
    lowercase="${sent/'The '/'the '}"
    lowercase2="${lowercase/'A '/'a '}"
    lowercase3="${lowercase2/'What '/'what '}"
    lowercase4="${lowercase3/'Who '/'who '}"
    echo p \"${lowercase4}\" | tr -d '.' | gf --run "$2" >> "$3"

done < "$1"
