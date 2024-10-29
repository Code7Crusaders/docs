#!/bin/bash

files=(

    # "./Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    
    # "./Candidatura/Lettera_di_Presentazione.tex"
    # "./Candidatura/Valutazione_Capitolati.tex"
    # "./Candidatura/analisi_costi_assunzione_impegni.tex"

    # NON TOCCARE CHE MANCA FIRMA CON QUESTA COMPILAZIONE
    "./Candidatura/verbali_esterni/verbale_24-10-18_ergon.tex"
    "./Candidatura/verbali_esterni/verbale_24-10-17_azzurodigitale.tex"

    # "./Candidatura/verbali_esterni/verbale_24-10-18_sanmarco.tex"

    # "./Candidatura/verbali_interni/verbale_24-10-18_v1.0.tex"
    # "./Candidatura/verbali_interni/verbale_24-10-15_v1.0.tex"
    # "./Candidatura/verbali_interni/verbale_24-10-25_v1.0.tex"

    # "./DiariDiBordo/Diario_28-10-2024.tex"

    # "./templateC7C/template.tex"
    # "./templateC7C/slide.tex"

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


