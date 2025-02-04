import re

# Funzione parsing del gloassario, es. Parola1 ("Parola parola2") prende come chiavi tutte e due Parola1 e "Parola parola2" e mette come valore lo stesso link

def crea_hashmap_glossario(percorso_file):
    hashmap = {}
    base_url = "https://code7crusaders.github.io/docs/RTB/documentazione_interna/glossario.html#"
    pattern_subsection = r"\\subsection\{(.+?)\}"

    try:
        with open(percorso_file, "r", encoding="utf-8") as file:
            contenuto = file.read()

        matches = re.findall(pattern_subsection, contenuto)

        for parola in matches:
            parola_format = parola.replace(" ", "-")
            parola_format = parola_format.replace("(", "").replace(")", "")

            link = f"{base_url}{parola_format.lower()}"

            varianti = [parola]
            if "(" in parola and ")" in parola:
                senza_parentesi = parola.split("(")[0].strip()
                varianti.append(senza_parentesi)

                acronimo = parola[parola.find("(")+1:parola.find(")")]
                varianti.append(acronimo)

            for variante in varianti:
                if variante not in hashmap:
                    hashmap[variante] = link  

        return hashmap
    except FileNotFoundError:
        print(f"Errore: Il file {percorso_file} non esiste.")
        return None

# Funzione che aggiunge stile alle parole (G alta) e modifica il documento, gestisce anche prefissi suffissi (problemi con subsection)

import re

def aggiungi_stile_hyperlink_latex(percorso_file, hashmap):
    try:
        with open(percorso_file, "r", encoding="utf-8") as file:
            contenuto = file.readlines()

        pattern_sezioni_principali = r"\\(section|chapter|part)\{.*?\}"
        pattern_sezioni_sottolivello = r"\\(subsection|subsubsection|subsubsubsection|subsubsubsubsection|paragraph)\{.*?\}"
        pattern_url = r"\\url\{[^}]+\}"  

        in_titolo_sezione = False
        
        for i, riga in enumerate(contenuto):
            nuova_riga = ""
            ultimo_indice = 0

            if re.match(pattern_sezioni_principali, riga):
                in_titolo_sezione = True
                continue  # Salta il processamento di queste righe
            
            if re.match(pattern_sezioni_sottolivello, riga):
                in_titolo_sezione = False  # Permetti la modifica
                
            if in_titolo_sezione:
                continue  # Non modificare i contenuti delle sezioni principali
            
            href_matches = list(re.finditer(r"\\href\{[^}]+\}\{[^}]+\}", riga))
            url_matches = list(re.finditer(pattern_url, riga))

            for parola, link in hashmap.items():
                pattern = rf"(?<=\s){re.escape(parola)}(?=\s)"

                for match in re.finditer(pattern, riga):
                    start, end = match.span()

                    if any(href_match.start() <= start < href_match.end() for href_match in href_matches) or \
                       any(url_match.start() <= start < url_match.end() for url_match in url_matches):
                        continue

                    nuova_riga += riga[ultimo_indice:start]
                    nuova_riga += f"\\href{{{link}}}{{{parola}\\textsuperscript{{G}}}}"
                    ultimo_indice = end

            nuova_riga += riga[ultimo_indice:]
            if nuova_riga:
                contenuto[i] = nuova_riga

        with open(percorso_file, "w", encoding="utf-8") as file:
            file.writelines(contenuto)

        print(f"Hyperlink aggiunti correttamente nel file {percorso_file}.")
    except FileNotFoundError:
        print(f"Errore: Il file {percorso_file} non esiste.")
# MAIN

percorso_glossario = "./docs/src/2_RTB/documentazione_interna/glossario.tex" # Inserire il percorso del file del glossario
hashmap = crea_hashmap_glossario(percorso_glossario)
print(hashmap)
if hashmap:
    percorso_file_modificare = "./docs/src/2_RTB/documentazione_esterna/piano_di_qualifica_v0.3.tex" # Inserire il percorso del file da modificare
    aggiungi_stile_hyperlink_latex(percorso_file_modificare, hashmap)

