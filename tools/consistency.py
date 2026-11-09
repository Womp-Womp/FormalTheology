"""
Consistency scaffolding: prove a file's axioms cannot contradict each other.

If the premises and readings of a file were inconsistent, Lean could "prove" anything from them
and every theorem would be worthless. The cure is a MODEL: a concrete little world in which every
axiom is true. This tool generates, at the end of lean/<Name>.lean:

  * `structure Theory`: one field per axiom, in order, with the axiom's exact type;
  * a check that the file's real axioms inhabit Theory (so the structure can't drift from the file);

and the author writes `def model : Theory := { … }` by hand, with each premise proved by `decide`
(or another tactic). Then `theorem consistent : ¬(Theory → False)` follows. Lean checks it all.

  python -I tools/consistency.py lean/Matthew22.lean            # insert/refresh the generated block
  python -I tools/consistency.py --check lean/Matthew22.lean    # fail if missing or out of date
"""
import os, re, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import utf8_stdout

BEGIN = "-- BEGIN GENERATED THEORY (tools/consistency.py; do not edit by hand)"
END = "-- END GENERATED THEORY"

def axioms(src):
    """[(name, type)] in order. Types may continue on indented lines."""
    out, lines, i = [], src.split("\n"), 0
    while i < len(lines):
        m = re.match(r"^axiom\s+([\w.']+)\s*:\s*(.*)$", lines[i])
        if m:
            name, ty = m.group(1), [m.group(2).strip()]
            i += 1
            while i < len(lines) and lines[i].startswith((" ", "\t")) and lines[i].strip():
                ty.append(lines[i].strip()); i += 1
            out.append((name, " ".join(ty)))
            continue
        i += 1
    return out

def namespace(src):
    m = re.search(r"^namespace\s+(\S+)", src, re.M)
    if not m:
        raise SystemExit("file has no namespace")
    return m.group(1)

def generated(src):
    ns, ax = namespace(src), axioms(src)
    fields = "\n".join(f"  {n} : {t}" for n, t in ax)
    inst = ", ".join(f"{ns}.{n}" for n, _ in ax)
    return f"""{BEGIN}
namespace {ns}.Consistency

/-- Every axiom of this file, as one structure: a "theory". A value of this type is a world in
which all the file's terms are interpreted and all its premises and readings are true. -/
structure Theory where
{fields}

/-- The file's own axioms inhabit `Theory`, field for field: Lean checks each type, so the
structure cannot silently differ from the file. -/
noncomputable example : Theory := ⟨{inst}⟩

end {ns}.Consistency
{END}"""

def main():
    utf8_stdout()
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    path = args[0]
    src = open(path, encoding="utf-8").read()
    head = src.split(BEGIN)[0].rstrip() if BEGIN in src else src.rstrip()
    tail = src.split(END, 1)[1] if END in src else ""
    want = generated(head)
    if "--check" in sys.argv:
        if BEGIN not in src:
            print(f"MISSING consistency block in {path}"); sys.exit(1)
        have = BEGIN + src.split(BEGIN, 1)[1].split(END, 1)[0] + END
        if have != want:
            print(f"STALE consistency block in {path} (axioms changed; re-run tools/consistency.py)"); sys.exit(1)
        if not re.search(r"def model\s*:\s*Theory", tail) or "theorem consistent" not in tail:
            print(f"NO MODEL in {path}: write `def model : Theory` and `theorem consistent` after the block"); sys.exit(1)
        print(f"OK consistency scaffold {path}"); return
    new = head + "\n\n" + want + (tail if tail.strip() else "\n")
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(new)
    print(f"wrote consistency block: {len(axioms(head))} axioms -> Theory fields")

if __name__ == "__main__":
    main()
