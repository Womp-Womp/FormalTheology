/-!
# Romans 4:9–12 with Genesis 15–17 — "Not in circumcision, but in uncircumcision"

Paul asks whether the blessing of Genesis 15:6 belongs to the circumcision only. His answer is
an argument from TIME: "How was it then reckoned? when he was in circumcision, or in
uncircumcision? Not in circumcision, but in uncircumcision" (4:10). Circumcision came afterwards
as "the sign of circumcision, a seal of the righteousness of the faith" he already had, "that he
might be the father of all them that believe, though they be not circumcised" (4:11).

How time is modeled:
* Time is `Nat`: the instants of Abraham's life, in order, fine enough that two different events
  get two different instants. No unit is assumed.
* Ages are a relation, `AgedAt t n`: at instant t Abraham was "a son of n years" (Hebrew בֶּן ...
  שָׁנָה). A clause "X was N years old when E" is formalized as `∀ t, E t → AgedAt t N`: whenever
  E happened, his age was N. That states the age and nothing more, not even that E happened;
  where a proof needs the event to have happened, another verse that states it is cited
  (16:15 for Ishmael's birth, 17:26 for the circumcision).
* `omega` does the arithmetic. The decisive fact is 86 < 99.

What it shows:
* Two independent routes to "the reckoning came before the circumcision":
  (a) Paul's Greek, 4:10, plus one reading (being ἐν ἀκροβυστίᾳ means the circumcision is still
      ahead); (b) the Genesis chronology, 15:6 + 16:15 + 16:16 + 17:24, plus the reading that
      Genesis 15 happens no later than the birth of Genesis 16. Genesis 15:6 itself states no age
      and no date. The receipts share no premise.
* The reckoning fell when Abram was at most 86; at the circumcision he was 99. So "not in
  circumcision" is not a close call: at least 13 years. (13 is also Ishmael's age at that same
  circumcision, Genesis 17:25 שְׁלֹשׁ עֶשְׂרֵה, with 17:26 "the selfsame day": 86 + 13 = 99. The
  Hebrew numerals cohere. 17:25 is not needed as a premise and is not cited.)
* The opponent's premise, "it was reckoned only to him in circumcision", is refuted in Paul's own
  state form and in a time form, the time form by both routes.
* Abraham is father of all who believe uncircumcised (4:11). Its receipt contains NO chronology:
  Paul states this as a purpose (εἰς τὸ εἶναι), and the step from purpose to fact is labeled.

Where the layers diverge (the Greek and Hebrew govern):
* 4:9: the Greek has no "only" and no verb in the question. The KJV supplies "[Cometh]" and
  "[only]" in brackets; the BSB writes "only" with no mark; the Vulgate adds "tantum manet".
* 4:10: the Greek asks about a STATE, ἐν περιτομῇ ὄντι ἢ ἐν ἀκροβυστίᾳ ("being in circumcision, or
  in uncircumcision"). KJV and Vulgate keep the state. The BSB renders it as TIME ("after his
  circumcision, or before? ... not after, but before"), which is the reading route (a) labels.
* Genesis 15:6: Hebrew וַיַּחְשְׁבֶהָ is ACTIVE, "and he reckoned it" (Qal wayyiqtol, 3ms, with the
  object "it", a feminine suffix). The word table's Septuagint column gives ἐλογίσθη, PASSIVE, "it
  was reckoned", and Paul uses that same form of λογίζομαι (4:3, 4:9, 4:10). So Paul follows the
  Septuagint. KJV follows the Hebrew ("he counted it"); BSB ("it was credited") and Vulgate
  ("reputatum est") follow the passive. The Hebrew names no subject for "believed"; BSB and
  Vulgate supply "Abram". Where the Hebrew says "it", Paul names what was reckoned: ἡ πίστις.
* Genesis 17:24: Hebrew בְּהִמֹּלוֹ is passive (Niphal, "when he was circumcised"), as are KJV and
  BSB; the Vulgate makes it active ("quando circumcidit", "when he circumcised").
* 4:11: εἰς τὸ εἶναι is purpose ("that he might be", KJV) or result. The BSB asserts it ("So then,
  he is the father"); the Vulgate "ut sit" allows both. KJV "though they be not circumcised" is
  concessive; the Greek is δι' ἀκροβυστίας, "through uncircumcision" (Vulgate "per præputium").
* Paul's vocabulary is the Septuagint's Genesis 17: ἀκροβυστία renders עָרְלָה "foreskin" (17:11,
  17:24) and σημεῖον renders אוֹת "sign" (17:11). The Hebrew word table also files the tens under
  the units: שְׁמֹנִים "eighty" under lemma שְׁמֹנֶה "eight" (Strong's 8084, not 8083), תִּשְׁעִים
  "ninety" under תֵּשַׁע "nine" (8673, not 8672). The lemma lists cannot tell 80 from 8; the
  quotes, which must match letters and vowels, can.
-/

namespace Romans4

/-! ## Domain and terms -/

/-- @domain The persons Paul speaks of in 4:11, those who believe. A bare type of individuals, it
asserts nothing at all. -/
axiom Person : Type

/-- @term ROM 4:9 [λογίζομαι Ἀβραάμ πίστις δικαιοσύνη] "Ἐλογίσθη τῷ Ἀβραὰμ ἡ πίστις εἰς δικαιοσύνην"
`ReckonedGk t`: at instant t, faith was reckoned (ἐλογίσθη, aorist passive of λογίζομαι) to
Abraham for righteousness. Paul's word. -/
axiom ReckonedGk : Nat → Prop

/-- @term ROM 4:10 [ἐν περιτομή εἰμί] "ἐν περιτομῇ ὄντι"
`InCircumcision t`: at instant t Abraham was "being in circumcision". A state, not an event. -/
axiom InCircumcision : Nat → Prop

/-- @term ROM 4:10 [ἐν ἀκροβυστία] "ἐν ἀκροβυστίᾳ"
`InUncircumcision t`: at instant t Abraham was "in uncircumcision" (ἀκροβυστία, literally
"foreskin"). A state, not an event. -/
axiom InUncircumcision : Nat → Prop

/-- @term ROM 4:11 [πιστεύω διά ἀκροβυστία] "πιστευόντων δι’ἀκροβυστίας"
"those believing through uncircumcision": believers who are not circumcised. -/
axiom BelievesUncircumcised : Person → Prop

/-- @term ROM 4:11 [εἰμί αὐτός πατήρ] "εἶναι αὐτὸν πατέρα"
`FatherOf p`: Abraham is father of p. -/
axiom FatherOf : Person → Prop

/-- @term ROM 4:11 [εἰς ὁ εἰμί] "εἰς τὸ εἶναι"
`InOrderThat P`: "to the end that P", εἰς τὸ with the infinitive. It marks a purpose; it does not
by itself assert that P holds. -/
axiom InOrderThat : Prop → Prop

/-- @term GEN 15:6 [חָשַׁב לְ צְדָקָה] "וַיַּחְשְׁבֶ֥הָ לּ֖וֹ צְדָקָֽה"
`ReckonedHeb t`: at instant t "he reckoned it to him [as] righteousness" (חָשַׁב, Qal, active).
Moses' word. Septuagint: ἐλογίσθη. -/
axiom ReckonedHeb : Nat → Prop

/-- @term GEN 16:16 [יָלַד הָגָר יִשְׁמָעֵאל] "בְּלֶֽדֶת־הָגָ֥ר אֶת־יִשְׁמָעֵ֖אל"
`IshmaelBornAt t`: at instant t Hagar bore Ishmael. -/
axiom IshmaelBornAt : Nat → Prop

/-- @term GEN 17:24 [מוּל בָּשָׂר עׇרְלָה] "בְּהִמֹּל֖וֹ בְּשַׂ֥ר עָרְלָתֽוֹ"
`CircumcisedAt t`: at instant t Abraham was circumcised in the flesh of his foreskin (מוּל, an
event). -/
axiom CircumcisedAt : Nat → Prop

/-- @term GEN 17:24 [בֵּן שָׁנָה] "בֶּן־תִּשְׁעִ֥ים וָתֵ֖שַׁע שָׁנָ֑ה"
`AgedAt t n`: at instant t Abraham was "a son of n years", the Hebrew idiom for age. Genesis 16:16
says it of Abram and 17:24 of Abraham: one man, renamed in 17:5. -/
axiom AgedAt : Nat → Nat → Prop

/-! ## Premises: what the texts state -/

/-- @cite ROM 4:9 [λέγω λογίζομαι Ἀβραάμ πίστις εἰς δικαιοσύνη]
GRK:"λέγομεν γάρ Ἐλογίσθη τῷ Ἀβραὰμ ἡ πίστις εἰς δικαιοσύνην"
KJV:"for we say that faith was reckoned to Abraham for righteousness."
BSB:"We have been saying that Abraham’s faith was credited to him as righteousness."
VUL:"Dicimus enim quia reputata est Abrahæ fides ad justitiam."
The reckoning happened, at some instant Paul does not name. -/
axiom rom4_9 : ∃ t, ReckonedGk t

/-- @cite ROM 4:10 [πῶς οὖν λογίζομαι ἐν περιτομή εἰμί ἤ ἀκροβυστία οὐ ἀλλά]
GRK:"πῶς οὖν ἐλογίσθη;ἐν περιτομῇ ὄντι ἢ ἐν ἀκροβυστίᾳ;οὐκ ἐν περιτομῇ ἀλλ’ἐν ἀκροβυστίᾳ"
KJV:"How was it then reckoned? when he was in circumcision, or in uncircumcision? Not in circumcision, but in uncircumcision."
BSB:"In what context was it credited? Was it after his circumcision, or before? It was not after, but before."
VUL:"Quomodo ergo reputata est? in circumcisione, an in præputio? Non in circumcisione, sed in præputio."
Stated as the Greek states it, a STATE at the reckoning. The BSB's "before" is not used here. -/
axiom rom4_10 : ∀ t, ReckonedGk t → ¬InCircumcision t ∧ InUncircumcision t

/-- @cite ROM 4:11 [εἰς εἰμί αὐτός πατήρ πᾶς πιστεύω διά ἀκροβυστία]
GRK:"εἰς τὸ εἶναι αὐτὸν πατέρα πάντων τῶν πιστευόντων δι’ἀκροβυστίας"
KJV:"that he might be the father of all them that believe, though they be not circumcised"
BSB:"So then, he is the father of all who believe but are not circumcised"
VUL:"ut sit pater omnium credentium per præputium"
A purpose, as the Greek has it: the sign was given to the end that he be their father. -/
axiom rom4_11 : InOrderThat (∀ p, BelievesUncircumcised p → FatherOf p)

/-- @cite GEN 15:6 [חָשַׁב לְ צְדָקָה]
HEB:"וַיַּחְשְׁבֶ֥הָ לּ֖וֹ צְדָקָֽה"
KJV:"and he counted it to him for righteousness."
BSB:"and it was credited to him as righteousness."
VUL:"et reputatum est illi ad justitiam."
The reckoning happened. The verse gives no age and no date, so the instant is left unnamed. -/
axiom gen15_6 : ∃ t, ReckonedHeb t

/-- @cite GEN 16:15 [יָלַד הָגָר אַבְרָם בֵּן קָרָא שֵׁם יִשְׁמָעֵאל]
HEB:"וַתֵּ֧לֶד הָגָ֛ר לְאַבְרָ֖ם בֵּ֑ן וַיִּקְרָ֨א אַבְרָ֧ם שֶׁם־בְּנ֛וֹ אֲשֶׁר־יָלְדָ֥ה הָגָ֖ר יִשְׁמָעֵֽאל"
KJV:"And Hagar bare Abram a son: and Abram called his son’s name, which Hagar bare, Ishmael."
BSB:"And Hagar bore Abram a son, and Abram gave the name Ishmael to the son she had borne."
VUL:"Peperitque Agar Abræ filium: qui vocavit nomen ejus Ismaël."
Ishmael was born (at some instant). -/
axiom gen16_15 : ∃ t, IshmaelBornAt t

/-- @cite GEN 16:16 [אַבְרָם בֵּן שְׁמֹנֶה שָׁנָה שֵׁשׁ יָלַד הָגָר יִשְׁמָעֵאל]
HEB:"וְאַבְרָ֕ם בֶּן־שְׁמֹנִ֥ים שָׁנָ֖ה וְשֵׁ֣שׁ שָׁנִ֑ים בְּלֶֽדֶת־הָגָ֥ר אֶת־יִשְׁמָעֵ֖אל"
KJV:"And Abram [was] fourscore and six years old, when Hagar bare Ishmael to Abram."
BSB:"Abram was eighty-six years old when Hagar bore Ishmael to him."
VUL:"Octoginta et sex annorum erat Abram quando peperit ei Agar Ismaëlem."
שְׁמֹנִים שָׁנָה וְשֵׁשׁ שָׁנִים, "eighty year and six years": 86. -/
axiom gen16_16 : ∀ t, IshmaelBornAt t → AgedAt t 86

/-- @cite GEN 17:24 [אַבְרָהָם בֵּן תֵּשַׁע שָׁנָה מוּל בָּשָׂר עׇרְלָה]
HEB:"וְאַ֨בְרָהָ֔ם בֶּן־תִּשְׁעִ֥ים וָתֵ֖שַׁע שָׁנָ֑ה בְּהִמֹּל֖וֹ בְּשַׂ֥ר עָרְלָתֽוֹ"
KJV:"And Abraham [was] ninety years old and nine, when he was circumcised in the flesh of his foreskin."
BSB:"So Abraham was ninety-nine years old when he was circumcised,"
VUL:"Abraham nonaginta et novem erat annorum quando circumcidit carnem præputii sui."
תִּשְׁעִים וָתֵשַׁע שָׁנָה, "ninety and nine year": 99. -/
axiom gen17_24 : ∀ t, CircumcisedAt t → AgedAt t 99

/-- @cite GEN 17:26 [עֶצֶם יוֹם זֶה מוּל אַבְרָהָם]
HEB:"בְּעֶ֨צֶם֙ הַיּ֣וֹם הַזֶּ֔ה נִמּ֖וֹל אַבְרָהָ֑ם"
KJV:"In the selfsame day was Abraham circumcised"
BSB:"Abraham and his son Ishmael were circumcised on the same day."
VUL:"Eadem die circumcisus est Abraham"
The circumcision happened. Used only to show the time claims are not vacuous. -/
axiom gen17_26 : ∃ t, CircumcisedAt t

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Paul writes "we say" (4:9) after quoting Genesis 15:6 as "the scripture" in 4:3, in the
Septuagint's words. This reading identifies the occasion of Paul's ἐλογίσθη (λογίζομαι, passive)
with the occasion of Moses' וַיַּחְשְׁבֶהָ (חָשַׁב, active), whose Septuagint equivalent in the word
table is ἐλογίσθη. The voices differ; what is identified is the event. Alternative: James 2:23 says
that scripture was "fulfilled" (ἐπληρώθη) at a later act, and some read the reckoning as renewed or
confirmed afterwards; Paul's aorist then picks out the first reckoning, not necessarily the only. -/
axiom same_reckoning : ∀ t, ReckonedGk t ↔ ReckonedHeb t

/-- @interpretive
Genesis 15:6 gives no age or date. Genesis narrates it before chapter 16, and this reading takes
that narrative order as time order: the reckoning came no later than Ishmael's birth (≤, the weaker
claim). Support: in the same scene Abram says he goes childless (15:2) and has been given no seed
(15:3), and 16:1 opens with Sarai still having borne him no children. Caution: Genesis does not
always narrate in time order. Terah's death is told in 11:32 before Abram, aged 75, leaves Haran in
12:4; if Abram was born when Terah was 70 (11:26), Terah lived 60 years more, while Acts 7:4 puts
the departure after the death. Many therefore read Abram as not the firstborn; others as narration
out of order. Source critics also assign chapters 15 and 17 to different strands. Only route (b)
needs this reading; Paul's route does not. -/
axiom reckoned_before_ishmael : ∀ r b, ReckonedHeb r → IshmaelBornAt b → r ≤ b

/-- @interpretive
Genesis counts ages in whole years of one life ("a son of N years"). This adds only the arithmetic
of counting: at a later instant Abraham is never younger. It is not a claim of the text, and no
step depends on how years were counted (birthdays, inclusive reckoning); it also makes his age at
any one instant unique. -/
axiom aging_monotone : ∀ s t m n, s ≤ t → AgedAt s m → AgedAt t n → m ≤ n

/-- @interpretive
Paul's ἀκροβυστία is the Septuagint's word for the עָרְלָה ("foreskin") of Genesis 17:11 and 17:24,
which circumcision removes. Read as Abraham's bodily state, one who is still in it at instant a has
his circumcision ahead of him, so a comes before c. This assumes the circumcision is one event,
not undone, at an instant of its own. The BSB writes this reading into 4:10 ("not after, but
before"). Alternative: in Romans περιτομή and ἀκροβυστία often name peoples or covenant standing,
Jew and Gentile (2:26, 3:30), not a dated bodily state; on that reading 4:10 speaks of his
standing, and the time order must come from Genesis instead. -/
axiom uncircumcision_precedes : ∀ a c, InUncircumcision a → CircumcisedAt c → a < c

/-- @interpretive
Romans 4:11 states a purpose, εἰς τὸ εἶναι αὐτὸν πατέρα ("to the end that he be father"), not a
fact. This reading takes the stated purpose as accomplished, so Abraham IS father of uncircumcised
believers. Support: 4:16 says outright ὅς ἐστιν πατὴρ πάντων ἡμῶν, "who is the father of us all",
present indicative. Alternative: εἰς τὸ with the infinitive can express result, which is how the
BSB renders it ("So then, he is the father"); the KJV keeps purpose ("that he might be"), and the
Vulgate's ut sit allows either. -/
axiom purpose_realized :
  InOrderThat (∀ p, BelievesUncircumcised p → FatherOf p) → ∀ p, BelievesUncircumcised p → FatherOf p

/-! ## Two witnesses that the reckoning came before the circumcision -/

/-- Witness (a), Paul: 4:10 says "in uncircumcision"; one reading turns that state into an order in
time. Genesis supplies no premise here. -/
theorem before_via_paul : ∀ r c, ReckonedGk r → CircumcisedAt c → r < c :=
  fun r c hr hc => uncircumcision_precedes r c (rom4_10 r hr).2 hc

/-- A step of route (b): Ishmael was born before the circumcision, because 86 < 99. -/
theorem ishmael_born_before_circumcision : ∀ b c, IshmaelBornAt b → CircumcisedAt c → b < c := by
  intro b c hb hc
  cases Nat.lt_or_ge b c with
  | inl h => exact h
  | inr h =>
    have : 99 ≤ 86 := aging_monotone c b 99 86 h (gen17_24 c hc) (gen16_16 b hb)
    omega

/-- Witness (b), Genesis: 15:6 (via the identification), no later than 16:15–16 (via the narrative
reading), at 86, before 17:24, at 99. Romans supplies no premise here. -/
theorem before_via_genesis : ∀ r c, ReckonedGk r → CircumcisedAt c → r < c := by
  intro r c hr hc
  obtain ⟨b, hb⟩ := gen16_15
  have h1 : r ≤ b := reckoned_before_ishmael r b ((same_reckoning r).mp hr) hb
  have h2 : b < c := ishmael_born_before_circumcision b c hb hc
  omega

/-- The routes agree (proof irrelevance). They are two witnesses because their receipts share no
premise: {rom4_10, uncircumcision_precedes} versus {same_reckoning, reckoned_before_ishmael,
gen16_15, gen16_16, gen17_24, aging_monotone}. -/
example : before_via_paul = before_via_genesis := rfl

/-! ## How long before -/

/-- On the Genesis route, Abram was at most 86 when it was reckoned. -/
theorem reckoned_by_86 : ∀ r n, ReckonedGk r → AgedAt r n → n ≤ 86 := by
  intro r n hr hn
  obtain ⟨b, hb⟩ := gen16_15
  exact aging_monotone r b n 86
    (reckoned_before_ishmael r b ((same_reckoning r).mp hr) hb) hn (gen16_16 b hb)

/-- At least 13 years of age separate the reckoning from the circumcision. Paul's argument needs
only "before"; this shows the Genesis numbers leave no room for doubt about the order. -/
theorem at_least_thirteen_years :
    ∀ r c n k, ReckonedGk r → CircumcisedAt c → AgedAt r n → AgedAt c k → n + 13 ≤ k := by
  intro r c n k hr hc hn hk
  have h1 : n ≤ 86 := reckoned_by_86 r n hr hn
  have h2 : 99 ≤ k := aging_monotone c c 99 k (Nat.le_refl c) (gen17_24 c hc) hk
  omega

/-- The two theorems above quantify over every instant of reckoning and of circumcision, so they
would hold trivially if either event never happened. They did, and in this order. -/
theorem both_events_in_order : ∃ r c, ReckonedGk r ∧ CircumcisedAt c ∧ r < c := by
  obtain ⟨r, hr⟩ := gen15_6
  obtain ⟨c, hc⟩ := gen17_26
  have hr' : ReckonedGk r := (same_reckoning r).mpr hr
  exact ⟨r, c, hr', hc, before_via_genesis r c hr' hc⟩

/-! ## Therefore circumcision is not the condition of the reckoning

4:9 asks whether the blessing comes "upon the circumcision [only]". The opponent's premise, applied
to Abraham himself, is that the reckoning required circumcision. Two forms of it are refuted.

What this DOES establish: in Abraham's own case circumcision was not a necessary condition of the
reckoning of Genesis 15:6, neither as his state at the time nor as an event already past. Any
general rule "only the circumcised are reckoned righteous" has Abraham as an instance, so it falls
with him.

What it does NOT establish:
* that circumcision is void or worthless: 4:11 calls it a sign and a seal, and Genesis 17 commands it;
* that faith is a sufficient condition, for Abraham or anyone: nothing here derives the reckoning
  from faith; 4:9 states that it was faith that was reckoned;
* anything about the law, which is the separate argument of 4:13–15;
* that Abraham is father of uncircumcised believers: that is 4:11's stated purpose, below, and its
  receipt shares nothing with the chronology. -/

/-- Paul's own form, from Romans alone, constructive: the reckoning did not require that Abraham be
"in circumcision" when it was made. -/
theorem circumcision_state_not_required : ¬∀ r, ReckonedGk r → InCircumcision r :=
  fun h => match rom4_9 with
    | ⟨r, hr⟩ => (rom4_10 r hr).1 (h r hr)

/-- Logic only, no premise of any text: if a reckoning happened and every reckoning came before
every circumcision, then it is false that each reckoning was preceded by a circumcision. -/
theorem not_prior_of (hex : ∃ r, ReckonedGk r)
    (hbefore : ∀ r c, ReckonedGk r → CircumcisedAt c → r < c) :
    ¬∀ r, ReckonedGk r → ∃ c, CircumcisedAt c ∧ c ≤ r := by
  intro h
  obtain ⟨r, hr⟩ := hex
  obtain ⟨c, hc, hle⟩ := h r hr
  have := hbefore r c hr hc
  omega

/-- The time form, "he was already circumcised when it was reckoned", refuted from Romans. -/
theorem circumcision_not_prior_via_paul : ¬∀ r, ReckonedGk r → ∃ c, CircumcisedAt c ∧ c ≤ r :=
  not_prior_of rom4_9 before_via_paul

/-- The same, refuted from Genesis. The receipts share no premise. -/
theorem circumcision_not_prior_via_genesis :
    ¬∀ r, ReckonedGk r → ∃ c, CircumcisedAt c ∧ c ≤ r :=
  not_prior_of (match gen15_6 with | ⟨r, hr⟩ => ⟨r, (same_reckoning r).mpr hr⟩) before_via_genesis

/-! ## Father of all who believe -/

/-- 4:11 as cited: Abraham is father of all who believe uncircumcised. The receipt is {rom4_11,
purpose_realized} and nothing else. Paul places this purpose right after the chronology, and the
chronology is what makes it fitting (their father was himself reckoned in uncircumcision), but
Lean confirms that the fatherhood is not deduced from the dates: it is stated, as God's purpose. -/
theorem father_of_uncircumcised_believers : ∀ p, BelievesUncircumcised p → FatherOf p :=
  purpose_realized rom4_11

end Romans4

/-! ## The receipts -/
#print axioms Romans4.before_via_paul
#print axioms Romans4.ishmael_born_before_circumcision
#print axioms Romans4.before_via_genesis
#print axioms Romans4.reckoned_by_86
#print axioms Romans4.at_least_thirteen_years
#print axioms Romans4.both_events_in_order
#print axioms Romans4.circumcision_state_not_required
#print axioms Romans4.not_prior_of
#print axioms Romans4.circumcision_not_prior_via_paul
#print axioms Romans4.circumcision_not_prior_via_genesis
#print axioms Romans4.father_of_uncircumcised_believers
