module Wiki.Main

import Stage0.Fields.SessionType
import Stage1.Fields.GaugeGroup
import Stage0.BoxInt
import Stage1.UnixelFraction
import Stage1.Goh
import Wiki.GaugeInvarianceSpec
import Wiki.GaugeSessionTypeSpec
import Wiki.FieldsScaleTransformSpec
import Wiki.GaugeFieldStreamSpec
import Reflect.GaugeAuditor
import Language.Reflection

%default total

||| Compile-time macro invariant witnesses (Rule 01)
0 prfAuditPlaquetteFluxClosure : Reflect.GaugeAuditor.auditPlaquetteFluxClosureProof = True
prfAuditPlaquetteFluxClosure = auditPlaquetteFluxClosure

0 prfAuditBianchiIdentityBalance : Reflect.GaugeAuditor.auditBianchiIdentityBalanceProof = True
prfAuditBianchiIdentityBalance = auditBianchiIdentityBalance

0 prfAuditPureGaugeZeroCurvature : Reflect.GaugeAuditor.auditPureGaugeZeroCurvatureProof = True
prfAuditPureGaugeZeroCurvature = auditPureGaugeZeroCurvature

0 prfSessionDuality : (dualProto (dualProto (Send Nat Close)) = Send Nat Close)
prfSessionDuality = verifySessionDuality (Send Nat Close)

0 prfGaugeInvariance : (computeFieldEnergy (warpFieldByGaugeTensor Stage1.Fields.GaugeGroup.unitGaugePhase (makeGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5))) = computeFieldEnergy (makeGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5)))
prfGaugeInvariance = verifyGaugeInvariance Stage1.Fields.GaugeGroup.unitGaugePhase (makeGaugeFieldTensor (intToBoxInt 10) (intToBoxInt 5))

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn " ⚡ LAYER 7: IDRIS2-FIELDS VERIFICATION SUITE ⚡"
  putStrLn "========================================================"
  putStrLn "  [COMPILE-TIME MACRO AUDITS (Rule 01)]:"
  putStrLn "   - Plaquette Closed Flux Closure: INJECTED & VALID (Refl) ✅"
  putStrLn "   - Bianchi Identity Flux Balance: INJECTED & VALID (Refl) ✅"
  putStrLn "   - Pure Gauge Zero Curvature: INJECTED & VALID (Refl) ✅"
  putStrLn ""
  putStrLn "  [TEST 1] Linear QTT Session Protocol Duality: PASSED ✅"
  putStrLn "  [TEST 2] Local U(1) Gauge Phase Conservation & Invariance: PASSED ✅"
  
  putStrLn "--------------------------------------------------------"
  putStrLn " ⚡ IDRIS2-QUICKCHECK GENERATIVE PROPERTY SUITES ⚡"
  putStrLn "--------------------------------------------------------"
  
  okInvariance <- auditGaugeInvarianceSpecProof
  if okInvariance
     then putStrLn "  [TEST 3] Gauge Group Identity & Field Energy Invariance (QuickCheck): PASSED ✅"
     else putStrLn "  [TEST 3] Gauge Group Identity & Field Energy Invariance (QuickCheck): FAILED ❌"
     
  okSession <- auditGaugeSessionTypeSpecProof
  if okSession
     then putStrLn "  [TEST 4] Session Protocol Duality Involution (QuickCheck): PASSED ✅"
     else putStrLn "  [TEST 4] Session Protocol Duality Involution (QuickCheck): FAILED ❌"
     
  okScale <- auditFieldsScaleTransformSpecProof
  if okScale
     then putStrLn "  [TEST 5] Fields ScaleTransform & Gauge Action Associativity (QuickCheck): PASSED ✅"
     else putStrLn "  [TEST 5] Fields ScaleTransform & Gauge Action Associativity (QuickCheck): FAILED ❌"

  okStream <- auditGaugeFieldStreamSpecProof
  if okStream
     then putStrLn "  [TEST 6] Gauge Field Tensor Stream Flux Integration: PASSED ✅"
     else putStrLn "  [TEST 6] Gauge Field Tensor Stream Flux Integration: FAILED ❌"

  putStrLn "========================================================"
  if okInvariance && okSession && okScale && okStream
     then putStrLn " ✨ ALL LAYER 7 GAUGE FIELD SUITES & QUICKCHECK PASSED ✨"
     else putStrLn " ❌ LAYER 7 GAUGE FIELD VERIFICATION FAILED"
  putStrLn "========================================================"

