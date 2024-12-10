import os
import re
from PyPDF2 import PdfReader

def analyze_pdf(file_path):
    """Analizza un singolo file PDF e restituisce le sue statistiche."""
    reader = PdfReader(file_path)
    text = ""
    for page in reader.pages:
        text += page.extract_text()

    # Conta lettere, parole e frasi
    num_letters = sum(c.isalpha() for c in text)
    words = re.findall(r'\b\w+\b', text)
    num_words = len(words)
    sentences = re.split(r'[.!?]', text)
    num_sentences = len([s for s in sentences if s.strip()])

    return {
        "num_letters": num_letters,
        "num_words": num_words,
        "num_sentences": num_sentences,
    }

def analyze_pdfs_in_directory(directory):
    """Analizza tutti i file PDF in una directory e nelle sue sottodirectory."""
    results = {}
    total_letters = 0
    total_words = 0
    total_sentences = 0

    # Attraversa la directory e le sottodirectory
    for root, _, files in os.walk(directory):
        for file in files:
            if file.lower().endswith('.pdf'):
                file_path = os.path.join(root, file)
                print(f"Analizzando: {file_path}")
                try:
                    stats = analyze_pdf(file_path)
                    results[file_path] = stats
                    total_letters += stats["num_letters"]
                    total_words += stats["num_words"]
                    total_sentences += stats["num_sentences"]
                except Exception as e:
                    print(f"Errore durante l'elaborazione di {file_path}: {e}")

    return results, total_letters, total_words, total_sentences

# Directory contenente i file PDF
directory_path =  "../../../pdf/"

# Analizza tutti i PDF e stampa i risultati
all_results, total_letters, total_words, total_sentences = analyze_pdfs_in_directory(directory_path)

for file_path, stats in all_results.items():
    print(f"\nFile: {file_path}")
    print(f"  Numero di lettere: {stats['num_letters']}")
    print(f"  Numero di parole: {stats['num_words']}")
    print(f"  Numero di frasi: {stats['num_sentences']}")

# Stampa i totali
print("\nTotali:")
print(f"  Numero totale di lettere: {total_letters}")
print(f"  Numero totale di parole: {total_words}")
print(f"  Numero totale di frasi: {total_sentences}")
