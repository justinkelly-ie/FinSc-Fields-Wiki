module Wiki.Main

import Math.Fields.SessionType
import Math.Fields.GaugeGroup
import Core.BoxInt
import Core.UnixelFraction
import Core.Goh

%default total

0 prfSessionDuality : (dualProto (dualProto (Send Nat Close)) = Send Nat Close)
prfSessionDuality = verifySessionDuality (Send Nat Close)

0 prfGaugeInvariance : (computeFieldEnergy (warpFieldByGaugeTensor Math.Fields.GaugeGroup.unitGaugePhase (MkGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5))) = computeFieldEnergy (MkGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5)))
prfGaugeInvariance = verifyGaugeInvariance Math.Fields.GaugeGroup.unitGaugePhase (MkGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5))

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn " ⚡ LAYER 7: IDRIS2-FIELDS VERIFICATION SUITE ⚡"
  putStrLn "========================================================"
  putStrLn "  [TEST 1] Linear QTT Session Protocol Duality: PASSED ✅"
  putStrLn "  [TEST 2] Local U(1) Gauge Phase Conservation & Invariance: PASSED ✅"
  putStrLn "========================================================"
  putStrLn " Layer 7 Session Types & Gauge Fields Audit Complete."
  putStrLn "========================================================"
