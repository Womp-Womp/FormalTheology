# Formal Theology

*Founded by Tim Lee, November 9, 2026. Accredited by Tim Lee, until someone steps up.*

**Proof-carrying hermeneutics:** every theological conclusion is machine-checked in Lean 4, and every premise it rests on is a cited word of Scripture, checked against the Hebrew, Greek, Latin and English texts, or a reading that is openly declared as a reading.

Lean checks that a conclusion **follows** from its premises. It does not check that the premises are **true**. That is faith's part, not the kernel's. What this discipline adds is that nothing hides: `#print axioms` lists exactly which verses and which readings every conclusion depends on.

## The rules

1. **Every premise cites the text.** An `axiom` is a `@term` (names a Greek or Hebrew phrase), a `@cite` (a premise the verse itself states, quoted exactly in Greek, KJV, BSB and Vulgate), or an `@interpretive` reading that must explain itself. Nothing floats free.
2. **The original language decides.** Translations are witnesses, not the source. Where English merges words the Greek keeps apart, the formalization keeps them apart.
3. **Witnesses must be independent.** Two routes to a conclusion only count as two witnesses if their `#print axioms` lists share no verse (Deut 19:15; 2 Cor 13:1).
4. **Logic is visible too.** If a step needs classical logic (excluded middle), Lean shows `Classical.choice`. Constructive and classical conclusions are kept distinct.
5. **Test the spirits.** Readings are welcome, the author's included, as labeled `@interpretive` axioms anyone can see, test, and reject (1 John 4:1; Acts 17:11).

## First lesson: 1 Corinthians 15:12–22

[`lean/Cor15.lean`](lean/Cor15.lean) formalizes Paul's argument for the resurrection, which he wrote as a chain of if-thens.

What it found:

- **"Vain" is two words.** KJV says "your faith is also vain" (v14) and "your faith is vain" (v17). Paul wrote κενή, *empty*, then ματαία, *futile*. The Vulgate agrees with the Greek: *inanis*, then *vana*. Two witnesses against one smoothed translation, so the formalization keeps `FaithEmpty` and `FaithFutile` separate.
- **Paul gives two independent witnesses.** v13 ("no resurrection of the dead", a noun) and v16 ("the dead are not raised", a verb) both conclude "then not even Christ has been raised." `#print axioms` shows the routes share no verse: {v13, same_event} versus {v16}. Connecting v13 needs one declared reading (`same_event`), and it is labeled.
- **Paul's conclusion and its logic.** From v16 and v20 ("But now is Christ risen"), Lean proves *it is impossible that the dead are not raised* with no extra logic. The positive *the dead are raised* additionally uses the law of excluded middle, and Lean shows it.

## Run it

```
lean lean/Cor15.lean                                                     # proofs + receipts
python -I tools/check_citations.py lean/Cor15.lean data/1co15_12-22.json # every premise vs. the text
python -I tools/check_citations.py --selftest lean/Cor15.lean data/1co15_12-22.json  # checker catches tampering
```

Rebuild the aligned data (needs the full MACULA TSV and the eBible Vulgate files):

```
python -I tools/build_passage.py <macula-greek-Nestle1904.tsv> <latVUC_076_1CO_15_read.txt> sources/english_1co15_12-22.json data/1co15_12-22.json 1CO 15 12 22
```

## Layers and sources

| Layer | Source | License |
|---|---|---|
| Greek (Nestle 1904): word, lemma, Strong's, morphology, gloss, Louw-Nida domain | [MACULA Greek](https://github.com/Clear-Bible/macula-greek), © 2022–2024 Biblica, Inc. | CC BY 4.0 |
| Latin | Clementine Vulgate 1598, via [eBible.org latVUC](https://ebible.org/bible/details.php?id=latVUC) | Public domain |
| English | KJV, BSB, via the BibleReadingApp MCP server | Public domain |
| Hebrew (next, for the Old Testament) | Open Scriptures Hebrew Bible / MACULA Hebrew | CC BY 4.0 |

`data/macula_1CO15_12-22.tsv` is an unmodified slice of the MACULA TSV, included under CC BY 4.0 with attribution as above.

## License

The proofs, tools and writing here are released into the public domain under the [Unlicense](LICENSE). The bundled MACULA Greek data keeps its own license (CC BY 4.0, Biblica, Inc.); credit it as shown above when you reuse it.

## Where this goes

- More passages, same rules. Each new chapter adds `@term`s, `@cite`s and, honestly labeled, readings.
- Textual variants as explicit alternatives (Nestle 1904 vs. SBLGNT vs. Byzantine), never silently chosen.
- A controlled-English layer with a proven translation into Lean, so claims can be written in plain sentences without losing rigor.
- Cross-tradition maps: formalize two traditions' readings of the same passage and let `#print axioms` show exactly where they part.
