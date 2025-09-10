#!/bin/bash

echo "gt -depth=100000000000 | l -tabtreebank"  | gf --run ${1}.gf | awk 'NF' | sort > ${1}-both.txt

# get just the trees which are the first tab separated column
awk -F'\t' '{print $1}' ${1}-both.txt | sort | uniq > ${1}-trees.txt

# then sequences
awk -F'\t' '{print $2}' ${1}-both.txt | sort | uniq > ${1}-sequences.txt

echo ""
echo "number of trees:"
wc -l ${1}-trees.txt
echo "`cat ${1}-trees.txt | sort | uniq | wc -l` are unique"

echo ""
echo "number of sequences:"
wc -l ${1}-sequences.txt
echo "`cat ${1}-sequences.txt | sort | uniq | wc -l` are unique"

echo ""
# python3 dataset_properties.py ${1}-both.txt
