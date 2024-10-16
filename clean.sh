#!/bin/bash
# Per cancellare file ausiliari
files=(
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
)


initial_path=$(pwd)

for file in ${files[@]}; do
    if cd $(dirname $file); then
    rm -f $(basename $file .tex).log $(basename $file .tex).aux $(basename $file .tex).out $(basename $file .tex).toc
    fi
    cd $initial_path
done