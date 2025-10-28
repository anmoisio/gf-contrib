
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <grammar> <input_file> <output_file>"
    echo "For example: bash $0 cogs-rgl/SemanticsLF.gf cogs-rgl/parsed-cogs-dev.txt cogs-rgl/parsed-cogs-dev-interpreted.txt"
    exit 1
fi

i=-1
while IFS="" read -r p || [ -n "$p" ]
do
    # all trees start with "UseCl"
    if [[ "$p" == UseCl* ]]; then
        echo "####tree $i: $p" >> "$3.trees"
        echo "####interpretation and linearisation $i:" >> "$3.linearised"
        echo "pt -compute -tr Wrapper (iS (${p})) | linearize" | gf --run "$1" >> "$3.linearised"
    else
        if [ -n "$p" ]; then
            # check whether the line includes "The parser failed at token" or "The sentence is not complete"
            if [[ "$p" == *"The parser failed at token"* ]] || [[ "$p" == *"The sentence is not complete"* ]]; then
                continue
            fi
            i=$((i+1))
            echo "####sentence $i: $p" >> "$3.sentences"
        fi
    fi
done < "$2"
