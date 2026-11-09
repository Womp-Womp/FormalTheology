"""
Build the whole-Bible corpus (.cache/corpus/<layer>/<BOOK>.json) from verified sources.

  python -I tools/build_corpus.py

Each layer keeps ITS OWN versification (Hebrew, Vulgate and English differ in places);
citations name the reference per layer, so nothing is silently re-aligned.
"""
import csv, json, os, re, sys
from collections import defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import CORPUS_DIR, SRC_DIR, utf8_stdout

def write_layer(layer, books):
    os.makedirs(os.path.join(CORPUS_DIR, layer), exist_ok=True)
    for book, verses in books.items():
        with open(os.path.join(CORPUS_DIR, layer, f"{book}.json"), "w", encoding="utf-8") as f:
            json.dump({"layer": layer, "book": book, "verses": verses}, f, ensure_ascii=False)
    n = sum(len(v) for v in books.values())
    print(f"  {layer}: {len(books)} books, {n} verses")

def build_greek():
    books = defaultdict(dict)
    rows = defaultdict(list)
    with open(os.path.join(SRC_DIR, "macula-greek-Nestle1904.tsv"), encoding="utf-8", newline="") as f:
        for r in csv.DictReader(f, delimiter="\t"):
            b, rest = r["ref"].split(" ", 1)
            cv, n = rest.split("!")
            rows[(b, cv)].append((int(n), r))
    for (b, cv), ws in rows.items():
        ws.sort(key=lambda x: x[0])
        words = [{"text": r["text"], "after": r["after"], "lemma": r["lemma"], "strong": r["strong"],
                  "morph": r["morph"], "gloss": r["gloss"], "english": r["english"], "ln": r["ln"]}
                 for _, r in ws]
        books[b][cv] = {"text": "".join(w["text"] + w["after"] for w in words).strip(),
                        "lemmas": sorted({w["lemma"] for w in words}), "words": words}
    write_layer("grc", books)

def build_hebrew():
    books = defaultdict(dict)
    rows = defaultdict(list)
    with open(os.path.join(SRC_DIR, "macula-hebrew.tsv"), encoding="utf-8", newline="") as f:
        for r in csv.DictReader(f, delimiter="\t"):
            b, rest = r["ref"].split(" ", 1)
            cv = rest.split("!")[0]
            rows[(b, cv)].append((r["xml:id"], r))
    for (b, cv), ws in rows.items():
        ws.sort(key=lambda x: x[0])
        words = [{"text": r["text"], "after": r["after"], "lemma": r["lemma"],
                  "strong": r["strongnumberx"], "morph": r["morph"], "gloss": r["gloss"],
                  "english": r["english"], "lxx": r["greek"], "lxx_strong": r["greekstrong"],
                  "translit": r["transliteration"], "w": int(r["ref"].split("!")[1])}
                 for _, r in ws]
        # Rows are morphemes. Join morphemes of one word directly; between words use the
        # source's separator, or a space when the source gives none (else words run together).
        parts = []
        for i, w in enumerate(words):
            parts.append(w["text"] + w["after"])
            last_of_word = i + 1 == len(words) or words[i + 1]["w"] != w["w"]
            if last_of_word and w["after"] == "":
                parts.append(" ")
        books[b][cv] = {"text": " ".join("".join(parts).split()),
                        "lemmas": sorted({w["lemma"] for w in words if w["lemma"]}), "words": words}
    write_layer("heb", books)

VPL = re.compile(r"^([1-4A-Z]{3}) (\d+):(\d+) ?(.*)$")

def build_vpl(layer, folder, fname):
    books = defaultdict(dict)
    with open(os.path.join(SRC_DIR, folder, fname), encoding="utf-8-sig") as f:
        for line in f:
            m = VPL.match(line.rstrip("\n"))
            if not m:
                continue
            b, c, v, t = m.groups()
            entry = {"text": " ".join(t.split())}
            if layer == "kjv":
                entry["marked"] = entry["text"]                       # [brackets] = supplied words
                entry["text"] = " ".join(t.replace("[", "").replace("]", "").split())
            books[b][f"{c}:{v}"] = entry
    write_layer(layer, books)

def main():
    utf8_stdout()
    print("building corpus:")
    build_greek()
    build_hebrew()
    build_vpl("lat", "latVUC_vpl", "latVUC_vpl.txt")
    build_vpl("kjv", "eng-kjv_vpl", "eng-kjv_vpl.txt")
    build_vpl("bsb", "engbsb_vpl", "engbsb_vpl.txt")

if __name__ == "__main__":
    main()
