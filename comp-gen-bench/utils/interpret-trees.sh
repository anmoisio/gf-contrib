
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <grammar> <input_file>"
    echo "For example: bash $0 cogs-rgl/SemanticsLF.gf cogs-rgl/parsed-cogs-dev7.txt"
    echo "Output will be written to <input_file>.interpreted.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    # all trees start with "PhrUtt NoPConj ("
    if [[ "$p" == PhrUtt\ NoPConj* ]]; then
        echo "$p" | cut -f1 >> "$2"
        # regex the part between "PhrUtt NoPConj (UttS " and "") NoVoc"
        regexed=$(echo "$p" | sed -n 's/.*PhrUtt NoPConj (UttS \(.*\)) NoVoc.*/\1/p')
        echo "$regexed" >> "$2".interpreted.txt
        echo "pt -compute -tr Wrapper (iS ${regexed}) | linearize" | gf --run "$1" >> "$2".interpreted.txt
    else
        echo "$p" >> "$2".interpreted.txt
    fi

done < "$2"
