/-!
# Mark 3:22–27 — "How can Satan cast out Satan?"

The scribes from Jerusalem say two things (3:22): "He has Beelzebul," and "by the prince of the
demons he casts out the demons." Jesus answers the second "in parables" (ἐν παραβολαῖς, 3:23): a
kingdom divided against itself cannot stand (3:24), nor a house (3:25), and if Satan has risen up
against himself and been divided, he cannot stand but has an end (3:26). Then the strong man: no
one plunders his goods unless he first binds him (3:27).

This is a REDUCTIO. The scribes' charge is never asserted here. It is a named phrase of 3:22 that
enters each theorem only as a hypothesis (`charge`).

What it shows:
* Grant the charge, and two labeled readings with 3:26 give: Satan cannot stand but has an end
  (`charge_ends_satan`). Add the labeled reading that Satan still stands, and the charge is
  refuted (`charge_refuted`). Constructive throughout.
* The step everything rests on, "casting out demons by their prince is Satan divided against
  himself", is NOT stated in Mark. 3:23 is a question. It names the middle term ("Satan cast out
  Satan") but asserts no conditional. Matthew 12:26 states the step; Mark leaves it to the
  juxtaposition of 3:23 with 3:26. So here it is two readings, and the receipts show both.
* 3:26 is the parables applied to Satan, stated outright. The parables alone (3:24, 3:25) reach
  Satan only by analogy, one labeled reading each: three witnesses that share no premise. Only 3:26
  adds "but has an end" (τέλος ἔχει).
* 3:27 gives the other explanation. Whoever casts out demons has not failed to bind the strong man
  (constructive); "has bound him" needs excluded middle, and Lean shows it.
* A reductio proves nothing if its background is already inconsistent. A two-figure world in which
  every premise and reading of this file holds, Satan still stands, and the exorcist has bound him
  shows that the contradiction belongs to the charge alone.

Not formalized: the first clause, "He has Beelzebul" (Βεελζεβοὺλ ἔχει). This argument does not
answer it; Mark answers it at 3:28–30 ("Because they said, He hath an unclean spirit," 3:30).
-/

namespace Mark3

/-! ## Domain and terms -/

/-- @domain Whatever the parables say can be divided and can stand or fall: a kingdom, a house,
Satan, the strong man, and whoever enters his house. A bare type, it asserts nothing at all. -/
axiom Entity : Type

/-- @term MRK 3:26 [Σατανᾶς] "ὁ Σατανᾶς"
Satan, named by Jesus (3:23, 3:26). The scribes never use the name. Their words are Βεελζεβούλ
and "the prince of the demons" (3:22). -/
axiom satan : Entity

/-- @term MRK 3:22 [ἐν ἄρχων δαιμόνιον ἐκβάλλω] "ἐν τῷ ἄρχοντι τῶν δαιμονίων ἐκβάλλει τὰ δαιμόνια"
THE CHARGE: "by the prince of the demons he casts out the demons." Only a name for what the scribes
said. Nothing in this file asserts it; it enters the theorems as a hypothesis. -/
axiom ByPrince : Entity → Prop

/-- @term MRK 3:22 [ἐκβάλλω δαιμόνιον] "ἐκβάλλει τὰ δαιμόνια"
"he casts out the demons": the fact the scribes concede. They dispute only the power behind it. -/
axiom CastsOutDemons : Entity → Prop

/-- @term MRK 3:23 [Σατανᾶς ἐκβάλλω] "Σατανᾶς Σατανᾶν ἐκβάλλειν"
"Satan casting out Satan": the middle term of Jesus' question "How can Satan cast out Satan?" -/
axiom SatanCastsOutSatan : Prop

/-- @term MRK 3:24 [βασιλεία] "βασιλεία"
"a kingdom". -/
axiom Kingdom : Entity → Prop

/-- @term MRK 3:25 [οἰκία] "οἰκία"
"a house" (also: a household). -/
axiom House : Entity → Prop

/-- @term MRK 3:24 [ἐπί ἑαυτοῦ μερίζω] "ἐφ’ἑαυτὴν μερισθῇ"
"divided against itself": μερίζω with ἐπί ἑαυτήν. 3:25 repeats the phrase word for word. -/
axiom DividedAgainstItself : Entity → Prop

/-- @term MRK 3:26 [ἵστημι] "στῆναι"
"to stand": ἵστημι. 3:24 has the passive form σταθῆναι of the same verb, 3:25 and 3:26 have στῆναι,
and every layer renders all three "stand" (stare). The verses say οὐ δύναται στῆναι, "is NOT ABLE
to stand". Writing that as ¬Stand drops the "able": what cannot stand does not stand, so each
premise says less than its verse, never more. -/
axiom Stand : Entity → Prop

/-- @term MRK 3:26 [ἀνίστημι ἐπί ἑαυτοῦ] "ἀνέστη ἐφ’ἑαυτὸν"
"has risen up against himself". -/
axiom RoseAgainstHimself : Entity → Prop

/-- @term MRK 3:26 [μερίζω] "ἐμερίσθη"
"has been divided": the verb of 3:24–25, but here without its own ἐφ’ἑαυτόν, which in 3:26 goes
with ἀνέστη. Kept apart from `DividedAgainstItself`. -/
axiom Divided : Entity → Prop

/-- @term MRK 3:26 [τέλος ἔχω] "τέλος ἔχει"
"has an end". -/
axiom HasEnd : Entity → Prop

/-- @term MRK 3:27 [ἰσχυρός] "τὸν ἰσχυρὸν"
"the strong man". Earlier, John the Baptist used the comparative of the same word for the one
coming after him: ὁ ἰσχυρότερός μου, "the one stronger than I" (1:7). -/
axiom StrongMan : Entity → Prop

/-- @term MRK 3:27 [εἰς οἰκία ἰσχυρός εἰσέρχομαι σκεῦος διαρπάζω] "εἰς τὴν οἰκίαν τοῦ ἰσχυροῦ εἰσελθὼν τὰ σκεύη αὐτοῦ διαρπάσαι"
`PlundersGoods x s`: x, having entered the house of the strong man s, plunders his goods. -/
axiom PlundersGoods : Entity → Entity → Prop

/-- @term MRK 3:27 [ἰσχυρός δέω] "τὸν ἰσχυρὸν δήσῃ"
`Binds x s`: x binds the strong man s. -/
axiom Binds : Entity → Entity → Prop

/-! ## Premises: what the verses state -/

/-- @cite MRK 3:24 [ἐάν βασιλεία ἐπί ἑαυτοῦ μερίζω οὐ δύναμαι ἵστημι ἐκεῖνος]
GRK:"ἐὰν βασιλεία ἐφ’ἑαυτὴν μερισθῇ,οὐ δύναται σταθῆναι ἡ βασιλεία ἐκείνη"
KJV:"And if a kingdom be divided against itself, that kingdom cannot stand."
BSB:"If a kingdom is divided against itself, it cannot stand."
VUL:"Et si regnum in se dividatur, non potest regnum illud stare." -/
axiom mrk3_24 : ∀ k : Entity, Kingdom k → DividedAgainstItself k → ¬Stand k

/-- @cite MRK 3:25 [ἐάν οἰκία ἐπί ἑαυτοῦ μερίζω οὐ δύναμαι ἵστημι ἐκεῖνος]
GRK:"ἐὰν οἰκία ἐφ’ἑαυτὴν μερισθῇ,οὐ δυνήσεται ἡ οἰκία ἐκείνη στῆναι"
KJV:"And if a house be divided against itself, that house cannot stand."
BSB:"If a house is divided against itself, it cannot stand."
VUL:"Et si domus super semetipsam dispertiatur, non potest domus illa stare."
The Greek repeats 3:24's ἐφ’ἑαυτὴν μερισθῇ exactly; the Vulgate varies it (in se dividatur, then
super semetipsam dispertiatur). The tenses move too. Greek: δύναται (3:24, present), δυνήσεται
(3:25, future), δύναται (3:26, present). Vulgate: potest, potest, poterit, so the future has moved
from 3:25 to 3:26. KJV and BSB say "cannot" throughout. The formalization is tenseless. -/
axiom mrk3_25 : ∀ h : Entity, House h → DividedAgainstItself h → ¬Stand h

/-- @cite MRK 3:26 [εἰ Σατανᾶς ἀνίστημι ἐπί ἑαυτοῦ μερίζω οὐ δύναμαι ἵστημι ἀλλά τέλος ἔχω]
GRK:"εἰ ὁ Σατανᾶς ἀνέστη ἐφ’ἑαυτὸν καὶ ἐμερίσθη,οὐ δύναται στῆναι ἀλλὰ τέλος ἔχει"
KJV:"And if Satan rise up against himself, and be divided, he cannot stand, but hath an end."
BSB:"And if Satan is divided and rises against himself, he cannot stand; his end has come."
VUL:"Et si Satanas consurrexerit in semetipsum, dispertitus est, et non poterit stare, sed finem habet."
The Greek condition has two verbs joined by καί, so the premise needs both (KJV and BSB agree; BSB
reverses their order). The Vulgate puts "dispertitus est" outside the condition: "if Satan has risen
against himself, he IS divided". That is a stronger premise, one condition instead of two; the
Greek is followed. BSB "his end has come" sounds like an announcement. The Greek τέλος ἔχει, "has
an end" (KJV "hath an end", Vulgate "finem habet"), is the second half of a conditional. -/
axiom mrk3_26 : RoseAgainstHimself satan ∧ Divided satan → ¬Stand satan ∧ HasEnd satan

/-- @cite MRK 3:27 [οὐ δύναμαι οὐδείς εἰς οἰκία ἰσχυρός εἰσέρχομαι σκεῦος διαρπάζω ἐάν μή πρῶτος δέω]
GRK:"οὐ δύναται οὐδεὶς εἰς τὴν οἰκίαν τοῦ ἰσχυροῦ εἰσελθὼν τὰ σκεύη αὐτοῦ διαρπάσαι,ἐὰν μὴ πρῶτον τὸν ἰσχυρὸν δήσῃ"
KJV:"No man can enter into a strong man’s house, and spoil his goods, except he will first bind the strong man"
BSB:"no one can enter a strong man’s house to steal his possessions unless he first ties up the strong man."
VUL:"Nemo potest vasa fortis ingressus in domum diripere, nisi prius fortem alliget"
Taken as written: no one can plunder "if he does not (ἐὰν μή) first bind". So the premise is
¬Binds → ¬PlundersGoods, not the constructively stronger PlundersGoods → Binds. It also drops
πρῶτον, "first", the order of the two acts. Nestle 1904 opens the verse with ἀλλ’, "but", which
BSB renders "Indeed" and the KJV and Vulgate leave unrendered. -/
axiom mrk3_27 : ∀ x s : Entity, StrongMan s → ¬Binds x s → ¬PlundersGoods x s

/-! ## Readings: what the argument needs and the verses do not state

Why the key identification is a reading and not a citation. "Casting out the demons by their
prince is Satan divided against himself" is the step the reductio rests on, and 3:23 does not
state it. 3:23 is a question ("How can Satan cast out Satan?"), and a question asserts no
conditional. It supplies only the middle term, named above as `SatanCastsOutSatan`. Both links to
that term are left to the hearer: from the charge to it (the prince of the demons is Satan), and
from it to 3:26 (Satan casting out Satan is Satan risen up against himself and divided). Jesus
speaks "in parables" (ἐν παραβολαῖς), figurative speech that asks for exactly this inference.
Matthew, telling the same dispute, does state the second link (Matt 12:26). That shows it is a
separate claim, one Mark leaves unspoken. So: two readings, each visible in its own receipt.
3:23's question then comes out as a theorem (`satan_cannot_cast_out_satan`), not a premise. -/

/-- @interpretive
3:22 says he casts out demons "by the prince of the demons" (ἐν τῷ ἄρχοντι τῶν δαιμονίων), and
3:23 answers "How can Satan cast out Satan?" Reading the answer as a restatement of the charge adds
two identifications that Mark never states: the prince of the demons is Satan, and the demons cast
out are Satan's own, so that casting them out by his power is Satan casting out Satan. Matthew names
the scribes' figure "Beelzebul the prince of the demons" (ἐν τῷ Βεελζεβοὺλ ἄρχοντι τῶν δαιμονίων,
Matt 12:24), and there too Jesus answers with "Satan". Alternative: the scribes may have meant
Beelzebul as a lesser lord of demons, not Satan himself; Jesus' reply treats the two as one. Stated
for any exorcist, since the argument never uses who he is. -/
axiom charge_is_self_expulsion : ∀ x : Entity, ByPrince x → SatanCastsOutSatan

/-- @interpretive
3:23 names "Satan casting out Satan"; 3:26 speaks of Satan who "has risen up against himself and
been divided". Mark sets them side by side but never says the first is the second. Matthew does:
εἰ ὁ Σατανᾶς τὸν Σατανᾶν ἐκβάλλει,ἐφ’ἑαυτὸν ἐμερίσθη, "if Satan cast out Satan, he is divided
against himself" (Matt 12:26). The reading assumes the expulsions are real defeats for Satan's side.
Alternative: a feigned retreat, Satan yielding ground in order to deceive, would not be division,
and the argument would not touch it. -/
axiom self_expulsion_is_division : SatanCastsOutSatan → RoseAgainstHimself satan ∧ Divided satan

/-- @interpretive
The reductio needs Satan to be still standing, and 3:22–27 never says he is: the text assumes it.
The scribes' charge presupposes demons still at work to be cast out. 3:27 presupposes a strong man
who must be bound before his goods can be taken. And in the next chapter Satan is still active:
εὐθὺς ἔρχεται ὁ Σατανᾶς καὶ αἴρει τὸν λόγον, "Satan cometh immediately, and taketh away the word"
(4:15). Alternative: BSB renders 3:26 "his end has come", as if Jesus announced Satan's fall. On
that reading the dispute is over the CAUSE of his end (civil war, or the binding of 3:27), and this
premise holds only in the weaker sense "not fallen by division". -/
axiom satan_still_stands : Stand satan

/-- @interpretive
3:24 speaks of a kingdom and 3:26 of Satan; Mark never says Satan has a kingdom. Matthew 12:26 and
Luke 11:18 both say it: πῶς σταθήσεται ἡ βασιλεία αὐτοῦ, "how shall his kingdom stand?" The
reading: if Satan has risen up against himself and is divided, then his kingdom is divided against
itself, and he stands only if it stands. This is the analogy that carries the parable over to
Satan. Mark makes that step in words at 3:26, so the reading is needed only for the parable route. -/
axiom division_divides_his_kingdom :
    RoseAgainstHimself satan ∧ Divided satan →
      ∃ k : Entity, Kingdom k ∧ DividedAgainstItself k ∧ (Stand satan → Stand k)

/-- @interpretive
3:25 speaks of a house and 3:26 of Satan. The next verse speaks of "the house of the strong man"
(τὴν οἰκίαν τοῦ ἰσχυροῦ, 3:27); if the strong man is Satan, that is Satan's house. The reading: if
Satan has risen up against himself and is divided, then his house is divided against itself, and
he stands only if it stands. Alternative: Mark frames the whole scene with Jesus' own household,
who went out to seize him (οἱ παρ’αὐτοῦ, 3:21), and the house of 3:25 can be heard against that
frame instead of as Satan's realm. -/
axiom division_divides_his_house :
    RoseAgainstHimself satan ∧ Divided satan →
      ∃ h : Entity, House h ∧ DividedAgainstItself h ∧ (Stand satan → Stand h)

/-- @interpretive
3:27 never says who the strong man is, or what his goods are. The reading: the strong man is
Satan, and to cast out demons is to enter his house and plunder his goods. Mark has prepared it:
John proclaimed "the one stronger than I" (ὁ ἰσχυρότερός μου, 1:7), the comparative of ἰσχυρός.
The Vulgate keeps the link (fortior, then fortis); KJV ("mightier", "strong man") and BSB ("more
powerful", "strong man") lose it. Left open: when the binding happened (the testing by Satan in
the wilderness, 1:13, or in each exorcism), and whether the goods are the possessed or the demons.
Nothing below depends on either choice. -/
axiom strong_man_is_satan : StrongMan satan ∧ ∀ x : Entity, CastsOutDemons x → PlundersGoods x satan

/-! ## Three witnesses: a divided Satan cannot stand -/

/-- Witness 1, 3:26: stated outright, no reading needed. -/
theorem divided_satan_falls_v26 : RoseAgainstHimself satan ∧ Divided satan → ¬Stand satan :=
  fun h => (mrk3_26 h).1

/-- Witness 2, the kingdom parable (3:24): it reaches Satan only through the kingdom reading. -/
theorem divided_satan_falls_kingdom : RoseAgainstHimself satan ∧ Divided satan → ¬Stand satan :=
  fun h stands =>
    match division_divides_his_kingdom h with
    | ⟨k, hk, hd, hsk⟩ => mrk3_24 k hk hd (hsk stands)

/-- Witness 3, the house parable (3:25): it reaches Satan only through the house reading. -/
theorem divided_satan_falls_house : RoseAgainstHimself satan ∧ Divided satan → ¬Stand satan :=
  fun h stands =>
    match division_divides_his_house h with
    | ⟨d, hh, hd, hsd⟩ => mrk3_25 d hh hd (hsd stands)

/-- The routes agree (proof irrelevance). They count as three witnesses because their receipts share
no premise: {mrk3_26}, {mrk3_24, division_divides_his_kingdom}, {mrk3_25, division_divides_his_house}.
Only 3:26 goes on to "but has an end" (τέλος ἔχει); neither parable gives that. -/
example : divided_satan_falls_v26 = divided_satan_falls_kingdom := rfl
example : divided_satan_falls_v26 = divided_satan_falls_house := rfl

/-! ## The reductio -/

/-- Grant the charge for the sake of argument. Then Satan cannot stand but has an end: the scribes'
own explanation, followed through, finishes Satan. This step uses the two identification readings
and 3:26, and NOT the premise that Satan still stands. -/
theorem charge_ends_satan (x : Entity) (charge : ByPrince x) : ¬Stand satan ∧ HasEnd satan :=
  mrk3_26 (self_expulsion_is_division (charge_is_self_expulsion x charge))

/-- Jesus' question answered. "How can Satan cast out Satan?" He cannot, while he still stands. -/
theorem satan_cannot_cast_out_satan : ¬SatanCastsOutSatan :=
  fun h => (mrk3_26 (self_expulsion_is_division h)).1 satan_still_stands

/-- The charge refuted, for the one accused and for anyone else, since the proof never uses who the
exorcist is. Constructive: refuting a hypothesis is negation introduction, with no excluded middle. -/
theorem charge_refuted (x : Entity) : ¬ByPrince x :=
  fun charge => (charge_ends_satan x charge).1 satan_still_stands

/-! ## The other explanation: the strong man bound (3:27) -/

/-- Whoever casts out demons has not failed to bind the strong man. Constructive: from 3:27 as
written ("no one can ... if he does not first bind"), this double negation is all that follows
without excluded middle. It rests on 3:27 and its reading only, none of the reductio's premises. -/
theorem not_not_strong_man_bound (x : Entity) (h : CastsOutDemons x) : ¬¬Binds x satan :=
  fun unbound => mrk3_27 x satan strong_man_is_satan.1 unbound (strong_man_is_satan.2 x h)

/-- "He has bound the strong man." Dropping the double negation is excluded middle, so
`#print axioms` shows `Classical.choice` here and not above. -/
theorem strong_man_bound (x : Entity) (h : CastsOutDemons x) : Binds x satan :=
  Classical.byContradiction (not_not_strong_man_bound x h)

/-! ## Consistency: the charge has no world, the answer has one

A reductio proves something only if its background is consistent: from inconsistent premises
every charge "leads to a contradiction", the true ones too. Lean cannot test the file's axioms
from inside, so the premises are bundled as a structure. The first `example` checks that the
file's own axioms fill the bundle exactly, field by field. Then a two-figure world fills it too,
with the charge false, Satan still standing, and an exorcist who has bound him. -/

/-- Every term, premise and reading of this file, as one bundle. -/
structure Premises where
  Entity : Type
  satan : Entity
  ByPrince : Entity → Prop
  CastsOutDemons : Entity → Prop
  SatanCastsOutSatan : Prop
  Kingdom : Entity → Prop
  House : Entity → Prop
  DividedAgainstItself : Entity → Prop
  Stand : Entity → Prop
  RoseAgainstHimself : Entity → Prop
  Divided : Entity → Prop
  HasEnd : Entity → Prop
  StrongMan : Entity → Prop
  PlundersGoods : Entity → Entity → Prop
  Binds : Entity → Entity → Prop
  mrk3_24 : ∀ k : Entity, Kingdom k → DividedAgainstItself k → ¬Stand k
  mrk3_25 : ∀ h : Entity, House h → DividedAgainstItself h → ¬Stand h
  mrk3_26 : RoseAgainstHimself satan ∧ Divided satan → ¬Stand satan ∧ HasEnd satan
  mrk3_27 : ∀ x s : Entity, StrongMan s → ¬Binds x s → ¬PlundersGoods x s
  charge_is_self_expulsion : ∀ x : Entity, ByPrince x → SatanCastsOutSatan
  self_expulsion_is_division : SatanCastsOutSatan → RoseAgainstHimself satan ∧ Divided satan
  satan_still_stands : Stand satan
  division_divides_his_kingdom : RoseAgainstHimself satan ∧ Divided satan →
    ∃ k : Entity, Kingdom k ∧ DividedAgainstItself k ∧ (Stand satan → Stand k)
  division_divides_his_house : RoseAgainstHimself satan ∧ Divided satan →
    ∃ h : Entity, House h ∧ DividedAgainstItself h ∧ (Stand satan → Stand h)
  strong_man_is_satan : StrongMan satan ∧ ∀ x : Entity, CastsOutDemons x → PlundersGoods x satan

/-- The bundle is exactly this file: Lean checks every field against the axiom of the same name. -/
noncomputable example : Premises :=
  { Entity, satan, ByPrince, CastsOutDemons, SatanCastsOutSatan, Kingdom, House,
    DividedAgainstItself, Stand, RoseAgainstHimself, Divided, HasEnd, StrongMan, PlundersGoods,
    Binds, mrk3_24, mrk3_25, mrk3_26, mrk3_27, charge_is_self_expulsion,
    self_expulsion_is_division, satan_still_stands, division_divides_his_kingdom,
    division_divides_his_house, strong_man_is_satan }

/-- The two figures of the small world. -/
inductive Figure where
  | satan
  | exorcist

/-- Jesus' answer in miniature. Nothing is divided, so nothing falls; Satan stands, as the strong
man; the exorcist casts out demons, has bound him, and plunders his goods; nobody casts out by the
prince of the demons. It shows only that the premises fit together, not that they are true. -/
abbrev world : Premises where
  Entity := Figure
  satan := Figure.satan
  ByPrince := fun _ => False
  CastsOutDemons := fun x => x = Figure.exorcist
  SatanCastsOutSatan := False
  Kingdom := fun _ => False
  House := fun _ => False
  DividedAgainstItself := fun _ => False
  Stand := fun _ => True
  RoseAgainstHimself := fun _ => False
  Divided := fun _ => False
  HasEnd := fun _ => False
  StrongMan := fun s => s = Figure.satan
  PlundersGoods := fun x s => x = Figure.exorcist ∧ s = Figure.satan
  Binds := fun x s => x = Figure.exorcist ∧ s = Figure.satan
  mrk3_24 := fun _ _ divided _ => divided
  mrk3_25 := fun _ _ divided _ => divided
  mrk3_26 := fun h => h.1.elim
  mrk3_27 := fun _ _ _ unbound => unbound
  charge_is_self_expulsion := fun _ charge => charge
  self_expulsion_is_division := fun h => h.elim
  satan_still_stands := trivial
  division_divides_his_kingdom := fun h => h.1.elim
  division_divides_his_house := fun h => h.1.elim
  strong_man_is_satan := ⟨rfl, fun _ h => ⟨h, rfl⟩⟩

/-- The verdict. In EVERY world where this file's premises hold, no one casts out demons by the
prince of the demons. And there IS such a world, in which Satan still stands and someone casts out
demons and has bound him. So the contradiction is the charge's alone, and the answer of 3:27 is
consistent with the refutation. Its receipt lists no verse: both halves speak about the bundle,
not about the text, so this is pure logic. -/
theorem charge_fails_answer_fits :
    (∀ P : Premises, ∀ x : P.Entity, ¬P.ByPrince x) ∧
    (∃ P : Premises, P.Stand P.satan ∧ ∃ x : P.Entity, P.CastsOutDemons x ∧ P.Binds x P.satan) :=
  ⟨fun P x charge =>
      (P.mrk3_26 (P.self_expulsion_is_division (P.charge_is_self_expulsion x charge))).1
        P.satan_still_stands,
   ⟨world, trivial, Figure.exorcist, rfl, rfl, rfl⟩⟩

end Mark3

/-! ## The receipts -/
#print axioms Mark3.divided_satan_falls_v26
#print axioms Mark3.divided_satan_falls_kingdom
#print axioms Mark3.divided_satan_falls_house
#print axioms Mark3.charge_ends_satan
#print axioms Mark3.satan_cannot_cast_out_satan
#print axioms Mark3.charge_refuted
#print axioms Mark3.not_not_strong_man_bound
#print axioms Mark3.strong_man_bound
#print axioms Mark3.charge_fails_answer_fits
