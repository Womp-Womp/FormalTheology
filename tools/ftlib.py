"""Shared helpers for the Formal Theology tools."""
import json, os, re, sys, unicodedata

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(ROOT, ".cache")
SRC_DIR = os.path.join(CACHE, "sources")
CORPUS_DIR = os.path.join(CACHE, "corpus")
CITED_DIR = os.path.join(ROOT, "data", "cited")

LAYERS = ["heb", "grc", "lat", "kjv", "bsb"]
# Tag used in Lean doc comments -> corpus layer
TAG_LAYER = {"HEB": "heb", "GRK": "grc", "VUL": "lat", "KJV": "kjv", "BSB": "bsb"}
LAYER_TAG = {v: k for k, v in TAG_LAYER.items()}

NT_BOOKS = ["MAT", "MRK", "LUK", "JHN", "ACT", "ROM", "1CO", "2CO", "GAL", "EPH", "PHP", "COL",
            "1TH", "2TH", "1TI", "2TI", "TIT", "PHM", "HEB", "JAS", "1PE", "2PE", "1JN", "2JN",
            "3JN", "JUD", "REV"]

REF_RE = r"[1-4A-Z]{3} \d+:\d+"


def utf8_stdout():
    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass


def original_layer(ref: str) -> str:
    """Hebrew for the Old Testament, Greek for the New."""
    return "grc" if ref.split(" ")[0] in NT_BOOKS else "heb"


# Hebrew cantillation (te'amim) and a few marks that vary between editions; vowels are kept.
_HEB_MARKS = re.compile("[֑-ֽ֯׆]")
# punctuation becomes a space: Greek , . · ; ’  Hebrew maqaf ־ paseq ׀ sof pasuq ׃
_PUNCT = re.compile(r"[,.;·:’'\"“”‘?!()\[\]·;־׀׃’¶]")


def norm_orig(s: str) -> str:
    """Normalize Greek/Hebrew for quote matching: NFC, drop cantillation and punctuation
    (maqaf and commas become spaces), collapse whitespace. Letters and vowels must still match."""
    s = unicodedata.normalize("NFC", s)
    s = _HEB_MARKS.sub("", s)
    s = _PUNCT.sub(" ", s)
    return " ".join(s.split())


def norm_text(s: str) -> str:
    """Translations: exact wording, whitespace collapsed. Editorial marks that are not words
    (KJV pilcrow ¶, KJV [supplied-word] brackets, Vulgate [verse-start] brackets) are ignored."""
    s = unicodedata.normalize("NFC", s).replace("¶", " ").replace("[", "").replace("]", "")
    return " ".join(s.split())


def strip_kjv_brackets(s: str) -> str:
    return " ".join(s.replace("[", "").replace("]", "").split())


def corpus_path(layer: str, book: str) -> str:
    return os.path.join(CORPUS_DIR, layer, f"{book}.json")


_cache = {}


def load_book(layer: str, book: str):
    key = (layer, book)
    if key not in _cache:
        p = corpus_path(layer, book)
        if not os.path.exists(p):
            _cache[key] = None
        else:
            with open(p, encoding="utf-8") as f:
                _cache[key] = json.load(f)
    return _cache[key]


def get_verse(layer: str, ref: str):
    book, cv = ref.split(" ")
    b = load_book(layer, book)
    if b is None:
        return None
    return b["verses"].get(cv)
