/-!
# Matthew 22:23–33 — "Not the God of the dead, but of the living"

The Sadducees, "which say that there is no resurrection" (22:23), pose a riddle. Jesus answers
from the Torah they accepted, Exodus 3:6, spoken to Moses centuries after Abraham died:
"I am the God of Abraham … God is not the God of the dead, but of the living."

This file is the house TEMPLATE: one argument, crossing testaments, every premise cited in its
own original language (Hebrew for Exodus and Genesis, Greek for Matthew), every unstated step
labeled as a reading.

What it shows:
* Two independent routes to "God IS (now) the God of Abraham": Jesus' Greek (Ἐγώ εἰμι) states
  it outright; Moses' Hebrew has NO verb ("I the God of Abraham"; the KJV prints "I [am]" in
  brackets as a supplied word), so that route needs a labeled reading.
* The text keeps two words apart: Genesis 25:8 says Abraham DIED (verb מוּת, a past event);
  Jesus says God is not God of THE DEAD (adjective νεκρῶν, a present state). Abraham is the
  first and not the second.
* The Sadducees' hidden premise, "whoever died is dead," contradicts the cited verses: Lean
  refutes it outright.
* Jesus' answer is about resurrection (22:31). The final step from "lives to God" to "will be
  raised" is implied, not stated, and is labeled so.
-/

namespace Matthew22

/-! ## Domain and terms -/

/-- @domain The persons Scripture speaks about. A bare type of individuals, it asserts nothing at all. -/
axiom Person : Type

/-- @term GEN 25:8 [אַבְרָהָם] "אַבְרָהָם"
Abraham. -/
axiom abraham : Person

/-- @term GEN 25:8 [מוּת] "וַיָּמָת"
"and he died": מוּת, a finished past event (wayyiqtol). -/
axiom Died : Person → Prop

/-- @term EXO 3:6 [אֱלֹהִים אַבְרָהָם] "אֱלֹהֵי אַבְרָהָם"
"the God of Abraham": a relationship. The Hebrew clause has no verb, so it marks no tense. -/
axiom GodOf : Person → Prop

/-- @term MAT 22:32 [ἐγώ εἰμί θεός] "Ἐγώ εἰμι ὁ Θεὸς"
"I AM the God of …": εἰμί, present indicative. The relationship holds now. -/
axiom GodOfNow : Person → Prop

/-- @term MAT 22:32 [νεκρός] "νεκρῶν"
"the dead": νεκρός, a present condition, not the past event of dying. -/
axiom DeadNow : Person → Prop

/-- @term MAT 22:32 [ζάω] "ζώντων"
"the living": ζάω, present participle. -/
axiom LivingNow : Person → Prop

/-- @term MAT 22:31 [ἀνάστασις νεκρός] "ἀναστάσεως τῶν νεκρῶν"
"the resurrection of the dead", the question Jesus is answering. -/
axiom Raised : Person → Prop

/-! ## Premises: what the texts state -/

/-- @cite GEN 25:8 [גָּוַע מוּת אַבְרָהָם]
HEB:"וַיִּגְוַע וַיָּמָת אַבְרָהָם"
KJV:"Then Abraham gave up the ghost, and died"
BSB:"he breathed his last and died"
VUL:"Et deficiens mortuus est" -/
axiom gen25_8 : Died abraham

/-- @cite EXO 3:6 [אָנֹכִי אֱלֹהִים אַבְרָהָם]
HEB:"אָנֹכִי אֱלֹהֵי אָבִיךָ אֱלֹהֵי אַבְרָהָם"
KJV:"I [am] the God of thy father, the God of Abraham"
BSB:"I am the God of your father, the God of Abraham"
VUL:"Ego sum Deus patris tui, Deus Abraham" -/
axiom exo3_6 : GodOf abraham

/-- @cite MAT 22:32 [ἐγώ εἰμί θεός Ἀβραάμ]
GRK:"Ἐγώ εἰμι ὁ Θεὸς Ἀβραὰμ"
KJV:"I am the God of Abraham"
BSB:"I am the God of Abraham"
VUL:"Ego sum Deus Abraham" -/
axiom mat22_32a : GodOfNow abraham

/-- @cite MAT 22:32 [οὐ εἰμί θεός νεκρός ἀλλά ζάω]
GRK:"οὐκ ἔστιν ὁ Θεὸς νεκρῶν ἀλλὰ ζώντων"
KJV:"God is not the God of the dead, but of the living."
BSB:"He is not the God of the dead, but of the living."
VUL:"Non est Deus mortuorum, sed viventium." -/
axiom mat22_32b : ∀ p : Person, GodOfNow p → ¬DeadNow p ∧ LivingNow p

/-! ## Readings: steps the texts imply but do not state -/

/-- @interpretive
Exodus 3:6 has no verb: literally "I the God of your father, the God of Abraham." The KJV prints
"[am]" as a supplied word and MACULA glosses "[am].the.God". Reading the relationship as present
at the burning bush follows the Septuagint (ἐγώ εἰμι) and Jesus' own quotation, but the Hebrew
alone leaves the tense unstated. -/
axiom nominal_present : GodOf abraham → GodOfNow abraham

/-- @interpretive
Jesus offers verse 32 as an answer "touching the resurrection of the dead" (22:31). The step from
"he died, yet lives to God" to "he will be raised" is implied, not stated. The Sadducees denied
resurrection, angel and spirit alike (Acts 23:8), so showing that the departed still live answers
them, and one who lives after death is one whom God can raise. -/
axiom lives_after_death_raised : ∀ p : Person, Died p → LivingNow p → Raised p

/-! ## Two witnesses that God is Abraham's God now -/

/-- Witness 1, Jesus' Greek: stated outright, no reading needed. -/
theorem now_via_matthew : GodOfNow abraham := mat22_32a

/-- Witness 2, Moses' Hebrew: needs the present-tense reading, and the receipt says so. -/
theorem now_via_exodus : GodOfNow abraham := nominal_present exo3_6

/-- The routes agree (proof irrelevance). They count as two witnesses because their receipts share
no premise: {mat22_32a} versus {exo3_6, nominal_present}. -/
example : now_via_matthew = now_via_exodus := rfl

/-! ## The argument -/

/-- Abraham is not among "the dead" (νεκροί), though he died (מוּת). -/
theorem abraham_not_dead_now : ¬DeadNow abraham := (mat22_32b abraham mat22_32a).1

/-- The heart of it: Abraham died, and yet he is living. -/
theorem abraham_died_yet_lives : Died abraham ∧ LivingNow abraham :=
  ⟨gen25_8, (mat22_32b abraham mat22_32a).2⟩

/-- The Sadducees' hidden premise, "whoever died is dead," contradicts Genesis 25:8 together with
Matthew 22:32. Lean refutes it outright: the premise is inconsistent with the texts. -/
theorem sadducee_premise_refuted : ¬(∀ p : Person, Died p → DeadNow p) :=
  fun h => abraham_not_dead_now (h abraham gen25_8)

/-- Jesus' conclusion about the resurrection, with its one implied step visible in the receipt. -/
theorem abraham_raised : Raised abraham :=
  lives_after_death_raised abraham gen25_8 abraham_died_yet_lives.2

end Matthew22

/-! ## The receipts -/
#print axioms Matthew22.now_via_matthew
#print axioms Matthew22.now_via_exodus
#print axioms Matthew22.abraham_not_dead_now
#print axioms Matthew22.abraham_died_yet_lives
#print axioms Matthew22.sadducee_premise_refuted
#print axioms Matthew22.abraham_raised
