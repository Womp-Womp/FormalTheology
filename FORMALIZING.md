# How to formalize a passage

Read this whole page before writing a line. Then read `lean/Matthew22.lean`, the house template.

## The one principle

**Formalize the argument the text makes, and say no more than the text says.** You are not proving your theology, or anyone's. You are making an argument's structure checkable and its every premise visible. Where the text leaves a gap, you do not fill it silently: you name the gap.

## Setup (once)

```
python -I tools/fetch_sources.py     # downloads + verifies every source by SHA-256
python -I tools/build_corpus.py      # builds .cache/corpus (whole Bible, 5 layers)
```

## Workflow

1. **Read the passage in every layer.** `python -I tools/show.py "MAT 22:32" --words`
   The word table gives each original-language word's lemma, Strong's number, morphology and gloss (and, for Hebrew, the Septuagint's Greek equivalent). Lemma lists in your tags must be copied from here.
2. **Find the argument's skeleton.** Premises, the inference, the conclusion. Many arguments in Scripture are explicit if-then chains (1 Cor 15), a fortiori (John 10:35), temporal (Rom 4:10), or reductio (Mark 3:24-26).
3. **Write `lean/<Name>.lean`** with `namespace <Name>`, following the template's layout: domain, terms, premises, readings, theorems, receipts.
4. **Extract and check:**
   ```
   python -I tools/extract.py lean/<Name>.lean
   lean lean/<Name>.lean
   python -I tools/check_citations.py lean/<Name>.lean
   python -I tools/check_citations.py --selftest lean/<Name>.lean
   ```
   All four must pass. `python -I tools/check_all.py` runs everything for every file.

## The tags

Every `axiom` gets a doc comment with exactly one tag.

| Tag | Use for | Rules |
|---|---|---|
| `@domain` | a bare type: `axiom Person : Type` | type must be `Type`; explain in 8+ words |
| `@term REF [lemmas] "phrase"` | naming something: `axiom ChristRaised : Prop`, `axiom abraham : Person`, `axiom Died : Person → Prop` | type must end in `Prop`, `Type` or a @domain type, so a term can never assert anything. The phrase must occur in the original text of REF |
| `@cite REF [lemmas]` + quotes | a premise the verse itself states | quotes required in the original (`HEB:` for OT books, `GRK:` for NT books) and `KJV:`, `BSB:`, `VUL:`; each verbatim from that layer |
| `@interpretive` | any step the text implies but does not state | explain in 8+ words: what the text says, what you add, and why. Name the alternative reading where scholars disagree |

**Quotes:** cite the shortest clause that carries the premise. Greek/Hebrew matching ignores cantillation and punctuation but not letters or vowels. Translation quotes must be verbatim (KJV `[supplied]` brackets and ¶ are ignored, so quote with or without them).

**Versification differs by layer.** When `show.py` says a layer has no verse, or shows a different verse, that layer numbers it differently. Cite that layer at its own reference: `VUL@PSA 109:1:"Dixit Dominus Domino meo"`. Known differences:
- Vulgate Psalms: English 10–113 → Vulgate 9–112 (Ps 9+10 are one psalm), 114+115 → 113, 116 → 114–115, 117–146 → 116–145, 147 → 146–147.
- Hebrew Psalms count a superscription as verse 1, so English Ps 51:1 = Hebrew 51:3; short titles are often inside v1 (Ps 110:1 matches).
- Hebrew Malachi has 3 chapters (English 4:1–6 = Hebrew 3:19–24); Hebrew Joel has 4.
Always confirm with `show.py --heb "…"` or `--vul "…"` before citing.

## What a premise may say

The Lean statement of a `@cite` axiom must say **no more than its quotes**. If the verse says "if A then B", the axiom is `A → B`, not `A ↔ B`. If you need the converse, the contrapositive in a stronger form, an identification of two different words, a temporal ordering the text implies, or a general rule drawn from a particular case, that is an `@interpretive` axiom, and the receipts will show it.

When translations disagree with the original, trust the original, and say so in a comment (example: KJV "vain" in 1 Cor 15:14 and 15:17 is two Greek words, κενή and ματαία; the Vulgate keeps them apart too, *inanis* and *vana*). When the New Testament quotes the Old, cite both, and note whether the NT wording follows the Hebrew or the Septuagint (the word table's `LXX:` column shows the Septuagint's equivalent for each Hebrew word).

## What makes a good theorem

- It is the text's own conclusion, or a step the text explicitly takes.
- **Witnesses:** if two independent routes reach the same proposition, prove both and show with `#print axioms` that they share no premise.
- **Refutations:** if the text answers an opponent, formalize the opponent's premise and prove it contradicts the cited verses (`sadducee_premise_refuted`).
- **Logic made visible:** if a step needs excluded middle, let `Classical.byContradiction` show it, and where possible also prove the constructive form.
- No trivial padding: don't restate an axiom as a theorem unless it's a named witness route.

## Hard rules

- Core Lean 4 only: no `import Mathlib`. No `sorry`, `admit` or `native_decide`.
- Only create `lean/<Name>.lean` and `data/cited/<Name>.json` (via extract.py). Do not edit tools or other files; report tool problems instead.
- End the file with `#print axioms` for every theorem.
- Never invent a quotation, lemma or reading from memory. `show.py` is the source of truth.
