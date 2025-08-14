#!/bin/bash

echo "gr -depth=15 -number=5000 -probs=probs.txt | l -tabtreebank" | gf --run ${1}.gf | awk 'NF' > ${1}-trees-and-sequences.txt
