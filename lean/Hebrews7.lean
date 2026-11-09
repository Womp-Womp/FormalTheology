/-!
# Hebrews 7:1–10 — "The less is blessed of the better"

The writer sets Melchizedek above Abraham, and so above Levi, from two acts in Genesis 14:18–20:
Melchizedek blessed Abram, and a tenth of the spoils changed hands. "And without all contradiction
the less is blessed of the better" (7:7). "And as I may so say, Levi also, who receiveth tithes,
payed tithes in Abraham. For he was yet in the loins of his father, when Melchisedec met him"
(7:9–10).

What it shows:
* Two independent routes to "Abraham gave Melchizedek a tenth". Hebrews 7:4 says it. Genesis 14:20
  in Hebrew says only "and he gave him a tenth of all", naming neither man, so that route needs a
  labeled reading of the pronouns, plus Genesis 17:5 to join Abram to Abraham.
* The same for "Melchizedek blessed Abraham": Hebrews 7:1 names him; Genesis 14:19 has only "he".
* Two independent routes to "Melchizedek is better than Abraham". By blessing (7:6–7) the route is
  fully cited, because 7:7 states a universal. By tithe (7:4) it needs a reading: 7:4 says "how
  great", not "greater than", and states no rule.
* Levi. The writer hedges his own claim (ὡς ἔπος εἰπεῖν, "as I may so say"), so "better than Levi"
  rests on a labeled corporate-representation reading, and the receipt says so.
* Two refutations. "Abraham is better than Melchizedek" contradicts the cited verses plus one
  reading (asymmetry). "Levi is better than Melchizedek" contradicts them only with the
  representation and tithe readings as well. The receipts show the difference.

Not formalized: 7:3 (without father, without mother), 7:8 (dying men receive tithes, but he lives),
and Psalm 110:4, which Hebrews brings in at 7:11–17, not in 7:1–10.
-/

namespace Hebrews7

/-! ## Domain and terms -/

/-- @domain The persons this passage speaks about. A bare type of individuals, it asserts nothing at all. -/
axiom Person : Type

/-- @term GEN 14:18 [מַלְכִּיצֶדֶק] "מַלְכִּי־צֶ֨דֶק֙"
Melchizedek, "king of Salem" and "priest of God Most High". Hebrews 7:1 gives the same name in the
Septuagint's spelling (Μελχισέδεκ) with the same two titles, so it names this man. -/
axiom melchizedek : Person

/-- @term GEN 14:19 [אַבְרָם] "אַבְרָם֙"
Abram, his name in Genesis 14 (Septuagint αβραμ), before Genesis 17:5 renamed him. -/
axiom abram : Person

/-- @term GEN 17:5 [אַבְרָהָם] "אַבְרָהָ֔ם"
Abraham (Septuagint αβρααμ), the name Hebrews uses: Ἀβραάμ. -/
axiom abraham : Person

/-- @term HEB 7:9 [Λευί] "Λευεὶς"
Levi, Abraham's great-grandson, whose sons hold the priesthood (7:5). In 7:9 he stands for the
tithe-receiving tribe ("who receiveth tithes"); in 7:10 he is the man not yet born. -/
axiom levi : Person

/-- @term GEN 14:19 [בָּרַךְ] "וַֽיְבָרְכֵ֖הוּ"
The unnamed "he" of "and he blessed him". The Hebrew verb carries its subject; this verse gives
no name for it. -/
axiom he19 : Person

/-- @term GEN 14:20 [נָתַן] "וַיִּתֶּן"
The unnamed "he" of "and he gave". -/
axiom he20 : Person

/-- @term GEN 14:20 [לְ הוּא] "ל֥וֹ"
The unnamed "him" of "to him". -/
axiom him20 : Person

/-- @term HEB 7:1 [εὐλογέω αὐτός] "εὐλογήσας αὐτόν"
`Blessed x y`: x conferred a blessing on y, as a priest blesses (εὐλογέω). Genesis uses בָּרַךְ,
which the word table's LXX column renders by the same verb (εὐλογημένος for בָּרוּךְ, 14:19).
Only this sense is named. In 14:20 Melchizedek also says "blessed be God Most High" with the same
root, but that is praise given upward, not a blessing conferred, and it is not modeled here. -/
axiom Blessed : Person → Person → Prop

/-- @term HEB 7:4 [δέκατος δίδωμι] "δεκάτην Ἀβραὰμ ἔδωκεν"
`GaveTenth x y`: x gave a tenth to y. The word table's LXX column renders Genesis 14:20's
וַיִּתֶּן and מַעֲשֵׂר by ἔδωκεν and δεκάτην, the very words of Hebrews 7:4, so one relation names
the act in both books. -/
axiom GaveTenth : Person → Person → Prop

/-- @term HEB 7:7 [κρείττων ἐλάσσων] "τὸ ἔλαττον ὑπὸ τοῦ κρείττονος"
`Better x y`: x is the better (κρείττων), y the lesser (ἐλάσσων). The verse pairs the two
comparatives; this is one relation, read from either end. -/
axiom Better : Person → Person → Prop

/-- @term HEB 7:9 [διά δεκατόω] "δι’Ἀβραὰμ καὶ Λευεὶς ὁ δεκάτας λαμβάνων δεδεκάτωται"
`TithedThrough x y`: through y (διά), x "has been tithed" (δεδεκάτωται, perfect passive of
δεκατόω, the verb 7:6 uses actively of Melchizedek: δεδεκάτωκεν Ἀβραάμ, "has tithed Abraham").
The verse names no recipient. -/
axiom TithedThrough : Person → Person → Prop

/-- @term HEB 7:10 [ὀσφῦς πατήρ συναντάω] "ἐν τῇ ὀσφύϊ τοῦ πατρὸς ἦν ὅτε συνήντησεν αὐτῷ Μελχισέδεκ"
`InLoinsWhenMet x y`: x was still in the loin of his father y when Melchizedek met y. -/
axiom InLoinsWhenMet : Person → Person → Prop

/-! ## Premises: what the texts state -/

/-- @cite GEN 14:19 [בָּרַךְ אָמַר אַבְרָם]
HEB:"וַֽיְבָרְכֵ֖הוּ וַיֹּאמַ֑ר בָּר֤וּךְ אַבְרָם֙"
KJV:"And he blessed him, and said, Blessed [be] Abram"
BSB:"and he blessed Abram and said"
VUL:"benedixit ei, et ait: Benedictus Abram"
The one blessed is named by the blessing itself ("Blessed be Abram"); the one blessing is only
"he". The Vulgate runs 14:18–19 into one sentence with Melchisedech as the subject of benedixit;
the Hebrew starts a new clause. -/
axiom gen14_19 : Blessed he19 abram

/-- @cite GEN 14:20 [נָתַן לְ הוּא מַעֲשֵׂר מִן כֹּל]
HEB:"וַיִּתֶּן־ל֥וֹ מַעֲשֵׂ֖ר מִכֹּֽל"
KJV:"And he gave him tithes of all."
BSB:"Then Abram gave Melchizedek a tenth of everything."
VUL:"Et dedit ei decimas ex omnibus."
The layers DIVERGE. The Hebrew, the KJV and the Vulgate name neither man, and the Septuagint's
words in the word table (ἔδωκεν, αὐτῷ, δεκάτην, ἀπὸ, πάντων) keep the pronoun too. The BSB writes
both names in, which is the Hebrews 7:4 reading carried back into Genesis. The axiom follows the
Hebrew and says only "he gave him". Hebrews 7:2's δεκάτην ἀπὸ πάντων is the Septuagint's wording. -/
axiom gen14_20 : GaveTenth he20 him20

/-- @cite GEN 17:5 [שֵׁם אַבְרָם הָיָה אַבְרָהָם]
HEB:"וְלֹא־יִקָּרֵ֥א ע֛וֹד אֶת־שִׁמְךָ֖ אַבְרָ֑ם וְהָיָ֤ה שִׁמְךָ֙ אַבְרָהָ֔ם"
KJV:"Neither shall thy name any more be called Abram, but thy name shall be Abraham"
BSB:"No longer will you be called Abram, but your name will be Abraham"
VUL:"Nec ultra vocabitur nomen tuum Abram, sed appellaberis Abraham"
One man, two names: the verse renames the man it addresses; it does not introduce a second person. -/
axiom gen17_5 : abram = abraham

/-- @cite HEB 7:1 [Μελχισέδεκ συναντάω Ἀβραάμ εὐλογέω αὐτός]
GRK:"Οὗτος γὰρ ὁ Μελχισέδεκ"
GRK:"ὁ συναντήσας Ἀβραὰμ ὑποστρέφοντι ἀπὸ τῆς κοπῆς τῶν βασιλέων καὶ εὐλογήσας αὐτόν"
KJV:"For this Melchisedec"
KJV:"who met Abraham returning from the slaughter of the kings, and blessed him"
BSB:"This Melchizedek"
BSB:"He met Abraham returning from the slaughter of the kings and blessed him"
VUL:"Hic enim Melchisedech"
VUL:"qui obviavit Abrahæ regresso a cæde regum, et benedixit ei"
One Greek sentence. Its αὐτόν ("him") has one possible antecedent, Ἀβραὰμ, so this is grammar, not
a reading. Verse 7:6 repeats the blessing in the perfect (εὐλόγηκεν, "has blessed"), and 7:7
draws the principle from it. -/
axiom heb7_1 : Blessed melchizedek abraham

/-- @cite HEB 7:4 [πηλίκος οὗτος ὅς δέκατος Ἀβραάμ δίδωμι πατριάρχης]
GRK:"Θεωρεῖτε δὲ πηλίκος οὗτος ᾧ δεκάτην Ἀβραὰμ ἔδωκεν ἐκ τῶν ἀκροθινίων ὁ πατριάρχης"
KJV:"Now consider how great this man [was], unto whom even the patriarch Abraham gave the tenth of the spoils."
BSB:"Consider how great Melchizedek was: Even the patriarch Abraham gave him a tenth of the plunder."
VUL:"Intuemini autem quantus sit hic, cui et decimas dedit de præcipuis Abraham patriarcha."
"This one" (οὗτος) is the Melchizedek of 7:1; the BSB supplies his name. The Nestle 1904 Greek has
no "even" here, while the KJV ("even"), the BSB ("Even") and the Vulgate (et) all carry one.
Either way it is emphasis, not a premise. Genesis says "of all"; Hebrews 7:4 says "of the best
spoils" (ἀκροθίνια), while 7:2 keeps "of all". -/
axiom heb7_4 : GaveTenth abraham melchizedek

/-- @cite HEB 7:7 [χωρίς πᾶς ἀντιλογία ἐλάσσων ὑπό κρείττων εὐλογέω]
GRK:"χωρὶς δὲ πάσης ἀντιλογίας τὸ ἔλαττον ὑπὸ τοῦ κρείττονος εὐλογεῖται"
KJV:"And without all contradiction the less is blessed of the better."
BSB:"And indisputably, the lesser is blessed by the greater."
VUL:"Sine ulla autem contradictione, quod minus est, a meliore benedicitur."
A general maxim: the neuter τὸ ἔλαττον (Vulgate quod minus est) is "whatever is lesser", in the
present tense. The axiom takes it in the one direction the argument uses: whoever blesses is the
better of the two. Its converse, that the better always blesses the lesser, is not claimed. -/
axiom heb7_7 : ∀ x y : Person, Blessed x y → Better x y

/-- @cite HEB 7:9 [ὡς ἔπος λέγω διά Ἀβραάμ Λευί δεκατόω]
GRK:"καὶ ὡς ἔπος εἰπεῖν,δι’Ἀβραὰμ καὶ Λευεὶς ὁ δεκάτας λαμβάνων δεδεκάτωται"
KJV:"And as I may so say, Levi also, who receiveth tithes, payed tithes in Abraham."
BSB:"And so to speak, Levi, who collects the tenth, paid the tenth through Abraham."
VUL:"Et (ut ita dictum sit) per Abraham, et Levi, qui decimas accepit, decimatus est"
The hedge is quoted with the claim, so the figure stays visible in the premise. Translation notes:
διά is "through" (BSB through, Vulgate per), and the KJV says "in Abraham". The present participle
λαμβάνων, "receiving", is the KJV's "receiveth"; the Vulgate has the perfect accepit, "received". -/
axiom heb7_9 : TithedThrough levi abraham

/-- @cite HEB 7:10 [ἔτι ὀσφῦς πατήρ εἰμί ὅτε συναντάω Μελχισέδεκ]
GRK:"ἔτι γὰρ ἐν τῇ ὀσφύϊ τοῦ πατρὸς ἦν ὅτε συνήντησεν αὐτῷ Μελχισέδεκ"
GRK@HEB 7:9:"δι’Ἀβραὰμ καὶ Λευεὶς"
KJV:"For he was yet in the loins of his father, when Melchisedec met him."
BSB:"For when Melchizedek met Abraham, Levi was still in the loin of his ancestor."
VUL:"adhuc enim in lumbis patris erat, quando obviavit ei Melchisedech."
This verse names only Melchizedek. Its "he", "the father" and "him" find their antecedents in the
same Greek sentence (γάρ runs on from 7:9; the verse break is not the author's), quoted above from
7:9: Levi and Abraham. The BSB writes both names in; the KJV and the Vulgate keep the pronouns. The
Greek τοῦ πατρός has no "his", and πατήρ here means forefather: Abraham was Levi's
great-grandfather, and the BSB says "ancestor". -/
axiom heb7_10 : InLoinsWhenMet levi abraham

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Genesis 14:19 says only "and he blessed him"; the verb names no subject. The last-named actor is
Melchizedek, who in 14:18 "brought forth bread and wine" and is "the priest of the most high God";
Abram is not a subject in 14:18 at all. Reading this "he" as Melchizedek is uncontested, the
Vulgate's syntax builds it in, and Hebrews 7:1 says it outright. But the Hebrew verse does not name
him, so the step is labeled. -/
axiom gen14_19_subject : he19 = melchizedek

/-- @interpretive
Genesis 14:20 says "and he gave him a tenth of all" and names neither man. Grammar alone leans
the other way: since 14:18 the chain of verbs has had Melchizedek as subject (he brought out, he
blessed, he said), so a mechanical reading makes Melchizedek the giver, and some interpreters read
it so. The reading taken here, that Abram gave and Melchizedek received, rests on context. Abram
holds the recovered goods ("all the goods", 14:16) and goes on to refuse the king of Sodom's
share (14:22–23). It also rests on Hebrews, which says "Abraham gave" (7:4) and "apportioned" (7:2).
The BSB prints this reading into Genesis; the Hebrew, the KJV and the Vulgate leave it open. -/
axiom gen14_20_pronouns : he20 = abram ∧ him20 = melchizedek

/-- @interpretive
Hebrews 7:4 says "consider how great (πηλίκος) this man was, unto whom even the patriarch Abraham
gave the tenth". That infers greatness from a tithe received, but πηλίκος means "how great", not
"greater than", and no rule is stated. This reading supplies the comparison, and only for tithes
paid to Melchizedek. A general rule, "whoever receives a tithe is better than the one who pays it",
would clash with 7:5: the Levites take tithes from their own brethren by the law's commandment,
"though they come out of the loins of Abraham", that is, from equals. What sets Melchizedek's tithe
apart is that it came by no law and from a man outside his genealogy (7:6). Alternative: the tithe
only displays his greatness, and the comparison proper is made by the blessing in 7:7; on that
view this route is weaker than the blessing route. -/
axiom tithe_shows_greater : ∀ x : Person, GaveTenth x melchizedek → Better melchizedek x

/-- @interpretive
The corporate-representation reading. Hebrews 7:9 says Levi "payed tithes in Abraham" and hedges it
in the same breath: ὡς ἔπος εἰπεῖν, "as I may so say" (Vulgate "ut ita dictum sit", BSB "so to
speak"). Levi was not yet born. Verse 7:10 gives the ground: "he was yet in the loins of his father,
when Melchisedec met him", and 7:1–2 place Abraham's tithe at that meeting. The reading gives the
figure the weight the argument needs. A descendant tithed through an ancestor, while still in that
ancestor's loin, counts as having paid the ancestor's tithe to Melchizedek. Verse 7:9 names no
recipient; the recipient is taken from Abraham's tithe. Alternatives: the hedge may mark a manner of
speaking with no logical weight, which would make the Levi conclusion rhetoric rather than proof; or
it may point to a real seminal or federal headship (the verse is used in debates over how humanity
was "in Adam"). -/
axiom represented_in_abraham :
  ∀ x y : Person, TithedThrough x y → InLoinsWhenMet x y →
    GaveTenth y melchizedek → GaveTenth x melchizedek

/-- @interpretive
κρείττων and ἐλάσσων are comparatives, "better" and "lesser"; a ranking that ran both ways between
the same two persons would rank nothing. The text never says so. "Without all contradiction"
(χωρὶς πάσης ἀντιλογίας) means "beyond dispute", not "the ordering is asymmetric", so the step is
labeled. Only asymmetry is assumed. No theorem needs transitivity, so it is not assumed;
irreflexivity follows from asymmetry. If "better" is relative to a role (greater as priest), the
asymmetry holds within that one sense. -/
axiom better_asymm : ∀ x y : Person, Better x y → ¬Better y x

/-! ## Two witnesses that Abraham gave Melchizedek a tenth -/

/-- Witness 1, Hebrews 7:4: stated outright, no reading needed. -/
theorem tithe_via_hebrews : GaveTenth abraham melchizedek := heb7_4

/-- Witness 2, Genesis 14:20: needs the pronoun reading, and Genesis 17:5 to join Abram to
Abraham. The receipt shows both. -/
theorem tithe_via_genesis : GaveTenth abraham melchizedek := by
  have h := gen14_20
  rw [gen14_20_pronouns.1, gen14_20_pronouns.2, gen17_5] at h
  exact h

/-- The routes agree (proof irrelevance). They count as two witnesses because their receipts share
no premise: {heb7_4} versus {gen14_20, gen14_20_pronouns, gen17_5}. -/
example : tithe_via_hebrews = tithe_via_genesis := rfl

/-! ## Two witnesses that Melchizedek blessed Abraham -/

/-- Witness 1, Hebrews 7:1: stated outright. -/
theorem blessing_via_hebrews : Blessed melchizedek abraham := heb7_1

/-- Witness 2, Genesis 14:19: needs the (uncontested) subject reading, and Genesis 17:5. -/
theorem blessing_via_genesis : Blessed melchizedek abraham := by
  have h := gen14_19
  rw [gen14_19_subject, gen17_5] at h
  exact h

/-! ## The argument: Melchizedek is better than Abraham, by two routes -/

/-- By blessing (7:6–7). Every premise is cited: 7:1 says he blessed Abraham, and 7:7 states the
universal. No reading is needed. -/
theorem better_than_abraham_by_blessing : Better melchizedek abraham :=
  heb7_7 melchizedek abraham heb7_1

/-- By tithe (7:4). One reading is needed, because 7:4 says "how great", not "greater than". The
receipt, {heb7_4, tithe_shows_greater}, shares nothing with the blessing route's
{heb7_1, heb7_7}. -/
theorem better_than_abraham_by_tithe : Better melchizedek abraham :=
  tithe_shows_greater abraham heb7_4

/-! ## The argument: and better than Levi, "as I may so say" -/

/-- Levi, "who receiveth tithes", paid tithes to Melchizedek in Abraham (7:9–10). The cited
figure, its cited ground, and the labeled representation reading. -/
theorem levi_paid_in_abraham : GaveTenth levi melchizedek :=
  represented_in_abraham levi abraham heb7_9 heb7_10 heb7_4

/-- Melchizedek is better than Levi. The text implies this and does not state it; 7:11 builds on it.
It rests on two readings: the representation and the tithe comparison. -/
theorem better_than_levi : Better melchizedek levi :=
  tithe_shows_greater levi levi_paid_in_abraham

/-! ## Refutations -/

/-- "Abraham is better than Melchizedek" contradicts Hebrews 7:1 and 7:7, given only that
"better" cannot run both ways. -/
theorem abraham_greater_refuted : ¬Better abraham melchizedek :=
  better_asymm melchizedek abraham better_than_abraham_by_blessing

/-- "Levi is better than Melchizedek" contradicts the texts too, but only through the hedged figure:
the receipt carries represented_in_abraham and tithe_shows_greater as well as asymmetry. -/
theorem levi_greater_refuted : ¬Better levi melchizedek :=
  better_asymm melchizedek levi better_than_levi

end Hebrews7

/-! ## The receipts -/
#print axioms Hebrews7.tithe_via_hebrews
#print axioms Hebrews7.tithe_via_genesis
#print axioms Hebrews7.blessing_via_hebrews
#print axioms Hebrews7.blessing_via_genesis
#print axioms Hebrews7.better_than_abraham_by_blessing
#print axioms Hebrews7.better_than_abraham_by_tithe
#print axioms Hebrews7.levi_paid_in_abraham
#print axioms Hebrews7.better_than_levi
#print axioms Hebrews7.abraham_greater_refuted
#print axioms Hebrews7.levi_greater_refuted
