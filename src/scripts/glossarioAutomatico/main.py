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

def aggiungi_stile_hyperlink_latex(percorso_file, hashmap):
    try:
        with open(percorso_file, "r", encoding="utf-8") as file:
            contenuto = file.readlines()

        # Pattern per identificare i comandi \subsection{}, \subsubsection{}, ecc.
        pattern_sezioni = r"\\(subsection|subsubsection|subsubsubsection|subsubsubsubsection|section|chapter|paragraph)\{.*?\}"

        for i, riga in enumerate(contenuto):
            nuova_riga = ""
            ultimo_indice = 0

            # Se la riga è una sezione, la saltiamo
            if re.match(pattern_sezioni, riga):
                continue

            href_matches = list(re.finditer(r"\\href\{[^}]+\}\{[^}]+\}", riga))

            for parola, link in hashmap.items():
                pattern = rf"(\\(?:textbf|emph|textit|texttt|textsf|underline){{)?{re.escape(parola)}(\}})?"

                for match in re.finditer(pattern, riga):
                    start, end = match.span()

                    # Verifica che la parola non sia già in un hyperlink
                    if any(href_match.start() <= start < href_match.end() for href_match in href_matches):
                        continue

                    nuova_riga += riga[ultimo_indice:start]

                    prefisso = match.group(1) or ""
                    suffisso = match.group(2) or ""

                    nuova_riga += f"\\href{{{link}}}{{{prefisso}{parola}{suffisso}\\textsuperscript{{G}}}}"
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

percorso_glossario = "glossario.tex"
hashmap = crea_hashmap_glossario(percorso_glossario)
print(hashmap)
if hashmap:
    percorso_file_modificare = "analisi_costi_assunzione_impegni_v1.0.tex"  
    aggiungi_stile_hyperlink_latex(percorso_file_modificare, hashmap)
