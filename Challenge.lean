module

public import Mathlib

/-!
# Erdős problem 788: exact finite maximum and asymptotic bounds

For each natural n, vary B within (2n,4n) and choose C within (n,2n),
with no sum of distinct elements of C in B. The function f(n) is the
greatest integer universally guaranteed by |B|+|C|.

The compared statements assert exponent one half and the displayed quantitative
bounds. Zero and small n are handled by the explicit quantifiers. Repeated
summands are excluded in the admissibility condition, as in the source.
The source, attribution, previous formalization, and production account are
recorded in README.md and formalization.yaml.
-/

@[expose] public section

namespace Erdos788

/-- The natural integers strictly between n and 2n. -/
def I (n : ℕ) : Finset ℕ :=
  Finset.Ioo n (2 * n)

/-- The natural integers strictly between 2n and 4n. -/
def J (n : ℕ) : Finset ℕ :=
  Finset.Ioo (2 * n) (4 * n)

/-- C lies in I n and no sum of two distinct members of C belongs to B. -/
def Admissible (n : ℕ) (B C : Finset ℕ) : Prop :=
  C ⊆ I n ∧
    ∀ ⦃c⦄, c ∈ C → ∀ ⦃c'⦄, c' ∈ C → c ≠ c' → c + c' ∉ B

/-- Every B contained in J n admits a C with total cardinality at least t. -/
def Guarantees (n t : ℕ) : Prop :=
  ∀ B : Finset ℕ, B ⊆ J n →
    ∃ C : Finset ℕ, Admissible n B C ∧ t ≤ B.card + C.card

/-- A uniform finite upper bound for the sum of the two cardinalities. -/
def scoreBound (n : ℕ) : ℕ :=
  (J n).card + (I n).card

/-- The greatest natural threshold with the universal guarantee. -/
noncomputable def fNat (n : ℕ) : ℕ := by
  classical
  exact Nat.findGreatest (Guarantees n) (scoreBound n)

/-- The integer-valued maximum from the source problem. -/
noncomputable def f (n : ℕ) : ℤ :=
  (fNat n : ℤ)
/-- The exact finite maximum has asymptotic exponent one half. -/
theorem erdos_788 :
    ∀ ε : ℝ, 0 < ε → ∃ n₀ : ℕ, 1 ≤ n₀ ∧ ∀ n : ℕ, n₀ ≤ n →
      (n : ℝ) ^ ((1 / 2 : ℝ) - ε) ≤ (f n : ℝ) ∧
        (f n : ℝ) ≤ (n : ℝ) ^ ((1 / 2 : ℝ) + ε) := by sorry

/-- A uniform square-root logarithmic lower bound and a quantitative upper exponent. -/
theorem erdos_788_quantitative :
    (∀ n : ℕ, 3 ≤ n →
      (1 / 2000 : ℝ) * Real.sqrt ((n : ℝ) * Real.log (n : ℝ)) ≤ (f n : ℝ)) ∧
    ∃ C : ℝ, 0 < C ∧ ∃ n₀ : ℕ, 1 ≤ n₀ ∧ ∀ n : ℕ, n₀ ≤ n →
      (f n : ℝ) ≤ (n : ℝ) ^ ((1 / 2 : ℝ) + C *
        (Real.log (Real.log (n : ℝ)) / Real.log (n : ℝ)) ^ (1 / 3 : ℝ)) := by sorry

end Erdos788
