#!/bin/bash
# Per cancellare file ausiliari
files=(
    "./Candidatura/Lettera_di_Presentazione.tex"
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    "./Candidatura/verbali_interni/verbale_171024_azzurrodigitaleint_v0.1.tex"
    "./Candidatura/verbali_esterni/verbale_181024_ergon.tex"
    "./Candidatura/verbali_esterni/verbale_171024_azzurodigitale_v0.1.tex"
)


initial_path=$(pwd)

for file in ${files[@]}; do
    if cd $(dirname $file); then
    rm -f $(basename $file .tex).log $(basename $file .tex).aux $(basename $file .tex).out $(basename $file .tex).toc $(basename $file .tex).pdf
    fi
    cd $initial_path
done