#!/bin/bash


files=(

    # Diari di bordo
    # "./src/DiariDiBordo/Diario_18-11-2024.tex"
    # "./src/DiariDiBordo/Diario_28-10-2024.tex"
    # "./src/DiariDiBordo/Diario_12-11-2024.tex"

    # Template
    # "./src/templateC7C/template.tex"
    # "./src/templateC7C/slide.tex"
    # "./src/templateC7C/template-verbali-nuovo/template-verbali.tex"

    # Candidatura

    # "./src/1_Candidatura/DomandeProponenti/Domande_Proponenti.tex"
    
    # "./src/1_Candidatura/Lettera_di_Presentazione.tex"
    # "./src/1_Candidatura/Valutazione_Capitolati_v1.0.tex"
    # "./src/1_Candidatura/analisi_costi_assunzione_impegni_v1.0.tex"

    # ----- NON TOCCARE CHE MANCA FIRMA CON QUESTA COMPILAZIONE -----
    # "./Candidatura/verbali_esterni/verbale_24-10-18_ergon_v1.0.tex"
    # "./Candidatura/verbali_esterni/verbale_24-10-17_azzurodigitale_v1.0.tex"
    # "./Candidatura/verbali_esterni/verbale_24-10-18_sanmarco_v1.0.tex"
    # ----- NON TOCCARE CHE MANCA FIRMA CON QUESTA COMPILAZIONE -----

    # "./src/1_Candidatura/verbali_interni/verbale_24-10-18_v1.0.tex"
    # "./src/1_Candidatura/verbali_interni/verbale_24-10-15_v1.0.tex"
    # "./src/1_Candidatura/verbali_interni/verbale_24-10-25_v1.0.tex"

    # RTB

    # "./src/2_RTB/documentazione_interna/glossario.tex"
    # "./src/2_RTB/documentazione_interna/norme_di_progetto.tex"

    "./src/2_RTB/documentazione_esterna/analisi_dei_requisiti.tex"
    
    # "./src/2_RTB/verbali_esterni/verbale_24-11-14_v0.1.tex"

    # "./src/2_RTB/verbali_interni/verbale_24-11-04_v0.1.tex" 
    # "./src/2_RTB/verbali_interni/verbale_24-11-15_v0.1.tex"

)

current_dir=$(pwd)

for i in "${!files[@]}"; do
  filename=$(basename -- "${files[$i]}")
  dirname=$(dirname -- "${files[$i]}")

  output_dir="${dirname/src/pdf}"

  dirname="${dirname#./}"
  output_dir="${output_dir#./}"

  absolute_output_dir="$current_dir/$output_dir"
  absolute_dirname="$current_dir/$dirname"

  echo "Compiling $filename in $absolute_dirname"
  echo "Output will be stored in $absolute_output_dir"

  mkdir -p "$output_dir"
  latexmk -pdf -latexoption=-file-line-error -latexoption=-interaction=nonstopmode -cd -outdir="$absolute_output_dir" "$absolute_dirname/$filename"
  latexmk -c -outdir="$absolute_output_dir" "$absolute_dirname/$filename"

done

