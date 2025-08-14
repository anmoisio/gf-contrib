#!/bin/bash

echo "gt -depth=100 | l" | gf --run ${1}.gf | awk 'NF' | sort > ${1}-sequences.txt
echo "gt -depth=100"     | gf --run ${1}.gf | awk 'NF' | sort > ${1}-trees.txt
echo "gt -depth=100 | l -tabtreebank"     | gf --run ${1}.gf | awk 'NF' | sort > ${1}-both.txt

echo ""
echo "number of trees:"
wc -l ${1}-trees.txt
echo "`cat ${1}-trees.txt | sort | uniq | wc -l` are unique"

echo ""
echo "number of sequences:"
wc -l ${1}-sequences.txt
echo "`cat ${1}-sequences.txt | sort | uniq | wc -l` are unique"

echo ""
python3 dataset_properties.py ${1}-both.txt
