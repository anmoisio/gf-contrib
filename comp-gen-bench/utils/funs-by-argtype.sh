
if [ "$#" -ne 2 ]; then
    echo "Usage:   $0 <grammar> <argcat>"
    echo "e.g.:    $0 cogs-miniresource/MiniLangEng.gf NP"
    exit 1
fi

grammar=$1
argcat=$2
echo "pg -funs" | gf --run $1 | grep " $argcat ->"
