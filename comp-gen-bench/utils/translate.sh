
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <srcgrammar> <tgtgrammar> <input_file> <output_file>"
    echo "For example: bash $0 cogs-rgl/LangEng.gf cogs-rgl/LangFin.gf cogs-from-orig/orig-data/train.sentences.txt.100 cogs-from-orig/orig-data/train.sentences.txt.100.translated.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    echo 'p -lang=Eng "$p" | linearize -lang=Fin' | gf --run "$1" "$2" >> "$4"
done < "$3"
