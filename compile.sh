#!/bin/bash

files=(
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    "./Candidatura/Lettera_di_Presentazione.tex"
    "./Candidatura/Valutazione_Capitolati.tex"
    "./Candidatura/verbali_esterni/verbale_181024_ergon_v1.0.tex"
    "./Candidatura/verbali_esterni/verbale_171024_azzurodigitale_v1.0.tex"
    "./Candidatura/verbali_esterni/verbale_181024_sanmarco_v1.0.tex"
    "./Candidatura/verbali_interni/verbale_15182024_v1.0.tex"
    "./Candidatura/verbali_interni/verbale_18102024_v1.0.tex"
    "./templateC7C/template.tex"
    "./templateC7C/slide.tex"
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


