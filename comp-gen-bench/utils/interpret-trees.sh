
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <grammar> <input_file> <output_file>"
    echo "For example: bash $0 cogs-rgl/SemanticsLF.gf cogs-rgl/parsed-cogs-dev.txt cogs-rgl/parsed-cogs-dev-interpreted.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    # all trees start with "UseCl"
    if [[ "$p" == UseCl* ]]; then
        echo "$p" >> "$3"
        echo "pt -compute -tr Wrapper (iS (${p})) | linearize" | gf --run "$1" >> "$3"
    else
        echo "$p" >> "$3"
    fi
done < "$2"
