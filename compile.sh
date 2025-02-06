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

    # "./src/DiariDiBordo/Diario_24-11-18.tex"
    # "./src/DiariDiBordo/Diario_24-10-28.tex"
    # "./src/DiariDiBordo/Diario_24-11-12.tex"
    # "./src/DiariDiBordo/Diario_24-11-25.tex"
    # "./src/DiariDiBordo/Diario_24-12-02.tex"
    # "./src/DiariDiBordo/Diario_24-12-09.tex"
    # "./src/DiariDiBordo/Diario_24-12-18.tex"
    # "./src/DiariDiBordo/Diario_25-01-08.tex"
    #  "./src/DiariDiBordo/Diario_25-01-13.tex"
    
    # "./src/templateC7C/template.tex"
    # "./src/templateC7C/slide.tex"
    # "./src/templateC7C/template-verbali-nuovo/template-verbali.tex"

    "./src/2_RTB/documentazione_esterna/piano_di_progetto_v0.5.tex"
    "./src/2_RTB/documentazione_esterna/piano_di_progetto_v0.6.tex"
    "./src/2_RTB/documentazione_esterna/piano_di_progetto_v0.7.tex"
    "./src/2_RTB/documentazione_esterna/piano_di_qualifica_v0.3.tex"
    "./src/2_RTB/documentazione_esterna/analisi_dei_requisiti/analisi_dei_requisiti.tex"
    
    "./src/2_RTB/documentazione_interna/glossario.tex"
    "./src/2_RTB/documentazione_interna/norme_di_progetto.tex"  
    
    # ----- NON TOCCARE CHE MANCA FIRMA CON QUESTA COMPILAZIONE -----
    # "./src/2_RTB/verbali_esterni/verbale_24-11-14_v1.0.tex"
    #  "./src/2_RTB/verbali_esterni/verbale_24-12-12_v1.0.tex"
    # ----- NON TOCCARE CHE MANCA FIRMA CON QUESTA COMPILAZIONE -----

    # "./src/2_RTB/verbali_interni/verbale_24-11-04_v1.0.tex" 
    # "./src/2_RTB/verbali_interni/verbale_24-11-15_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_24-11-22_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_24-11-29_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_24-12-07_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_24-12-13_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_24-12-19_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_25-01-18_v1.0.tex"
    # "./src/2_RTB/verbali_interni/verbale_25-01-24_v1.0.tex"
    "./src/2_RTB/verbali_interni/verbale_25-02-04_v1.0.tex"

    "src/altri_documenti/analisi_LLM_Bloom_Openai_gpt4/analisi_modelli.tex"
    "src/altri_documenti/analisi_framework_frontend/analisi_frontend.tex"
    "src/altri_documenti/presentazione_rtb/presentazione_rtb.tex"

    "./src/2_RTB/lettera_di_presentazione.tex"

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

