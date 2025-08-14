#!/bin/bash

echo "gt -depth=100 | l -tabtreebank" | gf --run ${1}.gf ${2}.gf | awk 'NF' | sort > ${1}-trees-and-sequences.txt

echo ""
echo "number of trees:"
wc -l ${1}-trees-and-sequences.txt
echo "$(cut -f1 ${1}-trees-and-sequences.txt | sort | uniq | wc -l) are unique"

echo ""
echo "number of input sequences:"
wc -l ${1}-trees-and-sequences.txt
echo "$(cut -f2 ${1}-trees-and-sequences.txt | sort | uniq | wc -l) are unique"

echo ""
echo "number of output sequences:"
wc -l ${1}-trees-and-sequences.txt
echo "$(cut -f3 ${1}-trees-and-sequences.txt | sort | uniq | wc -l) are unique"

echo ""
python3 dataset_properties.py ${1}-trees-and-sequences.txt
