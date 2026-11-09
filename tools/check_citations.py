"""
Citation integrity checker. Verifies a Lean file against its committed data/cited/<Name>.json.

  python -I tools/check_citations.py lean/Matthew22.lean
  python -I tools/check_citations.py --selftest lean/Matthew22.lean

Every `axiom` must be preceded by a doc comment with exactly one tag:

  @term REF [lemmas] "phrase"
      names a phrase of the original text (Hebrew for OT books, Greek for NT books).
      Every lemma must occur in that verse; the phrase must occur in it (cantillation and
      punctuation ignored; letters and vowels must match).

  @cite REF [lemmas]
      a premise the verse itself states. Needs quotes in ALL of:
        HEB:"…" or GRK:"…" (whichever is the book's original), KJV:"…", BSB:"…", VUL:"…"
      Any quote may name its own reference when that layer numbers verses differently:
        VUL@PSA 109:1:"Dixit Dominus Domino meo"
      Translation quotes must be verbatim (KJV [supplied] brackets and ¶ ignored).

  @interpretive <reason, 8+ words>
      a reading the text does not state outright. Allowed, but always labeled.

  @domain <reason, 8+ words>
      a bare type of things spoken about (axiom Person : Type). Must have type Type.

A @term may only NAME something: its type must end in Prop, Type, or a @domain type
(ChristRaised : Prop, abraham : Person, Died : Person → Prop). A @term whose type is a
proposition would be a premise in disguise, and is rejected.

--selftest applies every corruption that fits this file and requires each to be caught.
"""
import json, os, re, sys, unicodedata
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import CITED_DIR, REF_RE, TAG_LAYER, norm_orig, norm_text, original_layer, utf8_stdout

DOC_AXIOM = re.compile(r"/--(.*?)-/\s*axiom\s+([\w.']+)\s*:\s*([^\n]*)", re.S)
BARE_AXIOM = re.compile(r"^\s*axiom\s+([\w.']+)", re.M)
HEADER = re.compile(rf"@(term|cite)\s+({REF_RE})\s*\[([^\]]*)\]")
QUOTE = re.compile(rf"\b(HEB|GRK|KJV|BSB|VUL)(?:@({REF_RE}))?:\"([^\"]+)\"")

def verse(data, layer, ref):
    return data["verses"].get(f"{layer}|{ref}")

def check(src, data):
    errors, report, documented = [], [], set()
    found = [(m.group(1), m.group(2), m.group(3).strip()) for m in DOC_AXIOM.finditer(src)]
    domains = {name for doc, name, ty in found if "@domain" in doc and ty == "Type"}
    for doc, name, ty in found:
        documented.add(name)
        tags = re.findall(r"@(term|cite|interpretive|domain)\b", doc)
        if len(tags) != 1:
            errors.append(f"{name}: needs exactly one of @term/@cite/@interpretive/@domain, found {tags}")
            continue
        tag = tags[0]
        if tag == "domain":
            if ty != "Type":
                errors.append(f"{name}: @domain must be a bare type (axiom {name} : Type)")
            if len(doc.split("@domain", 1)[1].split()) < 8:
                errors.append(f"{name}: @domain must explain itself (8+ words)")
            report.append(f"  DOMAIN   {name}")
            continue
        if tag == "term":
            result = ty.split("→")[-1].strip()
            if result not in ("Prop", "Type") and result not in domains:
                errors.append(f"{name}: @term may only name things; type '{ty}' asserts a proposition (use @cite or @interpretive)")
        if tag == "interpretive":
            reason = doc.split("@interpretive", 1)[1].strip()
            if len(reason.split()) < 8:
                errors.append(f"{name}: @interpretive must explain itself (8+ words)")
            report.append(f"  READING  {name}")
            continue
        h = HEADER.search(doc)
        if not h:
            errors.append(f"{name}: malformed @{tag} header (want @{tag} BOOK c:v [lemmas])")
            continue
        _, ref, lemmas = h.groups()
        lemmas = lemmas.split()
        orig = original_layer(ref)
        orig_tag = "HEB" if orig == "heb" else "GRK"
        ov = verse(data, orig, ref)
        if ov is None:
            errors.append(f"{name}: {ref} missing from the {orig_tag} data (run tools/extract.py)")
            continue
        # NFC: Hebrew vowel/dagesh marks may be stored in different orders; canonical equivalence only
        have = {unicodedata.normalize("NFC", l) for l in ov["lemmas"]}
        for lem in lemmas:
            if unicodedata.normalize("NFC", lem) not in have:
                errors.append(f"{name}: lemma {lem} does not occur in {orig_tag} {ref}")
        if not lemmas:
            errors.append(f"{name}: list at least one lemma from {ref}")
        if tag == "term":
            q = re.search(r'\]\s*"([^"]+)"', doc)
            if not q or norm_orig(q.group(1)) not in norm_orig(ov["text"]):
                errors.append(f"{name}: {orig_tag} phrase not found in {ref}")
            report.append(f"  TERM     {name:22} {ref}")
            continue
        quotes = QUOTE.findall(doc)
        layers_quoted = {t for t, _, _ in quotes}
        need = {orig_tag, "KJV", "BSB", "VUL"}
        if not need <= layers_quoted:
            errors.append(f"{name}: @cite needs quotes for {sorted(need - layers_quoted)}")
        if layers_quoted - need:
            errors.append(f"{name}: {sorted(layers_quoted - need)} is not this book's original language")
        for t, qref, q in quotes:
            layer, r = TAG_LAYER[t], (qref or ref)
            v = verse(data, layer, r)
            if v is None:
                errors.append(f"{name}: {t} {r} missing from data (run tools/extract.py)")
                continue
            if layer in ("heb", "grc"):
                ok = norm_orig(q) in norm_orig(v["text"])
            else:
                ok = norm_text(q) in norm_text(v["text"]) or norm_text(q) in norm_text(v.get("marked", ""))
            if not ok:
                errors.append(f"{name}: {t} quote not found verbatim in {t} {r}")
        report.append(f"  PREMISE  {name:22} {ref}  {len(lemmas)} lemmas, {len(quotes)} quotes verified")
    for name in BARE_AXIOM.findall(src):
        if name not in documented:
            errors.append(f"{name}: axiom with no citation (premises may not float free of the text)")
    if re.search(r"\b(sorry|admit)\b", src):
        errors.append("file contains sorry/admit")
    return errors, report

def corruptions(src):
    """Generic tamperings; each must be caught. Returns {name: corrupted_source}."""
    out = {}
    def first(pattern, repl, label, flags=0):
        new, n = re.subn(pattern, repl, src, count=1, flags=flags)
        if n and new != src:
            out[label] = new
    first(r"(@cite\s+" + REF_RE + r"\s*\[)(\S+)", r"\1ΧΨΩ", "wrong lemma")
    first(r'(KJV(?:@' + REF_RE + r')?:"[^"]*?)(")', r"\1 indeed\2", "altered KJV quote")
    first(r'(BSB(?:@' + REF_RE + r')?:"[^"]*?)(")', r"\1 indeed\2", "altered BSB quote")
    first(r'(VUL(?:@' + REF_RE + r')?:"[^"]*?)(")', r"\1 vero\2", "altered Vulgate quote")
    first(r'((?:GRK|HEB)(?:@' + REF_RE + r')?:"[^"]*?)(")', r"\1 καὶ אֶת\2", "altered original quote")
    first(r'(@term\s+' + REF_RE + r'\s*\[[^\]]*\]\s*")([^"]*)(")', r'\1\2 καὶ אֶת\3', "altered term phrase")
    first(r"(@cite\s+[1-4A-Z]{3} \d+:)(\d+)", lambda m: m.group(1) + str(int(m.group(2)) + 1), "wrong verse")
    first(r'\n\s*BSB(?:@' + REF_RE + r')?:"[^"]*"', "", "dropped a layer")
    out["untagged premise"] = src + "\naxiom sneaky : False\n"
    t = re.search(r'@term\s+' + REF_RE + r'\s*\[[^\]]*\]\s*"[^"]*"', src)
    if t:
        out["premise disguised as term"] = src + "\n/-- " + t.group(0) + " -/\naxiom disguised : False\n"
    first(r"(/--\s*@domain)(?:(?!-/).)*(?=-/\s*axiom)", r"\1 x\n", "lazy domain", re.S)
    out["sorry"] = src + "\ntheorem cheat : False := by sorry\n"
    # a real reading: an @interpretive doc comment attached to an axiom (not prose mentioning the tag)
    first(r"(/--\s*@interpretive)(?:(?!-/).)*(?=-/\s*axiom)", r"\1 trust me\n", "lazy reading", re.S)
    return out

def main():
    utf8_stdout()
    path = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    name = os.path.splitext(os.path.basename(path))[0]
    src = open(path, encoding="utf-8").read()
    data = json.load(open(os.path.join(CITED_DIR, f"{name}.json"), encoding="utf-8"))
    if "--selftest" in sys.argv:
        ok = True
        for what, bad in corruptions(src).items():
            errs, _ = check(bad, data)
            ok &= bool(errs)
            print(f"  {'CAUGHT' if errs else 'MISSED'}  {what}" + (f"  -> {errs[0]}" if errs else ""))
        sys.exit(0 if ok else 1)
    errors, report = check(src, data)
    print("\n".join(report))
    if errors:
        print("\nFAILED:"); print("\n".join("  " + e for e in errors)); sys.exit(1)
    print(f"OK {name}: every axiom is a verified term, a verified premise, or a declared reading.")

if __name__ == "__main__":
    main()
