/-!
# Galatians 3:15–18 — "The law … cannot disannul"

Paul makes two arguments.

1. **The covenant came first** (vv15, 17–18). "Even a man's covenant, once ratified, no one sets
   aside" (v15). "The covenant ratified beforehand by God, the law which came 430 years after does
   not annul, so as to make the promise of none effect" (v17). "If the inheritance is of the law,
   it is no longer of promise; but God granted it to Abraham through promise" (v18).
2. **One seed** (v16). "To Abraham were the promises spoken, and to his seed. He saith not, And to
   seeds, as of many; but as of one, And to thy seed, which is Christ."

What it shows:
* Two witnesses that the law does not annul the covenant: verse 17 says so outright, and verse 15's
  principle plus verse 17's dating argues it. Their receipts share no premise.
* The 430 is not load-bearing. `later_law_cannot_annul` goes through for ANY positive gap, so the
  dispute over how to count Exodus 12:40 (Hebrew: Egypt only; Greek and Samaritan, reportedly:
  Canaan and Egypt) cannot touch the logic. Moses' "thirty years and four hundred years" and Paul's
  "four hundred and thirty" are the same number (omega checks it), but identifying the two SPANS is
  a labeled reading.
* The rule behind "the law annuls the promise", that a later instrument overrides an earlier one,
  contradicts verse 17 and is refuted from cited premises alone, with no reading at all.
* Verse 18 needs only exclusivity (law excludes promise), never exhaustiveness (law or promise),
  and the conclusion is constructive.
* Verse 16: the Hebrew confirms Paul's report of the WORDING (singular זֶרַע, Septuagint
  σπέρματι). It cannot confirm his inference from the singular to one person, because זֶרַע is a
  collective singular; that inference is a reading about reference, and the receipt shows it. That
  Christ is the seed is Paul's own statement and needs no reading; that the seed is Christ ALONE
  needs the reading and, in Lean, excluded middle.

Text notes:
* KJV 3:17 "confirmed before of God in Christ": "in Christ" has no counterpart in the Nestle 1904
  Greek or the Vulgate here (the KJV's Greek base read εἰς Χριστόν). Nothing below uses it.
* KJV 3:17 "cannot disannul" is modal; the Greek οὐκ ἀκυροῖ is a plain present, "does not annul"
  (BSB "does not revoke", Vulgate "non irritum facit"). The Lean says "does not".
* Vulgate 3:17 "testamentum confirmatum a Deo" drops the προ- of προκεκυρωμένην ("ratified
  BEFOREHAND"); KJV "confirmed before" and BSB "previously established" keep it.
* διαθήκη: KJV and BSB "covenant", Vulgate testamentum ("will"). Verse 15's human example may be a
  will; see the `a_fortiori` reading.
-/

namespace Galatians3

/-! ## Domains -/

/-- @domain The binding instruments the passage weighs against each other: covenants (διαθήκη)
and the law (νόμος). A bare type, it asserts nothing at all. -/
axiom Instrument : Type

/-- @domain The persons the promise names: Abraham, his seed, and Christ. A bare type of
individuals, it asserts nothing at all. -/
axiom Person : Type

/-! ## Terms: verses 15 and 17, the covenant and the law -/

/-- @term GAL 3:17 [διαθήκη] "διαθήκην"
"the covenant" of verse 17, the one "ratified beforehand by God". -/
axiom covenant : Instrument

/-- @term GAL 3:17 [νόμος] "νόμος"
"the law", which "came" 430 years after. -/
axiom law : Instrument

/-- @term GAL 3:15 [ἄνθρωπος] "ἀνθρώπου"
"of a man": a human covenant, verse 15's example. -/
axiom OfMan : Instrument → Prop

/-- @term GAL 3:17 [ὑπό θεός] "ὑπὸ τοῦ Θεοῦ"
"by God": ratified by God. -/
axiom OfGod : Instrument → Prop

/-- @term GAL 3:15 [κυρόω] "κεκυρωμένην"
"ratified" in year t: κυρόω, perfect participle, an act completed whose result stands. Verse 17
uses the compound προκυρόω, "ratified beforehand". -/
axiom RatifiedIn : Instrument → Nat → Prop

/-- @term GAL 3:17 [γίνομαι] "γεγονὼς"
"having come" into being in year t: γίνομαι, perfect participle. -/
axiom ArisesIn : Instrument → Nat → Prop

/-- @term GAL 3:15 [ἀθετέω] "ἀθετεῖ"
"sets aside": ἀθετέω, verse 15's verb. Vulgate spernit. -/
axiom SetAside : Instrument → Prop

/-- @term GAL 3:17 [ἀκυρόω] "ἀκυροῖ"
"annuls", makes invalid: ἀκυρόω, verse 17's verb, not verse 15's. Vulgate irritum facit. -/
axiom Annuls : Instrument → Instrument → Prop

/-- @term GAL 3:17 [καταργέω ἐπαγγελία] "καταργῆσαι τὴν ἐπαγγελίαν"
x "makes the promise of none effect": καταργέω, to render inoperative. -/
axiom VoidsPromise : Instrument → Prop

/-! ## Terms: verse 18, the inheritance -/

/-- @term GAL 3:18 [ἐκ νόμος κληρονομία] "ἐκ νόμου ἡ κληρονομία"
"the inheritance is OF (ἐκ, out of) the law". -/
axiom InheritanceOfLaw : Prop

/-- @term GAL 3:18 [ἐκ ἐπαγγελία] "ἐξ ἐπαγγελίας"
"OF (ἐκ) promise". -/
axiom InheritanceOfPromise : Prop

/-- @term GAL 3:18 [διά ἐπαγγελία χαρίζομαι] "δι’ἐπαγγελίας κεχάρισται"
"God has granted [it] THROUGH (διά) promise": χαρίζομαι, perfect, granted as a free gift. The verb
has no object in the Greek. -/
axiom GrantedThroughPromise : Prop

/-! ## Terms: verse 16, the seed -/

/-- @term GAL 3:16 [Ἀβραάμ] "Ἀβραὰμ"
Abraham. -/
axiom abraham : Person

/-- @term GAL 3:16 [Χριστός] "Χριστός"
Christ. -/
axiom christ : Person

/-- @term GAL 3:16 [εἶπον ἐπαγγελία] "ἐρρέθησαν αἱ ἐπαγγελίαι"
"the promises were spoken" to x. -/
axiom PromisedTo : Person → Prop

/-- @term GAL 3:16 [σπέρμα] "τῷ σπέρματι αὐτοῦ"
x is (of) "his seed", the seed to whom the promises were spoken. σπέρμα, singular. -/
axiom Seed : Person → Prop

/-- @term GAL 3:16 [σπέρμα] "τοῖς σπέρμασιν"
the promise says "to seeds": the PLURAL wording Paul says Scripture does not use. -/
axiom SaysSeeds : Prop

/-! ## Terms: Exodus 12:40, the sojourn -/

/-- @term EXO 12:40 [מוֹשָׁב בֵּן יִשְׂרָאֵל] "וּמוֹשַׁב֙ בְּנֵ֣י יִשְׂרָאֵ֔ל"
"the dwelling of the children of Israel" ran from year a to year b. מוֹשָׁב, from יָשַׁב "dwell". -/
axiom DwellingSpan : Nat → Nat → Prop

/-! ## Premises: what the texts state -/

/-- @cite GAL 3:15 [ἄνθρωπος κυρόω διαθήκη οὐδείς ἀθετέω]
GRK:"ἀνθρώπου κεκυρωμένην διαθήκην οὐδεὶς ἀθετεῖ"
KJV:"Though [it be] but a man’s covenant, yet [if it be] confirmed, no man disannulleth"
BSB:"Even a human covenant, once it is ratified, cannot be canceled"
VUL:"hominis confirmatum testamentum nemo spernit"
Verse 15 also says no one "adds thereto" (ἐπιδιατάσσεται, adds a codicil); this file does not use
that half. -/
axiom gal3_15 : ∀ c : Instrument, ∀ t : Nat, OfMan c → RatifiedIn c t → ¬SetAside c

/-- @cite GAL 3:17 [διαθήκη προκυρόω ὑπό θεός]
GRK:"διαθήκην προκεκυρωμένην ὑπὸ τοῦ Θεοῦ"
KJV:"the covenant, that was confirmed before of God"
BSB:"the covenant previously established by God"
VUL:"testamentum confirmatum a Deo" -/
axiom gal3_17_byGod : OfGod covenant

/-- @cite GAL 3:17 [διαθήκη προκυρόω μετά τετρακόσιοι τριάκοντα ἔτος γίνομαι νόμος]
GRK:"διαθήκην προκεκυρωμένην"
GRK:"ὁ μετὰ τετρακόσια καὶ τριάκοντα ἔτη γεγονὼς νόμος"
KJV:"the covenant, that was confirmed before"
KJV:"the law, which was four hundred and thirty years after"
BSB:"the covenant previously established"
BSB:"The law that came 430 years later"
VUL:"testamentum confirmatum"
VUL:"quæ post quadringentos et triginta annos facta est lex"
Greek "four hundred and thirty", written 400 + 30. The clause names no starting point for the 430
years beyond the covenant "ratified beforehand" that it sets against the law; which event in
Genesis that ratification was is not stated (see `sojourn_is_pauls_span`). -/
axiom gal3_17_later : ∃ t : Nat, RatifiedIn covenant t ∧ ArisesIn law (t + (400 + 30))

/-- @cite GAL 3:17 [διαθήκη νόμος οὐ ἀκυρόω]
GRK:"διαθήκην προκεκυρωμένην ὑπὸ τοῦ Θεοῦ"
GRK:"νόμος οὐκ ἀκυροῖ"
KJV:"the law, which was four hundred and thirty years after, cannot disannul"
BSB:"The law that came 430 years later does not revoke the covenant"
VUL:"facta est lex, non irritum facit"
KJV "cannot" is modal; the Greek is a plain present, "does not annul". -/
axiom gal3_17_not_annulled : ¬Annuls law covenant

/-- @cite GAL 3:18 [εἰ ἐκ νόμος κληρονομία οὐκέτι ἐπαγγελία]
GRK:"εἰ γὰρ ἐκ νόμου ἡ κληρονομία,οὐκέτι ἐξ ἐπαγγελίας"
KJV:"For if the inheritance [be] of the law, [it is] no more of promise"
BSB:"For if the inheritance depends on the law, then it no longer depends on a promise"
VUL:"Nam si ex lege hæreditas, jam non ex promissione."
Exclusivity only: law excludes promise. The verse does not say the inheritance must be one or the
other, and nothing below needs that. -/
axiom gal3_18_exclusive : InheritanceOfLaw → ¬InheritanceOfPromise

/-- @cite GAL 3:18 [Ἀβραάμ διά ἐπαγγελία χαρίζομαι θεός]
GRK:"τῷ δὲ Ἀβραὰμ δι’ἐπαγγελίας κεχάρισται ὁ Θεός"
KJV:"but God gave [it] to Abraham by promise"
BSB:"but God freely granted it to Abraham through a promise"
VUL:"Abrahæ autem per repromissionem donavit Deus." -/
axiom gal3_18_granted : GrantedThroughPromise

/-- @cite GAL 3:16 [Ἀβραάμ εἶπον ἐπαγγελία σπέρμα αὐτός]
GRK:"τῷ δὲ Ἀβραὰμ ἐρρέθησαν αἱ ἐπαγγελίαι καὶ τῷ σπέρματι αὐτοῦ"
KJV:"Now to Abraham and his seed were the promises made"
BSB:"The promises were spoken to Abraham and to his seed"
VUL:"Abrahæ dictæ sunt promissiones, et semini ejus" -/
axiom gal3_16_spoken : PromisedTo abraham ∧ ∀ p : Person, Seed p → PromisedTo p

/-- @cite GAL 3:16 [οὐ λέγω σπέρμα]
GRK:"οὐ λέγει Καὶ τοῖς σπέρμασιν"
KJV:"He saith not, And to seeds"
BSB:"The Scripture does not say, “and to seeds,”"
VUL:"Non dicit: Et seminibus"
The Greek verb λέγει has no subject: KJV supplies "He", BSB "The Scripture"; the Vulgate, like the
Greek, has none. -/
axiom gal3_16_not_seeds : ¬SaysSeeds

/-- @cite GAL 3:16 [σπέρμα σύ ὅς εἰμί Χριστός]
GRK:"Καὶ τῷ σπέρματί σου,ὅς ἐστιν Χριστός"
KJV:"And to thy seed, which is Christ"
BSB:"“and to your seed,” meaning One, who is Christ"
VUL:"Et semini tuo, qui est Christus"
The relative ὅς is masculine (R-NSM) though σπέρμα is neuter (N-DSN): it agrees with the person,
Christ. Vulgate qui likewise. This is Paul's identification; Genesis does not make it. -/
axiom gal3_16_christ : Seed christ

/-- @cite GEN 13:15 [וְ לְ זֶרַע הוּא עַד עוֹלָם]
HEB:"וּֽלְזַרְעֲךָ֖ עַד־עוֹלָֽם"
KJV:"and to thy seed for ever"
BSB:"I will give to you and your offspring forever"
VUL:"et semini tuo usque in sempiternum"
"and to your seed": זֶרַע, singular (MACULA Ncmsc), and the word table's Septuagint column gives
καὶ τῷ σπέρματί σου, Paul's words exactly. Hebrew and Greek agree here. GEN 17:8 reads the same;
GEN 12:7, 15:18 and 24:7 lack "and". No promise text uses a plural: the only plural of זֶרַע in this
corpus's Hebrew is 1 Sam 8:15, meaning grain. BSB renders "offspring" here but "seed" in Galatians,
which hides the link Paul draws. -/
axiom gen13_15_seed : ¬SaysSeeds

/-- @cite EXO 12:40 [מוֹשָׁב בֵּן יִשְׂרָאֵל יָשַׁב מִצְרַיִם שָׁלֹשׁ אַרְבַּע מֵאָה שָׁנָה]
HEB:"וּמוֹשַׁב֙ בְּנֵ֣י יִשְׂרָאֵ֔ל אֲשֶׁ֥ר יָשְׁב֖וּ בְּמִצְרָ֑יִם שְׁלֹשִׁ֣ים שָׁנָ֔ה וְאַרְבַּ֥ע מֵא֖וֹת שָׁנָֽה"
KJV:"Now the sojourning of the children of Israel, who dwelt in Egypt, [was] four hundred and thirty years."
BSB:"Now the duration of the Israelites’ stay in Egypt was 430 years."
VUL:"Habitatio autem filiorum Israël qua manserunt in Ægypto, fuit quadringentorum triginta annorum."
Hebrew "thirty years and four hundred years", written 30 + 400. Literally "the dwelling … which
they dwelt in Egypt". KJV "who dwelt" attaches the clause to the people, the Vulgate's feminine
qua to the dwelling (habitatio); Hebrew אֲשֶׁר does not mark which. Either way the Hebrew places the
dwelling in Egypt. -/
axiom exo12_40 : ∃ a : Nat, DwellingSpan a (a + (30 + 400))

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Verse 15 speaks of a covenant "of man" (ἀνθρώπου), and Paul flags it as speaking "after the manner
of men" (κατὰ ἄνθρωπον λέγω). Verse 17 applies it to the covenant ratified "by God". The transfer
from a human covenant to God's is implied, not stated. Reading ὅμως as "even" (MACULA's gloss; KJV
"Though … yet"; BSB "Even") makes it an argument from the lesser to the greater; many scholars
accent it ὁμῶς, "likewise", making it a plain analogy. Either way the transfer is a reading. The
Vulgate's testamentum suggests a human will as the example, and which legal practice Paul has in
mind is itself debated. -/
axiom a_fortiori :
  (∀ c : Instrument, ∀ t : Nat, OfMan c → RatifiedIn c t → ¬SetAside c) →
  (∀ c : Instrument, ∀ t : Nat, OfGod c → RatifiedIn c t → ¬SetAside c)

/-- @interpretive
Two different verbs: verse 15 says no one "sets aside" (ἀθετέω) a ratified covenant; verse 17 says
the law does not "annul" (ἀκυρόω) the covenant. Verse 15 bears on verse 17 only if an instrument
that comes AFTER a covenant's ratification and annuls it thereby sets that ratified covenant aside.
The condition t < t′ carries the προ- of προκεκυρωμένην, "ratified beforehand": a provision made
before ratification would shape the covenant, not set it aside. KJV flattens both verbs into
"disannul"; the Vulgate (spernit, irritum facit) and BSB (canceled, revoke) keep them apart. -/
axiom annul_is_set_aside :
  ∀ x c : Instrument, ∀ t t' : Nat,
    RatifiedIn c t → ArisesIn x t' → t < t' → Annuls x c → SetAside c

/-- @interpretive
Verse 17 says the law does not annul the covenant "so as to make the promise of none effect" (εἰς
τὸ καταργῆσαι τὴν ἐπαγγελίαν): annulling the covenant is named as the way the promise would be
voided. The reading adds that it is the only way, so that the promise stands or falls with the
covenant that ratified it. Verses 17 and 18 move between covenant and promise as one grant, which
supports this, but the text does not say it outright. -/
axiom void_requires_annulment : ∀ x : Instrument, VoidsPromise x → Annuls x covenant

/-- @interpretive
Verse 18 says God "granted" (κεχάρισται) to Abraham "through promise" (δι’ ἐπαγγελίας), but the
verb has no object: KJV prints "gave [it]" as a supplied word and BSB adds "it". Taking the
unstated object to be "the inheritance" of the first clause, and "through (διά) promise" to be the
same as "of (ἐκ) promise", closes the argument. The Vulgate keeps even the nouns apart: ex
promissione, then per repromissionem. -/
axiom granted_through_is_of_promise : GrantedThroughPromise → InheritanceOfPromise

/-- @interpretive
This is the reading about reference that the argument from the singular needs: had many persons
been meant, Scripture would have said "seeds" (ὡς ἐπὶ πολλῶν, "as of many"). Grammar alone does
not supply it. Hebrew זֶרַע is grammatically singular, and the promise texts themselves use it
collectively: "I will multiply thy seed as the stars" (GEN 22:17); "thy seed shall be a stranger in
a land [that is] not theirs" (GEN 15:13, plural לָהֶם); GEN 17:8 gives the land "to thy seed" and
ends "I will be their God" (plural לָהֶם). The Hebrew has no plural of זֶרַע for descendants at all
(its one plural, 1 Sam 8:15, means grain), so the singular cannot by grammar rule out many. Paul
himself uses it collectively in 3:29, "ye are Abraham's seed" (σπέρμα with plural ἐστέ). Readings
differ: Paul reads the reference, not the morphology, as again in 3:19 ("till the seed should
come"); some point to the singular pronoun in GEN 22:17, "the gate of his enemies" (אֹיְבָיו, which
BSB renders "their"); many read a corporate singular, the one Christ and those who "are all one
(εἷς) in Christ Jesus" (3:28–29); others see a rabbinic-style argument from the word's form. -/
axiom plural_if_many : (∃ p q : Person, Seed p ∧ Seed q ∧ p ≠ q) → SaysSeeds

/-- @interpretive
Galatians 3:17 counts 430 years from the covenant to the law; Exodus 12:40 counts 430 years
("thirty years and four hundred years") for the dwelling of Israel "which they dwelt in Egypt",
ending at the exodus (12:41). Identifying the two spans is a chronological reading neither text
states. It dates the law to the end of the sojourn (Sinai came in the third month after the exodus,
EXO 19:1) and the covenant's ratification to its start. On the Hebrew wording that start is Jacob's
descent into Egypt, where God renewed to him the promise of a great nation (GEN 46:3), not the
promise to Abraham (GEN 12:7) or the covenant "in the same day" (GEN 15:18). The Septuagint and
Samaritan Pentateuch are reported to count the 430 years over Canaan and Egypt together, which
would start the span with Abraham; this corpus's Septuagint column aligns only to the Hebrew words
and cannot show that addition, so nothing is cited from it. Others take Paul's 430 as a traditional
figure (compare the 400 years of GEN 15:13). -/
axiom sojourn_is_pauls_span :
  ∀ a b : Nat, DwellingSpan a b → RatifiedIn covenant a ∧ ArisesIn law b

/-! ## Argument 1: the law does not annul the covenant -/

/-- Witness 1, verse 17 states it outright: no reading needed. -/
theorem law_cannot_annul_stated : ¬Annuls law covenant := gal3_17_not_annulled

/-- Paul's verse 15 argument, for ANY positive gap: if the law came n > 0 years after God ratified
the covenant, it does not annul it. Only "later" is used, never the number 430, so the chronology
of Exodus 12:40, counted either way, cannot affect the conclusion. The receipt shows the one
clause of verse 17 it still needs: "by God". -/
theorem later_law_cannot_annul (n : Nat) (hn : 0 < n)
    (dated : ∃ t : Nat, RatifiedIn covenant t ∧ ArisesIn law (t + n)) :
    ¬Annuls law covenant := by
  intro annuls
  obtain ⟨t, ratified, arises⟩ := dated
  have later : t < t + n := by omega
  have setAside : SetAside covenant :=
    annul_is_set_aside law covenant t (t + n) ratified arises later annuls
  exact a_fortiori gal3_15 covenant t gal3_17_byGod ratified setAside

/-- Witness 2, argued: verse 15's principle applied to verse 17's dating. -/
theorem law_cannot_annul_argued : ¬Annuls law covenant :=
  later_law_cannot_annul (400 + 30) (by omega) gal3_17_later

/-- The routes agree (proof irrelevance). They count as two witnesses because their receipts share
no premise: {gal3_17_not_annulled} versus {gal3_15, gal3_17_byGod, gal3_17_later, a_fortiori,
annul_is_set_aside}. Both draw on verse 17, but on different clauses: witness 1 on its denial,
witness 2 only on its dating and "by God", with verse 15 doing the work. -/
example : law_cannot_annul_stated = law_cannot_annul_argued := rfl

/-- "So as to make the promise of none effect": the law does not void the promise. -/
theorem law_does_not_void_promise : ¬VoidsPromise law :=
  fun voids => gal3_17_not_annulled (void_requires_annulment law voids)

/-- The rule behind "the law annuls the promise": whatever instrument comes later annuls a covenant
ratified earlier. (The rule is this file's statement of the position Paul answers; the text names
no opponent.) It contradicts verse 17 alone: the law came later and does not annul. No reading is
needed to refute it. -/
theorem later_overrides_refuted :
    ¬(∀ c x : Instrument, ∀ t t' : Nat,
        RatifiedIn c t → ArisesIn x t' → t < t' → Annuls x c) := by
  intro laterOverrides
  obtain ⟨t, ratified, arises⟩ := gal3_17_later
  exact gal3_17_not_annulled
    (laterOverrides covenant law t (t + (400 + 30)) ratified arises (by omega))

/-! ## The 430 years: two witnesses to the dating -/

/-- Dating witness 1, Galatians 3:17 states it. -/
theorem dated_via_galatians : ∃ t : Nat, RatifiedIn covenant t ∧ ArisesIn law (t + (400 + 30)) :=
  gal3_17_later

/-- Dating witness 2, Exodus 12:40: Moses' "thirty and four hundred" is Paul's "four hundred and
thirty" (omega), but the step from Moses' span to Paul's is the labeled chronological reading. -/
theorem dated_via_exodus : ∃ t : Nat, RatifiedIn covenant t ∧ ArisesIn law (t + (400 + 30)) := by
  obtain ⟨a, span⟩ := exo12_40
  have sameNumber : a + (30 + 400) = a + (400 + 30) := by omega
  obtain ⟨ratified, arises⟩ := sojourn_is_pauls_span a (a + (30 + 400)) span
  exact ⟨a, ratified, sameNumber ▸ arises⟩

/-! ## Argument 1, verse 18: the inheritance is not of the law -/

/-- Verse 18's conclusion. Constructive: exclusivity (v18a) and the grant (v18b) suffice, with no
appeal to "law or promise". -/
theorem inheritance_not_of_law : ¬InheritanceOfLaw :=
  fun ofLaw => gal3_18_exclusive ofLaw (granted_through_is_of_promise gal3_18_granted)

/-! ## Argument 2, verse 16: one seed -/

/-- "Not as of many", through Paul's report that Scripture does not say "seeds". -/
theorem not_as_of_many_via_paul : ¬∃ p q : Person, Seed p ∧ Seed q ∧ p ≠ q :=
  fun many => gal3_16_not_seeds (plural_if_many many)

/-- "Not as of many", through the Hebrew of Genesis 13:15 itself. Both routes need the same
reading `plural_if_many`: the Hebrew confirms Paul's report of the WORDING, not his inference from
it. The receipts show exactly that. -/
theorem not_as_of_many_via_genesis : ¬∃ p q : Person, Seed p ∧ Seed q ∧ p ≠ q :=
  fun many => gen13_15_seed (plural_if_many many)

/-- "But as of one": any two who are the seed are the same. Going from "not two distinct" to
"identical" is excluded middle on identity, so `#print axioms` shows `Classical.choice` here. -/
theorem as_of_one : ∀ p q : Person, Seed p → Seed q → p = q :=
  fun p q sp sq =>
    Classical.byContradiction (fun distinct => not_as_of_many_via_paul ⟨p, q, sp, sq, distinct⟩)

/-- "And to thy seed, which is Christ": the seed is Christ and no other. -/
theorem seed_is_christ_alone : ∀ p : Person, Seed p → p = christ :=
  fun p sp => as_of_one p christ sp gal3_16_christ

/-- The promises were spoken to Christ. This needs neither the singular argument nor excluded
middle: Paul's identification (v16b) and his opening clause (v16a) suffice. The argument from the
singular is needed only for "alone". -/
theorem promises_to_christ : PromisedTo christ :=
  gal3_16_spoken.2 christ gal3_16_christ

end Galatians3

/-! ## The receipts
`propext` and `Quot.sound` in a receipt come from `omega`'s year arithmetic, not from any verse;
`Classical.choice` marks excluded middle. -/
#print axioms Galatians3.law_cannot_annul_stated
#print axioms Galatians3.later_law_cannot_annul
#print axioms Galatians3.law_cannot_annul_argued
#print axioms Galatians3.law_does_not_void_promise
#print axioms Galatians3.later_overrides_refuted
#print axioms Galatians3.dated_via_galatians
#print axioms Galatians3.dated_via_exodus
#print axioms Galatians3.inheritance_not_of_law
#print axioms Galatians3.not_as_of_many_via_paul
#print axioms Galatians3.not_as_of_many_via_genesis
#print axioms Galatians3.as_of_one
#print axioms Galatians3.seed_is_christ_alone
#print axioms Galatians3.promises_to_christ
