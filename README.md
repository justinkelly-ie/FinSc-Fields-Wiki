# Idris2-Fields-Wiki

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Literate Verification Suite & Specification Manual for Layer 7 (`Idris2-Fields`)**

`Idris2-Fields-Wiki` provides formal compile-time macro reflection proofs, QuickCheck property test suites, and literate Markdown specifications for **Layer 7** of the non-linear discrete multiset physical law ecosystem.

---

## 📚 Specification Chapters & Verification Modules

### 1. `Library/Wiki/GaugeInvarianceSpec.md`
- **Algebra & Homomorphisms:** Specifications for discrete U(1) gauge group phase elements (`GaugePhase`), gauge phase multiplication (`mulGaugePhase`), electromagnetic field strength tensors ($E, B$), and energy density invariance ($Q_{\text{EM}} = E^2 + B^2$).
- **Verification:** QuickCheck property tests validating gauge group identity, gauge field energy conservation, and 4D dihedral phase invariance.

### 2. `Library/Wiki/GaugeSessionTypeSpec.md`
- **Algebra & Homomorphisms:** Specifications for linear session protocols (`SessionProto`: `Send`, `Recv`, `Close`), session duality involution ($\text{dual}(\text{dual}(p)) \equiv p$), and metrically synchronized gauge channels (`GaugeSyncChannel`).
- **Verification:** Proof witnesses and property tests for session duality and QTT linear channel resource accounting.

### 3. `Library/Wiki/FieldsScaleTransformSpec.md`
- **Algebra & Homomorphisms:** Specifications for scale transformations mapping gauge fields across scale levels, group action associativity ($g_1 \cdot (g_2 \cdot F) \equiv (g_1 \cdot g_2) \cdot F$), and metrically transported energy density invariance.
- **Verification:** QuickCheck property tests for gauge action associativity and spatial field transport invariance.

### 4. `Library/Wiki/Generators.idr`
- **QuickCheck Generators:** Arbitrary instances for `GaugePhase`, `GaugeFieldTensor`, `BoxInt`, and `UnixelFraction`.

### 5. `Library/Wiki/Main.idr`
- **Verification Runner:** Literate Idris 2 test runner executing compile-time `%macro` reflection proofs and QuickCheck property test suites for Layer 7 (`fields-wiki`).

---

## 🚀 Verification & Build

To compile the literate verification suite and execute the test runner binary:

```bash
idris2 --build Idris2-Fields-Wiki.ipkg
./build/exec/fields-wiki
```

---

## 🏗️ 10-Layer Ecosystem Architecture

1. `Idris2-Multiset-Core` / `Idris2-Multiset-Core-Wiki` (Layer 1: Flat Primitives)
2. `Idris2-Multiset-Transform` / `Idris2-Multiset-Transform-Wiki` (Layer 2: Fields & Scale Functors)
3. `Idris2-Multiset-Binary` / `Idris2-Multiset-Binary-Wiki` (Layer 2b: Boolean Field Engines)
4. `Idris2-Multiset-Ternary` / `Idris2-Multiset-Ternary-Wiki` (Layer 2c: Balanced Ternary Sifting)
5. `Idris2-Geometry` / `Idris2-Geometry-Wiki` (Layer 3: Emergent Metric Geometry)
6. `Idris2-Physics` / `Idris2-Physics-Wiki` (Layer 3b/6: Physical Conservation Laws)
7. `Idris2-Hadron` / `Idris2-Hadron-Wiki` (Layer 4b: Standard Model Confinement)
8. `Idris2-Chemistry` / `Idris2-Chemistry-Wiki` (Layer 5b: Molecular Kinetics)
9. `Idris2-Biology` / `Idris2-Biology-Wiki` (Layer 6: Biological Hierarchies & Active Inference)
10. `Idris2-Universe` / `Idris2-Universe-Wiki` (Layer 10: Cosmic Motive & Master Audit)
