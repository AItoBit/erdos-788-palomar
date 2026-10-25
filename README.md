# Erdős problem 788: reproduction and port of Wang's formal proof

This project contains the full substantive Lean proof source for Shouqiao Wang's
existing result on Erdős problem 788. It is a toolchain/module-system port and
registry verification package. It does not claim a new mathematical solution,
an independent proof of Wang's result, or human peer review.

## Mathematical result

For a natural n, write I_n=(n,2n) intersected with the natural numbers and
J_n=(2n,4n) intersected with the natural numbers. A subset C of I_n is admissible
for B if c+c' is not in B whenever c,c' are distinct members of C.

The integer f(n) is the greatest threshold t such that every B contained in J_n
has an admissible C with |B|+|C| >= t. The quantifier over B precedes the
choice of C. `fNat` takes the greatest guaranteed natural threshold under an
explicit finite bound, and `f` embeds it into the integers. The source proof
contains the maximality API and its equivalence to the integer-valued maximum.
These definitions retain the original open endpoints and distinctness condition.

The two compared declarations are:

1. `Erdos788.erdos_788`: for every positive real epsilon, there is n0>=1 such
   that, for all natural n>=n0,
   n^(1/2-epsilon) <= f(n) <= n^(1/2+epsilon).
2. `Erdos788.erdos_788_quantitative`: for every natural n>=3,
   sqrt(n log n)/2000 <= f(n); and there are C>0 and n0>=1 such that, for all
   natural n>=n0,
   f(n) <= n^(1/2+C*(log(log n)/log n)^(1/3)).

Thus f(n)=n^(1/2+o(1)), with stronger quantitative information. Small inputs
and logarithm boundary values are controlled by the displayed lower bounds on n
and the existential eventual threshold. The proof uses ordinary Mathlib real
logarithms, real powers, and natural/integer casts; the Challenge defines these
exactly as the Solution does. No desired theorem is assumed in the Solution.

## Challenge and Solution

`Challenge.lean` is a small statement file importing only canonical Mathlib.
Its two intentional theorem holes are the statements Comparator must check.
They are not proofs and are not imported by the Solution.

`Solution.lean` publicly imports `ErdosProblems/Erdos788.lean`. That module
supplies both actual proofs through its complete 44-module dependency closure,
all included in this repository. `comparator.json` selects the two declarations
with the same fully qualified names. It permits only `propext`, `Quot.sound`,
and `Classical.choice`; it does not permit `sorryAx` or custom mathematical axioms.

The Solution and its substantive proof modules contain no deliberate holes,
new axioms, `unsafe` verification shortcuts, or `native_decide` proofs. This is
an ordinary project containing the proof source, rather than a thin wrapper
that merely exposes declarations from an external proof package.

## Provenance and authorship

The mathematical argument and the original formalization are credited to
**Shouqiao Wang**. The mathematical source is *A Proposed Solution to Erdős
Problem 788*, at https://github.com/ShouqiaoW/erdos/blob/f2ae0ed/788/paper.tex .
The problem is https://www.erdosproblems.com/788 .

The proof was reproduced from plby/lean-proofs at the exact commit
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, under
`src/latest/ErdosProblems/Erdos788.lean` and its supporting Erdos788 directory.
Original source hashes are retained in `upstream-source-hashes.json`.
The original source was already ported from Lean4.27.0 to Lean4.33.0 and did
not identify its formalization model. This package updates the module system
and toolchain to Lean4.35.0 with exactly matching canonical Mathlib.
The uniform-random-row measure in `ShortLinearCode.lean` is also adapted to
Mathlib's newer finite-uniform-measure API; the mathematical distribution
and theorem statements are unchanged. Original hashes describe the upstream
sources before these visibility and API edits.

AItoBit is the public human maintainer name supplied by the submitter. The
submitter states that a responsible author or maintainer of the underlying
formalization approved submission. No approver is named, and no source-author
endorsement beyond that approval statement is asserted. Maintainer status is
not presented as authorship of Wang's mathematical result.

OpenAI Codex and separate audit/port agents performed reproduction, statement
audits, toolchain-port work, build checks, and registry packaging. AI systems
are not listed as human authors or maintainers. The source and packaging have
been agent-reviewed; no expert human peer review is claimed.

## Verification and reproduction

The prior reproduction with Lean4.33.0 and Mathlib commit
db584cd6d46c92f209a44c0f1c829460d327499d compiled all44modules and a separate
statement bridge. The final named theorems used only the three standard axioms.
Those logs document the prior reproduction, not success of the newer port.

This project pins Lean4.35.0 and canonical Mathlib commit
56a005855ea17e0b0958f73ec801ae140b0a1679. The final port and Palomar mechanical
reports must be inspected separately; a source-level build is not Comparator
or NanoDa verification. No registration or successful registry review is
claimed merely by publishing this package.

To compile locally after fetching dependencies and the Mathlib cache:

```
lake update
lake exe cache get Mathlib
lake build ErdosProblems
lake env lean Challenge.lean
lake env lean Solution.lean
```

The included workflow calls Palomar's full reusable mechanical preflight,
pinned to c02bbeaed888df45c4e28c4e99dba540ad21552a, with the standard GitHub-hosted
execution profile. Only a `status: pass` mechanical report qualifies the package
for intake. Registration is a later, separate decision after the actual review
has been shown to the submitter.

## License

MIT, preserving the original copyright notice for Shouqiao Wang in `LICENSE`.
This license covers the submitted software snapshot and does not alter the
copyright of cited mathematical sources or external dependencies.
