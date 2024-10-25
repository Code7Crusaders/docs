#!/bin/bash

files=(
    #"./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    #"./Candidatura/Lettera_di_Presentazione.tex"
    #"./templateC7C/slide.tex"

    # INTERNI
    # "./Candidatura/verbali_interni/verbale_24-10-15_v1.0.tex"
    # "./Candidatura/verbali_interni/verbale_24-10-18_v1.0.tex"

    # ESTERNI
    # "./Candidatura/verbali_esterni/verbale_24-10-18_ergon.tex"
    # "./Candidatura/verbali_esterni/verbale_24-10-17_azzurodigitale.tex"
    "./Candidatura/verbali_esterni/verbale_24-10-18_sanmarco.tex"
     
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


