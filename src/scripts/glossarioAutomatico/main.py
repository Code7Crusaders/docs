import re

def crea_hashmap_glossario(percorso_file):
    hashmap = {}
    base_url = "https://code7crusaders.github.io/docs/RTB/documentazione_interna/glossario.html#"
    pattern_subsection = r"\\subsection\{(.+?)\}"

    try:
        with open(percorso_file, "r", encoding="utf-8") as file:
            contenuto = file.read()

        matches = re.findall(pattern_subsection, contenuto)

        for parola in matches:
            parola_format = parola.replace(" ", "-").replace("(", "").replace(")", "")

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

def aggiungi_stile_hyperlink_latex(percorso_file, hashmap):
    parole_escluse = {"RTB", "API", "SQL"}  # Aggiungi parole da escludere se necessario

    try:
        with open(percorso_file, "r", encoding="utf-8") as file:
            contenuto = file.readlines()

        pattern_sezioni_principali = re.compile(r"\\(section|chapter|part)\{.*?\}")
        pattern_sezioni_sottolivello = re.compile(r"\\(subsection|subsubsection|paragraph)\{.*?\}")
        pattern_href = re.compile(r"\\href\{[^}]+\}\{[^}]+\}")
        pattern_url = re.compile(r"\\url\{[^}]+\}")

        in_titolo_sezione = False

        for i, riga in enumerate(contenuto):
            if pattern_sezioni_principali.match(riga):
                in_titolo_sezione = True
                continue  
            if pattern_sezioni_sottolivello.match(riga):
                in_titolo_sezione = False  
            if in_titolo_sezione:
                continue  

            href_matches = list(pattern_href.finditer(riga))
            url_matches = list(pattern_url.finditer(riga))

            nuova_riga = riga
            for parola, link in hashmap.items():
                if parola in parole_escluse:
                    continue  # Salta parole che non devono essere sostituite

                # Assicura che la parola sia un termine completo e non parte di un'altra parola
                pattern = re.compile(rf"(?<!\w)(\\(?:textbf|emph|textit|texttt|textsf|underline){{)?{re.escape(parola)}(}})?(?!\w)")

                nuova_riga = pattern.sub(
                    lambda match: f"\\href{{{link}}}{{{match.group(1) or ''}{parola}{match.group(2) or ''}\\textsuperscript{{G}}}}" 
                    if not any(m.start() <= match.start() < m.end() for m in href_matches + url_matches) 
                    else match.group(0),
                    nuova_riga
                )

            contenuto[i] = nuova_riga

        with open(percorso_file, "w", encoding="utf-8") as file:
            file.writelines(contenuto)

        print(f"Hyperlink aggiunti correttamente nel file {percorso_file}.")
    except FileNotFoundError:
        print(f"Errore: Il file {percorso_file} non esiste.")


# MAIN

percorso_glossario = "pathtoglossary" # Inserire il percorso del file glossario.tex
hashmap = crea_hashmap_glossario(percorso_glossario)
print(hashmap)
if hashmap:
    percorso_file_modificare = "pathtofile"  # Inserire il percorso del file da modificare 
    aggiungi_stile_hyperlink_latex(percorso_file_modificare, hashmap)
