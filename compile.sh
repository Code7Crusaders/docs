#!/bin/bash

files=(
    "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    "./templateC7C/template.tex"
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


