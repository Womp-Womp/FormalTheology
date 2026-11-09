"""
Download every pinned source into .cache/sources and verify its SHA-256.

  python -I tools/fetch_sources.py            # download what's missing, verify all
  python -I tools/fetch_sources.py --from DIR # copy from a local folder instead (still verified)

A file whose hash doesn't match is refused (renamed *.REJECTED), never used.
"""
import hashlib, json, os, shutil, sys, urllib.request, zipfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ftlib import ROOT, SRC_DIR, utf8_stdout

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

def main():
    utf8_stdout()
    local = sys.argv[sys.argv.index("--from") + 1] if "--from" in sys.argv else None
    spec = json.load(open(os.path.join(ROOT, "sources", "SOURCES.json"), encoding="utf-8"))
    os.makedirs(SRC_DIR, exist_ok=True)
    ok = True
    for s in spec["files"]:
        dest = os.path.join(SRC_DIR, s["name"])
        if not os.path.exists(dest):
            if local and os.path.exists(os.path.join(local, s["name"])):
                shutil.copy(os.path.join(local, s["name"]), dest)
            else:
                print(f"downloading {s['name']} ...")
                req = urllib.request.Request(s["url"], headers={"User-Agent": "formal-theology-fetch"})
                with urllib.request.urlopen(req) as r, open(dest, "wb") as out:
                    shutil.copyfileobj(r, out)
        got = sha256(dest)
        if got != s["sha256"]:
            ok = False
            os.replace(dest, dest + ".REJECTED")
            print(f"  REJECTED {s['name']}: sha256 {got} != pinned {s['sha256']}")
            continue
        print(f"  verified {s['name']}  {got[:16]}…")
        if dest.endswith(".zip"):
            outdir = dest[:-4]
            if not os.path.isdir(outdir):
                with zipfile.ZipFile(dest) as z:
                    z.extractall(outdir)
    sys.exit(0 if ok else 1)

if __name__ == "__main__":
    main()
