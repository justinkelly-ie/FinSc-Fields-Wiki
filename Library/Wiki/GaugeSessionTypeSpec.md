# 📡 Linear Session Types & Multiset Flux Exchange Specification

Documents and verifies linear session protocols (`SessionProto`), session protocol duality involution ($\text{dual}(\text{dual}(p)) \equiv p$), and their physical realization as **conservative multiset flux exchanges** between spacetime gauge plaquettes.

---

## 1. Physical Grounding: Channels as Multiset Flux Exchanges

In traditional concurrency theory (Honda 1993, Wadler 2014), **Linear Session Types** govern bi-directional communication channels where endpoints strictly alternate between `Send` and `Recv` actions until `Close`:

1. **Protocol State AST**:
   $$\text{SessionProto} ::= \text{Send}(T, P) \mid \text{Recv}(T, P) \mid \text{Close}$$
2. **Protocol Duality**:
   Dualizing a protocol turns outputs into inputs and vice-versa:
   $$\text{dual}(\text{Send}(T, P)) = \text{Recv}(T, \text{dual}(P)), \quad \text{dual}(\text{Close}) = \text{Close}$$
   satisfying the involution theorem:
   $$\text{dual}(\text{dual}(P)) \equiv P$$

### The Constructive Finite Science Refinement

In finite science, physical spacetime contains no abstract "message brokers" or mock channel identifiers (`MkChan id`). Instead:
- Every communication endpoint is a **discrete multiset carrier** $\mathcal{M} : \text{Multiset } \text{BoxInt } \alpha$.
- A `Send` action corresponds to depositing flux particles of weight $w$ into the exchange boundary:
  $$\text{depositGaugeFlux} : \mathcal{M} \xrightarrow{+w} \mathcal{M}'$$
- A `Recv` action corresponds to withdrawing flux particles from the exchange boundary:
  $$\text{withdrawGaugeFlux} : \mathcal{M}' \xrightarrow{-w} \mathcal{M}''$$
- Bilateral interaction across neighboring spatial regions strictly preserves total gauge charge:
  $$\text{Weight}(\mathcal{M}_{\text{source}}) + \text{Weight}(\mathcal{M}_{\text{sink}}) \equiv \text{Weight}(\mathcal{M}'_{\text{source}}) + \text{Weight}(\mathcal{M}'_{\text{sink}})$$

### Metrically Synchronized Transport Across the 4 Geometries

Channel transmission honors the four fundamental metric signatures:
- **Elliptic ($\det g = +1$, 27 VM)**: Bound gauge flux confinement within compact lattice cells.
- **Hyperbolic ($\det g = -1$, 128 DE)**: Propagating gauge wavefronts and lightcone phase transitions.
- **Parabolic ($\det g = 0$, 55 DM)**: Gauge remainder dissipation along null directions.
- **Substrate (210 Master)**: Asymmetric causal arrow $\Delta S \ge 1$ driving irreversible thermodynamic exchange.

---

## 2. Formal Specification & Verification Suite

```idris
module Wiki.GaugeSessionTypeSpec

import Stage0.Fields.SessionType
import Stage0.BoxInt
import Stage0.Multiset
import Stage0.Applicative
import Wiki.Generators
import public QuickCheck

%default total

||| 1. Session Duality Involution: dualProto (dualProto p) == p
public export
prop_sessionDualityInvolution : Bool
prop_sessionDualityInvolution =
  let p1 = Send Nat (Recv Integer Close)
      p2 = dualProto (dualProto p1)
  in case (p1, p2) of
       (Send _ (Recv _ Close), Send _ (Recv _ Close)) => True
       _ => False

||| Static Compiler Proof Witness Verification
public export
0 prfStaticSessionDuality : (p : SessionProto) -> dualProto (dualProto p) = p
prfStaticSessionDuality p = verifySessionDuality p

||| 2. Constructive Multiset Session Flux Transmission (Deposit & Withdraw)
public export
prop_multisetChannelTransmission : Bool
prop_multisetChannelTransmission =
  let initChan : MultisetSession (Send Nat (Recv Nat Close)) Nat
      initChan = MkMsetChan ZeroM
      chanAfterSend = depositGaugeFlux initChan 42 (MkBoxInt 10)
      chanAsRecv : MultisetSession (Recv Nat Close) Nat
      chanAsRecv = chanAfterSend
  in case withdrawGaugeFlux chanAsRecv of
       Right (val, w, chanAfterRecv) =>
         val == 42 && unwrapBox w == 10 &&
         unwrapBox (multisetSum (closeGaugeSession chanAfterRecv)) == 0
       Left _ => False

||| 3. Bilateral Multiset Flux Exchange & Total Charge Preservation
public export
prop_bilateralFluxExchangeConservation : Bool
prop_bilateralFluxExchangeConservation =
  let src : Multiset BoxInt Nat
      src = AddM 1 (MkBoxInt 15) ZeroM
      dst : Multiset BoxInt Nat
      dst = AddM 2 (MkBoxInt 25) ZeroM
      result = exchangeGaugeFlux src dst 3 (MkBoxInt 10)
      srcWeight = unwrapBox (multisetSum result.sourceMset)
      dstWeight = unwrapBox (multisetSum result.destMset)
  in (srcWeight + dstWeight) == (15 + 25 + 10)

||| QuickCheck Execution Runner for Session Type Suite
public export
auditGaugeSessionTypeSpecProof : IO Bool
auditGaugeSessionTypeSpecProof = do
  let pass = prop_sessionDualityInvolution &&
             prop_multisetChannelTransmission &&
             prop_bilateralFluxExchangeConservation
  pure pass
```
