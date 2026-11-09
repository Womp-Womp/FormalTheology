"""
Citation integrity checker for Formal Theology Lean files.

  python -I tools/check_citations.py lean/Cor15.lean data/1co15_12-22.json
  python -I tools/check_citations.py --selftest lean/Cor15.lean data/1co15_12-22.json

Every `axiom` must be preceded by a doc comment with exactly one tag:
  @term REF [lemmas] "greek phrase"     the phrase must occur in that verse's Greek
  @cite REF [lemmas] + GRK/KJV/BSB/VUL:"quote" lines, each an exact substring of that layer
  @interpretive <reason>                a reading the text doesn't state; reason required
Every lemma listed must occur in the verse (MACULA lemma field).

--selftest corrupts the file in several ways and confirms each corruption is caught,
so the checker can't silently pass everything.
"""
import json, re, sys

LAYER = {"GRK": "greek", "KJV": "kjv", "BSB": "bsb", "VUL": "latin"}
DOC_AXIOM = re.compile(r"/--(.*?)-/\s*axiom\s+(\w+)", re.S)
BARE_AXIOM = re.compile(r"^\s*axiom\s+(\w+)", re.M)

def check(lean_src, data):
    verses = {v["ref"]: v for v in data["verses"]}
    errors, report = [], []
    documented = set()
    for m in DOC_AXIOM.finditer(lean_src):
        doc, name = m.group(1), m.group(2)
        documented.add(name)
        tags = re.findall(r"@(term|cite|interpretive)\b", doc)
        if len(tags) != 1:
            errors.append(f"{name}: needs exactly one tag, found {tags}"); continue
        tag = tags[0]
        if tag == "interpretive":
            reason = doc.split("@interpretive", 1)[1].strip()
            if len(reason.split()) < 8:
                errors.append(f"{name}: @interpretive must explain itself (8+ words)")
            report.append(f"  READING  {name}")
            continue
        h = re.search(r"@(?:term|cite)\s+(\w+ \d+:\d+)\s*\[([^\]]*)\]", doc)
        if not h:
            errors.append(f"{name}: malformed @{tag} header"); continue
        ref, lemmas = h.group(1), h.group(2).split()
        v = verses.get(ref)
        if not v:
            errors.append(f"{name}: {ref} not in data"); continue
        for lem in lemmas:
            if lem not in v["lemmas"]:
                errors.append(f"{name}: lemma {lem} does not occur in {ref}")
        if tag == "term":
            q = re.search(r'\]\s*"([^"]+)"', doc)
            if not q or q.group(1) not in v["greek"]:
                errors.append(f"{name}: Greek phrase not found in {ref}")
            report.append(f"  TERM     {name:16} {ref}  {len(lemmas)} lemmas")
        else:
            quotes = re.findall(r'(GRK|KJV|BSB|VUL):"([^"]+)"', doc)
            if {k for k, _ in quotes} != set(LAYER):
                errors.append(f"{name}: @cite needs GRK, KJV, BSB and VUL quotes")
            for layer, q in quotes:
                if q not in v[LAYER[layer]]:
                    errors.append(f"{name}: {layer} quote not found verbatim in {ref}")
            report.append(f"  PREMISE  {name:16} {ref}  {len(lemmas)} lemmas, {len(quotes)} quotes verified")
    for name in BARE_AXIOM.findall(lean_src):
        if name not in documented:
            errors.append(f"{name}: axiom with no citation (premises may not float free of the text)")
    return errors, report

def selftest(src, data):
    corruptions = {
        "wrong lemma":        src.replace("[ἀνάστασις νεκρός] \"ἀνάστασις", "[ἀνάστασις θάνατος] \"ἀνάστασις", 1),
        "altered KJV quote":  src.replace("then is Christ not risen\"", "then Christ is not risen\"", 1),
        "altered Greek":      src.replace("ματαία ἡ πίστις ὑμῶν\"", "κενὴ ἡ πίστις ὑμῶν\"", 1),
        "altered Vulgate":    src.replace("vana est fides vestra", "inanis est fides vestra", 1),
        "wrong verse":        src.replace("@cite 1CO 15:20", "@cite 1CO 15:21", 1),
        "untagged premise":   src + "\naxiom sneaky : False\n",
        "lazy reading":       src.replace("@interpretive\n", "@interpretive trust me\n-/\naxiom lazy : True\n/-- @interpretive\n", 1),
    }
    ok = True
    for what, bad in corruptions.items():
        assert bad != src, f"selftest corruption '{what}' did not apply"
        errs, _ = check(bad, data)
        caught = bool(errs)
        ok &= caught
        print(f"  {'CAUGHT' if caught else 'MISSED'}  {what}" + (f"  -> {errs[0]}" if caught else ""))
    return ok

def main():
    sys.stdout.reconfigure(encoding="utf-8")
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    src = open(args[0], encoding="utf-8").read()
    data = json.load(open(args[1], encoding="utf-8"))
    if "--selftest" in sys.argv:
        print("Self-test: each corruption must be caught")
        sys.exit(0 if selftest(src, data) else 1)
    errors, report = check(src, data)
    print("\n".join(report))
    if errors:
        print("\nFAILED:"); print("\n".join("  " + e for e in errors)); sys.exit(1)
    print(f"\nOK: every axiom is a verified term, a verified premise, or a declared reading.")

if __name__ == "__main__":
    main()
