"""
Build an aligned, word-by-word data file for a passage.

  python -I tools/build_passage.py <macula.tsv> <vulgate_chapter.txt> <english.json> <out.json> <BOOK> <CH> <V1> <V2>

Layers per verse:
  greek   : Nestle 1904 words from MACULA Greek (CC BY 4.0, Biblica / Clear Bible):
            text, lemma, Strong's, morphology, English gloss, Louw-Nida domain
  latin   : Clementine Vulgate 1598 (public domain, via eBible.org latVUC)
  kjv/bsb : from Tim's BibleReadingApp MCP server (public domain texts)

Also writes a small vendored TSV slice next to the output so the repo rebuilds
without the 19 MB source file.
"""
import csv, json, sys, os

def main():
    sys.stdout.reconfigure(encoding="utf-8")  # Greek on a Windows console (-I ignores PYTHONIOENCODING)
    tsv, vul, eng, out, book, ch, v1, v2 = sys.argv[1:9]
    ch, v1, v2 = int(ch), int(v1), int(v2)
    verses = {v: {"ref": f"{book} {ch}:{v}", "greek_words": []} for v in range(v1, v2 + 1)}

    slice_rows = []
    with open(tsv, encoding="utf-8", newline="") as f:
        rd = csv.DictReader(f, delimiter="\t")
        header = rd.fieldnames
        for row in rd:
            ref = row["ref"]                      # e.g. "1CO 15:13!3"
            b, rest = ref.split(" ", 1)
            cv = rest.split("!")[0]
            c, v = (int(x) for x in cv.split(":"))
            if b != book or c != ch or v not in verses:
                continue
            slice_rows.append(row)
            verses[v]["greek_words"].append({
                "n": int(rest.split("!")[1]),
                "text": row["text"], "after": row["after"],
                "lemma": row["lemma"], "strong": row["strong"], "morph": row["morph"],
                "gloss": row["gloss"], "english": row["english"],
                "louw_nida": row["ln"], "domain": row["domain"],
            })

    for v, d in verses.items():
        d["greek_words"].sort(key=lambda w: w["n"])
        d["greek"] = "".join(w["text"] + w["after"] for w in d["greek_words"]).strip()
        d["lemmas"] = sorted({w["lemma"] for w in d["greek_words"]})

    # Vulgate readaloud file: line 1 book title, line 2 chapter, then one verse per line
    with open(vul, encoding="utf-8-sig") as f:
        lines = [l.rstrip("\n").strip() for l in f]
    for v, d in verses.items():
        d["latin"] = lines[v + 1]

    with open(eng, encoding="utf-8") as f:
        en = json.load(f)
    for v, d in verses.items():
        d["kjv"] = en["KJV"][str(v)]
        d["bsb"] = en["BSB"][str(v)]

    doc = {
        "passage": f"{book} {ch}:{v1}-{v2}",
        "sources": {
            "greek": "MACULA Greek, Nestle1904 TSV. (c) 2022-2024 Biblica, Inc. CC BY 4.0. https://github.com/Clear-Bible/macula-greek",
            "latin": "Clementine Vulgate 1598 (public domain), eBible.org latVUC readaloud text",
            "english": "KJV and BSB (public domain), via BibleReadingApp MCP",
        },
        "verses": [verses[v] for v in sorted(verses)],
    }
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, "w", encoding="utf-8") as f:
        json.dump(doc, f, ensure_ascii=False, indent=1)

    slice_path = os.path.join(os.path.dirname(out), f"macula_{book}{ch}_{v1}-{v2}.tsv")
    with open(slice_path, "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=header, delimiter="\t")
        w.writeheader(); w.writerows(slice_rows)

    for d in doc["verses"]:
        print(d["ref"], "|", d["greek"])
        print("   lemmas:", " ".join(d["lemmas"]))
        print("   VUL:", d["latin"])

if __name__ == "__main__":
    main()
