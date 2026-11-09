/-!
# John 10:31–36 with Psalm 82:6 — "Is it not written in your law, I said, Ye are gods?"

The Jews take up stones (10:31). Not for a good work, they say, "but for blasphemy; and because
that thou, being a man, makest thyself God" (10:33). Jesus answers from their own Scripture,
Psalm 82:6: "Is it not written in your law, I said, Ye are gods? If he called them gods, unto
whom the word of God came, and the scripture cannot be broken; say ye of him, whom the Father
hath sanctified, and sent into the world, Thou blasphemest; because I said, I am the Son of God?"
(10:34–36).

The argument is an a fortiori (qal wahomer, lesser to greater):
* LESSER: Scripture calls "gods" those to whom the word of God came, and Scripture cannot be
  broken, so that naming is no blasphemy.
* GREATER: the one the Father sanctified and sent into the world says "I am the Son of God".
* RULE (unstated, labeled): what the lesser may be called without blasphemy, the greater may
  claim without blasphemy.
* So the charge "Thou blasphemest" fails, by premises the accusers hold: "your law", and a
  scripture that "cannot be broken".

What it shows:
* Two independent routes to "Scripture called some 'gods'": Jesus' Greek (Θεοί ἐστε) states it;
  the Psalm's Hebrew says אֱלֹהִים, a word that also means God and, elsewhere, judges, so that
  route needs a labeled reading.
* The passage's conclusion, `charge_refuted`, is "not blasphemy" and nothing more. No divinity
  claim is derived; the file has no predicate for one.
* Who the "gods" of Psalm 82 are (Israel's judges, Israel at Sinai, or angelic beings) is
  debated. The conclusion does NOT depend on it: its receipt holds no identification reading.
  Only the stronger `bare_rule_refuted` ("no man may be called god" is false) needs one, and
  its receipt shows `addressees_are_men`.
* Every proof is constructive: no receipt shows `Classical.choice`.

Where the layers diverge:
* Psalm 82:6 is a verbless clause, אֱלֹהִים אַתֶּם, "gods you" (KJV prints "Ye [are] gods" with
  the verb as a supplied word). The Septuagint adds the verb, and John's Greek
  "Ἐγὼ εἶπα Θεοί ἐστε" matches the word table's LXX column word for word (ἐγὼ εἶπα θεοί ἐστε).
  Hebrew perfect אָמַרְתִּי: KJV and BSB give "I have said" in the Psalm; KJV John "I said".
* "your law" (νόμῳ, 10:34) introduces a psalm, not the Torah; John 15:25 does the same ("written
  in their law", quoting a psalm). The Vulgate agrees: in lege vestra.
* The λόγος that "came" to them (10:35) is the same Greek word as the Λόγος of 1:1. The Vulgate
  breaks the echo: "sermo Dei" here, "Verbum" there. KJV keeps "word" in both.
* "Son of God" (10:36) is Υἱὸς τοῦ Θεοῦ with no article on Υἱὸς; KJV and BSB print "the Son of
  God", and Latin has no articles (Filius Dei). The formalization takes no position on it.
* 10:33 words the charge "ποιεῖς σεαυτὸν Θεόν", "makest thyself God" (BSB "declare Yourself to be
  God"); in 10:36 Jesus restates it as "because I said, I am the Son of God". This file uses the
  10:36 wording, which is what his answer answers. It does not identify the two.

Versification: John 10 numbers alike in all four layers. Psalm 82 agrees in Hebrew and English
(the short title sits inside v1, and Hebrew Ps 82 has 8 verses like the English); the Vulgate
numbers it Psalm 81, so its quote is cited at VUL@PSA 81:6.
-/

namespace John10

/-! ## Domain and terms -/

/-- @domain The persons Scripture speaks about, human or not. A bare type of individuals, it asserts nothing at all. -/
axiom Person : Type

/-- @term JHN 10:34 [Ἰησοῦς] "ὁ Ἰησοῦς"
Jesus, who answers in 10:34–36. -/
axiom jesus : Person

/-- @term JHN 10:33 [ἄνθρωπος εἰμί] "ἄνθρωπος ὢν"
"being a man": the accusers' own description of him. -/
axiom Man : Person → Prop

/-- @term JHN 10:33 [περί βλασφημία] "περὶ βλασφημίας"
"for blasphemy". Read as a property of the one named: to give p the divine name in question is
blasphemy, whoever speaks it. The charge returns in 10:36 as the verb Βλασφημεῖς, "Thou
blasphemest". -/
axiom Blasphemy : Person → Prop

/-- @term PSA 82:6 [אָמַר אֱלֹהִים אַתֶּם] "אָמַרְתִּי אֱלֹהִים אַתֶּם"
"I said: אֱלֹהִים, you". The Hebrew word, with its whole range: God, gods, and (elsewhere) judges. -/
axiom CalledElohim : Person → Prop

/-- @term JHN 10:35 [λέγω θεός] "εἶπεν θεοὺς"
"he called them gods" (θεοί). The text leaves the subject of εἶπεν unnamed: God, the "I" of the
Psalm, or the law that records it. Nothing here depends on which. -/
axiom CalledGods : Person → Prop

/-- @term JHN 10:35 [πρός ὅς λόγος θεός γίνομαι] "πρὸς οὓς ὁ λόγος τοῦ Θεοῦ ἐγένετο"
"unto whom the word of God came": Jesus' own gloss on the addressees of the Psalm. -/
axiom WordCame : Person → Prop

/-- @term JHN 10:35 [λύω γραφή] "λυθῆναι ἡ γραφή"
"the scripture be broken" (λύω: loose, annul, set aside). -/
axiom ScriptureBroken : Prop

/-- @term JHN 10:36 [πατήρ ἁγιάζω ἀποστέλλω εἰς κόσμος] "ὁ Πατὴρ ἡγίασεν καὶ ἀπέστειλεν εἰς τὸν κόσμον"
"the Father sanctified (ἁγιάζω: set apart, consecrated) and sent into the world". -/
axiom SanctifiedSent : Person → Prop

/-- @term JHN 10:36 [λέγω υἱός θεός εἰμί] "εἶπον Υἱὸς τοῦ Θεοῦ εἰμι"
"I said, I am the Son of God": the claim the charge is about. -/
axiom SaidSonOfGod : Person → Prop

/-! ## Premises: what the texts state -/

/-- @cite PSA 82:6 [אֲנִי אָמַר אֱלֹהִים אַתֶּם]
HEB:"אֲנִי אָמַרְתִּי אֱלֹהִים אַתֶּם"
KJV:"I have said, Ye [are] gods"
BSB:"I have said, ‘You are gods"
VUL@PSA 81:6:"Ego dixi: Dii estis" -/
axiom psa82_6 : ∃ p : Person, CalledElohim p

/-- @cite JHN 10:34 [γράφω νόμος ἐγώ λέγω θεός εἰμί]
GRK:"Οὐκ ἔστιν γεγραμμένον ἐν τῷ νόμῳ ὑμῶν ὅτι Ἐγὼ εἶπα Θεοί ἐστε"
KJV:"Is it not written in your law, I said, Ye are gods?"
BSB:"Is it not written in your Law: ‘I have said you are gods’?"
VUL:"Nonne scriptum est in lege vestra, Quia ego dixi: Dii estis?"
A question with οὐκ expects the answer yes: it is written. -/
axiom jhn10_34 : ∃ p : Person, CalledGods p

/-- @cite JHN 10:35 [εἰ ἐκεῖνος λέγω θεός πρός ὅς λόγος γίνομαι]
GRK:"εἰ ἐκείνους εἶπεν θεοὺς πρὸς οὓς ὁ λόγος τοῦ Θεοῦ ἐγένετο"
KJV:"If he called them gods, unto whom the word of God came"
BSB:"If he called them gods to whom the word of God came"
VUL:"Si illos dixit deos, ad quos sermo Dei factus est"
The "if" (εἰ) states as a condition what 10:34 has just shown written. The premise taken here
is only the relative clause: those he called gods are those to whom the word came. -/
axiom jhn10_35a : ∀ p : Person, CalledGods p → WordCame p

/-- @cite JHN 10:35 [οὐ δύναμαι λύω γραφή]
GRK:"οὐ δύναται λυθῆναι ἡ γραφή"
KJV:"and the scripture cannot be broken"
BSB:"and the Scripture cannot be broken"
VUL:"et non potest solvi Scriptura"
"Cannot be broken" is modal; the axiom states only that it is not broken, which is weaker. -/
axiom jhn10_35b : ¬ScriptureBroken

/-- @cite JHN 10:36 [ὅς πατήρ ἁγιάζω ἀποστέλλω εἰς κόσμος]
GRK:"ὃν ὁ Πατὴρ ἡγίασεν καὶ ἀπέστειλεν εἰς τὸν κόσμον"
KJV:"whom the Father hath sanctified, and sent into the world"
BSB:"whom the Father sanctified and sent into the world"
VUL:"quem Pater sanctificavit, et misit in mundum"
"Whom" is the speaker: the same verse goes on "Thou blasphemest; because I said", and the speaker
is Jesus (10:34). -/
axiom jhn10_36a : SanctifiedSent jesus

/-- @cite JHN 10:36 [ὅτι λέγω υἱός θεός εἰμί]
GRK:"ὅτι εἶπον Υἱὸς τοῦ Θεοῦ εἰμι"
KJV:"because I said, I am the Son of God"
BSB:"for stating that I am the Son of God"
VUL:"quia dixi: Filius Dei sum" -/
axiom jhn10_36b : SaidSonOfGod jesus

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Psalm 82:6 says they were called אֱלֹהִים, the word this same psalm uses for God himself (82:1,
"אֱלֹהִים נִצָּב", KJV "God standeth") and for the gods among whom he judges (82:1, "בְּקֶרֶב
אֱלֹהִים"). Jesus' Greek gives θεοί, the Septuagint's word. Reading the Hebrew as "called gods" is
an identification of two words: אֱלֹהִים also bears the sense "judges" (KJV and BSB at Exodus 21:6,
where the Vulgate has "diis"). On that rendering the word spoken over them is still the divine
name, which is what the argument turns on, but the identification is a reading all the same. -/
axiom elohim_read_as_gods : ∀ p : Person, CalledElohim p → CalledGods p

/-- @interpretive
Verse 35 sets "and the scripture cannot be broken" beside "he called them gods" but does not
state the link between them. The reading supplies it: to condemn as blasphemy a name that
Scripture itself gives would be to break (λύω: annul, set aside) that scripture. It holds whether
ἡ γραφή, singular, means this one passage or Scripture as a whole; only the narrower sense is
needed, since the name in question stands in this passage. -/
axiom blasphemy_would_break_scripture : ∀ p : Person, CalledGods p → Blasphemy p → ScriptureBroken

/-- @interpretive
The a fortiori rule (qal wahomer, lesser to greater), which the text uses but never states.
Verses 35–36 set "them, unto whom the word of God came" beside "him, whom the Father hath
sanctified, and sent into the world" and ask whether the second may be told "Thou blasphemest"
when the first were called gods. The reading adds: (1) the rule itself, that what the lesser
may be called without blasphemy the greater may claim without blasphemy; (2) that the one
sanctified and sent is the greater, which the contrast implies but never says; (3) that "Son of
God" is no higher a name than "gods" (Psalm 82:6b, which Jesus does not quote, calls the same
addressees "וּבְנֵי עֶלְיוֹן", "children of the most High"); (4) that a claim made by one the
Father sent is warranted as a name given by God is. Alternatives: some read the reply as only
ad hominem (your own Scripture uses the word of others, so the charge is not automatic), which
supports `bare_rule_refuted` but does not by itself reach `charge_refuted`; others hear a
contrast between those to whom the λόγος came and the Λόγος himself (1:1), which goes beyond
these verses and is not used here. -/
axiom a_fortiori : ∀ a b : Person, WordCame a → CalledGods a → ¬Blasphemy a →
  SanctifiedSent b → SaidSonOfGod b → ¬Blasphemy b

/-- @interpretive
Jesus' only gloss on who "ye" are is "unto whom the word of God came" (10:35, cited above); the
Psalm itself does not say. This reading adds that they are human. Scholars disagree: Israel's
judges (82:2 "How long will ye judge unjustly"; KJV renders the same word "judges" at Exodus
21:6); Israel at Sinai, when the word of God came to them; or angelic members of a divine
council (82:1 "in the midst of the gods"), who are not men, so that 82:7 "ye shall die like men"
(כְּאָדָם) is their fall. On the first two readings this axiom is true; on the third it is false.
Only `bare_rule_refuted` uses it. -/
axiom addressees_are_men : ∀ p : Person, CalledGods p → Man p

/-! ## Two witnesses that Scripture called some "gods" -/

/-- Witness 1, Jesus' Greek: stated outright, no reading needed. -/
theorem called_gods_via_john : ∃ p : Person, CalledGods p := jhn10_34

/-- Witness 2, the Psalm's Hebrew: needs the reading that אֱלֹהִים here means "gods" (θεοί). -/
theorem called_gods_via_psalm : ∃ p : Person, CalledGods p :=
  match psa82_6 with
  | ⟨p, h⟩ => ⟨p, elohim_read_as_gods p h⟩

/-- The routes agree (proof irrelevance). They are two witnesses because their receipts share no
premise: {jhn10_34} versus {psa82_6, elohim_read_as_gods}. -/
example : called_gods_via_john = called_gods_via_psalm := rfl

/-! ## The lesser case -/

/-- Whatever name Scripture gives, it gives without blasphemy, since the scripture cannot be
broken. -/
theorem scripture_names_not_blasphemy : ∀ p : Person, CalledGods p → ¬Blasphemy p :=
  fun p hc hb => jhn10_35b (blasphemy_would_break_scripture p hc hb)

/-- The lesser half of the a fortiori, as 10:35 puts it: there are those to whom the word of God
came, whom Scripture called gods, and that was no blasphemy. -/
theorem lesser_case : ∃ a : Person, WordCame a ∧ CalledGods a ∧ ¬Blasphemy a :=
  match jhn10_34 with
  | ⟨a, hc⟩ => ⟨a, jhn10_35a a hc, hc, scripture_names_not_blasphemy a hc⟩

/-! ## The argument -/

/-- The passage's conclusion, and no more: "say ye of him … Thou blasphemest?" His saying "I am
the Son of God" is not blasphemy, by the accusers' own law. This says nothing about what "Son of
God" means beyond that; the receipt holds no identification of who the "gods" were. -/
theorem charge_refuted : ¬Blasphemy jesus :=
  match lesser_case with
  | ⟨a, hw, hc, hn⟩ => a_fortiori a jesus hw hc hn jhn10_36a jhn10_36b

/-- The accusers' premise, "a man who says 'I am the Son of God' blasphemes" (10:33 "being a
man" with 10:36 "Thou blasphemest; because I said, I am the Son of God"). Granting them their
own description of him as a man, the premise contradicts the cited verses and the a fortiori
reading. The hypothesis `hman` is theirs; the file does not assert it. -/
theorem accusers_premise_refuted (hman : Man jesus) :
    ¬(∀ p : Person, Man p → SaidSonOfGod p → Blasphemy p) :=
  fun h => charge_refuted (h jesus hman jhn10_36b)

/-- A stronger result the passage does not need: the bare rule behind 10:33, "to call any man
god is blasphemy", is false. The lesser case alone refutes it, with no a fortiori, but only if
the addressees of Psalm 82 are men. The receipt shows that disputed reading; on the angelic
reading this theorem falls and `charge_refuted` still stands. -/
theorem bare_rule_refuted : ¬(∀ p : Person, Man p → CalledGods p → Blasphemy p) :=
  fun h => match jhn10_34 with
    | ⟨p, hc⟩ => scripture_names_not_blasphemy p hc (h p (addressees_are_men p hc) hc)

end John10

/-! ## The receipts -/
#print axioms John10.called_gods_via_john
#print axioms John10.called_gods_via_psalm
#print axioms John10.scripture_names_not_blasphemy
#print axioms John10.lesser_case
#print axioms John10.charge_refuted
#print axioms John10.accusers_premise_refuted
#print axioms John10.bare_rule_refuted
