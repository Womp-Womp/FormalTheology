"""
Show a verse in every layer, word by word.

  python -I tools/show.py "EXO 3:6"
  python -I tools/show.py "PSA 110:1" --vul "PSA 109:1"     # layer-specific reference
  python -I tools/show.py "MAT 22:32" --words               # full word table (lemma, Strong's, morph, gloss)

The original-language lemmas printed here are exactly what @term/@cite lemma lists must use.
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import get_verse, original_layer, utf8_stdout

def main():
    utf8_stdout()
    args = sys.argv[1:]
    ref = args[0]
    over = {}
    for flag, layer in (("--heb", "heb"), ("--grc", "grc"), ("--vul", "lat"), ("--kjv", "kjv"), ("--bsb", "bsb")):
        if flag in args:
            over[layer] = args[args.index(flag) + 1]
    orig = original_layer(ref)
    o = get_verse(orig, over.get(orig, ref))
    print(f"== {ref}  ({'Hebrew, WLC' if orig == 'heb' else 'Greek, Nestle 1904'})")
    if o is None:
        print("   (not in the original-language corpus at this reference: check versification or textual variants)")
    else:
        print("  ", o["text"])
        print("   lemmas:", " ".join(o["lemmas"]))
        if "--words" in args:
            for w in o["words"]:
                extra = f"  LXX:{w['lxx']}" if w.get("lxx") else ""
                print(f"     {w['text']:<14} lemma={w['lemma']:<12} strong={w['strong']:<6} {w['morph']:<12} {w['gloss']}{extra}")
    for layer, name in (("lat", "VUL"), ("kjv", "KJV"), ("bsb", "BSB")):
        r = over.get(layer, ref)
        v = get_verse(layer, r)
        tag = f"{name}@{r}" if r != ref else name
        if v is None:
            print(f"{tag}: (no verse at {r} in this layer's numbering)")
        else:
            print(f"{tag}: {v.get('marked', v['text'])}")

if __name__ == "__main__":
    main()
