/-!
# Hebrews 4:6–9 with Psalm 95:7–11 — "There remaineth therefore a rest"

Psalm 95 ends with God's oath over the wilderness generation: "I sware in my wrath that they
should not enter into my rest" (95:11). Hebrews reads the Psalm's own date against it. Joshua led
the next generation into Canaan; long after, "in David", God still says "To day if ye will hear
his voice" (95:7). So the rest the Psalm offers cannot be what Joshua gave: "For if Jesus had
given them rest, then would he not afterward have spoken of another day. There remaineth
therefore a rest to the people of God" (4:8–9).

This is a temporal, counterfactual argument. What it shows:
* The core is modus tollens. 4:8 states the conditional; the later "To day" of 4:7 denies its
  consequent; so Joshua did not give the rest. The proof is constructive: no `Classical` axiom
  appears in any receipt, and the bare logical form `modus_tollens` depends on no axioms at all.
* The step needs one piece of history the text assumes but never states: Joshua came before
  David. It is a labeled reading.
* "Jesus" in the KJV of 4:8 is JOSHUA son of Nun. Greek Ἰησοῦς (lemma Ἰησοῦς, Strong's 2424) is
  one name for both men: the Septuagint column gives ἰησοῖ for יְהוֹשֻׁעַ at Joshua 1:1. MACULA
  glosses this Ἰησοῦς "Joshua" and the BSB prints "Joshua"; the KJV and the Vulgate print "Jesus".
  The same divergence recurs at Acts 7:45 (KJV "with Jesus", Vulgate "cum Jesu", BSB "with Joshua").
* "In David" is Hebrews' claim, not the Hebrew Psalm's: Hebrew Psalm 95 has no superscription.
  Two witnesses that God set the "To day" in David's time: Hebrews 4:7 states it; Psalm 95:7
  needs a labeled reading for the date, and the receipt shows it.
* Two witnesses that Joshua gave no rest: the modus tollens, and the grammar of 4:8 itself, a
  contrary-to-fact condition. Their receipts share no premise.
* Joshua 21:44 says "the LORD gave them rest round about", and its Septuagint column has
  κατέπαυσεν and αὐτοὺς, the very words of Hebrews 4:8. Reading that land-rest as the rest of
  Hebrews 4:8 contradicts the cited verses: Lean refutes it. Hebrews' rest is God's own, "my rest".
* The conclusion of 4:9 needs a labeled reading: the passage weighs three candidates for those
  who "must enter" (the first hearers, Israel under Joshua, the people of God) and eliminates two.

Versification, checked with `show.py`: Hebrew Psalm 95 has no title, so its verses match the
English one for one (95:1 is "O come, let us sing" in both). The Vulgate numbers it Psalm 94 and
divides it about half a verse later: "Hodie si vocem ejus audieritis" opens its 94:8 instead of
closing 94:7. The Vulgate's Joshua 21:44 is its 21:42.

Words for "rest" the translations blur: καταπαύω "give rest" (4:8), κατάπαυσις "rest" (4:5, from
מְנוּחָה in Psalm 95:11) and σαββατισμός "Sabbath-rest" (4:9) are three words. The KJV says "rest"
for all three; the Vulgate keeps the last apart (requiem, but sabbatismus); the BSB prints
"Sabbath rest" in 4:9.
-/

namespace Hebrews4

/-! ## Domain and terms -/

/-- @domain Times in Israel's history at which God acts or speaks. A bare type of moments, it asserts nothing at all. -/
axiom Era : Type

/-- @term HEB 4:8 [Ἰησοῦς] "Ἰησοῦς"
The days of Ἰησοῦς: here Joshua son of Nun, who brought Israel into Canaan, not Jesus of Nazareth.
MACULA's gloss and the BSB say "Joshua"; the KJV and the Vulgate transliterate, "Jesus". -/
axiom joshuaDays : Era

/-- @term HEB 4:7 [Δαυίδ] "ἐν Δαυεὶδ"
"in David": the time at which God spoke Psalm 95's "To day". -/
axiom davidDays : Era

/-- @term HEB 4:8 [μετά οὗτος] "μετὰ ταῦτα"
"after these things". `After a b`: time b comes later than time a. -/
axiom After : Era → Era → Prop

/-- @term HEB 4:8 [αὐτός Ἰησοῦς καταπαύω] "αὐτοὺς Ἰησοῦς κατέπαυσεν"
"Joshua had given them rest": καταπαύω, aorist. "Them" are the Israelites he led into Canaan.
The "rest" is the one the chapter is about, God's κατάπαυσις, "my rest" (4:5, quoting Ps 95:11). -/
axiom JoshuaGaveRest : Prop

/-- @term HEB 4:8 [περί ἄλλος λαλέω ἡμέρα] "περὶ ἄλλης ἐλάλει μετὰ ταῦτα ἡμέρας"
"he spoke about another day". `SpokeOfAnotherDay t`: God did so at time t. The subject is
unexpressed in the Greek ("he"); the BSB supplies "God". -/
axiom SpokeOfAnotherDay : Era → Prop

/-- @term HEB 4:7 [πάλιν τὶς ὁρίζω ἡμέρα σήμερον] "πάλιν τινὰ ὁρίζει ἡμέραν Σήμερον"
"again he appoints a certain day, To day" (KJV "limiteth", BSB "designated", Vulgate "terminat").
`SetsToday t`: God did so at time t. -/
axiom SetsToday : Era → Prop

/-- @term PSA 95:7 [יוֹם אִם קוֹל שָׁמַע] "הַיּוֹם אִם בְּקֹלוֹ תִשְׁמָעוּ"
"To day if ye will hear his voice": the Psalm's own call. הַיּוֹם is "the day", "today" (Septuagint
column σήμερον). The Hebrew attaches no author and no date to the call. -/
axiom PsalmToday : Prop

/-- @term PSA 95:11 [שָׁבַע אַף אִם] "נִשְׁבַּעְתִּי בְאַפִּי אִם"
"I swore in my anger: if …". `SworeIf P` is the Hebrew oath formula exactly as written, with
אִם, "if", and the curse left unsaid. It names the form of words and asserts nothing. -/
axiom SworeIf : Prop → Prop

/-- @term PSA 95:11 [בּוֹא מְנוּחָה] "יְבֹאוּן אֶל מְנוּחָתִי"
"they shall enter into my rest": מְנוּחָה, which the Septuagint column renders κατάπαυσις, the
word Hebrews quotes (4:3, 4:5). -/
axiom TheyEnterMyRest : Prop

/-- @term HEB 4:6 [ἀπολείπω τὶς εἰσέρχομαι] "ἀπολείπεται τινὰς εἰσελθεῖν εἰς αὐτήν"
"it remains for some to enter it". αὐτήν, feminine, points back to ἡ κατάπαυσις, "my rest" (4:5);
the BSB writes the referent out, "His rest". -/
axiom SomeMustEnter : Prop

/-- @term HEB 4:6 [πρότερος εὐαγγελίζω εἰσέρχομαι] "οἱ πρότερον εὐαγγελισθέντες"
"those who formerly received the good news" entered (εἰσέρχομαι): the wilderness generation. -/
axiom FirstHearersEntered : Prop

/-- @term HEB 4:9 [ἀπολείπω σαββατισμός λαός θεός] "ἀπολείπεται σαββατισμὸς τῷ λαῷ τοῦ Θεοῦ"
"There remaineth … a rest to the people of God". σαββατισμός, "Sabbath-rest" (Strong's 4520), is
rare: in the whole Greek New Testament corpus its lemma occurs in this one verse, and the corpus's
Septuagint column (Greek equivalents for the Hebrew books) never has it, only forms of the verb
σαββατίζω, "keep sabbath" (σαββατιεῖ, σαββατιεῖτε at Leviticus 23:32; 26:34; 26:35). -/
axiom SabbathRestRemains : Prop

/-- @term JOS 21:44 [נוּחַ יהוה סָבִיב] "וַיָּנַח יְהוָה לָהֶם מִסָּבִיב"
"And the LORD gave them rest round about": rest in the land, in Joshua's day. נוּחַ, hiphil. -/
axiom LandRestGiven : Prop

/-! ## Premises: what the texts state -/

/-- @cite HEB 4:6 [ἐπεί ἀπολείπω τὶς εἰσέρχομαι]
GRK:"ἐπεὶ οὖν ἀπολείπεται τινὰς εἰσελθεῖν εἰς αὐτήν"
KJV:"Seeing therefore it remaineth that some must enter therein"
BSB:"Since, then, it remains for some to enter His rest"
VUL:"Quoniam ergo superest introire quosdam in illam" -/
axiom heb4_6a : SomeMustEnter

/-- @cite HEB 4:6 [πρότερος εὐαγγελίζω οὐ εἰσέρχομαι ἀπείθεια]
GRK:"οἱ πρότερον εὐαγγελισθέντες οὐκ εἰσῆλθον δι’ἀπείθειαν"
KJV:"they to whom it was first preached entered not in because of unbelief"
BSB:"those who formerly heard the good news did not enter because of their disobedience"
VUL:"ii, quibus prioribus annuntiatum est, non introierunt propter incredulitatem"
ἀπείθεια is "disobedience" (MACULA's gloss and the BSB); the KJV and the Vulgate say "unbelief"
(incredulitatem), as they also do at 3:19 for a different Greek word, ἀπιστία. -/
axiom heb4_6b : ¬FirstHearersEntered

/-- @cite HEB 4:7 [πάλιν ὁρίζω ἡμέρα σήμερον Δαυίδ μετά τοσοῦτος χρόνος]
GRK:"πάλιν τινὰ ὁρίζει ἡμέραν Σήμερον ἐν Δαυεὶδ λέγων μετὰ τοσοῦτον χρόνον"
KJV:"Again, he limiteth a certain day, saying in David, To day, after so long a time"
BSB:"God again designated a certain day as “Today,” when a long time later He spoke through David"
VUL:"iterum terminat diem quemdam, Hodie, in David dicendo, post tantum temporis"
The verse goes on to quote Psalm 95:7–8, and every Greek word the Septuagint column shows for
those verses recurs in it (σήμερον, ἐὰν, τῆς φωνῆς, αὐτοῦ, ἀκούσητε, μὴ σκληρύνητε … καρδίας ὑμῶν),
so the quotation follows the Septuagint. That Greek renders the Hebrew
closely, with one difference: Hebrew לְבַבְכֶם is "your heart", singular (95:8, Ncmsc; KJV Psalm
"your heart"), where Hebrews has τὰς καρδίας, "hearts" (KJV Hebrews "your hearts"). -/
axiom heb4_7 : SetsToday davidDays

/-- @cite HEB 4:8 [εἰ Ἰησοῦς καταπαύω οὐ ἄν ἄλλος λαλέω μετά οὗτος ἡμέρα]
GRK:"εἰ γὰρ αὐτοὺς Ἰησοῦς κατέπαυσεν οὐκ ἂν περὶ ἄλλης ἐλάλει μετὰ ταῦτα ἡμέρας"
KJV:"For if Jesus had given them rest, then would he not afterward have spoken of another day."
BSB:"For if Joshua had given them rest, God would not have spoken later about another day."
VUL:"Nam si eis Jesus requiem præstitisset, numquam de alia loqueretur, posthac, die."
The Greek is a counterfactual ("if he had …, he would not have …"). Stated here as a plain
implication, which a counterfactual entails on the usual logic of counterfactuals, so the axiom
says less than the verse. "Afterward" (μετὰ ταῦτα) is read as "at any time after Joshua's". -/
axiom heb4_8 : JoshuaGaveRest → ¬∃ t, After joshuaDays t ∧ SpokeOfAnotherDay t

/-- @cite PSA 95:7 [יוֹם אִם קוֹל שָׁמַע]
HEB:"הַיּוֹם אִם בְּקֹלוֹ תִשְׁמָעוּ"
KJV:"To day if ye will hear his voice"
BSB:"Today, if you hear His voice"
VUL@PSA 94:8:"Hodie si vocem ejus audieritis" -/
axiom ps95_7 : PsalmToday

/-- @cite PSA 95:11 [שָׁבַע אַף אִם בּוֹא מְנוּחָה]
HEB:"נִשְׁבַּעְתִּי בְאַפִּי אִם יְבֹאוּן אֶל מְנוּחָתִי"
KJV:"Unto whom I sware in my wrath that they should not enter into my rest."
BSB:"They shall never enter My rest."
VUL@PSA 94:11:"ut juravi in ira mea: Si introibunt in requiem meam."
The axiom follows the Hebrew, which (like the Vulgate's "Si") says "if they shall enter"; the
KJV and BSB print the negative sense. Reading the "if" as "not" is a labeled step below. -/
axiom ps95_11 : SworeIf TheyEnterMyRest

/-- @cite JOS 21:44 [נוּחַ יהוה סָבִיב]
HEB:"וַיָּנַח יְהוָה לָהֶם מִסָּבִיב"
KJV:"And the LORD gave them rest round about"
BSB:"And the LORD gave them rest on every side"
VUL@JOS 21:42:"Dataque est ab eo pax in omnes per circuitum nationes"
The Vulgate turns "rest" into "pax", peace, and so loses the link Hebrews' Greek keeps: the
Septuagint column gives κατέπαυσεν for וַיָּנַח, the verb of Hebrews 4:8. -/
axiom jos21_44 : LandRestGiven

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Hebrews 4:7 says God set the day "in David" (ἐν Δαυεὶδ); the Hebrew Psalm does not. Hebrew Psalm
95 has no superscription: 95:1 begins לְכוּ נְרַנְּנָה, "O come, let us sing", as in English,
although the Hebrew Psalter does name authors when it means to (Psalm 90:1, תְּפִלָּה לְמֹשֶׁה,
"A Prayer of Moses"). The corpus's Septuagint data is a word-by-word column under the Hebrew,
so a Greek title with no Hebrew word beneath it cannot appear there, and none is checked here.
The Vulgate, whose Psalter was made from the Greek, heads this psalm "Laus cantici ipsi David."
(its Psalm 94:1); the KJV and BSB have no title. So the Davidic date rests on Hebrews 4:7 and the
Greek tradition. This reading also adds that the Psalm's call is God's own setting of a day: the
Psalm says "his voice" in the third person and turns to God's first person by 95:9 ("When your
fathers tempted me"); Hebrews hears the whole as God speaking (4:7) and as the Holy Spirit (3:7,
"as the Holy Ghost saith"). Alternative: ἐν Δαυεὶδ may mean "in the book of David", the Psalter
(BSB "through David"), rather than authorship; the argument needs only that the words came long
after Joshua. -/
axiom psalm_in_david : PsalmToday → SetsToday davidDays

/-- @interpretive
4:7 says God "again appoints a certain day" (πάλιν τινὰ ὁρίζει ἡμέραν); 4:8 speaks of his speaking
"about another day" (περὶ ἄλλης … ἡμέρας). These are different words, and the text never says in so
many words that they are the same day. The γάρ ("for") that opens 4:8 makes it explain 4:7, which
is why we read "another day" as pointing back to the "To day" of 4:7, and πάλιν ("again") is what
makes it another: a day other than the entry under Joshua. We add only this identification, and
only at David's time. -/
axiom again_is_another : SetsToday davidDays → SpokeOfAnotherDay davidDays

/-- @interpretive
4:7 says the "To day" came "after so long a time" (μετὰ τοσοῦτον χρόνον) but not after what, and
4:6–9 never says that Joshua lived before David. The argument needs exactly that ordering, so that
the "afterward" (μετὰ ταῦτα) of 4:8 reaches David's time. It is history the text assumes: in the
narrative of Joshua through 2 Samuel the conquest comes before the judges, Saul and David.
Scripture states the sequence elsewhere, in Stephen's speech: the tabernacle came in "with Jesus"
(μετὰ Ἰησοῦ, Joshua again) and stood "unto the days of David" (ἕως τῶν ἡμερῶν Δαυείδ, Acts 7:45);
that verse is noted, not used as a premise. The reading carries real weight: had Psalm 95 been
older than Joshua, as Psalm 90 is headed as Moses' prayer, the argument would fail. -/
axiom joshua_before_david : After joshuaDays davidDays

/-- @interpretive
4:8 is a contrary-to-fact condition: εἰ with an aorist indicative (κατέπαυσεν, V-AAI-3S), then ἄν
with an imperfect indicative (ἐλάλει, V-IAI-3S). Greek uses this form for a supposition the speaker
holds to be untrue, so the grammar alone presents "Joshua gave them rest" as false. The Vulgate
(præstitisset … loqueretur, subjunctives) and the KJV and BSB ("had given … would not … have
spoken") keep the unreal mood. This is the author's presupposition, not his argument: the modus
tollens below is the reason he gives for it. -/
axiom contrary_to_fact : ¬JoshuaGaveRest

/-- @interpretive
Psalm 95:11 ends its oath with "if they shall enter into my rest" (אִם יְבֹאוּן). In a Hebrew oath,
אִם with the curse left unsaid means "they surely shall not". The literal "if" survives in the
Septuagint column (εἰ), in the Vulgate (Si introibunt) and in Hebrews' own quotations (Εἰ
εἰσελεύσονται, 3:11; 4:3; 4:5), and the KJV keeps it at Hebrews 4:3 and 4:5 ("if they shall enter
into my rest"), while the KJV Psalm ("that they should not enter") and the BSB ("They shall never
enter") translate the sense. Hebrews gives that sense itself at 3:18: ὤμοσεν μὴ εἰσελεύσεσθαι,
"sware he that they should not enter". We also add that God's sworn word is kept, which the text
assumes throughout. -/
axiom oath_means_not : SworeIf TheyEnterMyRest → ¬TheyEnterMyRest

/-- @interpretive
The "they" of Psalm 95:11 are the generation of 95:10 ("Forty years long was I grieved with [this]
generation"); "those who formerly received the good news" (Hebrews 4:6) are, in Hebrews' own gloss,
those "whose carcases fell in the wilderness" (3:17). Identifying the two groups, and the Psalm's
"my rest" (מְנוּחָה) with the "it" of 4:6 (Hebrews' κατάπαυσις, the Septuagint column's word for
מְנוּחָה), is the reading Hebrews 3:16–4:6 makes. We state it only in the direction needed: if the
first hearers entered, then "they" entered "my rest". -/
axiom they_are_first_hearers : FirstHearersEntered → TheyEnterMyRest

/-- @interpretive
4:9 draws its conclusion with ἄρα, "so then", but does not state the rule behind it. The passage
weighs three candidates for the "some" who "must enter" (4:6): those who first heard (4:6, they did
not enter), Israel under Joshua (4:8, he did not give them rest), and "the people of God" now (4:9).
That these are the only candidates is our reading; the text has no "either … or". The reading also
identifies the σαββατισμός, "Sabbath-rest", of 4:9 with the κατάπαυσις, "rest", of 4:6 (αὐτήν) and
of Psalm 95:11 ("my rest"): different words. Hebrews prepares the switch at 4:4, where "God did
rest the seventh day" (κατέπαυσεν, the verb of 4:8), so the rest on offer is God's own Sabbath.
Note that 4:6 and 4:9 share the verb ἀπολείπεται, "remains": 4:9 restates 4:6, now naming who (the
people of God) and what (a Sabbath-rest), once 4:8 has ruled out the past. -/
axiom remains_reading : SomeMustEnter → FirstHearersEntered ∨ JoshuaGaveRest ∨ SabbathRestRemains

/-! ## The logical form -/

/-- Modus tollens, proved from nothing: if A rules out B, and B holds, then not A. Constructive:
`¬A` is `A → False`, so no excluded middle is needed, and the receipt is empty. -/
theorem modus_tollens {A B : Prop} (hab : A → ¬B) (hb : B) : ¬A :=
  fun ha => hab ha hb

/-! ## Two witnesses that God set the "To day" in David's time -/

/-- Witness 1, Hebrews' Greek: stated outright, no reading needed. -/
theorem today_via_hebrews : SetsToday davidDays := heb4_7

/-- Witness 2, the Psalm's Hebrew: the call is there, the date is not; the receipt shows the
borrowed reading. The receipts share no premise, {heb4_7} versus {ps95_7, psalm_in_david}, but the
weight is not equal: the Davidic date in route 2 comes from Hebrews 4:7 itself and the Greek
tradition. The pair shows exactly where the Hebrew is silent. -/
theorem today_via_psalm : SetsToday davidDays := psalm_in_david ps95_7

example : today_via_hebrews = today_via_psalm := rfl

/-! ## The argument: Joshua did not give the rest -/

/-- The heart of it, by modus tollens. 4:8: had Joshua given them rest, there would be no later
time at which God spoke of another day. But in David's time, after Joshua's, God did. -/
theorem joshua_gave_no_rest : ¬JoshuaGaveRest :=
  modus_tollens heb4_8 ⟨davidDays, joshua_before_david, again_is_another today_via_hebrews⟩

/-- Witness 2, the grammar of 4:8 alone. Its receipt, {contrary_to_fact}, shares no premise with the
argument's {heb4_8, heb4_7, again_is_another, joshua_before_david}. The text both presupposes its
conclusion (the mood) and argues for it (the modus tollens). -/
theorem joshua_gave_no_rest_by_grammar : ¬JoshuaGaveRest := contrary_to_fact

example : joshua_gave_no_rest = joshua_gave_no_rest_by_grammar := rfl

/-- The objection 4:8 answers, made explicit (Hebrews does not cite Joshua 21:44). Joshua 21:44 says
the land-rest was given, and its Septuagint column even has κατέπαυσεν and αὐτοὺς, Hebrews 4:8's
own words (MACULA aligns αὐτοὺς to יְהוָה and κύριος to the suffix הֶם, evidently swapped). Read that
land-rest as the rest of Hebrews 4:8 and the cited verses contradict each other: Lean refutes the
identification outright. The Hebrew sharpens the point, since Moses calls the land itself by Psalm
95:11's word מְנוּחָה (Deuteronomy 12:9, "ye are not as yet come to the rest"). The Psalm, spoken
long after the land was given, still warns of "my rest"; so, Hebrews argues, the land was not it. -/
theorem land_rest_not_the_rest : ¬(LandRestGiven → JoshuaGaveRest) :=
  fun same => joshua_gave_no_rest (same jos21_44)

/-! ## Two witnesses that the first hearers did not enter -/

/-- Witness 1, Hebrews 4:6: stated outright. -/
theorem first_hearers_out_via_hebrews : ¬FirstHearersEntered := heb4_6b

/-- Witness 2, Psalm 95:11: God's oath, with the oath idiom and the identity of "they" as labeled
readings. Receipts: {heb4_6b} versus {ps95_11, oath_means_not, they_are_first_hearers}. -/
theorem first_hearers_out_via_psalm : ¬FirstHearersEntered :=
  fun entered => oath_means_not ps95_11 (they_are_first_hearers entered)

/-! ## The conclusion: a rest remains -/

/-- 4:9, "There remaineth therefore a rest to the people of God". Of the three candidates the
reading names, the first two are eliminated by the cited 4:6 and by the argument of 4:8, leaving
the third. Disjunctive syllogism is constructive, so this receipt has no `Classical` axiom either. -/
theorem a_rest_remains : SabbathRestRemains :=
  match remains_reading heb4_6a with
  | Or.inl entered => absurd entered heb4_6b
  | Or.inr (Or.inl gave) => absurd gave joshua_gave_no_rest
  | Or.inr (Or.inr remains) => remains

end Hebrews4

/-! ## The receipts -/
#print axioms Hebrews4.modus_tollens
#print axioms Hebrews4.today_via_hebrews
#print axioms Hebrews4.today_via_psalm
#print axioms Hebrews4.joshua_gave_no_rest
#print axioms Hebrews4.joshua_gave_no_rest_by_grammar
#print axioms Hebrews4.land_rest_not_the_rest
#print axioms Hebrews4.first_hearers_out_via_hebrews
#print axioms Hebrews4.first_hearers_out_via_psalm
#print axioms Hebrews4.a_rest_remains
