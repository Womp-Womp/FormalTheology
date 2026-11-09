# Formal Theology

*Founded by Tim Lee, November 9, 2026. Accredited by Tim Lee, until someone steps up.*

**Proof-carrying hermeneutics:** every theological conclusion is machine-checked in Lean 4, and every premise it rests on is a cited word of Scripture, checked against the Hebrew or Greek, the Latin Vulgate, the KJV and the BSB, or a reading that is openly declared as a reading.

Lean checks that a conclusion **follows** from its premises. It does not check that the premises are **true**. That is faith's part, not the kernel's. What this discipline adds is that nothing hides: `#print axioms` lists exactly which verses and which readings every conclusion depends on.

[![verify](https://github.com/Womp-Womp/FormalTheology/actions/workflows/verify.yml/badge.svg)](https://github.com/Womp-Womp/FormalTheology/actions/workflows/verify.yml)

## The rules

1. **Every premise cites the text.** Each `axiom` is a `@term` (names a Hebrew or Greek phrase, and may only name, never assert), a `@cite` (a premise the verse states, quoted exactly in the original, KJV, BSB and Vulgate), an `@interpretive` reading that must explain itself, or a bare `@domain` type. Nothing floats free.
2. **The original language decides.** Translations are witnesses, not the source. Where English merges words the Hebrew or Greek keeps apart, the formalization keeps them apart.
3. **Witnesses must be independent.** Two routes to a conclusion count as two witnesses only if their `#print axioms` lists share no premise (Deut 19:15; 2 Cor 13:1).
4. **Logic is visible too.** If a step needs the law of excluded middle, Lean shows `Classical.choice`. Constructive and classical conclusions are kept distinct.
5. **Test the spirits.** Readings are welcome, the author's included, as labeled `@interpretive` axioms anyone can see, test and reject (1 John 4:1; Acts 17:11).
6. **No vacuous proofs.** Every file carries a model: a concrete world where all its premises and readings are true at once, checked by Lean. Contradictory premises could prove anything; a model rules that out.

## The catalog

Each file formalizes an argument **Scripture itself makes**, with the logic as the text gives it.

| File | Passage | The argument | What the formalization found |
|---|---|---|---|
| [Cor15](lean/Cor15.lean) | 1 Cor 15:12–22 | If the dead are not raised, Christ is not raised, and faith is vain; but Christ is raised | KJV "vain" is two Greek words, κενή (empty) and ματαία (futile); the Vulgate agrees (*inanis*, *vana*). v13 and v16 are independent witnesses. "The dead are raised" needs excluded middle; "it is impossible they are not" does not |
| [Matthew22](lean/Matthew22.lean) | Matt 22:23–33; Exod 3:6; Gen 25:8 | "Not the God of the dead, but of the living" | Exodus 3:6 has no verb (KJV prints "I [am]"); Jesus' Greek states it (ἐγώ εἰμι), so two witnesses, one needing a labeled reading. Genesis says Abraham *died* (מוּת); Jesus says *the dead* (νεκρός). The Sadducees' "whoever died is dead" is refuted outright |
| [Matthew22b](lean/Matthew22b.lean) | Matt 22:41–46; Ps 110:1 | "If David then call him Lord, how is he his son?" | Hebrew keeps יהוה apart from אָדוֹן ("my lord", the ordinary word); Greek and Latin merge them, and the argument never needs the merger. The custom "a father does not call his son lord" is refuted by two premise-disjoint routes |
| [John10](lean/John10.lean) | John 10:31–36; Ps 82:6 | "Ye are gods": a fortiori from lesser to greater | Proves only what the text concludes: not blasphemy, by the accusers' own law. No divinity predicate exists in the file. The conclusion does not depend on who the "gods" of Ps 82 are |
| [Hebrews7](lean/Hebrews7.lean) | Heb 7:1–10; Gen 14:18–20 | The lesser is blessed by the better; Levi paid tithes in Abraham | Gen 14:20 says only "he gave him a tenth"; the BSB writes in "Abram gave Melchizedek", carrying Hebrews back into Genesis. "Better than Abraham" by blessing needs no reading; "better than Levi" needs the text's own hedge, "as I may so say" |
| [Hebrews4](lean/Hebrews4.lean) | Heb 4:6–9; Ps 95:7–11 | If Joshua had given them rest, God would not later speak of another day | Ἰησοῦς in 4:8 is Joshua; KJV and Vulgate print "Jesus". σαββατισμός occurs once in the whole New Testament and never in the Septuagint equivalents. The core is modus tollens |
| [Mark3](lean/Mark3.lean) | Mark 3:22–27 | A house divided cannot stand | A reductio: the scribes' charge is refuted constructively. Three premise-disjoint witnesses that a divided Satan falls; the strong-man reply is consistent with the refutation |
| [Romans4](lean/Romans4.lean) | Rom 4:9–12; Gen 15–17 | Reckoned righteous "not in circumcision, but in uncircumcision" | Two independent witnesses: Paul's statement, and Genesis' own chronology (Abram 86 at Ishmael's birth, 99 at circumcision). Abraham's fatherhood of uncircumcised believers is stated as purpose; Lean shows it is not deduced from the dates |
| [Galatians3](lean/Galatians3.lean) | Gal 3:15–18; Gen 13:15; Exod 12:40 | The law 430 years later cannot annul the covenant; "seed", not "seeds" | זֶרַע is a collective singular: 229 occurrences, the only plural meaning grain (1 Sam 8:15), so Paul's argument from the singular is labeled as a reading about reference. KJV's "in Christ" (3:17) is not in Nestle 1904 |

## Verify it yourself

```
python -I tools/check_all.py
```

For every file this compiles the Lean proofs (no `sorry`), checks every citation against the committed verse data, runs the tamper self-test (13 kinds of corruption, each must be caught), and requires a Lean-certified consistency model. GitHub runs it on every change, and separately **re-downloads every source, verifies its SHA-256, rebuilds the whole-Bible corpus and confirms every committed citation matches byte for byte.**

To work on a passage, see [FORMALIZING.md](FORMALIZING.md), then:

```
python -I tools/fetch_sources.py     # download + verify the five sources
python -I tools/build_corpus.py      # whole Bible, five layers, each in its own versification
python -I tools/show.py "EXO 3:6" --words
```

## Sources

| Layer | Source | License |
|---|---|---|
| Hebrew OT (WLC): lemma, Strong's, morphology, glosses, Septuagint equivalents | [MACULA Hebrew](https://github.com/Clear-Bible/macula-hebrew), © 2022–2024 Biblica, Inc. | CC BY 4.0 |
| Greek NT (Nestle 1904): lemma, Strong's, morphology, glosses, Louw-Nida domains | [MACULA Greek](https://github.com/Clear-Bible/macula-greek), © 2022–2024 Biblica, Inc. | CC BY 4.0 |
| Latin | Clementine Vulgate 1598 via [eBible.org](https://ebible.org/bible/details.php?id=latVUC) | Public domain |
| English | KJV (with the translators' supplied words in brackets) and BSB via eBible.org | Public domain |

All five are pinned in [sources/SOURCES.json](sources/SOURCES.json): MACULA by git commit, all by SHA-256. `data/cited/` holds only the verses each file cites, extracted from these sources, under their licenses.

## License

The proofs, tools and writing here are released into the public domain under the [Unlicense](LICENSE). The bundled MACULA data keeps its own license (CC BY 4.0, Biblica, Inc.); credit it as above when you reuse it.

## Where this goes

- More of Scripture's own arguments, same rules (Romans 5:12–21, Hebrews 9:16–17, Galatians 4:21–31, 1 Corinthians 15:35–49 …).
- Textual variants as explicit alternatives (Nestle 1904 vs. SBLGNT vs. Byzantine), never silently chosen.
- A controlled-English layer with a proven translation into Lean, so claims can be written in plain sentences without losing rigor.
- Cross-tradition maps: formalize two traditions' readings of the same passage and let `#print axioms` show exactly where they part.
