module Wiki.Generators

import public QuickCheck
import Core.BoxInt
import Core.VexelMaxel
import Core.UnixelFraction
import Math.Fields.SessionType
import Math.Fields.GaugeGroup

%default total

public export
Arbitrary BoxInt where
  arbitrary = map (intToBoxInt . cast) (the (Gen Int) arbitrary)
  coarbitrary (MkBoxInt v) gen = coarbitrary (the Integer v) gen

public export
Arbitrary UnixelFraction where
  arbitrary = do
    n <- arbitrary {a = Int}
    d <- arbitrary {a = Nat}
    let d' = if d == 0 then 1 else d
    pure (mkUnixelFraction (intToBoxInt (cast n)) d')
  coarbitrary (MkUnixelFraction (MkBoxInt n) (MkUnixel d)) gen =
    coarbitrary (the Integer n) (coarbitrary (the Nat d) gen)

public export
Arbitrary GaugePhase where
  arbitrary = map MkGaugePhase arbitrary
  coarbitrary (MkGaugePhase p) gen = coarbitrary p gen

public export
Arbitrary Maxel where
  arbitrary = do
    e <- arbitrary
    b <- arbitrary
    pure (makeGaugeFieldTensor e b)
  coarbitrary m gen = coarbitrary (electricField m) (coarbitrary (magneticFlux m) gen)
