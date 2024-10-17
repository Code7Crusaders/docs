#!/bin/bash

files=(
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex",
    "./Candidatura/Lettera_di_Presentazione.tex"
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


