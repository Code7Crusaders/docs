#!/bin/bash
# Per cancellare file ausiliari
files=(
    #"./Candidatura/Lettera_di_Presentazione.tex"
    #"./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    #"./Candidatura/verbali_interni/verbale_171024_azzurrodigitaleint_v0.1.tex"
    "./Candidatura/verbali_esterni/verbale_24-10-18_ergon.tex"
    "./Candidatura/verbali_esterni/verbale_24-10-17_azzurodigitale_v0.1.tex"
    "./Candidatura/verbali_esterni/verbale_24-10-18_sanmarco.tex"
    #"./Candidatura/verbali_interni/verbale_181024_azzurrodigitaleint_v0.1.tex"
    "./Candidatura/verbali_interni/verbale_24-10-18_v1.0.tex"
    "./Candidatura/verbali_interni/verbale_24-10-15_v1.0.tex"
)


initial_path=$(pwd)

for file in ${files[@]}; do
    if cd $(dirname $file); then
    rm -f $(basename $file .tex).log $(basename $file .tex).aux $(basename $file .tex).out $(basename $file .tex).toc $(basename $file .tex).pdf
    fi
    cd $initial_path
done