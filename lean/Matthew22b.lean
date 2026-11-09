/-!
# Matthew 22:41–46 with Psalm 110:1 — "If David then call him Lord, how is he his son?"

The Pharisees are gathered, and Jesus asks them: "What think ye of Christ? whose son is he?"
They answer, "[The Son] of David." Then how does David, "in spirit", call him Lord, saying
"The LORD said unto my Lord, Sit thou on my right hand" (Psalm 110:1)? "If David then call him
Lord, how is he his son?" And no man was able to answer him a word (22:46).

The text asks a question and gives no answer. This file formalizes the question, and labels the
answer it implies as implied.

What it shows:
* Two witnesses that David calls the Christ "lord". Jesus says so outright (22:43). The Hebrew
  psalm gets there only through two labeled identifications: that the psalm's voice is David
  (the heading לְדָוִד is ambiguous) and that the "my lord" addressed is the Christ (the psalm
  names no one). The second receipt shows exactly what Matthew's claim adds to the Hebrew.
* Two witnesses that the Christ is David's son: the Pharisees' answer (22:42), which Jesus does
  not dispute, and Matthew's own first line (1:1). Each needs one labeled step.
* The custom the question leans on, "a father does not call his own son lord", cannot hold
  without exception. Lean refutes the exceptionless form from the texts, by two routes that
  share no premise.
* The implied answer: the Christ is David's son AND David's lord. The opposing premise, "being
  David's son, he is not David's lord", is refuted.

Where the layers diverge:
* Hebrew keeps two words apart: יהוה (the divine name) speaks to אָדוֹן, "my lord" (H0113,
  the ordinary word for a master or a king). The same psalm uses the divine title אֲדֹנָי
  (H0136) in v5. Matthew's Greek has κύριος for both ("Εἶπεν Κύριος τῷ Κυρίῳ μου"), and so
  does the Vulgate (Dominus … Domino). The KJV keeps them apart by typography even in Matthew
  (LORD / Lord), translating a Greek that does not; BSB keeps them apart in the Psalm only.
  Jesus' argument never needs the merger: it runs on "MY lord", which the Hebrew has.
* Hebrew נְאֻם is a noun, "utterance (of)", the prophets' oracle word; the Septuagint (LXX
  column: εἶπεν), Matthew, the Vulgate (Dixit) and both English versions have "said".
* Hebrew "a footstool for your feet" (הֲדֹם; LXX column ὑποπόδιον), Vulgate scabellum, KJV
  Matthew "thy footstool". Nestle 1904 Matthew instead reads ὑποκάτω τῶν ποδῶν σου, "under
  your feet" (BSB follows it), the wording the LXX column shows for Psalm 8:7 (Hebrew
  numbering). Otherwise Matthew's quotation follows the Septuagint's words.
* "In spirit": the Greek has no article (ἐν Πνεύματι; the capital is the editors'). KJV "in
  spirit", BSB "in the Spirit", Vulgate "in spiritu".
-/

namespace Matthew22b

/-! ## Domain and terms -/

/-- @domain The persons Scripture speaks about. A bare type of individuals, it asserts nothing at all. -/
axiom Person : Type

/-- @term MAT 22:42 [Χριστός] "τοῦ Χριστοῦ"
"the Christ" (ὁ Χριστός, the Anointed), the one the Pharisees await. Jesus asks about him in the
third person; the passage never says who he is. -/
axiom christ : Person

/-- @term MAT 22:42 [Δαυίδ] "Τοῦ Δαυείδ"
David. -/
axiom david : Person

/-- @term MAT 1:1 [Ἰησοῦς] "Ἰησοῦ Χριστοῦ"
Jesus, whom Matthew's first line calls "Jesus Christ". -/
axiom jesus : Person

/-- @term PSA 110:1 [הוּא] "לַאדֹנִי"
The psalm's own voice: the "my" of "to my lord" (the suffix -ī, which MACULA lemmatizes under
הוּא). The Hebrew psalm never names him. -/
axiom speaker : Person

/-- @term PSA 110:1 [אָדוֹן] "לַאדֹנִי"
"my lord", the one YHWH addresses: אָדוֹן (H0113), the ordinary word for a master or a king. The
ending is -נִי ("my lord"), not the -נָי of the divine title אֲדֹנָי (H0136) that the same psalm
uses in v5. KJV and BSB print "my Lord" with a capital; Hebrew has no capitals, and the capital
already encodes the reading `my_lord_is_christ`. The psalm names no one. -/
axiom myLord : Person

/-- @term PSA 110:1 [לְ דָּוִד] "לְדָוִד"
"The psalm is headed לְדָוִד": the preposition לְ plus David. The preposition is ambiguous: "by
David", "for David", "about David", or "belonging to David's collection". MACULA glosses it "of";
the LXX column has the dative τῷ ("to, for"); KJV and BSB "A Psalm of David"; Vulgate "Psalmus
David". -/
axiom HeadedLeDavid : Prop

/-- @term MAT 22:45 [υἱός] "υἱὸς αὐτοῦ ἐστιν"
`SonOf c f`: c is the son of f. Here υἱός means descendant: Matthew counts fourteen generations
from David to the exile and fourteen more from the exile to the Christ (1:17). Taken from Jesus'
"how is he his son?", which names the proposition without asserting it. -/
axiom SonOf : Person → Person → Prop

/-- @term MAT 22:45 [καλέω κύριος] "καλεῖ αὐτὸν Κύριον"
`CallsLord a b`: a calls b "lord". Taken from the if-clause of 22:45, which names the
proposition without asserting it. For the Psalm, the word is Hebrew אָדוֹן, which the LXX
column (κυρίῳ) and Matthew render κύριος. -/
axiom CallsLord : Person → Person → Prop

/-- @term MAT 22:44 [κύριος ἐγώ] "τῷ Κυρίῳ μου"
`IsLordOf b a`: b really is a's lord, his master and superior. This is rank, not a form of
address: CallsLord is what is said, IsLordOf is what is so. Matthew's Greek uses κύριος for both
lords of the verse; the Hebrew has יהוה for the first and אָדוֹן for the second. This term is
the second, "MY lord". -/
axiom IsLordOf : Person → Person → Prop

/-- @term MAT 22:42 [λέγω] "λέγουσιν αὐτῷ"
`TheySay p`: the Pharisees say p to Jesus. Matthew reports their answer; he does not state it
in his own voice. -/
axiom TheySay : Prop → Prop

/-! ## Premises: what the texts state -/

/-- @cite MAT 22:42 [τίς υἱός εἰμί λέγω αὐτός Δαυίδ]
GRK:"τίνος υἱός ἐστιν;λέγουσιν αὐτῷ Τοῦ Δαυείδ"
KJV:"whose son is he? They say unto him, [The Son] of David."
BSB:"Whose son is He?” “David’s,” they answered."
VUL:"cujus filius est? Dicunt ei: David."
The verse reports the Pharisees' answer, so the premise is only that THEY SAY it. The Greek
answer is a bare genitive, Τοῦ Δαυείδ, "David's"; the KJV supplies "[The Son]". -/
axiom mat22_42 : TheySay (SonOf christ david)

/-- @cite MAT 22:43 [Δαυίδ ἐν πνεῦμα καλέω αὐτός κύριος]
GRK:"Δαυεὶδ ἐν Πνεύματι καλεῖ αὐτὸν Κύριον"
KJV:"doth David in spirit call him Lord"
BSB:"does David in the Spirit call Him ‘Lord’"
VUL:"David in spiritu vocat eum Dominum"
Jesus' own words. They come as a how-question ("How then …?"), and a how-question takes its fact
as given: it asks how David calls him Lord, not whether. The premise is that fact. The Lean
statement leaves out "in spirit", which only the reading `in_spirit_true` uses. -/
axiom mat22_43 : CallsLord david christ

/-- @cite PSA 110:1 [לְ דָּוִד מִזְמוֹר]
HEB:"לְדָוִד מִזְמוֹר"
KJV:"A Psalm of David."
BSB:"A Psalm of David."
VUL@PSA 109:1:"Psalmus David."
The heading only. Hebrew counts it as part of verse 1; the Vulgate numbers this Psalm 109. -/
axiom psa110_heading : HeadedLeDavid

/-- @cite PSA 110:1 [נְאֻם יהוה לְ אָדוֹן הוּא]
HEB:"נְאֻם יְהוָה לַאדֹנִי"
KJV:"The LORD said unto my Lord"
BSB:"The LORD said to my Lord"
VUL@PSA 109:1:"Dixit Dominus Domino meo"
Literally "utterance of YHWH to my lord": the psalm's voice calls the one YHWH addresses "my
lord". Who the voice is, and who is addressed, the Hebrew does not say. -/
axiom psa110_1 : CallsLord speaker myLord

/-- @cite MAT 1:1 [Ἰησοῦς Χριστός υἱός Δαυίδ]
GRK:"Ἰησοῦ Χριστοῦ υἱοῦ Δαυεὶδ"
KJV:"Jesus Christ, the son of David"
BSB:"Jesus Christ, the son of David"
VUL:"Jesu Christi filii David"
Matthew's narrator, in his own voice. -/
axiom mat1_1 : SonOf jesus david

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Matthew 22:42 reports the Pharisees' answer, "David's"; this reading takes it as TRUE. Jesus
does not dispute it: his "how is he his son?" (22:45) asks how sonship and lordship fit together,
not whether the Christ is David's son, and Matthew's own first line calls Jesus Christ "the son of
David" (1:1). Some read the parallel in Mark 12:35–37 as Jesus setting Davidic descent aside;
Matthew's framing tells against that reading here. -/
axiom answer_granted : TheySay (SonOf christ david) → SonOf christ david

/-- @interpretive
Matthew 1:1 names "Jesus Christ"; Matthew 22:42 asks about "the Christ" in the third person.
Identifying the two is Matthew's whole claim (1:16 "Jesus, who is called Christ"; Peter's
confession at 16:16), but in 22:41–46 Jesus never says that the Christ is himself. -/
axiom jesus_is_the_christ : jesus = christ

/-- @interpretive
The heading לְדָוִד can mean "by David", "for David", "about David", or "of David's collection";
the Hebrew alone does not say that David speaks. Matthew 22:43 says he does ("David … call him
Lord, saying"), and Jesus' argument depends on it. On another common reading the psalm is a
court oracle spoken TO the king by a prophet or courtier, so that "my lord" is the king, and the
question loses its force. -/
axiom heading_names_speaker : HeadedLeDavid → speaker = david

/-- @interpretive
The psalm never names the one YHWH seats at his right hand. Jesus' "call HIM Lord" (αὐτὸν,
22:43) applies it to the Christ, and no one answers otherwise (22:46). Others have applied it to
the reigning king (the court-oracle reading), to Abraham (Babylonian Talmud, Nedarim 32b), or to
Hezekiah (a Jewish reading reported by Justin Martyr, Dialogue with Trypho 33). (Those two
references are from outside this project's corpus and are not machine-checked.) -/
axiom my_lord_is_christ : myLord = christ

/-- @interpretive
"My lord" could be a mere form of address, as a subject addresses a king. Jesus' conclusion
needs more: that David's word is TRUE, that the Christ really is David's lord. Matthew grounds
this in "in spirit" (ἐν Πνεύματι, 22:43), and the psalm presents its words as נְאֻם יְהוָה, the
prophets' oracle formula (נְאֻם יְהוָה: 268 times in the Hebrew corpus, in the Psalms only here;
the bare noun opens Ps 36:2, "oracle of transgression"). Still,
the step from what David calls him to what he is, is a step, so it is labeled. -/
axiom in_spirit_true : CallsLord david christ → IsLordOf christ david

/-! ## Two witnesses that David calls the Christ "lord" -/

/-- Witness 1, Jesus' Greek: stated outright (22:43), no reading needed. -/
theorem calls_lord_via_matthew : CallsLord david christ := mat22_43

/-- Witness 2, the Hebrew psalm: "to my lord" becomes "David calls the Christ lord" only through
two labeled identifications, of the voice and of the one addressed. The receipt shows exactly what
Matthew 22:43 adds to the Hebrew. -/
theorem calls_lord_via_psalm : CallsLord david christ :=
  heading_names_speaker psa110_heading ▸ my_lord_is_christ ▸ psa110_1

/-- The routes agree (proof irrelevance). They are two witnesses because their receipts share no
premise: {mat22_43} versus {psa110_heading, heading_names_speaker, psa110_1, my_lord_is_christ}. -/
example : calls_lord_via_matthew = calls_lord_via_psalm := rfl

/-! ## Two witnesses that the Christ is David's son -/

/-- Witness 1, the Pharisees' answer, taken as true. -/
theorem son_via_pharisees : SonOf christ david := answer_granted mat22_42

/-- Witness 2, Matthew's narrator, with the identification of Jesus as the Christ. -/
theorem son_via_narrator : SonOf christ david := jesus_is_the_christ ▸ mat1_1

/-- Receipts: {mat22_42, answer_granted} versus {mat1_1, jesus_is_the_christ}. No shared premise. -/
example : son_via_pharisees = son_via_narrator := rfl

/-! ## The question no one could answer -/

/-- "If David then call him Lord, how is he his son?" leans on a custom the text never states: a
father does not call his own son "lord". Whoever holds (1) the Christ is David's son, (2) David
calls him lord, and (3) that custom without exception, holds an inconsistent set; perhaps that is
why "no man was able to answer him a word" (22:46), though the text does not say so. The custom
appears here only as a hypothesis, never as an axiom: as an axiom it would make the file
inconsistent. Lean refutes its exceptionless form from Matthew 22 alone. -/
theorem custom_has_an_exception : ¬(∀ a b : Person, SonOf b a → ¬CallsLord a b) :=
  fun custom => custom david christ son_via_pharisees calls_lord_via_matthew

/-- The same refutation by the other two witnesses: Matthew's narrator and the Hebrew psalm. Its
receipt shares no premise with the one above. -/
theorem custom_has_an_exception_via_psalm : ¬(∀ a b : Person, SonOf b a → ¬CallsLord a b) :=
  fun custom => custom david christ son_via_narrator calls_lord_via_psalm

/-! ## The answer the question implies -/

/-- What David calls him, he is: the Christ is David's lord, through the labeled "in spirit" step. -/
theorem christ_is_davids_lord : IsLordOf christ david := in_spirit_true calls_lord_via_matthew

/-- The implied answer, which the text never states: the Christ is David's son AND David's lord. -/
theorem son_and_lord : SonOf christ david ∧ IsLordOf christ david :=
  ⟨son_via_pharisees, christ_is_davids_lord⟩

/-- The opposing premise, "being David's son, the Christ is not David's lord" (he is only David's
son, under David and not over him), contradicts the cited verses plus the labeled readings. -/
theorem only_son_refuted : ¬(SonOf christ david → ¬IsLordOf christ david) :=
  fun only_son => only_son son_and_lord.1 son_and_lord.2

end Matthew22b

/-! ## The receipts -/
#print axioms Matthew22b.calls_lord_via_matthew
#print axioms Matthew22b.calls_lord_via_psalm
#print axioms Matthew22b.son_via_pharisees
#print axioms Matthew22b.son_via_narrator
#print axioms Matthew22b.custom_has_an_exception
#print axioms Matthew22b.custom_has_an_exception_via_psalm
#print axioms Matthew22b.christ_is_davids_lord
#print axioms Matthew22b.son_and_lord
#print axioms Matthew22b.only_son_refuted

-- BEGIN GENERATED THEORY (tools/consistency.py; do not edit by hand)
namespace Matthew22b.Consistency

/-- Every axiom of this file, as one structure: a "theory". A value of this type is a world in
which all the file's terms are interpreted and all its premises and readings are true. -/
structure Theory where
  Person : Type
  christ : Person
  david : Person
  jesus : Person
  speaker : Person
  myLord : Person
  HeadedLeDavid : Prop
  SonOf : Person → Person → Prop
  CallsLord : Person → Person → Prop
  IsLordOf : Person → Person → Prop
  TheySay : Prop → Prop
  mat22_42 : TheySay (SonOf christ david)
  mat22_43 : CallsLord david christ
  psa110_heading : HeadedLeDavid
  psa110_1 : CallsLord speaker myLord
  mat1_1 : SonOf jesus david
  answer_granted : TheySay (SonOf christ david) → SonOf christ david
  jesus_is_the_christ : jesus = christ
  heading_names_speaker : HeadedLeDavid → speaker = david
  my_lord_is_christ : myLord = christ
  in_spirit_true : CallsLord david christ → IsLordOf christ david

/-- The file's own axioms inhabit `Theory`, field for field: Lean checks each type, so the
structure cannot silently differ from the file. -/
noncomputable example : Theory := ⟨Matthew22b.Person, Matthew22b.christ, Matthew22b.david, Matthew22b.jesus, Matthew22b.speaker, Matthew22b.myLord, Matthew22b.HeadedLeDavid, Matthew22b.SonOf, Matthew22b.CallsLord, Matthew22b.IsLordOf, Matthew22b.TheySay, Matthew22b.mat22_42, Matthew22b.mat22_43, Matthew22b.psa110_heading, Matthew22b.psa110_1, Matthew22b.mat1_1, Matthew22b.answer_granted, Matthew22b.jesus_is_the_christ, Matthew22b.heading_names_speaker, Matthew22b.my_lord_is_christ, Matthew22b.in_spirit_true⟩

end Matthew22b.Consistency
-- END GENERATED THEORY

namespace Matthew22b.Consistency

/-- A two-person world, `false` = David and `true` = the Christ (who is Jesus): David is the
psalm's voice and the Christ its "my lord", so both disputed readings hold here, and the Christ
is David's son and David's lord while David is not his own son. The father-son custom fails in
this world (David calls his own son "lord"), yet nothing collapses, so "son and lord" needs no
merging of David with the Christ. -/
def model : Theory where
  Person := Bool
  christ := true
  david := false
  jesus := true
  speaker := false
  myLord := true
  HeadedLeDavid := True
  SonOf := fun c f => c = true ∧ f = false
  CallsLord := fun a b => a = false ∧ b = true
  IsLordOf := fun b a => b = true ∧ a = false
  TheySay := fun p => p
  mat22_42 := ⟨rfl, rfl⟩
  mat22_43 := ⟨rfl, rfl⟩
  psa110_heading := trivial
  psa110_1 := ⟨rfl, rfl⟩
  mat1_1 := ⟨rfl, rfl⟩
  answer_granted := fun h => h
  jesus_is_the_christ := rfl
  heading_names_speaker := fun _ => rfl
  my_lord_is_christ := rfl
  in_spirit_true := fun _ => ⟨rfl, rfl⟩

/-- The premises and readings of this file cannot contradict each other: a world satisfying all of
them exists. So no theorem above holds merely because the axioms were inconsistent. -/
theorem consistent : ¬(Theory → False) := fun h => h model

end Matthew22b.Consistency

#print axioms Matthew22b.Consistency.consistent
