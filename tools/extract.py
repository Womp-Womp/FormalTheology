"""
Extract every verse a Lean file cites into data/cited/<Name>.json (committed), so proofs can be
re-checked anywhere without the 150 MB corpus.

  python -I tools/extract.py lean/Matthew22.lean
"""
import json, os, re, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import CITED_DIR, LAYERS, REF_RE, ROOT, TAG_LAYER, get_verse, original_layer, utf8_stdout

HEADER = re.compile(rf"@(?:term|cite)\s+({REF_RE})")
OVERRIDE = re.compile(rf"\b(HEB|GRK|KJV|BSB|VUL)@({REF_RE}):")

def needed(src):
    need = set()
    for ref in HEADER.findall(src):
        need.add((original_layer(ref), ref))
        for layer in ("lat", "kjv", "bsb"):
            need.add((layer, ref))
    for tag, ref in OVERRIDE.findall(src):
        need.add((TAG_LAYER[tag], ref))
    return need

def main():
    utf8_stdout()
    path = sys.argv[1]
    name = os.path.splitext(os.path.basename(path))[0]
    src = open(path, encoding="utf-8").read()
    spec = json.load(open(os.path.join(ROOT, "sources", "SOURCES.json"), encoding="utf-8"))
    verses, missing = {}, []
    for layer, ref in sorted(needed(src)):
        v = get_verse(layer, ref)
        if v is None:
            missing.append(f"{layer}|{ref}")
        else:
            verses[f"{layer}|{ref}"] = v
    os.makedirs(CITED_DIR, exist_ok=True)
    out = os.path.join(CITED_DIR, f"{name}.json")
    with open(out, "w", encoding="utf-8") as f:
        json.dump({"file": f"lean/{name}.lean",
                   "sources": {s["id"]: {"sha256": s["sha256"], "url": s["url"], "license": s["license"]}
                               for s in spec["files"]},
                   "verses": verses}, f, ensure_ascii=False, indent=1, sort_keys=True)
    print(f"wrote {os.path.relpath(out, ROOT)}: {len(verses)} verse-layers")
    if missing:
        print("  not present (expected when numbering differs; cite that layer with TAG@REF):", ", ".join(missing))

if __name__ == "__main__":
    main()
