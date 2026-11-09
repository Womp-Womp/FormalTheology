"""
Check everything: every Lean file compiles with no sorry, every citation verifies, every
tamper self-test is caught. Prints each theorem's receipts (the verses and readings it rests on).

  python -I tools/check_all.py
"""
import glob, os, re, subprocess, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import ROOT, utf8_stdout

def run(cmd):
    p = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, encoding="utf-8")
    return p.returncode, p.stdout + p.stderr

def receipts(lean_out):
    """'X' depends on axioms: [a, b, …] -> {X: [verse/reading axioms only]}"""
    res = {}
    for m in re.finditer(r"'([^']+)' depends on axioms: \[(.*?)\]", lean_out, re.S):
        names = [n.strip() for n in m.group(2).replace("\n", " ").split(",")]
        res[m.group(1)] = names
    return res

def main():
    utf8_stdout()
    files = sorted(glob.glob(os.path.join(ROOT, "lean", "*.lean")))
    failed = []
    for f in files:
        rel = os.path.relpath(f, ROOT).replace("\\", "/")
        code, out = run(["lean", rel])
        bad_lean = code != 0 or "sorry" in out or "sorryAx" in out
        c2, out2 = run([sys.executable, "-I", "tools/check_citations.py", rel])
        c3, out3 = run([sys.executable, "-I", "tools/check_citations.py", "--selftest", rel])
        caught = out3.count("CAUGHT"); total = caught + out3.count("MISSED")
        status = "OK " if not (bad_lean or c2 or c3) else "FAIL"
        print(f"{status} {rel}: lean {'ok' if not bad_lean else 'FAILED'}, citations {'ok' if not c2 else 'FAILED'}, tamper test {caught}/{total}")
        if bad_lean: print(out)
        if c2: print(out2)
        if c3: print(out3)
        for thm, ax in receipts(out).items():
            logic = [a for a in ax if a in ("propext", "Classical.choice", "Quot.sound")]
            prem = [a.split(".")[-1] for a in ax if a not in logic]
            print(f"     {thm}  <=  {', '.join(prem)}" + ("   [+classical logic]" if "Classical.choice" in logic else ""))
        if status != "OK ":
            failed.append(rel)
    print(f"\n{len(files) - len(failed)}/{len(files)} files fully verified.")
    sys.exit(1 if failed else 0)

if __name__ == "__main__":
    main()
