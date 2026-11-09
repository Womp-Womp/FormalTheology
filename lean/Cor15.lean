/-!
# 1 Corinthians 15:12–22 — Paul's argument for the resurrection

Formal Theology v0. Core Lean 4, no Mathlib:   lean lean/Cor15.lean

Rules of the house (enforced by tools/check_citations.py):
* Every `axiom` carries exactly one tag:
  - `@term`        a proposition naming a phrase of the Greek text,
  - `@cite`        a premise the verse itself states, with exact quotes,
  - `@interpretive` a reading the text does NOT state; it must say why.
* Every Greek lemma and every quote (Greek, KJV, BSB, Vulgate) is checked against
  data/1co15_12-22.json, built from MACULA Greek (Nestle 1904), the Clementine Vulgate,
  and KJV/BSB.
* `#print axioms` at the bottom shows exactly which verses and readings each conclusion
  rests on. That list is the point.

Lean checks that conclusions FOLLOW from these premises. It does not, and cannot,
check that the premises are true. That is faith's part, not the kernel's.
-/

namespace Cor15

/-! ## Terms: what the Greek actually names -/

/-- @term 1CO 15:13 [ἀνάστασις νεκρός] "ἀνάστασις νεκρῶν οὐκ ἔστιν"
"There is a resurrection of the dead." Noun ἀνάστασις: the event as a whole. -/
axiom ResurrectionIs : Prop

/-- @term 1CO 15:16 [νεκρός ἐγείρω] "νεκροὶ οὐκ ἐγείρονται"
"The dead are raised." Verb ἐγείρονται, present passive: raised by another. -/
axiom DeadRaised : Prop

/-- @term 1CO 15:13 [Χριστός ἐγείρω] "Χριστὸς ἐγήγερται"
"Christ has been raised." Perfect passive: raised, and remains raised. -/
axiom ChristRaised : Prop

/-- @term 1CO 15:14 [κενός κήρυγμα] "κενὸν ἄρα τὸ κήρυγμα ἡμῶν"
"Our preaching is empty" (κενός: hollow, with nothing in it). -/
axiom PreachingEmpty : Prop

/-- @term 1CO 15:14 [κενός πίστις] "κενὴ καὶ ἡ πίστις ὑμῶν"
"Your faith is EMPTY" (κενή). Vulgate: inanis. -/
axiom FaithEmpty : Prop

/-- @term 1CO 15:17 [μάταιος πίστις] "ματαία ἡ πίστις ὑμῶν"
"Your faith is FUTILE" (ματαία: goes nowhere, achieves nothing). Vulgate: vana.
Not the same word as v14's κενή. KJV renders both "vain"; Greek and Latin keep them apart. -/
axiom FaithFutile : Prop

/-- @term 1CO 15:17 [ἁμαρτία] "ἔτι ἐστὲ ἐν ταῖς ἁμαρτίαις ὑμῶν"
"You are still in your sins." -/
axiom StillInSins : Prop

/-! ## Premises: what Paul states -/

/-- @cite 1CO 15:13 [εἰ ἀνάστασις νεκρός οὐ οὐδέ Χριστός ἐγείρω]
GRK:"εἰ δὲ ἀνάστασις νεκρῶν οὐκ ἔστιν,οὐδὲ Χριστὸς ἐγήγερται"
KJV:"But if there be no resurrection of the dead, then is Christ not risen"
BSB:"If there is no resurrection of the dead, then not even Christ has been raised."
VUL:"Si autem resurrectio mortuorum non est: neque Christus resurrexit." -/
axiom v13 : ¬ResurrectionIs → ¬ChristRaised

/-- @cite 1CO 15:14 [εἰ Χριστός οὐ ἐγείρω κενός κήρυγμα πίστις]
GRK:"κενὸν ἄρα τὸ κήρυγμα ἡμῶν,κενὴ καὶ ἡ πίστις ὑμῶν"
KJV:"And if Christ be not risen, then is our preaching vain, and your faith is also vain."
BSB:"And if Christ has not been raised, our preaching is worthless, and so is your faith."
VUL:"inanis est ergo prædicatio nostra, inanis est et fides vestra" -/
axiom v14 : ¬ChristRaised → PreachingEmpty ∧ FaithEmpty

/-- @cite 1CO 15:16 [εἰ νεκρός οὐ ἐγείρω οὐδέ Χριστός]
GRK:"εἰ γὰρ νεκροὶ οὐκ ἐγείρονται,οὐδὲ Χριστὸς ἐγήγερται"
KJV:"For if the dead rise not, then is not Christ raised"
BSB:"For if the dead are not raised, then not even Christ has been raised."
VUL:"Nam si mortui non resurgunt, neque Christus resurrexit." -/
axiom v16 : ¬DeadRaised → ¬ChristRaised

/-- @cite 1CO 15:17 [εἰ Χριστός οὐ ἐγείρω μάταιος πίστις ἔτι ἁμαρτία]
GRK:"ματαία ἡ πίστις ὑμῶν,ἔτι ἐστὲ ἐν ταῖς ἁμαρτίαις ὑμῶν"
KJV:"And if Christ be not raised, your faith is vain; ye are yet in your sins."
BSB:"And if Christ has not been raised, your faith is futile; you are still in your sins."
VUL:"vana est fides vestra: adhuc enim estis in peccatis vestris." -/
axiom v17 : ¬ChristRaised → FaithFutile ∧ StillInSins

/-- @cite 1CO 15:20 [νυνί Χριστός ἐγείρω ἐκ νεκρός]
GRK:"Νυνὶ δὲ Χριστὸς ἐγήγερται ἐκ νεκρῶν"
KJV:"But now is Christ risen from the dead"
BSB:"But Christ has indeed been raised from the dead"
VUL:"Nunc autem Christus resurrexit a mortuis" -/
axiom v20 : ChristRaised

/-! ## Readings: what the text does not say outright -/

/-- @interpretive
v13 says "there is no resurrection (ἀνάστασις) of the dead"; v16 says "the dead are not raised
(ἐγείρονται)". Read as the same claim restated, noun then verb. Paul's parallel structure
(both end "οὐδὲ Χριστὸς ἐγήγερται") supports it, but the text never says they are identical. -/
axiom same_event : ResurrectionIs ↔ DeadRaised

/-! ## Two routes, two different words (no reading needed) -/

/-- Route A, v13 → v14: no resurrection ⇒ your faith is EMPTY (κενή). -/
theorem routeA : ¬ResurrectionIs → FaithEmpty := fun h => (v14 (v13 h)).2

/-- Route B, v16 → v17: the dead not raised ⇒ your faith is FUTILE (ματαία). -/
theorem routeB : ¬DeadRaised → FaithFutile := fun h => (v17 (v16 h)).1

/-! ## Witnesses: two independent paths to the same middle step -/

/-- Witness 1: through v13, which needs the `same_event` reading to connect. -/
theorem christ_not_raised_via13 : ¬DeadRaised → ¬ChristRaised :=
  fun h => v13 (fun r => h (same_event.mp r))

/-- Witness 2: v16 states it directly. -/
theorem christ_not_raised_via16 : ¬DeadRaised → ¬ChristRaised := v16

/-- The two paths agree (in Lean, any two proofs of one proposition are equal). Agreement is
cheap; INDEPENDENCE is what counts. See `#print axioms` below: witness 1 rests on {v13,
same_event}, witness 2 on {v16}. No shared verse, so they are two witnesses, not one counted twice. -/
example : christ_not_raised_via13 = christ_not_raised_via16 := rfl

/-! ## Paul's conclusion (v20) -/

/-- Constructive form, no extra logic: "it is impossible that the dead are not raised." -/
theorem not_not_dead_raised : ¬¬DeadRaised := fun h => v16 h v20

/-- Positive form, "the dead are raised." Going from ¬¬P to P is the law of excluded middle,
so `#print axioms` shows `Classical.choice` here and not above. Lean makes the logical
step visible, not just the verses. -/
theorem dead_raised : DeadRaised := Classical.byContradiction (fun h => v16 h v20)

/-- Second witness to the conclusion: through v13 and the `same_event` reading. -/
theorem dead_raised_via13 : DeadRaised :=
  same_event.mp (Classical.byContradiction (fun h => v13 h v20))

end Cor15

/-! ## The receipts -/
#print axioms Cor15.routeA
#print axioms Cor15.routeB
#print axioms Cor15.christ_not_raised_via13
#print axioms Cor15.christ_not_raised_via16
#print axioms Cor15.not_not_dead_raised
#print axioms Cor15.dead_raised
#print axioms Cor15.dead_raised_via13

-- BEGIN GENERATED THEORY (tools/consistency.py; do not edit by hand)
namespace Cor15.Consistency

/-- Every axiom of this file, as one structure: a "theory". A value of this type is a world in
which all the file's terms are interpreted and all its premises and readings are true. -/
structure Theory where
  ResurrectionIs : Prop
  DeadRaised : Prop
  ChristRaised : Prop
  PreachingEmpty : Prop
  FaithEmpty : Prop
  FaithFutile : Prop
  StillInSins : Prop
  v13 : ¬ResurrectionIs → ¬ChristRaised
  v14 : ¬ChristRaised → PreachingEmpty ∧ FaithEmpty
  v16 : ¬DeadRaised → ¬ChristRaised
  v17 : ¬ChristRaised → FaithFutile ∧ StillInSins
  v20 : ChristRaised
  same_event : ResurrectionIs ↔ DeadRaised

/-- The file's own axioms inhabit `Theory`, field for field: Lean checks each type, so the
structure cannot silently differ from the file. -/
noncomputable example : Theory := ⟨Cor15.ResurrectionIs, Cor15.DeadRaised, Cor15.ChristRaised, Cor15.PreachingEmpty, Cor15.FaithEmpty, Cor15.FaithFutile, Cor15.StillInSins, Cor15.v13, Cor15.v14, Cor15.v16, Cor15.v17, Cor15.v20, Cor15.same_event⟩

end Cor15.Consistency
-- END GENERATED THEORY

namespace Cor15.Consistency

/-- Paul's world as v20 describes it: Christ is raised, the dead are raised, there is a
resurrection, and so preaching and faith are neither empty nor futile. Every premise holds: the
conditionals of v13–v17 are true because their "if" clauses are false. -/
def model : Theory where
  ResurrectionIs := True
  DeadRaised := True
  ChristRaised := True
  PreachingEmpty := False
  FaithEmpty := False
  FaithFutile := False
  StillInSins := False
  v13 := fun h => absurd trivial h
  v14 := fun h => absurd trivial h
  v16 := fun h => absurd trivial h
  v17 := fun h => absurd trivial h
  v20 := trivial
  same_event := Iff.rfl

/-- The premises and the reading `same_event` cannot contradict each other. -/
theorem consistent : ¬(Theory → False) := fun h => h model

end Cor15.Consistency

#print axioms Cor15.Consistency.consistent
