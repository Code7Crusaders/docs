#!/bin/bash

files=(
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    "./Candidatura/Lettera_di_Presentazione.tex"
    "./Candidatura/verbali_interni/verbale_171024_azzurrodigitaleint_v0.1.tex"
    "./Candidatura/verbali_esterni/verbale_181024_ergon.tex"
    "./Candidatura/verbali_esterni/verbale_171024_azzurodigitale_v0.1.tex"
    "./Candidatura/verbali_esterni/verbale_181024_sanmarco.tex"
)

for file in ${files[@]}; do
  if cd $(dirname $file); then
    pdflatex -interaction=batchmode $(basename $file)
    echo "File $(basename $file .tex).pdf created"
    cd -
  else
    echo "Failed to change directory to $(dirname $file)"
  fi
done


