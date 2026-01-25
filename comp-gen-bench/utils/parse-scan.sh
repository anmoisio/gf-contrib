
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <grammar> <output_file>"
    echo "For example: "
    echo "  bash $0 scan/train-input.txt scan/ScanInput.gf scan/parsed-train-input.txt"
    exit 1
fi

while IFS="" read -r p || [ -n "$p" ]
do
    echo "$p" | cut -f1 >> "$3"
    sent=$(echo "$p" | cut -f1)
    echo p \"${sent}\" | tr -d '.' | gf --run "$2" >> "$3"

done < "$1"
