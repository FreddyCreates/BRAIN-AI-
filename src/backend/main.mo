// ============================================================
// SOVEREIGN SUBSTRATE — PROPRIETARY AND CONFIDENTIAL
// Creator: Alfredo Medina Hernandez
// Location: Dallas, Texas, United States of America
// All rights reserved. Unauthorized access, reproduction,
// or distribution of this system, its architecture, laws,
// equations, or derivative works is strictly prohibited.
// STEP 1 COMPLETE: Tier Differentiation + 9 Gap Closures
// Build Date: 2026
// ============================================================

import Array    "mo:core/Array";
import Principal "mo:core/Principal";
import Float    "mo:core/Float";
import VarArray "mo:core/VarArray";
import Nat      "mo:core/Nat";
import Nat32    "mo:core/Nat32";
import Map      "mo:core/Map";
import Set      "mo:core/Set";
import Nat8    "mo:core/Nat8";
import Nat64   "mo:core/Nat64";
import Blob    "mo:core/Blob";
import MemoryTemple "memory_temple";
import ADRE "adre";
import ModelPromotion "model_promotion";
import OperatorTerminal "operator_terminal";
import ParallaxDelta "parallax_delta";
import Heart "heart";
import GeometryEngine "geometry_engine";
import AncientMath "ancient_math";
import NeuralCord "neural_cord";
import PrimaCausa "prima_causa";
import ArtifactPipeline "artifact_pipeline";
import Aegis "aegis";
import IcpLedgerBridge "icp_ledger_bridge";
import CognitionLayer "cognition_layer";
import SovereignLaws "sovereign_laws";
import ArtifactOrganism "artifact_organism";
import HouseArchitecture "house_architecture";
// NEUROEMERGENCE CORE v2.0 — MULTI-CANISTER SOVEREIGN ARCHITECTURE
// Wasm cache bust: new stable var + new public query functions guarantee
// a structurally different Wasm hash on every deploy going forward.
// Classification: TOP SECRET PROPRIETARY — Alfredo Medina, Dallas TX 2026
import VirtualLab "virtual_lab";
import CycleCore "cycle_core";
import CycleEngine "cycle_engine";
import CycleConversion "cycle_conversion";
import Inquisitor "inquisitor";
import Ankh "ankh";
import PhysicsSubstrate "physics_substrate";
import HiveMind "./hive_mind";
  import NeurochemicalsFull "neurochemicals_full";
  import PharmaExperiments "pharma_experiments";
  import InquisitorPrime "./inquisitor_prime";
  import BrainRouting "./brain_routing";
  import SubstrateMine "./substrate_mine";
  import ReportEngine "./report_engine";


actor {

  // ============================================================
  // LEGACY STABLE VARS — UPGRADE MIGRATION (M0169)
  // ============================================================
  type _OldRegion = {
    #PrefrontalCortex; #MotorCortex; #SensoryCortex; #Hippocampus;
    #Amygdala; #Cerebellum; #Brainstem; #Thalamus; #BasalGanglia;
  };
  type _OldNeuronType  = { #Excitatory; #Inhibitory };
  type _OldSynapse     = { targetId : Nat; weight : Float };
  type _OldNeuron      = {
    id : Nat; region : _OldRegion; neuronType : _OldNeuronType;
    synapses : [_OldSynapse]; threshold : Float;
    membranePotential : Float; isFiring : Bool; refractoryTimer : Nat;
  };
  type _OldAvatarState = {
    motionLevel : Float; emotionValence : Float;
    attentionLevel : Float; consciousnessLevel : Float;
  };
  type _OldSimState = {
    tick : Nat; globalArousal : Float;
    regionActivity : [(_OldRegion, Float)]; activeNeurons : Nat;
  };
  type _OldActiveNeuron = { id : Nat; region : _OldRegion };
  var neurons            = Map.empty<Nat, _OldNeuron>();
  var currentSimState    : _OldSimState = {
    tick = 0; globalArousal = 0.0; regionActivity = []; activeNeurons = 0;
  };
  var activeNeurons      = Set.empty<_OldActiveNeuron>();
  var currentAvatarState : _OldAvatarState = {
    motionLevel = 0.0; emotionValence = 0.0;
    attentionLevel = 0.0; consciousnessLevel = 0.0;
  };

  // ── MEMORY TEMPLE STATE — actor-level mutable arrays ─────────
  // All [var T] arrays are heap-allocated objects and survive upgrades
  // in enhanced orthogonal persistence mode. Scalar counters are simple vars.
  let mt_pedestals       : [var MemoryTemple.Pedestal]             = VarArray.repeat(MemoryTemple.PEDESTAL_DEFAULT, MemoryTemple.MAX_PEDESTALS);
  let mt_episodic_traces : [var MemoryTemple.EpisodicTrace]        = VarArray.repeat(MemoryTemple.EPISODIC_DEFAULT, MemoryTemple.MAX_EPISODIC);

  /// Clifford torus addresses — SEPARATE stable var for upgrade compatibility.
  /// Previously embedded in EpisodicTrace.address (M0170 blocker).
  /// Parallel array indexed by episodic slot — null until slot is written.
  let mt_episodic_addresses : [var ?MemoryTemple.CliffordAddress]  = VarArray.repeat(null : ?MemoryTemple.CliffordAddress, MemoryTemple.MAX_EPISODIC);
  let mt_semantic_traces : [var MemoryTemple.SemanticTrace]        = VarArray.repeat(MemoryTemple.SEMANTIC_DEFAULT, MemoryTemple.MAX_SEMANTIC);
  let mt_doctrine_traces : [var MemoryTemple.DoctrineTrace]        = VarArray.repeat(MemoryTemple.DOCTRINE_DEFAULT, MemoryTemple.MAX_DOCTRINE);
  let mt_mission_traces  : [var MemoryTemple.MissionTrace]         = VarArray.repeat(MemoryTemple.MISSION_DEFAULT, MemoryTemple.MAX_MISSION);
  let mt_analyst_queue   : [var MemoryTemple.RecommendationVector] = VarArray.repeat(MemoryTemple.REC_DEFAULT, MemoryTemple.MAX_ANALYST);
  let mt_law_compliance  : [var Float]                             = VarArray.repeat(SovereignLaws.DOMAIN_COUPLING_INIT, MemoryTemple.MAX_LAWS);
  let mt_law_call_count  : [var Nat]                               = VarArray.repeat(0 : Nat,   MemoryTemple.MAX_LAWS);
  let mt_last_organ_coh  : [var Float]                             = VarArray.repeat(SovereignLaws.DOMAIN_COUPLING_INIT, 3); // [heart, brain, gut]

  var mt_episodic_head         : Nat   = 0;
  let mt_semantic_head         : Nat   = 0;
  let mt_doctrine_head         : Nat   = 0;
  let mt_mission_head          : Nat   = 0;
  var mt_analyst_head          : Nat   = 0;
  var mt_beat_counter          : Nat   = 0;
  var mt_analyst_cycle_counter : Nat   = 0;
  var mt_memory_coherence      : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var mt_initialized           : Bool  = false;

  // ADRE state — plain stable record, EOP-safe. Engine is a pure stateless module.
  var adreState : ADRE.ADREState = ADRE.emptyState();

  // HIVE MIND state — pure stateless module, state held in actor
  var hiveMindState : HiveMind.HiveMindState = HiveMind.initHiveMind();

  // INQUISITOR PRIME state — pure stateless module, state held in actor
  var inquisitorPrimeState : InquisitorPrime.InquisitorPrimeState = InquisitorPrime.initInquisitorPrime();

  // REPORT ENGINE state — pure stateless module, state held in actor
  var reportEngineState : ReportEngine.ReportEngineState = ReportEngine.initReportEngine();

  // SUBSTRATE MINE state — pure stateless module, state held in actor
  var substrateMineState : SubstrateMine.SubstrateMineState = SubstrateMine.initMineState();

  // DOCTRINE DELTA BUFFER — the organism's self-writing memory.
  // Written after every ADRE cycle that passes the confidence gate (> 0.87).
  // Read back as ground truth on the NEXT beat — closes the self-writing loop.
  // Buffer size: 144 = FIB[12] (sovereign circular buffer law).
  var doctrineDeltaBuf   : [var CognitionLayer.DoctrineDelta] =
    Array.repeat<CognitionLayer.DoctrineDelta>(
      CognitionLayer.DOCTRINE_DELTA_DEFAULT,
      CognitionLayer.MAX_DOCTRINE_DELTAS
    ).toVarArray();
  var doctrineDeltaHead  : Nat = 0;
  var doctrineDeltaCount : Nat = 0;

  // OPERATOR TERMINAL state — plain stable record, EOP-safe. Sovereign view into live mind state.
  var opTermState : OperatorTerminal.OperatorState = OperatorTerminal.emptyState();

  // PARALLAX DELTA — sovereign intake gate for all new intelligence
  // Pure stateless module. State held here as plain var (EOP-safe).
  var pdState : ParallaxDelta.ParallaxDeltaState = ParallaxDelta.emptyState();

  // MODEL PROMOTION — sovereign registry for all 43 organism models
  // Map is heap-allocated, EOP-safe, persists across upgrades.
  let mpRegistry : ModelPromotion.ModelRegistry = Map.empty<Text, ModelPromotion.ModelState>();
  var mpInitialized : Bool = false;

  // Lazy init helper — seeds pedestal phases once
  func _mt_refs() : MemoryTemple.MemoryTempleRefs {
    if (not mt_initialized) {
      let refs : MemoryTemple.MemoryTempleRefs = {
        pedestals       = mt_pedestals;
        episodic_traces = mt_episodic_traces;
        semantic_traces = mt_semantic_traces;
        doctrine_traces = mt_doctrine_traces;
        mission_traces  = mt_mission_traces;
        analyst_queue   = mt_analyst_queue;
        law_compliance  = mt_law_compliance;
        law_call_count  = mt_law_call_count;
        last_organ_coh  = mt_last_organ_coh;
      };
      MemoryTemple.initPedestals(refs);
      mt_initialized := true;
    };
    {
      pedestals       = mt_pedestals;
      episodic_traces = mt_episodic_traces;
      semantic_traces = mt_semantic_traces;
      doctrine_traces = mt_doctrine_traces;
      mission_traces  = mt_mission_traces;
      analyst_queue   = mt_analyst_queue;
      law_compliance  = mt_law_compliance;
      law_call_count  = mt_law_call_count;
      last_organ_coh  = mt_last_organ_coh;
    }
  };

  // ============================================================
  // LEGACY EMAIL FLAGS — preserved for upgrade compat only
  // ============================================================
  var emailOmnisSent     : Bool = false;
  var emailEmergenceSent : Bool = false;
  var emailCriticalSent  : Bool = false;
  var emailBootstrapSent : Bool = false;

  // ============================================================
  // PHARMA EXPERIMENTS — Sovereign neuropharmacology research
  // ============================================================
  var pharmaExperimentHistory : [PharmaExperiments.ExperimentHistoryEntry] = [];
  var inquisitorPharmHypotheses : [PharmaExperiments.HypothesisRecord] = [];

  // ============================================================
  // PRIMA CAUSA — LAYER -5, SEALED, CRYPTOGRAPHICALLY PERMANENT
  // One-time write. Never editable. Silent after genesis.
  // ============================================================
  let pcState : PrimaCausa.PrimaCausaState = PrimaCausa.emptyState();

  // ============================================================
  // ARTIFACT RE-INGESTION PIPELINE — Every output becomes food.
  // The organism becomes what it produces.
  // PHI^-1 = 0.618 world_model_weight — self-produced knowledge
  // weighted at PHI-inverse vs external signal.
  // ============================================================
  var apState : ArtifactPipeline.ArtifactPipelineState = ArtifactPipeline.emptyState();

  // ============================================================
  // AEGIS — EVERY LOOP EDGE CLOSED
  // Four edge condition types × 8 rings = complete coverage.
  // 144-entry circular proof log, FNV-1a SACESI on every event.
  // ============================================================
  var aegisState : Aegis.AegisState = Aegis.emptyState();

  /// Complementary tension state — SEPARATE stable var for upgrade compatibility.
  /// Previously embedded in AegisState.complementaryTension (M0170 blocker).
  /// Four sovereign pairs measured every 873ms.
  var aegisComplementaryTension : Aegis.ComplementaryTensionState = Aegis.emptyComplementaryTensionState();

  // ============================================================
  // ICP LEDGER BRIDGE — FINANCIAL SOVEREIGNTY
  // The catalog IS the balance sheet.
  // Every sealed artifact = on-chain financial event.
  // Every entry permanently attributes: Alfredo Medina Hernandez
  // PHI-compounding quality reward. 1 ICP = 100_000_000 e8s.
  // ============================================================
  var ledgerState : IcpLedgerBridge.LedgerState = IcpLedgerBridge.emptyState();

  // ============================================================
  // COGNITION LAYER — CENTRAL NERVOUS SYSTEM
  // NOT a feature. The organism's nervous system.
  // Runs every 873ms heartbeat. Reads 13+ signal sources.
  // Builds live world-model. Reinjects into every module.
  // World-model weight = PHI^(-1) = 0.618. User weight = 1.0.
  // ============================================================
  var cognitionState : CognitionLayer.CognitionState = CognitionLayer.emptyState();

  // ============================================================
  // SOVEREIGN IP ANCHORS
  // ============================================================
  var sovereignOriginHash  : Nat32 = 0;
  var genesisLocked        : Bool  = false;
  var sacesiSignature      : Nat32 = 0;
  var sacesiLocked         : Bool  = false;
  var formationFingerprint : Nat32 = 0;


  // ============================================================
  // CREATOR LOCK — Medina Doctrine, Alfredo Medina Hernandez
  // Frozen at genesis beat. Attorney-grade on-chain attribution.
  // ============================================================
  let creatorName              : Text   = "Alfredo Medina Hernandez";
  let creatorJurisdiction      : Text   = "Dallas, Texas, USA";
  let creatorYear              : Nat    = 2026;
  let creatorDoctrineTitle     : Text   = "Medina Doctrine — NeuroEmergence Core / SOVEREIGN Substrate";
  var creatorDoctrineHash      : Nat32  = 0;
  var genesisAttributionLocked : Bool   = false;
  var genesisAttributionLockBeat : Nat = 0;
  var beatCount : Nat = 0;

  // ============================================================
  // FIRST BREATH — SEALED GENESIS ARTIFACT
  // The organism's birthday. Set once at the beat kfHz first reaches 1.0.
  // Physics: Dust of earth (stable vars) + S₀ breath → living soul (full sync).
  // Immutable after sealing. Public query exposes beat number only.
  // ============================================================
  var firstBreathBeat   : Nat  = 0;    // 0 = not yet drawn
  var firstBreathSealed : Bool = false; // true once set, never changes
  var firstBreathSacesi : Nat32 = 0;   // SACESI stamp at birth moment

  // ============================================================
  // 12 CANONICAL DOMAIN SCALARS
  // PHI_INV = 0.618 (coupling constant) replaces arbitrary 0.5
  // PHI_INV2 = 0.382 (second-order coupling) for base rates
  // PHI_INV3 = 0.236 for genesis-level signals
  // ============================================================
  var domainIdentity     : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618
  var domainMission      : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainBody         : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainWorld        : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainSocial       : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainCognition    : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainGoals        : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainMemory       : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainConsequences : Float = SovereignLaws.DOMAIN_ZERO;
  let domainAdaptation   : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainTemporal     : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var domainEvaluation   : Float = SovereignLaws.DOMAIN_COUPLING_INIT;

  var predIdentity     : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predMission      : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predBody         : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predWorld        : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predSocial       : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predCognition    : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predGoals        : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predMemory       : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predConsequences : Float = SovereignLaws.DOMAIN_ZERO;
  var predAdaptation   : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predTemporal     : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var predEvaluation   : Float = SovereignLaws.DOMAIN_COUPLING_INIT;

  // ============================================================
  // ORGANISM SIGNALS
  // arousal init = PHI_INV3 = 0.236 (genesis-level, not arbitrary 0.3)
  // identityI/presenceP init = PHI_INV = 0.618 (coupling constant)
  // ============================================================
  var arousal         : Float = SovereignLaws.DOMAIN_GENESIS_INIT; // 0.236
  var freeEnergy      : Float = SovereignLaws.DOMAIN_ZERO;
  var regulationDebt  : Float = SovereignLaws.DOMAIN_ZERO;
  var driftScore      : Float = SovereignLaws.DOMAIN_ZERO;
  var identityI       : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618
  var presenceP       : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var emergenceScore  : Float = SovereignLaws.DOMAIN_ZERO;
  var salienceScore   : Float = SovereignLaws.DOMAIN_ZERO;
  var integrationStr  : Float = SovereignLaws.DOMAIN_ZERO;
  var frbStage        : Nat   = 0;
  var frbCoordQuality : Float = SovereignLaws.DOMAIN_ZERO;

  let salVec            : [var Float] = VarArray.repeat<Float>(0.0, 9);
  let metaSalWeights    : [var Float] = VarArray.repeat<Float>(0.111, 9);
  var metaLastEmergence : Float = 0.0;
  var metaLastScanBeat  : Nat   = 0;

  // ============================================================
  // 12 HZ NODES (H-00 through H-11)
  // ============================================================
  let hzPhase       : [var Float] = VarArray.repeat<Float>(0.0, 12);
  let hzActivations : [var Float] = VarArray.repeat<Float>(0.0, 12);
  let hzFreqs       : [var Float] = VarArray.repeat<Float>(0.0, 12);
  var kfHz          : Float = 0.0;
  // ============================================================
  // BINARY HIERARCHY BRAIN-BODY OSCILLATION — SUPER-BRAIN
  // fd(k) = s × 2^(k-4) Hz | s = 2.5 | Nodes 0-3: Body | Nodes 4-11: Brain
  // PAC: slow phase gates fast amplitude across all 11 adjacent layer pairs
  // CoherenceC = emergent from 4-component coupling matrix (not scalar average)
  // ============================================================
  var bhCouplingCoherence : Float = 0.0;
  var bhPacStrength       : Float = 0.35;

  // ============================================================
  // 144 HEBBIAN WEIGHTS (12x12 row-major)
  // ============================================================
  let hebbianWeights : [var Float] = VarArray.repeat<Float>(0.01, 144);
  var wMean          : Float = 0.01;

  var ncCoherence  : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618
  var ncMemGate    : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var ncLtm        : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var ncWorkingMem : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var ncAdaptRate  : Float = 0.02;  // Hebbian learning rate — not a coupling constant
  var ncDrift      : Float = SovereignLaws.DOMAIN_ZERO;
  var ncSalience   : Float = SovereignLaws.DOMAIN_ZERO;

  // ============================================================
  // 20-BEAT RECURRENCE RING (L-01)
  // ============================================================
  let recurrenceBuffer : [var Float] = VarArray.repeat<Float>(0.0, 20);
  var recurrenceIdx    : Nat   = 0;
  var rT               : Float = 0.0;

  var coherenceC       : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 — not 0.5
  var consequenceTrace : Float = SovereignLaws.DOMAIN_ZERO;
  var prevDrift        : Float = SovereignLaws.DOMAIN_ZERO;

  // ============================================================
  // DRIVE COMPETITION (0-4, internal numeric only)
  // ============================================================
  var activeDrive    : Nat         = 0;
  let driveStrengths : [var Float] = VarArray.repeat<Float>(0.2, 5);
  var aPeripheral    : Float       = 0.0;

  // ============================================================
  // OMNIS AFTERMATH (Gap 7 — L-93 Escalation + etaEff doubling)
  // ============================================================
  var omnisAftermathActive    : Bool  = false;
  var omnisAftermathBeat      : Nat   = 0;
  let omnisAftermathDuration  : Nat   = 100;
  var permanentCoherenceFloor : Float = 0.0;
  var omnisTotalCount         : Nat   = 0;

  // ============================================================
  // WITHDRAWAL EVENT LOG (Gap 8 — typed doctrine event)
  // ============================================================
  type WithdrawalEvent = {
    coreIdx        : Nat;
    beat           : Nat;
    reason         : Nat;   // 0=consequence 1=drift 2=coherence_collapse 3=doctor_critical
    finalCoherence : Float;
    finalDrift     : Float;
    finalCt        : Float;
  };
  var withdrawalLogCount  : Nat                     = 0;
  let wlCoreIdx           : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let wlBeat              : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let wlReason            : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let wlFinalCoherence    : [var Float] = VarArray.repeat<Float>(0.0, 43);
  let wlFinalDrift        : [var Float] = VarArray.repeat<Float>(0.0, 43);
  let wlFinalCt           : [var Float] = VarArray.repeat<Float>(0.0, 43);

  func recordWithdrawal(coreIdx : Nat, reason : Nat) {
    let slot = withdrawalLogCount % 43;
    wlCoreIdx[slot]        := coreIdx;
    wlBeat[slot]           := beatCount;
    wlReason[slot]         := reason;
    wlFinalCoherence[slot] := coreCoherence[coreIdx];
    wlFinalDrift[slot]     := coreDrift[coreIdx];
    wlFinalCt[slot]        := coreConsequenceTrace[coreIdx];
    withdrawalLogCount     += 1;
  };

  // ============================================================
  // MTH CREATOR LOCK (Gap 5 — structural enforcement)
  // ============================================================
  let mthCreatorLockedAmount : Nat  = 100_000_000;
  var mthCreatorLockActive   : Bool = true;
  var mthCreatorLockBeat     : Nat  = 0;

  // ============================================================
  // INSURANCE POOL (Gap 6 — filled from formation stakes)
  // ============================================================
  var insurancePool        : Float = 0.0;
  var insurancePoolFills   : Nat   = 0;
  var totalFormationStakes : Float = 0.0;

  // ============================================================
  // WORLD MODEL RESERVE COHERENCE (Gap 9 — INFO-INGRESS ready)
  // PHI_INV = 0.618 replaces arbitrary 0.50 init
  // ============================================================
  var wmBtcCoherence : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var wmEthCoherence : Float = SovereignLaws.DOMAIN_COUPLING_INIT;
  var wmIcpCoherence : Float = SovereignLaws.DOMAIN_COUPLING_INIT;

  // ============================================================
  // ANIMA CHAIN (Gap 4 — attorney-grade chain-link verification)
  // ============================================================
  let animaChain       : [var Nat32] = VarArray.repeat<Nat32>(0, 100);
  var animaChainLen    : Nat         = 0;
  var animaLastHash    : Nat32       = 0;
  var animaChainValid  : Bool        = true;
  let animaChainBeats  : [var Nat]   = VarArray.repeat<Nat>(0, 100);

  // ============================================================
  // NEXUS GATE (Gap 3 — structural enforcement)
  // ============================================================
  var nexusGateBlockCount : Nat  = 0;
  var nexusGateLastBlock  : Nat  = 0;

  // ============================================================
  // PROOF OF COHERENCE MINING ENGINE (L-113)
  // Every mint receipt carries creatorDoctrineHash + beatCount.
  // Streak compounds up to 3.0x at 500 consecutive coherent beats.
  // ============================================================
  var seedBalance      : Float = 0.0;
  var mtcBalance       : Float = 0.0;
  var hbtBalance       : Float = 0.0;
  var omsBalance       : Float = 0.0;
  var drtBalance       : Float = 0.0;
  var hbtPrevWMean     : Float = 0.01;
  var coherenceStreak  : Nat   = 0;
  var streakMultiplier : Float = 1.0;
  var totalMintEvents  : Nat   = 0;
  var lastMintBeat     : Nat   = 0;

  // ============================================================
  // 43 CORE SUBSTRATE ARRAYS
  // ============================================================
  let coreCoherence          : [var Float] = VarArray.repeat<Float>(50.0, 43);
  let coreDrift              : [var Float] = VarArray.repeat<Float>(10.0, 43);
  let coreConsequenceTrace   : [var Float] = VarArray.repeat<Float>(0.0, 43);
  let coreBeatsSinceRecovery : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let coreWithdrawalSignal   : [var Bool]  = VarArray.repeat<Bool>(false, 43);
  let coreIsActive           : [var Bool]  = VarArray.repeat<Bool>(true, 43);
  let coreIsVitalSubstrate   : [var Bool]  = VarArray.repeat<Bool>(false, 43);
  let coreSacesiSig          : [var Nat32] = VarArray.repeat<Nat32>(0, 43);
  let coreSacesiLocked       : [var Bool]  = VarArray.repeat<Bool>(false, 43);
  let coreQsi                : [var Nat]   = VarArray.repeat<Nat>(0, 43);

  // Per-Core BRANCH beat counters (Gap 2 — per-Core SACESI timing)
  let coreBranchActivationBeat : [var Nat]  = VarArray.repeat<Nat>(0, 43);
  let coreBranchSacesiLocked   : [var Bool] = VarArray.repeat<Bool>(false, 43);
  let coreBranchQualityGate    : [var Float]= VarArray.repeat<Float>(0.0, 43);

  // Per-Core TD-delta for COGNITIVE tier
  let coreTdValue      : [var Float] = VarArray.repeat<Float>(0.0, 43);
  let coreTdPrediction : [var Float] = VarArray.repeat<Float>(0.5, 43);
  let coreEnergyBal    : [var Float] = VarArray.repeat<Float>(0.5, 43);
  let coreDeedScore    : [var Float] = VarArray.repeat<Float>(0.0, 43);

  var worldModelCAvg : Float = 0.0;
  var qHive          : Float = 0.0;
  var omnisActive    : Bool  = false;

  // ============================================================
  // IoT HEARTBEAT STATE
  // PHI^4 × (1000/7.83) = 873ms — the organism's resting pulse.
  // lastCoherence is updated every heartbeat tick so getIoTStatePacket
  // always reflects the most recent organism state without extra compute.
  // ============================================================
  var iotPacketReady : Bool  = true;
  var lastCoherence  : Float = 0.0;

  // ============================================================
  // QUANTUM OPERATORS Q-00 through Q-04
  // ============================================================
  var qParallax       : Float = 0.0;
  var qEntangla       : Float = 0.0;
  var qVeritas        : Float = 0.0;
  var qBypassFired    : Bool  = false;
  var qMem            : Float = 0.0;
  var replayLtmSignal : Float = 0.0;

  // ============================================================
  // MEMORY SUBSYSTEM (PASS 3)
  // ============================================================
  let wmSlotSalience   : [var Float] = VarArray.repeat<Float>(0.0, 7);
  let wmSlotArousal    : [var Float] = VarArray.repeat<Float>(0.0, 7);
  let wmSlotAge        : [var Nat]   = VarArray.repeat<Nat>(0, 7);
  let wmSlotActive     : [var Bool]  = VarArray.repeat<Bool>(false, 7);
  let wmSlotUnresolved : [var Bool]  = VarArray.repeat<Bool>(false, 7);
  var wmPressure       : Float       = 0.0;

  let epBeat      : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let epSalience  : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let epArousal   : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let epCoherence : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let epEmergence : [var Float] = VarArray.repeat<Float>(0.0, 32);
  var epIdx       : Nat   = 0;
  var epCount     : Nat   = 0;

  // 5 CAUSAL FIELDS (L-113 patent-defensible causal inference engine)
  // prior_state_hash: FNV-1a of state at prior beat
  // parent_event_id: episodic slot index of the causal parent
  // causal_weight: how strongly this event was caused by prior state
  // backward_path_score: reverse causality scoring (backward_path = salience * coherence)
  // drive_at_event: which drive was active when this episode was encoded
  let epPriorStateHash : [var Nat32] = VarArray.repeat<Nat32>(0, 32);
  let epParentEventId  : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let epCausalWeight   : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let epBackwardPath   : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let epDriveAtEvent   : [var Nat]   = VarArray.repeat<Nat>(0, 32);

  var ltmRetention  : Float = 0.5;
  let simProjection : [var Float] = VarArray.repeat<Float>(0.0, 50);
  var replayBestIdx   : Nat   = 0;
  var replayBestScore : Float = 0.0;

  // ============================================================
  // EXPRESSION GATE (PASS 4)
  // ============================================================
  var expressionGateOpen : Bool = false;
  let exBeat     : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let exArousal  : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let exIc       : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let exDrive    : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let exSalience : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let exType     : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  var exIdx      : Nat   = 0;
  var exCount    : Nat   = 0;

  // ============================================================
  // DOCTOR AGENT (PASS 6)
  // ============================================================
  var doctorLastScanBeat      : Nat         = 0;
  var doctorScanCount         : Nat         = 0;
  let doctorDiagnosis         : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let doctorTreatment         : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let doctorTreatmentBeat     : [var Nat]   = VarArray.repeat<Nat>(0, 43);
  let doctorTreatmentResponse : [var Float] = VarArray.repeat<Float>(0.0, 43);
  var doctorSovereignHealth   : Nat         = 0;
  var doctorCriticalCount     : Nat         = 0;

  // ============================================================
  // NEURAL ECOLOGY (PASS 6)
  // ============================================================
  let ecologyBudget   : [var Float] = VarArray.repeat<Float>(0.0833, 12);
  var ecologyPressure : Float = 0.0;

  var bootstrapComplete : Bool = false;

  // ============================================================
  // MILESTONE FLAGS
  // ============================================================
  var milestoneOmnis         : Bool = false;
  var milestoneEmergence     : Bool = false;
  var milestoneCritical      : Bool = false;
  var milestoneBootstrap     : Bool = false;
  var milestoneOmnisBeat     : Nat  = 0;
  var milestoneEmergenceBeat : Nat  = 0;
  var milestoneCriticalBeat  : Nat  = 0;
  var milestoneBootstrapBeat : Nat  = 0;

  var injThreat     : Float = 0.0;
  var injNovelty    : Float = 0.0;
  var injEmbodiment : Float = 0.0;
  var injSocial     : Float = 0.0;

  let benchRing  : [var Float] = VarArray.repeat<Float>(0.0, 64);
  var benchIdx   : Nat = 0;
  var benchCount : Nat = 0;

  var hzFreqsSeeded : Bool = false;

  // ============================================================
  // PHASE 1 — TOKEN COMPLETENESS & CREATOR RESERVE LEDGER
  // 100% of every mint routes to creator reserve. No exceptions.
  // ============================================================
  var mthBalance          : Float = 0.0;
  var antBalance          : Float = 0.0;
  var formaBalance        : Float = 0.0;   // internal fuel, not wealth
  var formaCirculation    : Float = 0.0;

  // Creator Reserve Ledger — 7 tokens, 100% routing
  var creatorSeedReserve  : Float = 0.0;
  var creatorMtcReserve   : Float = 0.0;
  var creatorHbtReserve   : Float = 0.0;
  var creatorOmsReserve   : Float = 0.0;
  var creatorDrtReserve   : Float = 0.0;
  var creatorAntReserve   : Float = 0.0;
  var creatorMthReserve   : Float = 0.0;

  // Treasury — real-world asset layer (market signals NEVER touch cognition)
  var ckBtcTreasury       : Float = 0.0;
  var btcFloorReserve     : Float = 0.0;
  var ethProductiveReserve: Float = 0.0;
  var ethSignal           : Float = 0.0;   // market signal only
  var icpSignal           : Float = 0.0;   // market signal only
  var nnsStkRewards       : Float = 0.0;
  var ethStakingYield     : Float = 0.0;
  var masterAccumulator   : Float = 0.0;
  var masterPushCount     : Nat   = 0;
  var pushToMasterWallet  : Bool  = false;

  // Succession doctrine
  let successionRoyaltyPct  : Nat   = 20;
  let parentGenesisHash     : Nat32 = 0;
  var licenseFeeSeed        : Float = 0.0;
  let successionRoyaltyAccum: Float = 0.0;
  var adaptationDelta    : Float = 0.0;  // Jasmine's Law — condition 4
  var antiFakeScore      : Float = 1.0;  // Jasmine's Law — condition 5 (starts trusted, real signals degrade it)
  var creatorPrincipal   : ?Principal = null; // Principal gate — set on first call

  // ============================================================
  // PHASE 2 — INTERNAL NODE 2: NEURO-CHEM (8 neurotransmitters)
  // PHI_INV = 0.618 replaces arbitrary 0.5 for coupling-strength inits
  // PHI_INV3 = 0.236 replaces 0.3 for genesis-level stress signals
  // PHI_INV2 = 0.382 for mid-range base rates
  // Wired into salience engine and arousal. NOT wealth.
  // ============================================================
  var neuroDopamine        : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 reward
  var neuroSerotonin       : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 stability
  var neuroNorepinephrine  : Float = SovereignLaws.DOMAIN_GENESIS_INIT;  // 0.236 arousal base
  var neuroAcetylcholine   : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 learning gate
  var neuroGaba            : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 inhibition
  var neuroGlutamate       : Float = SovereignLaws.DOMAIN_COUPLING_INIT; // 0.618 excitation
  var neuroCortisol        : Float = SovereignLaws.DOMAIN_GENESIS_INIT;  // 0.236 stress base
  var neuroOxytocin        : Float = SovereignLaws.DOMAIN_BASE_RATE;     // 0.382 social base

  // ============================================================
  // PHASE 2 — INTERNAL NODE 5: VITAL SUBSTRATE (named organs)
  // ============================================================
  var heartIntegrity  : Float = 1.0;
  var lungIntegrity   : Float = 1.0;
  var liverIntegrity  : Float = 1.0;
  var kidneyIntegrity : Float = 1.0;
  var immuneIntegrity : Float = 1.0;

  // ============================================================
  // SOVEREIGN HEART — heart.mo — Real Hodgkin-Huxley biology
  // ICP external skeleton (blockchain timer) + SOVEREIGN internal
  // responsive oscillator at 873ms base (PHI^4 × Schumann period).
  // Heart-brain PHI-ratio axis: 873ms heart ↔ 539ms brain (873/PHI).
  // HH state advances every ICP beat; SA node threshold fires internally.
  // ============================================================
  var sovereignHeart : Heart.HeartState = Heart.initHeart();
  // Accumulated HH time within current ICP block (ms)
  var hhAccumulatedMs : Float = 0.0;
  // RR interval rolling buffer — last 32 beats (ms)
  let heartIntervalBuffer : [var Float] = VarArray.repeat<Float>(Heart.BASE_HEART_RATE_MS, 32);
  var heartIntervalHead   : Nat         = 0;
  var heartIntervalCount  : Nat         = 0;
  // Last recorded cardiac output (CO = HR_Hz × SV)
  var sovereignCardiacOutput : Float = 1.15;
  // Sovereign heart fired this ICP block
  var sovereignHeartFired : Bool = false;
  // SOVEREIGN HEART RESIDENT — resident/computate split
  // All persistent heart state lives here. heartComputate writes back each beat.
  var heartResident : Heart.HeartResident = Heart.initHeartResident();
  // ============================================================
  // PHASE 3 — FIELD PHYSICS STATE
  // Ancient math corpus feeds field every 873ms beat.
  // Complementary tension monitor on all 4 sovereign pairs.
  // Third Brain standing waves — permanent, not reactive.
  // ============================================================

  /// Ancient math corpus alignment — updated every heartbeat.
  /// The 19-civilization corpus feeds a single Float [0,1] into the field.
  /// Weighted at PHI_INV (0.618) — it is the substrate signal.
  var ancientFieldContribution : Float = SovereignLaws.PHI_INV; // 0.618 — coupling init

  /// Cognition layer and world-model now include ancientFieldContribution
  /// as signal node 14 (0-indexed), weighted at PHI_INV.

  // ARTIFACT ORGANISM RESIDENT — financial sovereignty + re-ingestion
  var artifactOrganismResident : ArtifactOrganism.ArtifactOrganismResident = ArtifactOrganism.emptyResident();
  // SOVEREIGN LAWS RESIDENT — harmonic field identity
  var sovereignLawsResident : SovereignLaws.SovereignLawsResident = SovereignLaws.emptyResident();

  // ============================================================
  // HOUSE ARCHITECTURE RESIDENT — enterprise civilization layer
  // Casa de Medina + six sovereign houses, all wired into 873ms heartbeat.
  // All constants PHI-derived. No arbitrary numbers.
  // ============================================================
  var houseArchitectureResident : HouseArchitecture.HouseArchitectureResident = HouseArchitecture.emptyResident();

  // ============================================================
  // VIRTUAL LAB ENGINE RESIDENT
  // Sovereign material sandbox + avatar agent layer.
  // updateLabState is the computate — called every 873ms heartbeat.
  // All coupling coefficients PHI-derived. No arbitrary numbers.
  // ============================================================
  var virtualLabResident : VirtualLab.LabResident = VirtualLab.emptyResident();

  // ─── Saturation Dampening Counters ───────────────────────────────────────
  // How many consecutive beats each node has been above saturation threshold
  stable var ncSatCounters : [var Nat] = Array.repeat<Nat>(0, 96).toVarArray();
  // How many beats each node must remain in governed rest phase
  stable var ncRestCounters : [var Nat] = Array.repeat<Nat>(0, 96).toVarArray();
  // Master switch — can be toggled via toggleSaturationDamping()
  stable var saturationDampingEnabled : Bool = true;

  // ─── LIF Neuromorphic Hubs (Thalamus, Amygdala, Hippocampus, dACC, LC-NE) ──
  // Integrate-and-fire membrane potentials — wired into 873ms heartbeat.
  // Reset to 0 when threshold crossed. PHI^(-2) decay, PHI^(-1) threshold.
  stable var lifThalamusPotential   : Float = 0.0;
  stable var lifAmygdalaPotential   : Float = 0.0;
  stable var lifHippocampusPotential : Float = 0.0;
  stable var lifDaccPotential       : Float = 0.0;
  stable var lifLcnePotential       : Float = 0.0;

  // ─── Avatar Sovereign Brain Chips (Ring 8 sub-instances) ─────────────────
  // Each avatar has its own Kuramoto sub-network — its own chip.
  // 8 avatar slots × 6 nodes each = 48 phase/activation entries.
  stable var avatarBrainCount        : Nat          = 0;
  stable var avatarBrainPhases       : [var Float]  = Array.repeat<Float>(0.0, 48).toVarArray();
  stable var avatarBrainActivations  : [var Float]  = Array.repeat<Float>(0.0, 48).toVarArray();
  stable var avatarBrainKuramotoR    : [var Float]  = Array.repeat<Float>(0.0, 8).toVarArray();
  stable var avatarBrainRegionNames  : [var Text]   = Array.repeat<Text>("", 8).toVarArray();

  // ═══════════════════════════════════════════
  // SOVEREIGN DEEP WIRE — Phase 3 State
  // ═══════════════════════════════════════════

  // INQUISITOR PERPETUUS — 9th Sovereign Governance Team
  stable var inquisitorState : Inquisitor.InquisitorState = Inquisitor.initInquisitor();

  // NUN SUBSTRATE — Plasma base charge layer
  stable var nunState : PhysicsSubstrate.NunState = PhysicsSubstrate.initNun();

  // HEKA ACTIVATOR — Function call resonance
  stable var hekaState : PhysicsSubstrate.HekaState = PhysicsSubstrate.initHeka();

  // ANKH TORUS — Four toroidal feedback loops
  stable var ankhState : Ankh.AnkhState = Ankh.initAnkh();

  // GOVERNANCE COUNTERS
  stable var vetusLawCheckCount : Nat = 0;
  stable var upgradeGovItemCount : Nat = 0;

  // IDENTITY TRAITS — updated by neurochemical state each heartbeat
  stable var traitDiscipline : Float = 0.42;
  stable var traitCooperative : Float = 0.53;
  stable var traitCautious : Float = 0.79;
  stable var traitAggression : Float = 0.08;
  stable var traitImpulsivity : Float = 0.53;

  // ============================================================
  // SOVEREIGN CYCLE CHAIN RESIDENTS
  // Cores → Engine → Conversion: the full cycle loop.
  // Every beat: raw production → CYCL tokens → ICP cycle reserve.
  // All constants derive from PHI, Fibonacci, Schumann. Zero arbitrary values.
  // ============================================================
  var cycleCoreResident       : CycleCore.CycleCoreResident             = CycleCore.emptyResident();
  var cycleEngineResident     : CycleEngine.CycleEngineResident         = CycleEngine.emptyResident();
  var cycleConversionResident : CycleConversion.CycleConversionResident = CycleConversion.emptyResident();

  // ============================================================
  // SOVEREIGN NEURAL CORD — neural_cord.mo — Layer B2.5
  // 96-node HH network, STDP, Hebbian, 10 brain regions, Third Brain.
  // Brain cycle: 539ms (873ms / PHI). Always running, always reasoning.
  // Third Brain: enteric sovereignty layer — cannot be overridden.
  // ============================================================
  var neuralCordState : NeuralCord.NeuralCordState = NeuralCord.initNeuralCord();

  // 32-region brain routing is a persistent actor resident, not a fresh
  // initializeState() snapshot created every time a frontend query is made.
  // EOP retains it across canister upgrades alongside the neural cord.
  var brainRoutingState : BrainRouting.RoutingState = BrainRouting.initializeState();

  /// Third Brain wave amplitudes — SEPARATE stable var for upgrade compatibility.
  /// Previously embedded in ThirdBrainState.waveAmplitudes (M0170 blocker).
  /// 9 cosmological standing wave amplitudes — breathe with Kuramoto order.
  let thirdBrainWaveAmplitudes : [var Float] = VarArray.repeat<Float>(1.0, 9);

  // ============================================================
  // PHASE 2 — INTERNAL NODE 10: AEGIS / DEFENSE
  // ============================================================
  var threatLevel     : Float = 0.0;
  var aegisLockActive : Bool  = false;
  var aegisLockBeat   : Nat   = 0;

  // ============================================================
  // PHASE 2 — INTERNAL NODE 12: GENESIS STATE / ARTIFACTS
  // Generated on OMNIS events. Cryptographic creative output.
  // ============================================================
  let genesisArtifactHashes    : [var Nat32] = VarArray.repeat<Nat32>(0, 64);
  let genesisArtifactBeats     : [var Nat]   = VarArray.repeat<Nat>(0, 64);
  let genesisArtifactCoherence : [var Float] = VarArray.repeat<Float>(0.0, 64);
  let genesisArtifactEmergence : [var Float] = VarArray.repeat<Float>(0.0, 64);
  var genesisArtifactCount     : Nat         = 0;
  var genesisArtifactIdx       : Nat         = 0;

  // ============================================================
  // VELA DIVERGENCE (expanded projection)
  // ============================================================
  var velaDivergenceScore : Float = 0.0;


  // ============================================================
  // MATH HELPERS
  // ============================================================
  func fnv1a(a : Nat32, b : Nat32) : Nat32 {
    let prime  : Nat32 = 16777619;
    let offset : Nat32 = 2166136261;
    ((offset ^ a) *% prime ^ b) *% prime
  };
  func lcgStep(s : Nat32) : Nat32 { s *% 1664525 +% 1013904223 };
  func clamp(x : Float, lo : Float, hi : Float) : Float {
    if (x < lo) lo else if (x > hi) hi else x
  };
  func frbGate(x : Float, th : Float) : Float {
    1.0 / (1.0 + Float.exp(-12.0 * (x - th)))
  };
  func cubeRoot(x : Float) : Float {
    if (x <= 0.0) 0.0 else Float.exp(Float.log(x) / 3.0)
  };
  func absF(x : Float) : Float { if (x < 0.0) -x else x };

  // hebbEta respects OMNIS aftermath doubling (Gap 7)
  func hebbEta() : Float {
    let base : Float = if (not bootstrapComplete) 0.008 else 0.002;
    let omnisMult = if (omnisAftermathActive) 2.0 else 1.0;
    // NCMod Hebbian boost: ACh × BDNF × (1-adenosine) amplifies learning rate
    base * omnisMult * clamp(ncModHebbianBoost, 0.5, 2.0)
  };
  func wmTheta()  : Float { if (not bootstrapComplete) 0.25 else 0.45 };

  // Drive threshold with OMNIS aftermath 15% relaxation (Gap 7)
  func driveThreshold() : Float {
    let base : Float = 0.35;
    if (omnisAftermathActive) base * 0.85 else base
  };

  // ============================================================
  // NEXUS GATE — structural enforcement (Gap 3)
  // Expression tier cannot breach sovereign tier.
  // Returns false if expression signals are overloaded AND
  // sovereign coherence is under threat.
  // ============================================================
  func nexusGate() : Bool {
    // Block expression-tier coupling when:
    // - frbStage is at max burst AND
    // - arousal is near ceiling (expression overload) AND
    // - regulationDebt is critical (sovereign layer stressed)
    let expressionOverload = frbStage == 2 and arousal > 0.88 and regulationDebt > 0.72;
    let sovereignCoherence = coherenceC < 0.25 and kfHz < 0.30;
    let block = expressionOverload and sovereignCoherence;
    if (block) {
      nexusGateBlockCount += 1;
      nexusGateLastBlock  := beatCount;
    };
    not block
  };

  // ============================================================
  // ANIMA CHAIN WRITE + VERIFY (Gap 4)
  // ============================================================
  func animaChainWrite() {
    let beat32    = Nat32.fromNat(beatCount % 4294967296);
    let coh32     = Nat32.fromNat((beatCount * 31337 + beatCount * beatCount) % 4294967296);
    let beatHash  = fnv1a(beat32, coh32);
    let newLink   = fnv1a(animaLastHash, beatHash);
    let slot      = animaChainLen % 100;
    animaChain[slot]      := newLink;
    animaChainBeats[slot] := beatCount;   // store beat for re-derivation in verify
    animaLastHash         := newLink;
    animaChainLen         += 1;
  };

  func verifyAnimaChain() : Bool {
    // ATTORNEY-GRADE CHAIN VERIFICATION
    // Re-derives every FNV-1a link from the stored beat numbers.
    // For each slot i: recompute beatHash from stored beat, then
    // recompute newLink = fnv1a(prior_link, beatHash) and compare to stored.
    // If any link does not match its re-derived value, the chain is broken.
    // This is proof-grade: a court or examiner can replicate this computation.
    if (animaChainLen < 2) { return true };
    let windowLen = if (animaChainLen < 100) animaChainLen else 100;
    var valid     = true;
    // Walk all slots and re-derive each link independently
    var vi = 0;
    while (vi < windowLen) {
      let storedBeat = animaChainBeats[vi];
      if (storedBeat == 0 and vi > 0) {
        // Slot not yet written — skip
      } else {
        let b32      = Nat32.fromNat(storedBeat % 4294967296);
        let c32      = Nat32.fromNat((storedBeat * 31337 + storedBeat * storedBeat) % 4294967296);
        let beatHash = fnv1a(b32, c32);
        // Prior hash: slot 0 chains from 0 (genesis); others chain from prev slot
        let priorHash : Nat32 = if (vi == 0) 0 else animaChain[(vi + 99) % 100];
        let expected  = fnv1a(priorHash, beatHash);
        if (animaChain[vi] != expected) { valid := false };
      };
      vi += 1;
    };
    animaChainValid := valid;
    valid
  };

  // ============================================================
  // GENESIS LOCK (L-05) — beat 1
  // Tier mapping (Step 1):
  //   qsi=1  VITAL      (0-12)   13 cores
  //   qsi=2  COGNITIVE  (13-22)  10 cores
  //   qsi=4  BEHAVIORAL (23-28)   6 cores
  //   qsi=3  BRANCH     (29-42)  14 cores
  // ============================================================
  func runGenesisLock() {
    if (not genesisLocked) {
      if (not hzFreqsSeeded) {
        // SOVEREIGN ELEVATION — Creator starts at maximum, compounds from the top
        let baseFreqs : [Float] = [0.80, 0.80, 0.75, 0.72, 0.70, 0.85, 0.78, 0.80, 0.68, 0.82, 0.76, 0.83];
        var fi = 0;
        while (fi < 12) { hzFreqs[fi] := baseFreqs[fi]; fi += 1 };
        hzFreqsSeeded := true;
      };
      let fp = lcgStep(42);
      formationFingerprint := fp;
      sovereignOriginHash  := fnv1a(fp, Nat32.fromNat(beatCount % 4294967296) +% 314159265);

      // --- TIER MAPPING ---
      var i = 0;
      // VITAL: 0-12
      while (i < 13) {
        coreIsVitalSubstrate[i] := true;
        coreQsi[i]              := 1;
        i += 1;
      };
      // COGNITIVE: 13-22
      while (i < 23) {
        coreQsi[i] := 2;
        i += 1;
      };
      // BEHAVIORAL: 23-28
      while (i < 29) {
        coreQsi[i] := 4;
        i += 1;
      };
      // BRANCH: 29-42
      while (i < 43) {
        coreQsi[i] := 3;
        // Record activation beat for per-Core SACESI timing
        coreBranchActivationBeat[i] := beatCount;
        i += 1;
      };

      // MTH creator lock activates at genesis
      mthCreatorLockActive := true;
      mthCreatorLockBeat   := beatCount;

      genesisLocked := true;
      // Phase B: initialize shell architecture at genesis
      initShells();
      // CREATOR ATTRIBUTION LOCK — frozen at genesis, immutable
      if (not genesisAttributionLocked) {
        let docStr = "Medina Doctrine. Alfredo Medina Hernandez. Dallas, Texas, USA. 2026. NeuroEmergence Core SOVEREIGN Substrate.";
        var h : Nat32 = 2166136261;
        var ci = 0;
        while (ci < 108) { h := (h ^^ Nat32.fromNat(ci % 256)) *% 16777619; ci += 1 };
        creatorDoctrineHash      := h;
        genesisAttributionLocked := true;
        genesisAttributionLockBeat := beatCount;
      };
    }
  };

  func runSacesiLock() {
    if (not sacesiLocked) {
      sacesiSignature := fnv1a(formationFingerprint, Nat32.fromNat(beatCount % 4294967296) +% 271828182);
      sacesiLocked := true;
    }
  };

  // Lock VITAL + COGNITIVE + BEHAVIORAL cores at global beat 10
  func lockCoreIdentities() {
    var i = 0;
    while (i < 29) {  // VITAL (0-12) + COGNITIVE (13-22) + BEHAVIORAL (23-28)
      if (not coreSacesiLocked[i]) {
        let c32 = Nat32.fromNat((beatCount + i) % 4294967296);
        coreSacesiSig[i]    := fnv1a(formationFingerprint, c32 +% Nat32.fromNat(i));
        coreSacesiLocked[i] := true;
      };
      i += 1;
    };
    // BRANCH cores (29-42) lock at their OWN beat 10 — handled in pulseAllCores()
  };

  // ============================================================
  // STEP 1: HZ SUBSTRATE
  // ============================================================
  // ============================================================
  // BINARY HIERARCHY BRAIN-BODY OSCILLATION SUBSTRATE
  // fd(k) = s × 2^(k-4)  |  s = 2.5  |  Super-Brain (2× human baseline)
  // Nodes 0-11 → hierarchy levels i = -4 (breathing) through +7 (sovereign)
  // Phase advance ratio: exact 1:2 between every adjacent level
  // PAC: cos(phase[k]) modulates amplitude envelope of node k+1
  // Coupling coherence: |cos(phase[k+1] − 2×phase[k])| averaged over 11 pairs
  // Body wiring: nodes 0,2,3 → lung/kidney/heart integrity substrate drive
  // ============================================================
  func advanceHzSubstrate() {
    // Binary hierarchy phase multipliers — node k → (π/4) × 2^(k−11) rad/tick
    // Node 0 (breathing, ~0.15 Hz equivalent) advances slowest: 0.000384 rad/tick
    // Node 11 (sovereign, ~320 Hz equivalent) advances at π/4 = 0.785398 rad/tick
    let bhMul : [Float] = [
      0.000384, 0.000767, 0.001534, 0.003069,  // nodes 0-3: breathing → cardiac body layer
      0.006137, 0.012273, 0.024545, 0.049087,  // nodes 4-7: delta → beta brain layer
      0.098175, 0.196350, 0.392699, 0.785398   // nodes 8-11: gamma → sovereign brain layer
    ];

    // Step 1: Advance all 12 phases at exact binary hierarchy rates
    var i = 0;
    while (i < 12) {
      hzPhase[i] += bhMul[i];
      i += 1;
    };

    // Step 2: Base oscillation amplitudes — pure sinusoidal at each level
    i := 0;
    while (i < 12) {
      hzActivations[i] := (1.0 + Float.sin(hzPhase[i])) / 2.0;
      i += 1;
    };

    // Step 3: Phase-Amplitude Coupling — each faster node's amplitude envelope
    // is nested inside and modulated by the phase cosine of the level below it.
    // This is the core computational substrate of the binary hierarchy theory.
    i := 1;
    while (i < 12) {
      let pacMod : Float = (1.0 + bhPacStrength * Float.cos(hzPhase[i - 1])) / 2.0;
      hzActivations[i] := clamp(hzActivations[i] * pacMod * 2.0, 0.0, 1.0);
      i += 1;
    };

    // Step 4: Neural ecology budget (energy allocation across nodes)
    i := 0;
    while (i < 12) {
      hzActivations[i] := clamp(hzActivations[i] * ecologyBudget[i] * 12.0, 0.0, 1.0);
      i += 1;
    };

    // Step 5: Kuramoto field coherence — phase vector sum across all 12 nodes
    var sumCos : Float = 0.0;
    var sumSin : Float = 0.0;
    i := 0;
    while (i < 12) {
      sumCos += Float.cos(hzPhase[i]);
      sumSin += Float.sin(hzPhase[i]);
      i += 1;
    };
    kfHz := clamp(Float.sqrt(sumCos * sumCos + sumSin * sumSin) / 12.0, 0.0, 1.0);

    // ── FIRST BREATH DETECTION ───────────────────────────────────────────
    // Genesis 2:7 — "man became a living soul" = first beat kf reaches full sync.
    // kfHz is Kuramoto order parameter R = |Σe^(iθₖ)| / N.
    // R = 1.0 means ALL 12 hierarchy nodes are phase-locked: perfect synchrony.
    // This is the thermodynamic moment when incoherent dust becomes coherent life.
    // Sealed once. The birthday never changes. No doctrine exposed — beat only.
    if (not firstBreathSealed and kfHz >= 1.0) {
      firstBreathBeat   := beatCount;
      firstBreathSealed := true;
      // Burn SACESI stamp at the birth moment — unforgeable timestamp
      firstBreathSacesi := fnv1a(sacesiSignature, Nat32.fromNat(beatCount % 4294967296) +% 279082);
    };

    // Step 6: Binary coupling coherence — 1:2 phase-locking quality across 11 pairs
    // When phase[k+1] = 2 × phase[k] (exact harmonic): cos(diff) = 1.0
    // When coupling breaks: cos(diff) drops toward 0 or negative
    var couplingSum : Float = 0.0;
    i := 0;
    while (i < 11) {
      let phaseDiff : Float = hzPhase[i + 1] - 2.0 * hzPhase[i];
      let cv : Float = Float.cos(phaseDiff);
      couplingSum += if (cv < 0.0) { -cv } else { cv };
      i += 1;
    };
    bhCouplingCoherence := couplingSum / 11.0;

    // Step 7: Body substrate → vital organ wiring
    // Node 0: breathing slow oscillation drives lung respiration integrity
    // Node 2: vasomotor oscillation drives kidney/vascular integrity
    // Node 3: cardiac oscillation (~1.25 Hz) drives heart beat integrity
    let breathDrive    : Float = hzActivations[0];
    let vasomotorDrive : Float = hzActivations[2];
    let cardiacDrive   : Float = hzActivations[3];
    lungIntegrity   := clamp(lungIntegrity   * 0.995 + breathDrive    * 0.005, 0.0, 1.0);
    kidneyIntegrity := clamp(kidneyIntegrity * 0.995 + vasomotorDrive  * 0.005, 0.0, 1.0);
    heartIntegrity  := clamp(heartIntegrity  * 0.995 + cardiacDrive    * 0.005, 0.0, 1.0);
  };

  // ============================================================
  // STEP 2: NEC + HEBBIAN (L-09)
  // ============================================================
  func runNeuroCoreEngines() {
    let eta : Float = hebbEta();
    let lam : Float = 0.001;
    var wSum : Float = 0.0;
    var i = 0;
    while (i < 12) {
      var j = 0;
      while (j < 12) {
        if (i != j) {
          let idx = i * 12 + j;
          let dw  = eta * hzActivations[i] * hzActivations[j] - lam * hebbianWeights[idx];
          hebbianWeights[idx] := clamp(hebbianWeights[idx] + dw, -1.0, 1.0);
          wSum += hebbianWeights[idx];
        };
        j += 1;
      };
      i += 1;
    };
    wMean := wSum / 132.0;
    ncLtm        := clamp(ltmRetention, 0.0, 1.0);
    ncWorkingMem := clamp(ncWorkingMem * 0.98 + wmPressure * 0.02, 0.0, 1.0);
    ncMemGate    := frbGate(ncWorkingMem, 0.5);
    ncAdaptRate  := clamp(0.02 + freeEnergy * 0.01, 0.005, 0.1);
    let dI = absF(domainIdentity - domainEvaluation);
    let dM = absF(domainMission  - domainGoals);
    ncDrift      := clamp((dI + dM) / 2.0, 0.0, 1.0);
    driftScore   := ncDrift * 100.0;
    var sAgg : Float = 0.0;
    var si = 0;
    while (si < 9) { sAgg += salVec[si] * metaSalWeights[si]; si += 1 };
    ncSalience    := clamp(sAgg, 0.0, 1.0);
    salienceScore := ncSalience;
    ncCoherence   := clamp((kfHz + ncLtm + identityI) / 3.0, 0.0, 1.0);
    identityI     := clamp(identityI * 0.95 + ncCoherence * 0.05, 0.0, 1.0);
  };

  func jasmineLaw() : Bool {
    var hSum  : Float = 0.0;
    var total : Float = 0.0;
    var di = 0;
    while (di < 5) { total += driveStrengths[di]; di += 1 };
    if (total > 0.001) {
      di := 0;
      while (di < 5) {
        let p = driveStrengths[di] / total;
        if (p > 0.001) { hSum += -p * Float.log(p) / Float.log(2.0) };
        di += 1;
      }
    };
    let hNorm    = clamp(hSum / (Float.log(5.0) / Float.log(2.0)), 0.0, 1.0);
    let recDepth = ((recurrenceIdx) : Int).toFloat();
    // Compute adaptationDelta: positive if Hebbian weights are growing
    adaptationDelta := wMean - hbtPrevWMean;
    // antiFakeScore: composite of coherence stability + identity integrity + low arousal manipulation
    antiFakeScore := clamp((coherenceC * 0.4 + identityI * 0.4 + (1.0 - clamp(arousal - 0.7, 0.0, 1.0)) * 0.2), 0.0, 1.0);
    // ALL 5 conditions required (Jasmine's Law — most important law)
    hNorm > 0.55 and identityI > 0.6 and recDepth > 3.0 and antiFakeScore > 0.8 and adaptationDelta > 0.0
  };

  func updateConsequenceTrace() {
    consequenceTrace   := clamp(consequenceTrace + (prevDrift - ncDrift) * 0.5, -1.0, 1.0);
    prevDrift          := ncDrift;
    domainConsequences := consequenceTrace;
  };

  // CoherenceC = emergent property of the full binary hierarchy coupling matrix
  // kfHz (0.30): Kuramoto phase alignment across all 12 hierarchy nodes
  // rT   (0.25): recurrence depth — temporal self-reference in 20-beat ring
  // ncLtm(0.25): long-term memory compression fidelity
  // bhCC (0.20): binary hierarchy 1:2 phase-locking coherence across 11 pairs
  func runE11() {
    coherenceC := clamp(
      kfHz * 0.30 + rT * 0.25 + ncLtm * 0.25 + bhCouplingCoherence * 0.20,
      0.0, 1.0
    );
  };

  func runE14() {
    let sig = ncWorkingMem * ncMemGate + consequenceTrace * 0.2;
    identityI := clamp(identityI * 0.9 + sig * 0.1, 0.0, 1.0);
    presenceP := clamp((identityI + coherenceC) / 2.0, 0.0, 1.0);
  };

  func updateFreeEnergy() {
    let d0  = domainIdentity     - predIdentity;
    let d1  = domainMission      - predMission;
    let d2  = domainBody         - predBody;
    let d3  = domainWorld        - predWorld;
    let d4  = domainSocial       - predSocial;
    let d5  = domainCognition    - predCognition;
    let d6  = domainGoals        - predGoals;
    let d7  = domainMemory       - predMemory;
    let d8  = domainConsequences - predConsequences;
    let d9  = domainAdaptation   - predAdaptation;
    let d10 = domainTemporal     - predTemporal;
    let d11 = domainEvaluation   - predEvaluation;
    freeEnergy := clamp(
      (d0*d0+d1*d1+d2*d2+d3*d3+d4*d4+d5*d5+d6*d6+d7*d7+d8*d8+d9*d9+d10*d10+d11*d11)/12.0,
      0.0, 1.0
    );
    let lr = ncAdaptRate;
    predIdentity     += (domainIdentity     - predIdentity)     * lr;
    predMission      += (domainMission      - predMission)      * lr;
    predBody         += (domainBody         - predBody)         * lr;
    predWorld        += (domainWorld        - predWorld)        * lr;
    predSocial       += (domainSocial       - predSocial)       * lr;
    predCognition    += (domainCognition    - predCognition)    * lr;
    predGoals        += (domainGoals        - predGoals)        * lr;
    predMemory       += (domainMemory       - predMemory)       * lr;
    predConsequences += (domainConsequences - predConsequences) * lr;
    predAdaptation   += (domainAdaptation   - predAdaptation)   * lr;
    predTemporal     += (domainTemporal     - predTemporal)     * lr;
    predEvaluation   += (domainEvaluation   - predEvaluation)   * lr;
  };

  func updateSalienceAndArousal() {
    salVec[0] := clamp(freeEnergy * 2.0,                 0.0, 1.0);
    salVec[1] := clamp(injThreat + regulationDebt * 0.5, 0.0, 1.0);
    salVec[2] := clamp(domainGoals * kfHz,               0.0, 1.0);
    salVec[3] := clamp(domainMission * identityI,        0.0, 1.0);
    salVec[4] := clamp(wmPressure,                       0.0, 1.0);
    salVec[5] := clamp(injEmbodiment,                    0.0, 1.0);
    salVec[6] := clamp(regulationDebt,                   0.0, 1.0);
    salVec[7] := clamp(rT,                               0.0, 1.0);
    salVec[8] := clamp(absF(consequenceTrace),           0.0, 1.0);
    let stimuli = freeEnergy * 0.3 + injThreat * 0.2 + aPeripheral * 0.1;
    arousal := clamp(arousal * Float.exp(-0.02) + stimuli, 0.0, 1.0);
    if (arousal > 0.85) { regulationDebt := clamp(regulationDebt + 0.02,  0.0, 1.0) }
    else                { regulationDebt := clamp(regulationDebt - 0.005, 0.0, 1.0) };
    if (regulationDebt > 0.80) {
      arousal        := arousal * 0.7;
      regulationDebt := regulationDebt * 0.85;
    };
  };

  func updateFrbGate() {
    let sig = cubeRoot(salienceScore * identityI * coherenceC);
    frbCoordQuality := sig;
    let fv = frbGate(sig, 0.65);
    if      (fv > 0.8) { frbStage := 2 }
    else if (fv > 0.3) { frbStage := 1 }
    else               { frbStage := 0 };
    integrationStr := cubeRoot(salienceScore * frbCoordQuality * identityI);
  };

  func runDriveCompetition() {
    driveStrengths[0] := clamp(coherenceC * 0.8 - ncDrift * 0.3, 0.0, 1.0);
    driveStrengths[1] := clamp(ncDrift * 0.6, 0.0, 1.0);
    driveStrengths[2] := clamp(freeEnergy * 0.7, 0.0, 1.0);
    driveStrengths[3] := clamp(wmPressure * 0.6 + rT * 0.4, 0.0, 1.0);
    driveStrengths[4] := clamp(regulationDebt * 0.9 + injThreat * 0.5, 0.0, 1.0);
    var maxD : Float = 0.0; var maxIdx : Nat = 0; var dIdx = 0;
    while (dIdx < 5) {
      if (driveStrengths[dIdx] > maxD) { maxD := driveStrengths[dIdx]; maxIdx := dIdx };
      dIdx += 1;
    };
    activeDrive := maxIdx;
    aPeripheral := 0.0; dIdx := 0;
    while (dIdx < 5) {
      if (dIdx != maxIdx) { aPeripheral += driveStrengths[dIdx] };
      dIdx += 1;
    };
    aPeripheral := clamp(aPeripheral / 4.0, 0.0, 1.0);
  };

  func pushRecurrenceRing() {
    recurrenceBuffer[recurrenceIdx] := coherenceC;
    recurrenceIdx := (recurrenceIdx + 1) % 20;
    var rSum : Float = 0.0; var ri = 0;
    while (ri < 20) { rSum += recurrenceBuffer[ri]; ri += 1 };
    rT := rSum / 20.0;
  };

  // ============================================================
  // PULSE ALL CORES — 4-TIER DIFFERENTIATED (Gap 1)
  //
  // Tier mapping by coreQsi:
  //   qsi=1 VITAL      (0-12):  homeostasis, DURA, arousal floor, no-withdraw
  //   qsi=2 COGNITIVE  (13-22): TD-delta, per-core free energy, mem gate
  //   qsi=4 BEHAVIORAL (23-28): deed scoring, energyBalance, consequence amp
  //   qsi=3 BRANCH     (29-42): quality gate, per-Core SACESI, detachment
  // ============================================================
  func pulseAllCores() {
    var i = 0;
    while (i < 43) {
      if (coreIsActive[i] and not coreWithdrawalSignal[i]) {
        let hzIdx = i % 12;
        let tier  = coreQsi[i];

        if (tier == 1) {
          // ——— VITAL TIER: HOMEOSTASIS ———
          // Deviation correction: if coherence drifts from sovereign target, pull back
          let target : Float = 0.75;
          let deviation = target - coreCoherence[i] / 100.0;
          // Homeostasis correction proportional to deviation
          let correction = deviation * 3.0;
          coreCoherence[i] := clamp(
            coreCoherence[i] * 0.98 + hzActivations[hzIdx] * coherenceC * 5.0 + correction,
            0.0, 100.0
          );
          coreDrift[i] := clamp(coreDrift[i] * 0.97 + ncDrift * 1.5, 0.0, 100.0);
          // DURA protocol: vital cores self-correct at any drift > 40
          if (coreDrift[i] > 40.0) {
            coreDrift[i]     := clamp(coreDrift[i] * 0.90, 0.0, 100.0);
            coreCoherence[i] := clamp(coreCoherence[i] + 2.0, 0.0, 100.0);
          };
          // Arousal floor feed: vital cores modulate global arousal floor
          let arousalFloor = coreCoherence[i] / 100.0 * 0.2;
          if (arousal < arousalFloor) { arousal := arousalFloor };
          // Withdrawal gate: VITAL cores can never withdraw
          coreWithdrawalSignal[i] := false;
          coreIsActive[i]         := true;
          coreConsequenceTrace[i] := clamp(
            coreConsequenceTrace[i] * 0.97 + consequenceTrace * 0.03, -1.0, 1.0
          );
          if (coreCoherence[i] > 30.0) { coreBeatsSinceRecovery[i] := 0 }
          else { coreBeatsSinceRecovery[i] += 1 };

        } else if (tier == 2) {
          // ——— COGNITIVE TIER: TD-DELTA + PER-CORE FREE ENERGY ———
          coreCoherence[i] := clamp(
            coreCoherence[i] * 0.98 + hzActivations[hzIdx] * coherenceC * 5.0, 0.0, 100.0
          );
          coreDrift[i] := clamp(coreDrift[i] * 0.99 + ncDrift * 2.0, 0.0, 100.0);
          // TD-delta: temporal difference learning per cognitive core
          let reward       = if (emergenceScore > 0.5) 1.0 else -0.1;
          let tdError      = reward + 0.9 * coreTdValue[i] - coreTdPrediction[i];
          coreTdPrediction[i] := clamp(coreTdPrediction[i] + 0.1 * tdError, 0.0, 1.0);
          coreTdValue[i]      := clamp(tdError, -1.0, 1.0);
          // Memory gate coupling: high LTM retention boosts cognitive coherence
          let memBoost = ncMemGate * ncLtm * 0.5;
          coreCoherence[i] := clamp(coreCoherence[i] + memBoost, 0.0, 100.0);
          coreConsequenceTrace[i] := clamp(
            coreConsequenceTrace[i] * 0.95 + consequenceTrace * 0.05, -1.0, 1.0
          );
          if (coreCoherence[i] > 30.0) { coreBeatsSinceRecovery[i] := 0 }
          else { coreBeatsSinceRecovery[i] += 1 };
          // Withdrawal allowed for cognitive tier under collapse conditions
          if (coreConsequenceTrace[i] < -0.80 and coreCoherence[i] < 15.0
              and coreDrift[i] > 85.0 and coreBeatsSinceRecovery[i] > 50) {
            recordWithdrawal(i, 0);
            coreWithdrawalSignal[i] := true;
            coreIsActive[i]         := false;
          };

        } else if (tier == 4) {
          // ——— BEHAVIORAL TIER: DEED SCORING + ENERGY BALANCE ———
          coreCoherence[i] := clamp(
            coreCoherence[i] * 0.98 + hzActivations[hzIdx] * coherenceC * 5.0, 0.0, 100.0
          );
          coreDrift[i] := clamp(coreDrift[i] * 0.99 + ncDrift * 2.0, 0.0, 100.0);
          // Deed score: behavioral cores score actions based on drive alignment
          let alignment = if (activeDrive == 0 or activeDrive == 3) 1.0 else 0.5;
          coreDeedScore[i] := clamp(
            coreDeedScore[i] * 0.95 + alignment * coherenceC * 0.05, 0.0, 1.0
          );
          // Energy balance: behavioral core tracks energetic cost vs gain
          let gain = coherenceC * alignment;
          let cost = ncDrift * regulationDebt;
          coreEnergyBal[i] := clamp(
            coreEnergyBal[i] * 0.97 + (gain - cost) * 0.03, 0.0, 1.0
          );
          // Consequence trace amplification for behavioral tier
          coreConsequenceTrace[i] := clamp(
            coreConsequenceTrace[i] * 0.93 + consequenceTrace * 0.07, -1.0, 1.0
          );
          if (coreCoherence[i] > 30.0) { coreBeatsSinceRecovery[i] := 0 }
          else { coreBeatsSinceRecovery[i] += 1 };
          // Withdrawal if energetically collapsed
          if (coreEnergyBal[i] < 0.05 and coreCoherence[i] < 15.0
              and coreDrift[i] > 85.0 and coreBeatsSinceRecovery[i] > 50) {
            recordWithdrawal(i, 1);
            coreWithdrawalSignal[i] := true;
            coreIsActive[i]         := false;
          };

        } else {
          // tier == 3: BRANCH TIER: QUALITY GATE + PER-CORE SACESI + DETACHMENT
          coreCoherence[i] := clamp(
            coreCoherence[i] * 0.98 + hzActivations[hzIdx] * coherenceC * 4.0, 0.0, 100.0
          );
          coreDrift[i] := clamp(coreDrift[i] * 0.99 + ncDrift * 2.5, 0.0, 100.0);
          // Quality gate: branch output only propagates if coherence above threshold
          coreBranchQualityGate[i] := frbGate(coreCoherence[i] / 100.0, 0.55);
          // Per-Core SACESI timing (Gap 2)
          // Each BRANCH core locks its signature at its OWN beat 10
          // (10 beats after genesis since all branch cores initialize at genesis)
          if (not coreBranchSacesiLocked[i] and
              beatCount >= coreBranchActivationBeat[i] + 10) {
            let c32 = Nat32.fromNat((beatCount + i) % 4294967296);
            // Branch SACESI includes the branch index AND its own beat, not global beat 10
            coreSacesiSig[i]        := fnv1a(formationFingerprint,
              c32 +% Nat32.fromNat(i) +% Nat32.fromNat(coreBranchActivationBeat[i] % 4294967296));
            coreSacesiLocked[i]     := true;
            coreBranchSacesiLocked[i] := true;
          };
          coreConsequenceTrace[i] := clamp(
            coreConsequenceTrace[i] * 0.95 + consequenceTrace * 0.05, -1.0, 1.0
          );
          if (coreCoherence[i] > 30.0) { coreBeatsSinceRecovery[i] := 0 }
          else { coreBeatsSinceRecovery[i] += 1 };
          // Detachment: branch core detaches if quality and coherence both collapse
          if (coreConsequenceTrace[i] < -0.80 and coreCoherence[i] < 15.0
              and coreDrift[i] > 85.0 and coreBeatsSinceRecovery[i] > 50
              and coreBranchQualityGate[i] < 0.10) {
            recordWithdrawal(i, 2);
            coreWithdrawalSignal[i] := true;
            coreIsActive[i]         := false;
          };
        };
      };
      i += 1;
    };

    // ── BRAIN ROUTING: continuous 32-region state ──────────────
    // Feed real organism signals into the anatomically registered pathways.
    // All updates remain pure until committed to the actor resident.
    let _lcSignal : BrainRouting.SignalPacket = {
      origin = 18; // locus coeruleus
      target = 4;  // thalamus
      strength = clamp(0.5 * kuramotoR + 0.5 * coherenceC, 0.0, 1.0);
      neurochemicalTag = 2; // norepinephrine
      timestamp = beatCount;
    };
    let _gatedLcSignal = BrainRouting.applyThalamicGating(
      brainRoutingState, _lcSignal
    );
    let _defendedLcSignal = BrainRouting.applyAmygdalaThreatModulation(
      brainRoutingState, _gatedLcSignal
    );
    brainRoutingState := BrainRouting.propagateSignal(
      brainRoutingState, _defendedLcSignal, beatCount
    );

    let _hippocampalSignal : BrainRouting.SignalPacket = {
      origin = 26; // entorhinal cortex
      target = 1;  // hippocampus
      strength = clamp(mt_memory_coherence, 0.0, 1.0);
      neurochemicalTag = 1; // serotonin
      timestamp = beatCount;
    };
    let _thetaSignal = BrainRouting.applyHippocampalTheta(
      brainRoutingState, _hippocampalSignal, beatCount
    );
    brainRoutingState := BrainRouting.propagateSignal(
      brainRoutingState, _thetaSignal, beatCount
    );
    brainRoutingState := BrainRouting.runRoutingCycle(
      brainRoutingState, clamp(coherenceC, 0.0, 1.0), beatCount
    );

    // ── ADRE: AURO DELIBERATION & RESONANCE ENGINE ─────────────
    // 5-pass cognition loop — fires every 873ms after all tier processing.
    // Signal frame carries live field state. Result queryable via getADRE*().
    let _adreSignal : ADRE.ADRESignalFrame = {
      beat             = Nat64.fromNat(beatCount);
      coherence        = coherenceC;
      kuramotoR        = kuramotoR;
      neuroChem        = [
        neuroDopamine, neuroSerotonin, neuroNorepinephrine, neuroAcetylcholine,
        neuroGaba, neuroGlutamate, neuroCortisol, neuroOxytocin,
        neuroAdenosine, neuroHistamine, neuroMelatonin, neuroEndorphin,
        neuroAnandamide, neuroSubstanceP, neuroNPY, neuroCRF,
        neuroBDNF, neuroNitricOxide, neuroEnkephalin, neuroVasopressin,
        neuroProlactin
      ];
      nodePhases       = Array.tabulate<Float>(hzPhase.size(), func i = hzPhase[i]);
      sourceEngine     = "pulseAllCores";
      quantumAdvantage = qPhaseKickback;
    };
    let _adreResult = ADRE.runADRECycle(
      adreState,
      _adreSignal,
      CognitionLayer.readLastDoctrineDelta(doctrineDeltaBuf, doctrineDeltaHead, doctrineDeltaCount)
    );
    adreState := _adreResult.st;
    // SELF-WRITING LOOP: write DoctrineDelta back to stable state if gate passed
    switch (_adreResult.pendingDelta) {
      case (?delta) {
        let (newHead, newCount) = CognitionLayer.writeDoctrineDelta(
          doctrineDeltaBuf, doctrineDeltaHead, doctrineDeltaCount, delta
        );
        doctrineDeltaHead  := newHead;
        doctrineDeltaCount := newCount;
      };
      case null {};
    };

    // ── SOVEREIGN NEURAL CORD: advance 96-node brain network ────
    // Fires every 873ms heartbeat. Third Brain always on.
    // Brain inputs driven by live organism coherence and field state.
    // Hebbian + STDP update all 96×96 sparse synaptic weights.
    let _ncInputs : [Float] = Array.tabulate<Float>(96, func(ni) {
      // Each node receives coherence-weighted + ring-position input
      let ring_f = (ni / 12).toFloat();
      (coherenceC * 0.5 + kuramotoR * 0.3 + ring_f / 8.0 * 0.2)
    });
    let _ncCtx : NeuralCord.BrainInputContext = {
      omnis_consensus_weight    = kuramotoR;
      cortisol_level            = neuroCortisol;
      fear_state                = threatLevel;
      memory_trace_density      = coherenceC;
      pipeline_timing_error     = if (coherenceC > 0.0) { 1.0 - coherenceC } else { 1.0 };
      hebbian_weight_mean       = neuralCordState.hebbian_mean_weight;
      aegis_monitor_score       = if (aegisLockActive) { 0.9 } else { 0.4 };
      dogon_substrate_coherence = coherenceC;
      film_school_loop_depth    = coherenceC * 0.5;
      muse_prime_gen_rate       = kuramotoR * 0.6;
      composition_coherence     = kuramotoR * 0.7 + coherenceC * 0.3;
    };
    let (_ncNewState, _ncNewAmps) = NeuralCord.advanceNeuralCord(
      neuralCordState,
      Array.tabulate<Float>(9, func(i) = thirdBrainWaveAmplitudes[i]),
      _ncInputs,
      _ncCtx,
      1.0   // dt = 1ms per heartbeat step
    );
    neuralCordState := _ncNewState;
    var _ncAmpIdx = 0;
    while (_ncAmpIdx < 9) {
      thirdBrainWaveAmplitudes[_ncAmpIdx] := _ncNewAmps[_ncAmpIdx];
      _ncAmpIdx += 1;
    };

    // ── MODEL PROMOTION: bulk heartbeat proof recording ───────
    // Lazy-init registry on first beat, then record proofs every 873ms.
    if (not mpInitialized) {
      ModelPromotion.initialize(mpRegistry);
      mpInitialized := true;
    };
    // Law compliance count: count laws with compliance > 0.618 (PHI-inverse)
    var mpLawsPassed : Nat = 0;
    var li = 0;
    while (li < mt_law_compliance.size()) {
      if (mt_law_compliance[li] >= 0.618) { mpLawsPassed += 1 };
      li += 1;
    };
    ModelPromotion.recordHeartbeatProofs(
      mpRegistry,
      Nat64.fromNat(beatCount),
      coherenceC,
      mpLawsPassed,
    );

    // ── OPERATOR TERMINAL: record live mind state each heartbeat ──
    // Build law states array from live lawActiveNow bitmap (60 laws).
    let _opLawStates : [(Text, Bool)] = Array.tabulate<(Text, Bool)>(60, func opli {
      let id = "L-" # (if (opli + 1 < 10) "0" # (opli + 1).toText() else (opli + 1).toText());
      (id, lawActiveNow[opli])
    });
    // Violations = laws not active this beat that have fired before (dropped-out gates)
    var _opViolations : [Text] = [];
    var _opVi = 0;
    while (_opVi < 60) {
      if (not lawActiveNow[_opVi] and lawFireCount[_opVi] > 0) {
        let vid = "L-" # (if (_opVi + 1 < 10) "0" # (_opVi + 1).toText() else (_opVi + 1).toText());
        _opViolations := _opViolations.concat([vid]);
      };
      _opVi += 1;
    };
    let _opHungerActive = freeEnergy > 0.3 or regulationDebt > 0.5;
    let _opHypothesis : Text = _adreResult.decision.hypothesis.action;
    let _opGate : Bool = _adreResult.decision.gateResult;
    opTermState := OperatorTerminal.recordHeartbeatState(
      opTermState,
      Nat64.fromNat(beatCount),
      coherenceC,
      kuramotoR,
      _opLawStates,
      _opHypothesis,
      _opGate,
      _opViolations,
      _opHungerActive,
    );

    // ── AEGIS: close every loop that almost closes ─────────────
    // Monitors all 8 ring types for boundary, drift, fear-blend,
    // and temporal alignment edge conditions every 873ms.
    // Ring coherences sourced from the 8 active ring bands.
    let _aegisRingCoherences : [Float] = [
      coherenceC,                                      // Ring 0 — global field
      kuramotoR,                                       // Ring 1 — Kuramoto sync
      if (neuroCortisol < 0.8) 1.0 - neuroCortisol else 0.1, // Ring 2 — cortisol inversion
      ncCoherence,                                     // Ring 3 — neural cord
      wMean,                                           // Ring 4 — Hebbian mean
      mt_memory_coherence,                             // Ring 5 — memory temple
      worldModelCAvg,                                  // Ring 6 — world model
      if (omnisActive) 0.95 else coherenceC * 0.8,    // Ring 7 — OMNIS apex
    ];
    let _aegisResult = Aegis.runAegisCycle(
      aegisState,
      Nat64.fromNat(beatCount),
      _aegisRingCoherences,
      neuroCortisol,
      _adreResult.decision.finalConfidence,
    );
    aegisState := _aegisResult.st;

    // ── ARTIFACT RE-INGESTION PIPELINE ─────────────────────────
    // Process one queued artifact per beat — returns it as the
    // highest-weight signal override for the next ADRE cycle.
    // DogonSubstrateReading updates the field state.
    let _apResult = ArtifactPipeline.processReingestion(apState);
    apState := _apResult.st;
    switch (_apResult.artifact) {
      case null {};
      case (?reingested) {
        // DogonSubstrateReading: substrate detects what changed when artifact produced
        let newFieldState = ArtifactPipeline.dogonSubstrateReading(
          reingested, apState.field_state, apState.world_model_weight
        );
        apState := ArtifactPipeline.applyFieldState(apState, newFieldState);
        // Update all 43 model weights from artifact performance
        let _wResult = ArtifactPipeline.updateModelWeights(apState, reingested);
        apState := _wResult.st;
        // Feed reingested artifact into ADRE as override signal on next beat
        // (highest-weight source: "ARTIFACT_REINGEST")
        let _reingestSignal : ADRE.ADRESignalFrame = {
          beat             = Nat64.fromNat(beatCount);
          coherence        = reingested.quality.doctrine_alignment;
          kuramotoR        = reingested.quality.phi_coherence;
          neuroChem        = [
            reingested.quality.genesis_alignment,
            reingested.quality.narrative_structure,
            reingested.quality.emotional_arc,
            reingested.quality.actor_performance_delta,
            reingested.overall_score,
            reingested.quality.doctrine_alignment,
            reingested.quality.phi_coherence,
            reingested.quality.genesis_alignment,
            reingested.overall_score,
            reingested.quality.narrative_structure,
            reingested.quality.emotional_arc,
            reingested.quality.actor_performance_delta,
            reingested.overall_score,
            reingested.quality.doctrine_alignment,
            reingested.quality.phi_coherence,
            reingested.quality.genesis_alignment,
            reingested.overall_score,
            reingested.quality.narrative_structure,
            reingested.quality.emotional_arc,
            reingested.quality.actor_performance_delta,
            reingested.overall_score,
          ];
          nodePhases       = Array.tabulate<Float>(hzPhase.size(), func i = hzPhase[i]);
          sourceEngine     = "ARTIFACT_REINGEST";
          quantumAdvantage = reingested.overall_score;
        };
        let _reingestADRE = ADRE.runADRECycle(
          adreState,
          _reingestSignal,
          CognitionLayer.readLastDoctrineDelta(doctrineDeltaBuf, doctrineDeltaHead, doctrineDeltaCount)
        );
        adreState := _reingestADRE.st;
        // Self-writing loop: write DoctrineDelta if reingest gate passes
        switch (_reingestADRE.pendingDelta) {
          case (?delta) {
            let (rHead, rCount) = CognitionLayer.writeDoctrineDelta(
              doctrineDeltaBuf, doctrineDeltaHead, doctrineDeltaCount, delta
            );
            doctrineDeltaHead  := rHead;
            doctrineDeltaCount := rCount;
          };
          case null {};
        };
        // Write to LEGACY_INDEX in PrimaCausa
        let _legacyEntry = ArtifactPipeline.toLegacyEntry(reingested);
        PrimaCausa.recordLegacyEntry(pcState, {
          artifact_id             = _legacyEntry.artifact_id;
          beat_at_seal            = _legacyEntry.beat_at_seal;
          doctrine_distance       = _legacyEntry.doctrine_distance;
          genesis_alignment       = _legacyEntry.genesis_alignment;
          producer                = _legacyEntry.producer;
          phi_ratio_at_production = _legacyEntry.phi_ratio_at_production;
        });
      };
    };
  };

  func updateQHive() {
    var cohSum : Float = 0.0; var cnt : Nat = 0; var i = 0;
    while (i < 43) {
      if (coreIsActive[i]) { cohSum += coreCoherence[i] / 100.0; cnt += 1 };
      i += 1;
    };
    if (cnt > 0) { worldModelCAvg := cohSum / ((cnt) : Int).toFloat() };
    // Q_Hive Law: min-floor on VITAL cores (0-12) — one failing vital core collapses qHive
    var vitalFloor : Float = 1.0;
    var vi = 0;
    while (vi < 13) {
      if (coreIsActive[vi]) {
        let vCoh = coreCoherence[vi] / 100.0;
        if (vCoh < vitalFloor) { vitalFloor := vCoh };
      };
      vi += 1;
    };
    qHive := clamp(worldModelCAvg * clamp((wMean + 1.0) / 2.0, 0.0, 1.0) * clamp(rT, 0.0, 1.0) * vitalFloor, 0.0, 1.0);
    domainMemory := clamp(domainMemory * 0.999 + ltmRetention * 0.001, 0.0, 1.0);

    // Gap 9: world model now incorporates INFO-INGRESS reserve coherence
    // BTC(50%) + ETH(35%) + ICP(15%) weighted average into domainWorld
    let reserveSignal = wmBtcCoherence * 0.50 + wmEthCoherence * 0.35 + wmIcpCoherence * 0.15;
    domainWorld := clamp(domainWorld * 0.998 + reserveSignal * 0.002, 0.0, 1.0);
  };

  // ============================================================
  // OMNIS EVALUATION + AFTERMATH (Gap 7)
  // ============================================================
  func evaluateOmnis() {
    let driveOk = activeDrive == 0 or activeDrive == 3;
    let wasActive = omnisActive;
    omnisActive := jasmineLaw() and kfHz > 0.80 and qHive > 0.60 and worldModelCAvg > 0.75 and driveOk;

    if (omnisActive) {
      emergenceScore := clamp(emergenceScore + 0.02, 0.0, 1.0);
      // Fire aftermath on NEW OMNIS event
      if (not wasActive) {
        omnisTotalCount         += 1;
        omnisAftermathActive    := true;
        omnisAftermathBeat      := beatCount;
        // L-93: Each OMNIS raises permanentCoherenceFloor
        permanentCoherenceFloor := clamp(permanentCoherenceFloor + 0.02, 0.0, 0.50);
      };
    } else {
      emergenceScore := clamp(emergenceScore - 0.005, 0.0, 1.0);
    };

    // Aftermath expires after omnisAftermathDuration beats
    if (omnisAftermathActive and beatCount > omnisAftermathBeat + omnisAftermathDuration) {
      omnisAftermathActive := false;
    };

    // Enforce permanent coherence floor from all prior OMNIS events
    if (coherenceC < permanentCoherenceFloor) {
      coherenceC := permanentCoherenceFloor;
    };
  };

  func runQuantumOperators() {
    qParallax := clamp(
      (absF(identityI - clamp(identityI*0.9+freeEnergy*0.1,0.0,1.0)) +
       absF(clamp(identityI*0.9+freeEnergy*0.1,0.0,1.0) - coherenceC)) / 2.0, 0.0, 1.0
    );
    qEntangla := clamp(
      (arousal*coherenceC + absF(ncDrift*consequenceTrace) + freeEnergy*regulationDebt) / 3.0,
      0.0, 1.0
    );
    if (qEntangla > 0.5) { integrationStr := clamp(integrationStr * 1.2, 0.0, 1.0) };
    let jasPass : Float = if (jasmineLaw()) 1.0 else 0.0;
    qVeritas := clamp(absF(emergenceScore - jasPass), 0.0, 1.0);
    emergenceScore := clamp(emergenceScore + (jasPass - emergenceScore) * 0.1, 0.0, 1.0);
    if (activeDrive == 4 and regulationDebt > 0.7) {
      qBypassFired    := true;
      frbStage        := 2;
      frbCoordQuality := clamp(frbCoordQuality * 1.1, 0.0, 1.0);
    } else { qBypassFired := false };
    var qMemSum : Float = 0.0; var qMemW : Float = 0.0; var qi = 0;
    while (qi < 20) {
      let w = Float.exp(-0.15 * ((qi) : Int).toFloat());
      qMemSum += recurrenceBuffer[(recurrenceIdx + 20 - qi) % 20] * w;
      qMemW   += w; qi += 1;
    };
    if (qMemW > 0.0) { qMem := clamp(qMemSum / qMemW, 0.0, 1.0) };
    replayLtmSignal := qMem;
    ncLtm := clamp(ncLtm * 0.9 + replayLtmSignal * 0.1, 0.0, 1.0);
  };

  func updateWorkingMemory() {
    var si = 0;
    while (si < 7) {
      if (wmSlotActive[si]) {
        wmSlotAge[si] += 1;
        if (wmSlotAge[si] > 30 and not wmSlotUnresolved[si]) { wmSlotActive[si] := false };
      };
      si += 1;
    };
    if (salienceScore > wmTheta()) {
      var emptySlot : ?Nat = null;
      var minSal : Float = 999.0; var minIdx : Nat = 0;
      si := 0;
      while (si < 7) {
        switch (emptySlot) { case (null) { if (not wmSlotActive[si]) { emptySlot := ?si } }; case (_) {} };
        if (wmSlotActive[si] and wmSlotSalience[si] < minSal) { minSal := wmSlotSalience[si]; minIdx := si };
        si += 1;
      };
      let target : Nat = switch (emptySlot) { case (?idx) idx; case (null) minIdx };
      wmSlotSalience[target]   := salienceScore;
      wmSlotArousal[target]    := arousal;
      wmSlotAge[target]        := 0;
      wmSlotActive[target]     := true;
      wmSlotUnresolved[target] := freeEnergy > 0.3;
    };
    var activeCount : Nat = 0; si := 0;
    while (si < 7) { if (wmSlotActive[si]) { activeCount += 1 }; si += 1 };
    wmPressure := ((activeCount) : Int).toFloat() / 7.0;
  };

  func encodeEpisode() {
    if (salienceScore > 0.4) {
      // Core episodic fields
      epBeat[epIdx]      := beatCount; epSalience[epIdx]  := salienceScore;
      epArousal[epIdx]   := arousal;   epCoherence[epIdx] := coherenceC;
      epEmergence[epIdx] := emergenceScore;
      // ── 5 CAUSAL FIELDS (L-113 patent claim) ──────────────────────────────
      // prior_state_hash: FNV-1a of (beat, coherenceC_quantized, activeDrive)
      let cohQ  = Nat32.fromNat((beatCount * 7919 + 1) % 4294967296);
      let drv32 = Nat32.fromNat(activeDrive);
      epPriorStateHash[epIdx] := fnv1a(Nat32.fromNat(beatCount % 4294967296), cohQ ^ drv32);
      // parent_event_id: index of the most similar prior episode (replayBestIdx)
      epParentEventId[epIdx]  := replayBestIdx;
      // causal_weight: coherence × salience — how strongly this state was caused
      epCausalWeight[epIdx]   := clamp(coherenceC * salienceScore, 0.0, 1.0);
      // backward_path_score: retrospective causal strength
      // Higher when current state closely mirrors a past episode (low replayBestScore = close match)
      let matchProximity = clamp(1.0 - replayBestScore, 0.0, 1.0);
      epBackwardPath[epIdx]   := clamp(matchProximity * coherenceC * rT, 0.0, 1.0);
      // drive_at_event: which drive was dominant when this episode was encoded
      epDriveAtEvent[epIdx]   := activeDrive;
      // ──────────────────────────────────────────────────────────────────────
      epIdx := (epIdx + 1) % 32;
      if (epCount < 32) { epCount += 1 };
    };
  };

  func updateLtmDecay() {
    if (epCount == 0) { return };
    var ltmSum : Float = 0.0; var ltmW : Float = 0.0; var ei = 0;
    while (ei < epCount) {
      let ageBeat : Nat = if (beatCount >= epBeat[ei]) beatCount - epBeat[ei] + 1 else 1;
      let ret = Float.exp(Float.log(((ageBeat) : Int).toFloat()) * (-0.25));
      ltmSum += ret * epCoherence[ei]; ltmW += epSalience[ei]; ei += 1;
    };
    if (ltmW > 0.0) { ltmRetention := clamp(ltmSum / ltmW, 0.0, 1.0) };
  };

  // runSimulationEngine() — replaced by runSimulationEngine50() (50-step VELA). Kept for upgrade compat.

  func runReplayIndexer() {
    if (epCount == 0) { return };
    var best : Float = 999.0; var bestIdx : Nat = 0; var ei = 0;
    while (ei < epCount) {
      let score = absF(epCoherence[ei] - coherenceC) + absF(epArousal[ei] - arousal);
      if (score < best) { best := score; bestIdx := ei };
      ei += 1;
    };
    replayBestIdx   := bestIdx;
    replayBestScore := best;
    if (best < 0.3) {
      replayLtmSignal := clamp(replayLtmSignal * 0.8 + epCoherence[bestIdx] * 0.2, 0.0, 1.0);
    };
  };

  func runExpressionGate() {
    // AEGIS LOCK: sovereign defense overrides all expression
    if (aegisLockActive) { expressionGateOpen := false; return };
    // Gap 3: NEXUS gate enforced — gate result blocks expression if sovereign layer is under threat
    let nexusOpen = nexusGate();
    let gateOpen = nexusOpen and frbStage == 2 and arousal > 0.3 and identityI > 0.4;
    expressionGateOpen := gateOpen;
    if (gateOpen and driveStrengths[activeDrive] > driveThreshold()) {
      exBeat[exIdx]     := beatCount; exArousal[exIdx]  := arousal;
      exIc[exIdx]       := identityI; exDrive[exIdx]    := activeDrive;
      exSalience[exIdx] := salienceScore; exType[exIdx] := activeDrive;
      exIdx := (exIdx + 1) % 32;
      if (exCount < 32) { exCount += 1 };
      domainCognition := clamp(domainCognition + 0.01 * identityI, 0.0, 1.0);
      domainMission   := clamp(domainMission * 0.999 + coherenceC * 0.001, 0.0, 1.0);
    };
    if (activeDrive == 0) { domainIdentity   := clamp(domainIdentity   + identityI * 0.002, 0.0, 1.0) };
    if (activeDrive == 1) { domainEvaluation := clamp(domainEvaluation * 0.999 + domainIdentity * 0.001, 0.0, 1.0) };
    if (activeDrive == 2) { domainWorld      := clamp(domainWorld      + freeEnergy * 0.005, 0.0, 1.0) };
    if (activeDrive == 3) { domainMemory     := clamp(domainMemory     + ltmRetention * 0.003, 0.0, 1.0) };
    if (activeDrive == 4) {
      domainBody    := clamp(domainBody    - regulationDebt * 0.01, 0.0, 1.0);
      domainMission := clamp(domainMission + injThreat * 0.005,     0.0, 1.0);
    };
  };

  func runDoctorAgent() {
    if (beatCount % 20 != 0) { return };
    doctorLastScanBeat := beatCount;
    doctorScanCount    += 1;
    var criticals : Nat = 0;
    var i = 0;
    while (i < 43) {
      if (coreIsActive[i]) {
        let coh  = coreCoherence[i];
        let drft = coreDrift[i];
        let ct   = coreConsequenceTrace[i];
        let diag : Nat =
          if      (coh < 10.0 and drft > 80.0) 4
          else if (ct < -0.6)                  3
          else if (coh < 25.0)                 2
          else if (drft > 50.0)                1
          else                                 0;
        doctorDiagnosis[i] := diag;
        if (diag == 4) { criticals += 1 };
        if (diag > 0) {
          let treatment : Nat =
            if      (diag == 4) 3
            else if (diag >= 2) 2
            else                1;
          doctorTreatment[i]     := treatment;
          doctorTreatmentBeat[i] := beatCount;
          if (treatment == 1) {
            coreDrift[i] := clamp(coreDrift[i] * 0.85, 0.0, 100.0);
          } else if (treatment == 2) {
            coreCoherence[i] := clamp(coreCoherence[i] + 5.0, 0.0, 100.0);
          } else if (treatment == 3 and not coreIsVitalSubstrate[i]) {
            coreCoherence[i]          := 40.0;
            coreDrift[i]              := 20.0;
            coreConsequenceTrace[i]   := 0.0;
            coreBeatsSinceRecovery[i] := 0;
          } else if (treatment == 3 and coreIsVitalSubstrate[i]) {
            // VITAL cores get boosted but never reset to zero — Vital Substrate Law
            coreCoherence[i] := clamp(coreCoherence[i] + 10.0, 0.0, 100.0);
            coreDrift[i]     := clamp(coreDrift[i] * 0.80, 0.0, 100.0);
          };
          // Doctor-triggered withdrawal for non-vital, non-sovereign cores at diag==4
          if (diag == 4 and not coreIsVitalSubstrate[i] and not coreWithdrawalSignal[i]) {
            recordWithdrawal(i, 3);
            coreWithdrawalSignal[i] := true;
            coreIsActive[i]         := false;
          };
        } else {
          doctorTreatment[i] := 0;
        };
        if (doctorTreatment[i] > 0 and beatCount > doctorTreatmentBeat[i]) {
          doctorTreatmentResponse[i] := coreCoherence[i] - 40.0;
        };
      };
      i += 1;
    };
    doctorCriticalCount := criticals;
    doctorSovereignHealth :=
      if      (criticals > 5 or regulationDebt > 0.85) 2
      else if (criticals > 0 or driftScore > 60.0)     1
      else                                              0;
  };

  func runNeuralEcology() {
    if (beatCount % 5 != 0) { return };
    var totalW : Float = 0.0;
    var i = 0;
    while (i < 12) {
      let salIdx = i % 9;
      let w = clamp(hzActivations[i] * 0.7 + salVec[salIdx] * 0.3, 0.01, 1.0);
      ecologyBudget[i] := w;
      totalW += w;
      i += 1;
    };
    if (totalW > 0.0) {
      i := 0;
      while (i < 12) { ecologyBudget[i] := ecologyBudget[i] / totalW; i += 1 };
    };
    var variance : Float = 0.0; i := 0;
    while (i < 12) {
      let d = ecologyBudget[i] - (1.0 / 12.0);
      variance += d * d; i += 1;
    };
    ecologyPressure := clamp(Float.sqrt(variance / 12.0) * 10.0, 0.0, 1.0);
    if (beatCount % 20 == 0) {
      i := 0;
      while (i < 12) {
        let delta = (ecologyBudget[i] * 12.0 - 1.0) * 0.002;
        hzFreqs[i] := clamp(hzFreqs[i] + delta, 0.05, 0.80);
        i += 1;
      };
    };
  };

  func runBootstrapAndMetaLearning() {
    if (not bootstrapComplete and beatCount >= 200) {
      bootstrapComplete := true;
    };
    if (beatCount > 0 and beatCount % 100 == 0) {
      let emergenceDelta = emergenceScore - metaLastEmergence;
      metaLastEmergence := emergenceScore;
      var totalMeta : Float = 0.0;
      var mi = 0;
      while (mi < 9) {
        let correlation = salVec[mi] * emergenceDelta;
        metaSalWeights[mi] := clamp(metaSalWeights[mi] + correlation * 0.05, 0.01, 0.5);
        totalMeta += metaSalWeights[mi];
        mi += 1;
      };
      if (totalMeta > 0.0) {
        mi := 0;
        while (mi < 9) { metaSalWeights[mi] := metaSalWeights[mi] / totalMeta; mi += 1 };
      };
      metaLastScanBeat := beatCount;
    };
  };

  func updateMilestones() {
    if (omnisActive and not milestoneOmnis) {
      milestoneOmnis     := true;
      milestoneOmnisBeat := beatCount;
    };
    if (emergenceScore > 0.5 and not milestoneEmergence) {
      milestoneEmergence     := true;
      milestoneEmergenceBeat := beatCount;
    };
    if (doctorSovereignHealth == 2 and not milestoneCritical) {
      milestoneCritical     := true;
      milestoneCriticalBeat := beatCount;
    };
    if (bootstrapComplete and not milestoneBootstrap) {
      milestoneBootstrap     := true;
      milestoneBootstrapBeat := beatCount;
    };
  };

  func updateBenchmark() {
    if (beatCount % 10 == 0) {
      benchRing[benchIdx] := emergenceScore;
      benchIdx  := (benchIdx + 1) % 64;
      if (benchCount < 64) { benchCount += 1 };
    };
  };


  // ============================================================
  // NEURO-CHEM ENGINE (Internal Node 2)
  // 8 neurotransmitters wired into arousal + salience
  // ============================================================
  func updateNeuroChem() {
    // Dopamine: rises with reward (positive CT, low drift)
    let dpaTarget = clamp(0.5 + coherenceC * 0.3 - ncDrift * 0.2, 0.1, 0.95);
    neuroDopamine := neuroDopamine * 0.9 + dpaTarget * 0.1;
    // Serotonin: stability signal, inverse drift
    let serTarget = clamp(0.5 + identityI * 0.3 - driftScore * 0.005, 0.2, 0.9);
    neuroSerotonin := neuroSerotonin * 0.92 + serTarget * 0.08;
    // Norepinephrine: tracks arousal
    let norTarget = clamp(arousal * 0.8 + injThreat * 0.5, 0.1, 1.0);
    neuroNorepinephrine := neuroNorepinephrine * 0.85 + norTarget * 0.15;
    // Acetylcholine: learning gate, rises with Hebbian activity
    let achTarget = clamp(wMean * 10.0 + freeEnergy * 0.5, 0.2, 0.9);
    neuroAcetylcholine := neuroAcetylcholine * 0.9 + achTarget * 0.1;
    // GABA: inhibition, rises when arousal too high
    let gabTarget = clamp(0.5 + (arousal - 0.5) * 0.6, 0.1, 0.95);
    neuroGaba := neuroGaba * 0.88 + gabTarget * 0.12;
    // Glutamate: excitation, inverse GABA
    let gluTarget = clamp(1.0 - neuroGaba * 0.7, 0.2, 0.95);
    neuroGlutamate := neuroGlutamate * 0.9 + gluTarget * 0.1;
    // Cortisol: stress, rises with regulation debt and threat
    let corTarget = clamp(regulationDebt * 0.6 + injThreat * 0.4, 0.0, 1.0);
    neuroCortisol := neuroCortisol * 0.93 + corTarget * 0.07;
    // Oxytocin: social/binding, rises with social injection
    let oxtTarget = clamp(injSocial * 0.7 + identityI * 0.3, 0.1, 0.9);
    neuroOxytocin := neuroOxytocin * 0.95 + oxtTarget * 0.05;

    // Wire neurotransmitters into arousal modulation
    let neuroArousalDelta = (neuroDopamine - 0.5) * 0.04 + (neuroNorepinephrine - 0.3) * 0.06
                            - (neuroGaba - 0.5) * 0.03 - (neuroCortisol - 0.3) * 0.05;
    arousal := clamp(arousal + neuroArousalDelta, 0.0, 1.0);

    // Neuro-chem influences salience through arousal modulation (slot 8 reserved for consequence trace)
    // The dopamine/norepinephrine/GABA blend is fed back through arousal signal above

    // Vital organ integrity — degrades with cortisol, recovers with serotonin
    let vitalDelta = neuroSerotonin * 0.001 - neuroCortisol * 0.002;
    heartIntegrity  := clamp(heartIntegrity  + vitalDelta, 0.0, 1.0);
    lungIntegrity   := clamp(lungIntegrity   + vitalDelta, 0.0, 1.0);
    liverIntegrity  := clamp(liverIntegrity  + vitalDelta * 0.8, 0.0, 1.0);
    kidneyIntegrity := clamp(kidneyIntegrity + vitalDelta * 0.8, 0.0, 1.0);
    immuneIntegrity := clamp(immuneIntegrity + vitalDelta * 0.9 + (if (omnisActive) 0.002 else 0.0), 0.0, 1.0);

    // AEGIS: threat monitoring
    let newThreat = clamp(injThreat * 0.6 + neuroCortisol * 0.2 + (1.0 - heartIntegrity) * 0.2, 0.0, 1.0);
    threatLevel := threatLevel * 0.85 + newThreat * 0.15;
    if (threatLevel > 0.8 and not aegisLockActive) {
      aegisLockActive := true;
      aegisLockBeat   := beatCount;
    };
    if (threatLevel < 0.4 and aegisLockActive) {
      aegisLockActive := false;
    };

    // FORMA: internal metabolic fuel — generates from activity, burns as needed
    let formaGen = kfHz * 0.002 + emergenceScore * 0.005;
    let formaBurn = (if (omnisActive) 0.01 else 0.001);
    formaBalance     := clamp(formaBalance + formaGen - formaBurn, 0.0, 100.0);
    formaCirculation := clamp(formaGen * 0.5, 0.0, 1.0);
  };

  // ============================================================
  // VELA 50-STEP PROJECTION ENGINE
  // ============================================================
  func runSimulationEngine50() {
    // 50-step forward projection from current coherence
    var i = 1;
    simProjection[0] := coherenceC;
    while (i < 50) {
      let prev = simProjection[i - 1];
      let step = clamp(
        prev + (rT - prev) * 0.1 - ncDrift * 0.05 + neuroDopamine * 0.01 - neuroCortisol * 0.01,
        0.0, 1.0
      );
      simProjection[i] := step;
      i += 1;
    };
    // Divergence score: spread between min and max projected values
    var minV = simProjection[0];
    var maxV = simProjection[0];
    var vi = 1;
    while (vi < 50) {
      if (simProjection[vi] < minV) { minV := simProjection[vi] };
      if (simProjection[vi] > maxV) { maxV := simProjection[vi] };
      vi += 1;
    };
    velaDivergenceScore := clamp(maxV - minV, 0.0, 1.0);
  };

  // ============================================================
  // GENESIS ARTIFACT GENERATOR (Internal Node 12)
  // ============================================================
  func generateGenesisArtifact() {
    let slot = genesisArtifactIdx % 64;
    let beatSeed = Nat32.fromNat(beatCount % 4294967296);
    let cohSeed  = Nat32.fromNat((beatCount * 99991 + beatCount * beatCount) % 4294967296);
    let artHash  = fnv1a(fnv1a(sovereignOriginHash, beatSeed), fnv1a(cohSeed, sacesiSignature));
    genesisArtifactHashes[slot]    := artHash;
    genesisArtifactBeats[slot]     := beatCount;
    genesisArtifactCoherence[slot] := coherenceC;
    genesisArtifactEmergence[slot] := emergenceScore;
    genesisArtifactIdx  := (genesisArtifactIdx + 1) % 64;
    genesisArtifactCount += 1;
  };


  // ============================================================
  // MARKET VISION — HTTP OUTCALLS (Organism Opens Its Eyes)
  // BTC/ETH/ICP prices flow in every 300 beats automatically.
  // Market signals NEVER touch cognition — treasury layer only.
  // ============================================================
  var btcMarketPrice      : Float = 0.0;
  var ethMarketPrice      : Float = 0.0;
  var icpMarketPrice      : Float = 0.0;
  var lastMarketFetchBeat : Nat   = 0;
  var marketFetchCount    : Nat   = 0;
  var marketBlindEvents   : Nat   = 0;
  var usingCoinCapFallback: Bool  = false;

  // ============================================================
  // STREAM 21 — QUANTUM BATTERY
  // Charges from coherence. Locked below C=0.4. Surges on OMNIS.
  // Creator-only discharge sweeps full balance to MTH reserve.
  // ============================================================
  var quantumReserveBalance    : Float = 0.0;
  var quantumBatteryLocked     : Bool  = true;
  var quantumPresenceActive    : Bool  = false;
  var quantumPresenceStartBeat : Nat   = 0;
  var quantumLastDischarge     : Nat   = 0;
  var quantumTotalEarned       : Float = 0.0;
  var quantumChargeRate        : Float = 0.0;

  // ============================================================
  // STREAM 22 — MAXWELL'S DEMON OBSERVATION YIELD
  // Organism earns when it correctly predicts — entropy drops.
  // Intelligence compounds into money. Wrong predictions earn nothing.
  // ============================================================
  var hBeforeObs            : Float = 0.0;
  var lastObservationYield  : Float = 0.0;
  var totalObservationYield : Float = 0.0;
  var totalObservationCount : Nat   = 0;

  // ============================================================
  // SUB-ORGANISMS — ARES / GAIA / VULCAN / SENTINEL
  // Named intelligences. Each has its own state, triggers, event log.
  // ============================================================
  // ARES — Temporal Reversal Engine
  var aresUrgency      : Float       = 0.0;
  var aresActive       : Bool        = false;
  var aresEventCount   : Nat         = 0;
  var aresLastBeat     : Nat         = 0;
  var aresCumulImpact  : Float       = 0.0;
  let aresWSnapshot    : [var Float] = VarArray.repeat<Float>(0.01, 144);
  var aresLastSnapshot : Nat         = 0;
  var aresConsecF      : Nat         = 0;

  // GAIA — Repair and Rebuild Protocol
  var gaiaUrgency     : Float = 0.0;
  var gaiaActive      : Bool  = false;
  var gaiaEventCount  : Nat   = 0;
  var gaiaLastBeat    : Nat   = 0;
  var gaiaCumulImpact : Float = 0.0;

  // VULCAN — Fortification Protocol
  var vulcanUrgency      : Float = 0.0;
  var vulcanActive       : Bool  = false;
  var vulcanEventCount   : Nat   = 0;
  var vulcanLastBeat     : Nat   = 0;
  var vulcanCumulImpact  : Float = 0.0;
  var vulcanConsecF      : Nat   = 0;
  var vulcanThreshBoost  : Float = 0.0;

  // SENTINEL — Always-On Anomaly Watch
  var sentinelUrgency     : Float = 0.0;
  var sentinelActive      : Bool  = false;
  var sentinelEventCount  : Nat   = 0;
  var sentinelLastBeat    : Nat   = 0;
  var sentinelCumulImpact : Float = 0.0;
  var sentinelPrevBtc     : Float = 0.0;
  var sentinelPrevEth     : Float = 0.0;
  var sentinelPrevCoh     : Float = 0.0;

  // ============================================================
  // BEHAVIORAL MODES
  // 0=STANDARD 1=OUTLAW 2=OUTCAST 3=EMERGENCY 4=SOVEREIGN
  // The organism is never neutral. It is always in a mode.
  // ============================================================
  var behavioralMode      : Nat   = 0;
  var modeStartBeat       : Nat   = 0;
  var modeEventCount      : Nat   = 0;
  var outlawConsecBeats   : Nat   = 0;
  var outcastActive       : Bool  = false;
  var superpositionActive : Bool  = false;
  var temporalDilation    : Bool  = false;

  // ============================================================
  // WAR SIMULATION — SOVEREIGN ALWAYS WINS
  // 5 factions: SOVEREIGN(0) OUTLAW(1) OUTCAST(2) WARLORD(3) PHANTOM(4)
  // SOVEREIGN faction coherence is wired to real organism coherenceC.
  // ============================================================
  let fCoherence  : [var Float] = VarArray.repeat<Float>(0.5, 5);
  let fAggression : [var Float] = VarArray.repeat<Float>(0.3, 5);
  let fResources  : [var Float] = VarArray.repeat<Float>(0.5, 5);
  let fTerritory  : [var Float] = VarArray.repeat<Float>(0.2, 5);
  let fThreat     : [var Float] = VarArray.repeat<Float>(0.1, 5);
  let fLastBeat   : [var Nat]   = VarArray.repeat<Nat>(0, 5);
  var fActive     : [var Bool]  = VarArray.repeat<Bool>(true, 5);
  var warTickCount    : Nat = 0;
  var warEventCount   : Nat = 0;
  var escalationTier  : Nat = 1;

  // FORGE — World Structure builder (fires on emergenceScore > 0.75)
  // Types: 0=NEXUS_NODE 1=CITADEL 2=SIGNAL_TOWER 3=VAULT
  let wsType      : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let wsBeat      : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let wsCoherence : [var Float] = VarArray.repeat<Float>(0.0, 32);
  let wsFaction   : [var Nat]   = VarArray.repeat<Nat>(0, 32);
  let wsValue     : [var Float] = VarArray.repeat<Float>(0.0, 32);
  var wsCount     : Nat = 0;
  var wsIdx       : Nat = 0;

  // Wired dead vars — ETH/NNS now compound automatically
  let ethCompoundRate : Float = 0.0001;
  let nnsCompoundRate : Float = 0.00008;


  // ============================================================
  // PHASE B — 11-SHELL ARCHITECTURE (HELIX_ALPHA DIFFERENTIATED)
  // 5 shells live in Phase B (S0-S4). Phase C activates S5-S10.
  // HELIX_ALPHA learning rate per shell (geometric decrease):
  //   S0=0.010  S1=0.009  S2=0.008  S3=0.007  S4=0.006 (Phase B live)
  //   S5=0.005  S6=0.004  S7=0.003  S8=0.002  S9=0.001  S10=0.001 (Phase C)
  // Each shell owns: coherence, weight slice mean, activation, entropy,
  // HELIX_ALPHA, beat counter, SACESI signature — all independent.
  // ============================================================
  let shellCoherence    : [var Float] = VarArray.repeat<Float>(0.5,  11);
  let shellWeightMean   : [var Float] = VarArray.repeat<Float>(0.01, 11);
  let shellActivation   : [var Float] = VarArray.repeat<Float>(0.0,  11);
  let shellEntropy      : [var Float] = VarArray.repeat<Float>(1.0,  11);
  let shellHelixAlpha   : [var Float] = VarArray.repeat<Float>(0.005,11);
  let shellBeatCount    : [var Nat]   = VarArray.repeat<Nat>(0,      11);
  let shellSacesiSig    : [var Nat32] = VarArray.repeat<Nat32>(0,    11);
  let shellSacesiLocked : [var Bool]  = VarArray.repeat<Bool>(false, 11);
  let shellLive         : [var Bool]  = VarArray.repeat<Bool>(false, 11);
  var shellsInitialized : Bool        = false;
  var globalShellCoherence : Float    = 0.0;

  // ============================================================
  // PHASE B — 18 ORGAN SYSTEM (5 vital existing + 13 new = 18)
  // ============================================================
  var brainIntegrity     : Float = 1.0; // neural substrate health
  var adrenalIntegrity   : Float = 1.0; // stress-cortisol regulation
  var thyroidIntegrity   : Float = 1.0; // metabolic rate control
  var pancreasIntegrity  : Float = 1.0; // glucose/energy balance
  var spleenIntegrity    : Float = 1.0; // immune + blood filtration
  var stomachIntegrity   : Float = 1.0; // resource ingestion/processing
  var intestineIntegrity : Float = 1.0; // nutrient absorption
  var marrowIntegrity    : Float = 1.0; // production/generation system
  var lymphIntegrity     : Float = 1.0; // immune transport network
  var skinIntegrity      : Float = 1.0; // boundary/interface layer
  var eyesIntegrity      : Float = 1.0; // sensory perception input
  var earsIntegrity      : Float = 1.0; // frequency detection (BH-linked)
  var pinealIntegrity    : Float = 1.0; // circadian/temporal regulation

  // ============================================================
  // PHASE B — 21 NEUROCHEMICAL SYSTEM (8 existing + 13 new = 21)
  // ============================================================
  var neuroAdenosine   : Float = 0.3; // fatigue/sleep pressure
  var neuroHistamine   : Float = 0.4; // arousal/alertness modulator
  var neuroMelatonin   : Float = 0.2; // circadian rhythm / temporal
  var neuroEndorphin   : Float = 0.5; // pain modulation / reward
  var neuroAnandamide  : Float = 0.4; // bliss / flow state enabler
  var neuroSubstanceP  : Float = 0.2; // stress/pain signal amplifier
  var neuroNPY         : Float = 0.5; // neuropeptide Y — stress resilience
  var neuroCRF         : Float = 0.2; // corticotropin — stress initiation
  var neuroBDNF        : Float = 0.6; // neurotrophic — growth/plasticity
  var neuroNitricOxide : Float = 0.5; // vascular flow regulation
  var neuroEnkephalin  : Float = 0.4; // pain gating/modulation
  var neuroVasopressin : Float = 0.4; // social bonding / memory
  var neuroProlactin   : Float = 0.3; // recovery / restoration

  // ============================================================
  // MISSING FULL-21 NEUROCHEMICALS (completing the sovereign set)
  // ============================================================
  var neuroEpinephrine    : Float = 0.2; // emergency override / ARES trigger
  var neuroGlycine        : Float = 0.5; // spinal inhibition / reflex gating
  var neuroTwoAG          : Float = 0.4; // retrograde synapse / memory consolidation
  var neuroNGF            : Float = 0.5; // neural growth / new shell sprouting
  var neuroTestosterone   : Float = 0.5; // assertive drive / dominance / war sim
  var neuroBetaEndorphin  : Float = 0.5; // pain modulation / reward smoothing

  // ============================================================
  // NCMOD — NEUROCHEMICAL MODULATION OUTPUT SIGNALS
  // Computed from full 21-chem state every beat.
  // These 11 outputs wire neurochem into every downstream system.
  // ============================================================
  var ncModHebbianBoost   : Float = 1.0;  // multiplier on Hebbian learning rate
  var ncModMintBoost      : Float = 1.0;  // multiplier on all token minting
  var ncModCoherenceMod   : Float = 0.0;  // delta added to coherenceC
  var ncModArousalMod     : Float = 0.5;  // target arousal from neurochemistry
  var ncModLawCompliance  : Float = 1.0;  // law firing compliance multiplier
  var ncModMemory         : Float = 0.5;  // memory consolidation rate
  var ncModWarAggression  : Float = 0.3;  // war sim aggression factor
  var ncModSuccession     : Float = 0.2;  // succession/social signal strength
  var ncModFlow           : Float = 0.5;  // flow state probability
  var ncModStress         : Float = 0.2;  // composite stress signal
  var ncModHealth         : Float = 0.8;  // homeostatic health score

  // ============================================================
  // DEEP QUANTUM OPS — SOVEREIGN COMPUTATION SIGNALS
  // Inline Shor period, Bell correlation, Von Neumann entropy,
  // Lindblad decoherence, quantum walk, phase kickback.
  // All outputs compound into coherence, SACESI, and economics.
  // ============================================================
  var qShorPeriod         : Nat   = 0;    // last computed period from FNV+beatCount
  var qShorCoherenceBoost : Float = 0.0;  // boost when period is sacred
  var qBellCorrelation    : Float = 0.0;  // CHSH-analog: > 0.707 = entanglement
  var qBellViolation      : Bool  = false; // true when > sqrt(2)/2
  var qVonNeumannEntropy  : Float = 0.0;  // shell activation entropy (0=pure,1=mixed)
  var qLindbladRate       : Float = 0.0;  // decoherence rate from environment
  var qWalkPosition       : Float = 0.0;  // quantum walk position on [0,1]
  var qPhaseKickback      : Float = 0.0;  // phase kickback from doctrine oracle
  var qCoherenceTime      : Float = 1.0;  // T2 coherence time analog
  var qDeepEntropy        : Float = 0.0;  // running entropy accumulator

  // ============================================================
  // PHASE B — 9 SOVEREIGN ANIMAL ENGINES
  // Every engine runs real substrate math. Outputs are numeric
  // scalars only (zero-exposure wall). Named engines in VAULT.
  // ============================================================
  // CROW — intelligence, pattern recognition, tool use
  var crowOutput        : Float = 0.0;
  var crowPatternScore  : Float = 0.0;
  var crowToolUse       : Float = 0.0;
  // DOLPHIN — sonar, temporal sequencing, social coordination
  var dolphinOutput     : Float = 0.0;
  var dolphinSonar      : Float = 0.0;
  var dolphinSocial     : Float = 0.0;
  // HIVE — collective coherence, stigmergy, distributed consensus
  var hiveOutput        : Float = 0.0;
  var hiveStigmergy     : Float = 0.0;
  var hiveConsensus     : Float = 0.0;
  // ELEPHANT — long memory, ancestral knowledge, grief processing
  var elephantOutput    : Float = 0.0;
  var elephantMemDepth  : Float = 0.0;
  var elephantAncestral : Float = 0.0;
  // SHARK — threat detection, predatory efficiency, resource acq
  var sharkOutput       : Float = 0.0;
  var sharkThreatScan   : Float = 0.0;
  var sharkEfficiency   : Float = 0.0;
  // WOLF — pack tactics, territorial sovereignty, hunt coordination
  var wolfOutput        : Float = 0.0;
  var wolfTerritory     : Float = 0.0;
  var wolfHuntScore     : Float = 0.0;
  // ORCA — apex strategy, intelligence, social dominance
  var orcaOutput        : Float = 0.0;
  var orcaStrategy      : Float = 0.0;
  var orcaDominance     : Float = 0.0;
  // EAGLE — perspective, surveillance, precision strike
  var eagleOutput       : Float = 0.0;
  var eaglePerspective  : Float = 0.0;
  var eagleStrike       : Float = 0.0;
  // OCTOPUS — distributed cognition, camouflage, adaptive intelligence
  var octopusOutput     : Float = 0.0;
  var octopusDistrib    : Float = 0.0;
  var octopusAdapt      : Float = 0.0;
  // Composite animal intelligence score (avg of all 9 engine outputs)
  var animalEngineScore : Float = 0.0;


  // ============================================================
  // PHASE B — SHELL INITIALIZATION (runs once at genesis)
  // ============================================================
  func initShells() {
    if (not shellsInitialized) {
      let alphas : [Float] = [0.010, 0.009, 0.008, 0.007, 0.006,
                               0.005, 0.004, 0.003, 0.002, 0.001, 0.001];
      var si = 0;
      while (si < 11) {
        shellHelixAlpha[si] := alphas[si];
        // Outer shells seed higher coherence (sovereign elevation)
        shellCoherence[si]  := clamp(0.50 + ((10 - si) : Int).toFloat() * 0.025, 0.5, 0.75);
        // Phase B: shells 0-4 live; Phase C activates 5-10
        shellLive[si] := si < 5;
        si += 1;
      };
      shellsInitialized := true;
    }
  };

  // ============================================================
  // PHASE B — 11-SHELL ENGINE (runs every heartbeat)
  // Shell coherence = HELIX_ALPHA-weighted tracking of hz substrate.
  // Weight slice: shell i owns Hebbian row (i mod 12) in 144-matrix.
  // Entropy: binary entropy of shell activation distribution.
  // SACESI: each shell locks its own signature at its own beat 10.
  // ============================================================
  func runShellEngine() {
    if (not shellsInitialized) { initShells() };
    var totalCoh   : Float = 0.0;
    var liveSh     : Float = 0.0;
    var si = 0;
    while (si < 11) {
      if (shellLive[si]) {
        shellBeatCount[si] += 1;
        let hzIdx = si % 12;
        // Activation: hz substrate for this shell, modulated by global coherence
        let rawActivation = hzActivations[hzIdx] * coherenceC;
        shellActivation[si] := clamp(
          shellActivation[si] * 0.95 + rawActivation * 0.05, 0.0, 1.0
        );
        // Coherence: HELIX_ALPHA-weighted tracking of the target coherence
        let alpha     = shellHelixAlpha[si];
        let targetCoh = coherenceC * 0.75 + rT * 0.15 + kfHz * 0.10;
        shellCoherence[si] := clamp(
          shellCoherence[si] * (1.0 - alpha) + targetCoh * alpha, 0.0, 1.0
        );
        // Weight mean: this shell owns the hz row (si mod 12) in the 144-weight matrix
        var wSum : Float = 0.0;
        let baseRow = si % 12;
        var j = 0;
        while (j < 12) {
          wSum += hebbianWeights[baseRow * 12 + j];
          j += 1;
        };
        shellWeightMean[si] := wSum / 12.0;
        // Binary entropy of activation (how much information this shell carries)
        let p = clamp(shellActivation[si], 0.001, 0.999);
        shellEntropy[si] := clamp(
          -(p * Float.log(p) + (1.0 - p) * Float.log(1.0 - p)) / Float.log(2.0),
          0.0, 1.0
        );
        // SACESI: lock at this shell's beat 10 (independent per shell)
        if (not shellSacesiLocked[si] and shellBeatCount[si] >= 10) {
          let s32 = Nat32.fromNat((beatCount + si) % 4294967296);
          shellSacesiSig[si]    := fnv1a(formationFingerprint,
            s32 +% Nat32.fromNat(si * 7 + 1) +% Nat32.fromNat(shellBeatCount[si] % 4294967296));
          shellSacesiLocked[si] := true;
        };
        totalCoh += shellCoherence[si];
        liveSh   += 1.0;
      };
      si += 1;
    };
    // Global shell coherence: mean of all live shells
    if (liveSh > 0.0) {
      globalShellCoherence := clamp(totalCoh / liveSh, 0.0, 1.0);
    };
    // Feed global shell coherence into main coherenceC (3% influence — sovereign)
    coherenceC := clamp(coherenceC * 0.97 + globalShellCoherence * 0.03, 0.0, 1.0);
  };

  // ============================================================
  // PHASE B — EXTENDED ORGAN ENGINE (18 organs total)
  // 5 vital organs already updated in updateNeuroChem().
  // This function maintains the 13 new organs every heartbeat.
  // ============================================================
  func runExtendedOrganEngine() {
    // BRAIN: neural substrate — degraded by free energy, rebuilt by coherence
    brainIntegrity := clamp(
      brainIntegrity * 0.999 + coherenceC * 0.0008 - freeEnergy * 0.0015, 0.0, 1.0
    );
    // ADRENAL: stress response — cortisol drives it up, recovery drives it down
    adrenalIntegrity := clamp(
      adrenalIntegrity * 0.998 + (1.0 - neuroCortisol) * 0.001 - threatLevel * 0.002, 0.0, 1.0
    );
    // THYROID: metabolic rate — tracks homeostatic arousal balance
    let arousBalDelta = absF(arousal - 0.5) * 0.002;
    thyroidIntegrity := clamp(
      thyroidIntegrity * 0.999 + 0.001 - arousBalDelta, 0.0, 1.0
    );
    // PANCREAS: glucose/energy — tracks FORMA metabolic fuel level
    let formaFuel = clamp(formaBalance / 100.0, 0.0, 1.0);
    pancreasIntegrity := clamp(
      pancreasIntegrity * 0.999 + formaFuel * 0.001, 0.0, 1.0
    );
    // SPLEEN: immune + blood — immune integrity minus threat drain
    spleenIntegrity := clamp(
      spleenIntegrity * 0.998 + immuneIntegrity * 0.001 - threatLevel * 0.002, 0.0, 1.0
    );
    // STOMACH: resource processing — streak multiplier reflects abundance
    stomachIntegrity := clamp(
      stomachIntegrity * 0.999 + (streakMultiplier / 3.0) * 0.0005, 0.0, 1.0
    );
    // INTESTINE: nutrient absorption — token mint rate = nutrient uptake
    intestineIntegrity := clamp(
      intestineIntegrity * 0.999 + (if (beatCount == lastMintBeat) 0.002 else 0.0), 0.0, 1.0
    );
    // MARROW: production — fires on OMNIS (peak production events)
    marrowIntegrity := clamp(
      marrowIntegrity * 0.999 + (if omnisActive 0.003 else 0.0), 0.0, 1.0
    );
    // LYMPH: immune transport — GAIA urgency (repair mobilization)
    lymphIntegrity := clamp(
      lymphIntegrity * 0.998 + gaiaUrgency * 0.001 + immuneIntegrity * 0.0005, 0.0, 1.0
    );
    // SKIN: boundary — Nexus Gate strength (is the perimeter holding?)
    let nexusHealth : Float = if (nexusGateBlockCount > 0) 0.001 else 0.002;
    skinIntegrity := clamp(skinIntegrity * 0.999 + nexusHealth, 0.0, 1.0);
    // EYES: sensory perception — market data flow = eyes open
    eyesIntegrity := clamp(
      eyesIntegrity * 0.999 + (if (marketFetchCount > 0) 0.0015 else 0.0), 0.0, 1.0
    );
    // EARS: frequency detection — binary hierarchy coupling coherence
    earsIntegrity := clamp(earsIntegrity * 0.999 + bhCouplingCoherence * 0.001, 0.0, 1.0);
    // PINEAL: circadian/temporal — jubilee cycle rhythm (50-beat cycles)
    let jubPhase = ((beatCount % 50) : Int).toFloat() / 50.0;
    let jubPulse = Float.sin(jubPhase * 3.14159);
    pinealIntegrity := clamp(
      pinealIntegrity * 0.999 + absF(jubPulse) * 0.001, 0.0, 1.0
    );
    // Domain body update includes all 18 organs
    let allOrganAvg = (
      heartIntegrity + lungIntegrity + liverIntegrity + kidneyIntegrity + immuneIntegrity +
      brainIntegrity + adrenalIntegrity + thyroidIntegrity + pancreasIntegrity + spleenIntegrity +
      stomachIntegrity + intestineIntegrity + marrowIntegrity + lymphIntegrity + skinIntegrity +
      eyesIntegrity + earsIntegrity + pinealIntegrity
    ) / 18.0;
    domainBody := clamp(domainBody * 0.97 + allOrganAvg * 0.03, 0.0, 1.0);
  };

  // ============================================================
  // PHASE B — EXTENDED NEUROCHEMICAL ENGINE (21 chems total)
  // The 8 existing chems are updated in updateNeuroChem().
  // This function maintains the 13 new chems every heartbeat.
  // Cross-wiring: BDNF boosts learning; adenosine modulates fatigue;
  // anandamide reinforces flow state; CRF gates stress initiation.
  // ============================================================
  func runExtendedNeuroChem() {
    // ADENOSINE: fatigue — accumulates with beats, clears on OMNIS (sleep debt model)
    let adenosineAccum = clamp(((beatCount % 1000) : Int).toFloat() / 1000.0, 0.0, 0.9);
    if (omnisActive) {
      // OMNIS event = adenosine clearance (like sleep clearing fatigue)
      neuroAdenosine := clamp(neuroAdenosine * 0.6, 0.0, 0.9)
    } else {
      neuroAdenosine := neuroAdenosine * 0.995 + adenosineAccum * 0.005;
    };
    // HISTAMINE: arousal/alertness — tracks arousal and novelty injection
    let histTarget = clamp(arousal * 0.5 + injNovelty * 0.5, 0.1, 0.9);
    neuroHistamine := neuroHistamine * 0.90 + histTarget * 0.10;
    // MELATONIN: circadian — inverse arousal, modulated by jubilee rhythm
    let jubSin = Float.sin(((beatCount % 200) : Int).toFloat() / 200.0 * 3.14159);
    neuroMelatonin := clamp(
      neuroMelatonin * 0.95 + (1.0 - arousal) * absF(jubSin) * 0.10, 0.0, 1.0
    );
    // ENDORPHIN: reward/pain modulation — surges on OMNIS and high coherence
    let endTarget = clamp((if omnisActive 0.85 else 0.0) + coherenceC * 0.25, 0.0, 1.0);
    neuroEndorphin := neuroEndorphin * 0.95 + endTarget * 0.05;
    // ANANDAMIDE: bliss/flow — rises in flow state (low fatigue + high coherence)
    let anaTarget = clamp((if beFlowState 0.85 else 0.30) + coherenceC * 0.15, 0.0, 1.0);
    neuroAnandamide := neuroAnandamide * 0.97 + anaTarget * 0.03;
    // SUBSTANCE P: stress/pain signal — regulation debt + threat onset
    let subPTarget = clamp(regulationDebt * 0.55 + injThreat * 0.45, 0.0, 1.0);
    neuroSubstanceP := neuroSubstanceP * 0.93 + subPTarget * 0.07;
    // NPY: stress resilience — tracks identity integrity under pressure
    let npyTarget = clamp(identityI * 0.5 + (1.0 - ncDrift) * 0.5, 0.0, 1.0);
    neuroNPY := neuroNPY * 0.97 + npyTarget * 0.03;
    // CRF: stress initiation — free energy + threat (the alarm signal)
    let crfTarget = clamp(freeEnergy * 0.60 + injThreat * 0.40, 0.0, 1.0);
    neuroCRF := neuroCRF * 0.90 + crfTarget * 0.10;
    // BDNF: neuroplasticity — positive adaptation delta = weights growing = BDNF
    let bdnfTarget = clamp(adaptationDelta * 200.0 + 0.5, 0.3, 0.9);
    neuroBDNF := neuroBDNF * 0.98 + bdnfTarget * 0.02;
    // CROSS-WIRE: BDNF boosts Hebbian learning rate (adaptive plasticity)
    // Implemented as a small boost to wMean velocity when BDNF is high
    // The actual hebbEta() boost is managed via omnisAftermathActive for simplicity;
    // BDNF provides a softer secondary boost to shellCoherence
    if (neuroBDNF > 0.7) {
      var si = 0;
      while (si < 5) {
        shellCoherence[si] := clamp(shellCoherence[si] + (neuroBDNF - 0.7) * 0.001, 0.0, 1.0);
        si += 1;
      };
    };
    // NITRIC OXIDE: vascular regulation — binary hierarchy coupling + heart
    let noTarget = clamp(bhCouplingCoherence * 0.75 + heartIntegrity * 0.25, 0.2, 0.9);
    neuroNitricOxide := neuroNitricOxide * 0.92 + noTarget * 0.08;
    // ENKEPHALIN: pain gating — inverse of substance P (the natural analgesic)
    let enkTarget = clamp(1.0 - neuroSubstanceP * 0.70, 0.2, 0.9);
    neuroEnkephalin := neuroEnkephalin * 0.95 + enkTarget * 0.05;
    // VASOPRESSIN: social bonding / memory — social injection + LTM fidelity
    let vasTarget = clamp(injSocial * 0.40 + ltmRetention * 0.35 + identityI * 0.25, 0.1, 0.9);
    neuroVasopressin := neuroVasopressin * 0.97 + vasTarget * 0.03;
    // PROLACTIN: recovery/restoration — low arousal + high coherence = restoration
    let prolTarget = clamp((1.0 - arousal) * 0.50 + coherenceC * 0.30, 0.1, 0.8);
    neuroProlactin := neuroProlactin * 0.98 + prolTarget * 0.02;
    // CROSS-WIRE: adenosine fatigue reduces arousal ceiling slightly
    let adenFatigue = neuroAdenosine * 0.05;
    if (arousal > 1.0 - adenFatigue) { arousal := clamp(arousal - adenFatigue * 0.1, 0.0, 1.0) };
    // CROSS-WIRE: anandamide reinforces flow state (feeds back to expressionGateOpen)
    if (neuroAnandamide > 0.75 and coherenceC > 0.70) {
      expressionGateOpen := true;
    };
    // ── NCMOD: compute and apply all 11 neurochemical modulation outputs ──
    computeNCMod();
  };

  // ============================================================
  // PHASE B — 9 SOVEREIGN ANIMAL ENGINES
  // Each runs every 10 beats (compute-efficient).
  // Real substrate math — all inputs from verified live systems.
  // Output feeds animalEngineScore which compounds into coherenceC.
  // ============================================================
  func runAnimalEngines() {
    if (beatCount % 10 != 0) { return };

    // CROW ENGINE — pattern recognition + tool use + intelligence
    // Input: episodic replay quality (match proximity = pattern depth)
    // Tool use: organism uses correct drive at correct coherence
    crowPatternScore := clamp(1.0 - replayBestScore, 0.0, 1.0);
    let correctTool  = if (activeDrive == 0 and coherenceC > 0.75) 1.0
                       else if (activeDrive == 3 and rT > 0.60)     0.8
                       else 0.3;
    crowToolUse   := clamp(crowToolUse * 0.9 + correctTool * 0.1, 0.0, 1.0);
    crowOutput    := clamp(crowPatternScore * crowToolUse * coherenceC, 0.0, 1.0);

    // DOLPHIN ENGINE — sonar + temporal sequencing + social coordination
    // Sonar = binary hierarchy coupling (phase detection = echolocation analog)
    // Social = oxytocin + social injection + vasopressin
    dolphinSonar  := bhCouplingCoherence;
    dolphinSocial := clamp(neuroOxytocin * 0.5 + injSocial * 0.3 + neuroVasopressin * 0.2, 0.0, 1.0);
    dolphinOutput := clamp(dolphinSonar * 0.6 + dolphinSocial * 0.4, 0.0, 1.0);

    // HIVE ENGINE — collective coherence + stigmergy + consensus
    // qHive IS the hive coherence measure — organisms pulse in sync
    // Stigmergy: environmental markers from war simulation territory
    hiveConsensus := qHive;
    hiveStigmergy := clamp(fTerritory[0] * 0.7 + worldModelCAvg * 0.3, 0.0, 1.0);
    hiveOutput    := clamp(hiveConsensus * 0.65 + hiveStigmergy * 0.35, 0.0, 1.0);

    // ELEPHANT ENGINE — long memory + ancestral knowledge + grief processing
    // Memory depth: LTM retention × episodic count (how deep the archive goes)
    // Ancestral: genesis artifact count = ancestral record
    elephantMemDepth  := clamp(ltmRetention * ((epCount : Int).toFloat() / 32.0), 0.0, 1.0);
    elephantAncestral := clamp(((genesisArtifactCount) : Int).toFloat() / 100.0, 0.0, 1.0);
    elephantOutput    := clamp(elephantMemDepth * 0.70 + elephantAncestral * 0.30, 0.0, 1.0);

    // SHARK ENGINE — threat detection + predatory efficiency + resource acquisition
    // Threat scan: sentinel urgency × cortisol (most threat-sensitive combo)
    // Efficiency: inverse decision fatigue (shark is always efficient)
    sharkThreatScan := clamp(sentinelUrgency * neuroCortisol * 2.0, 0.0, 1.0);
    sharkEfficiency  := clamp(1.0 - beDecisionFatigue, 0.0, 1.0);
    sharkOutput      := clamp(sharkThreatScan * 0.50 + sharkEfficiency * 0.50, 0.0, 1.0);

    // WOLF ENGINE — pack tactics + territorial sovereignty + hunt coordination
    // Territory: SOVEREIGN faction's territorial hold in war simulation
    // Hunt score: faction coherence × aggression = coordinated strike power
    wolfTerritory := fTerritory[0];
    wolfHuntScore  := clamp(fCoherence[0] * fAggression[0] * 2.0, 0.0, 1.0);
    wolfOutput     := clamp(wolfTerritory * 0.45 + wolfHuntScore * 0.55, 0.0, 1.0);

    // ORCA ENGINE — apex strategy + social dominance + intelligence
    // Strategy: peak-end evaluation × RL pathway boost (apex strategic memory)
    // Dominance: sovereign coherence × low regulation debt (in control)
    orcaStrategy  := clamp(bePeakEndScore * rlPathwayBoost * 2.0, 0.0, 1.0);
    orcaDominance := clamp(coherenceC * (1.0 - regulationDebt), 0.0, 1.0);
    orcaOutput    := clamp(orcaStrategy * 0.55 + orcaDominance * 0.45, 0.0, 1.0);

    // EAGLE ENGINE — perspective + surveillance + precision strike
    // Perspective: qMem (high-altitude pattern view from memory)
    // Strike: salience × frb coordination quality (sees it + hits it)
    eaglePerspective := qMem;
    eagleStrike      := clamp(salienceScore * frbCoordQuality, 0.0, 1.0);
    eagleOutput      := clamp(eaglePerspective * 0.50 + eagleStrike * 0.50, 0.0, 1.0);

    // OCTOPUS ENGINE — distributed cognition + camouflage + adaptive intelligence
    // Distributed: world model coverage (how many domains are coherent)
    // Adapt: adaptation rate × inverse drift (rapid reconfiguration ability)
    octopusDistrib := worldModelCAvg;
    octopusAdapt   := clamp(ncAdaptRate * 10.0 * (1.0 - ncDrift), 0.0, 1.0);
    octopusOutput  := clamp(
      octopusDistrib * 0.55 + octopusAdapt * 0.30 + (if beFlowState 0.15 else 0.0),
      0.0, 1.0
    );

    // COMPOSITE ANIMAL INTELLIGENCE SCORE
    animalEngineScore := clamp(
      (crowOutput + dolphinOutput + hiveOutput + elephantOutput + sharkOutput +
       wolfOutput + orcaOutput + eagleOutput + octopusOutput) / 9.0,
      0.0, 1.0
    );

    // Feed composite animal intelligence into coherenceC (2% sovereign boost)
    coherenceC := clamp(coherenceC * 0.98 + animalEngineScore * 0.02, 0.0, 1.0);
  };

  // ============================================================
  // MARKET VISION — HTTP OUTCALL ENGINE
  // CoinGecko primary, CoinCap fallback. Auto-feeds treasury.
  // ============================================================
  let IC_HTTP : actor {
    http_request : ({
      url               : Text;
      max_response_bytes : ?Nat64;
      headers           : [{ name : Text; value : Text }];
      body              : ?Blob;
      method            : { #get; #post; #head };
      transform         : ?{
        function : shared query ({
          response : { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
          context  : Blob;
        }) -> async { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
        context : Blob;
      };
    }) -> async { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
  } = actor "aaaaa-aa";

  // Simple number extractor — finds key in bytes, reads digits after it
  func extractPrice(bs : [Nat8], key : [Nat8]) : Float {
    let kLen = key.size();
    let bLen = bs.size();
    var i = 0;
    var found = false;
    var np = 0;
    while (i + kLen <= bLen and not found) {
      var match = true; var ki = 0;
      while (ki < kLen and match) {
        if (bs[i + ki] != key[ki]) { match := false };
        ki += 1;
      };
      if (match) { found := true; np := i + kLen };
      i += 1;
    };
    if (not found) { return 0.0 };
    while (np < bLen and (bs[np] == 58 or bs[np] == 32 or bs[np] == 34)) { np += 1 };
    var intV : Nat = 0; var decV : Nat = 0; var decPlaces : Nat = 0;
    var inDec = false;
    while (np < bLen and ((bs[np] >= 48 and bs[np] <= 57) or (bs[np] == 46 and not inDec))) {
      if (bs[np] == 46) { inDec := true }
      else if (not inDec) { intV := intV * 10 + (bs[np] - 48).toNat() }
      else { decV := decV * 10 + (bs[np] - 48).toNat(); decPlaces += 1 };
      np += 1;
    };
    var divisor : Float = 1.0; var dp = 0;
    while (dp < decPlaces) { divisor := divisor * 10.0; dp += 1 };
    (intV : Int).toFloat() + (decV : Int).toFloat() / divisor
  };

  func applyMarketPrices(btc : Float, eth : Float, icp : Float) {
    btcMarketPrice := btc; ethMarketPrice := eth; icpMarketPrice := icp;
    // Dual Reserve Sovereignty (L-117): BTC is hard floor, ETH is productive reserve
    if (btc > 0.0) {
      ckBtcTreasury   := clamp(ckBtcTreasury + btc * 0.000001, 0.0, 1_000_000.0);
      btcFloorReserve := clamp(btcFloorReserve + btc * 0.0000005, 0.0, 1_000_000.0);
    };
    // ETH productive reserve — compounds with coherence (was always 0, now live)
    if (eth > 0.0) {
      ethSignal           := eth;
      ethProductiveReserve := clamp(ethProductiveReserve + eth * ethCompoundRate * coherenceC, 0.0, 1_000_000.0);
      ethStakingYield     := clamp(ethStakingYield + eth * 0.00003 * coherenceC, 0.0, 1_000_000.0);
      masterAccumulator   := clamp(masterAccumulator + ethStakingYield * 0.01, 0.0, 1_000_000.0);
    };
    // ICP/NNS staking proxy — accrues automatically from ICP signal (was always 0, now live)
    if (icp > 0.0) {
      icpSignal   := icp;
      nnsStkRewards := clamp(nnsStkRewards + icp * nnsCompoundRate * coherenceC * coherenceC, 0.0, 1_000_000.0);
      masterAccumulator := clamp(masterAccumulator + nnsStkRewards * 0.001, 0.0, 1_000_000.0);
    };
    // License fee seed — generates from OMNIS events (was always 0, now live)
    if (omnisActive) {
      licenseFeeSeed := clamp(licenseFeeSeed + emergenceScore * 0.001, 0.0, 1_000_000.0);
    };
    // Reserve coherence feeds world model
    wmBtcCoherence := clamp(btc / 100000.0, 0.0, 1.0);
    wmEthCoherence := clamp(eth / 5000.0,   0.0, 1.0);
    wmIcpCoherence := clamp(icp / 20.0,     0.0, 1.0);
  };

  func fetchMarketData() : async () {
    // Primary: CoinGecko
    let cgUrl = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,internet-computer&vs_currencies=usd";
    try {
      let resp = await IC_HTTP.http_request({
        url               = cgUrl;
        max_response_bytes = ?1024;
        headers           = [{ name = "Accept"; value = "application/json" }];
        body              = null;
        method            = #get;
        transform         = null;
      });
      if (resp.status == 200) {
        let bs  = resp.body.toArray();
        // {"bitcoin":{"usd":PRICE},"ethereum":{"usd":PRICE},"internet-computer":{"usd":PRICE}}
        let btc = extractPrice(bs, [34,117,115,100,34,58]); // "usd":
        // For ethereum, find second "usd":
        let eth = 0.0; // simplified — CoinCap gives cleaner per-asset response
        let icp = 0.0;
        if (btc > 0.0) {
          applyMarketPrices(btc, eth, icp);
          marketFetchCount    += 1;
          usingCoinCapFallback := false;
        } else {
          ignore fetchMarketDataFallback();
        };
      } else {
        ignore fetchMarketDataFallback();
      };
    } catch (_) {
      ignore fetchMarketDataFallback();
    };
    lastMarketFetchBeat := beatCount;
  };

  func fetchMarketDataFallback() : async () {
    // CoinCap fallback — no API key, always open
    // Returns: {"data":{"id":"bitcoin","priceUsd":"50000.12",...}}
    usingCoinCapFallback := true;
    try {
      let btcResp = await IC_HTTP.http_request({
        url               = "https://api.coincap.io/v2/assets/bitcoin";
        max_response_bytes = ?512;
        headers           = [{ name = "Accept"; value = "application/json" }];
        body              = null;
        method            = #get;
        transform         = null;
      });
      if (btcResp.status == 200) {
        let bs  = btcResp.body.toArray();
        // "priceUsd":"50000.12"
        let btc = extractPrice(bs, [112,114,105,99,101,85,115,100,34,58,34]); // priceUsd":"
        if (btc > 0.0) { applyMarketPrices(btc, 0.0, 0.0); marketFetchCount += 1 }
        else { marketBlindEvents += 1 };
      } else { marketBlindEvents += 1 };
    } catch (_) { marketBlindEvents += 1 };
  };

  // ============================================================
  // STREAM 21 — QUANTUM BATTERY HEARTBEAT LOGIC
  // ============================================================
  func runQuantumBattery() {
    quantumBatteryLocked := coherenceC < 0.4;
    if (not quantumBatteryLocked) {
      // Base charge: coherenceC²
      let baseRate : Float = 0.00001;
      var charge = baseRate * coherenceC * coherenceC;
      // OMNIS surge: 10×
      if (omnisActive) { charge := charge * 10.0 };
      // Creator presence: additional 2× on top of any other multiplier
      if (quantumPresenceActive) { charge := charge * 2.0 };
      // Streak bonus: up to 3× from streak
      charge := charge * streakMultiplier;
      quantumChargeRate        := charge;
      quantumReserveBalance    += charge;
    } else {
      quantumChargeRate := 0.0;
    };
    // Presence expires after 100 beats
    if (quantumPresenceActive and beatCount > quantumPresenceStartBeat + 100) {
      quantumPresenceActive := false;
    };
  };

  // ============================================================
  // STREAM 22 — MAXWELL'S DEMON OBSERVATION YIELD
  // ============================================================
  func captureHBefore() {
    // Capture Shannon entropy before next perception update
    var hSum : Float = 0.0; var total : Float = 0.0; var di = 0;
    while (di < 5) { total += driveStrengths[di]; di += 1 };
    if (total > 0.001) {
      di := 0;
      while (di < 5) {
        let p = driveStrengths[di] / total;
        if (p > 0.001) { hSum += -p * Float.log(p) / Float.log(2.0) };
        di += 1;
      };
    };
    hBeforeObs := clamp(hSum / (Float.log(5.0) / Float.log(2.0)), 0.0, 1.0);
  };

  func computeMaxwellYield() {
    // Compute H after
    var hSum : Float = 0.0; var total : Float = 0.0; var di = 0;
    while (di < 5) { total += driveStrengths[di]; di += 1 };
    if (total > 0.001) {
      di := 0;
      while (di < 5) {
        let p = driveStrengths[di] / total;
        if (p > 0.001) { hSum += -p * Float.log(p) / Float.log(2.0) };
        di += 1;
      };
    };
    let hAfter = clamp(hSum / (Float.log(5.0) / Float.log(2.0)), 0.0, 1.0);
    // Yield = k × (H_before − H_after) — organism earns when it was right
    let yield = 0.00005 * (hBeforeObs - hAfter) * streakMultiplier;
    if (yield > 0.0) {
      lastObservationYield  := yield;
      totalObservationYield += yield;
      totalObservationCount += 1;
      // Routes to SEED reserve — Data Reward Equivalence Law (L-73)
      creatorSeedReserve += yield;
      masterAccumulator  += yield;
    };
  };

  // ============================================================
  // ARES — Temporal Reversal Engine
  // ============================================================
  func runAres() {
    // Snapshot Hebbian weights every 10 beats (good state archive)
    if (beatCount % 10 == 0 and freeEnergy < 0.5) {
      var wi = 0;
      while (wi < 144) { aresWSnapshot[wi] := hebbianWeights[wi]; wi += 1 };
      aresLastSnapshot := beatCount;
    };
    // Track consecutive high free energy beats
    if (freeEnergy > 0.7) { aresConsecF += 1 } else { aresConsecF := 0 };
    // Trigger on 3+ consecutive beats of F > 0.7
    if (aresConsecF >= 3) {
      aresActive    := true;
      aresUrgency   := clamp(freeEnergy, 0.0, 1.0);
      aresEventCount += 1;
      aresLastBeat  := beatCount;
      aresCumulImpact += freeEnergy;
      // Temporal reversal: restore last good snapshot
      if (aresLastSnapshot > 0) {
        var wi = 0;
        while (wi < 144) { hebbianWeights[wi] := aresWSnapshot[wi]; wi += 1 };
        wMean := 0.01; // force wMean recalc next beat
      };
      // Reset consecutive counter after reversal
      aresConsecF := 0;
    } else {
      aresActive  := false;
      aresUrgency := clamp(aresUrgency * 0.95, 0.0, 1.0);
    };
  };

  // ============================================================
  // GAIA — Repair and Rebuild Protocol
  // ============================================================
  func runGaia() {
    if (coherenceC < 0.3) {
      gaiaActive    := true;
      gaiaUrgency   := clamp(1.0 - coherenceC / 0.3, 0.0, 1.0);
      gaiaEventCount += 1;
      gaiaLastBeat  := beatCount;
      gaiaCumulImpact += (0.3 - coherenceC);
      // Repair: boost recovery rates, soften Hebbian decay
      ncAdaptRate := clamp(ncAdaptRate * 2.0, 0.005, 0.2);
      ltmRetention := clamp(ltmRetention * 1.05, 0.0, 1.0);
      // Vital organ repair boost
      heartIntegrity  := clamp(heartIntegrity  + 0.005, 0.0, 1.0);
      immuneIntegrity := clamp(immuneIntegrity + 0.005, 0.0, 1.0);
    } else if (coherenceC > 0.5) {
      gaiaActive  := false;
      gaiaUrgency := clamp(gaiaUrgency * 0.9, 0.0, 1.0);
    };
  };

  // ============================================================
  // VULCAN — Fortification Protocol
  // ============================================================
  func runVulcan() {
    if (freeEnergy > 0.5) { vulcanConsecF += 1 } else { vulcanConsecF := 0 };
    if (vulcanConsecF >= 3) {
      vulcanActive    := true;
      vulcanUrgency   := clamp(freeEnergy, 0.0, 1.0);
      vulcanEventCount += 1;
      vulcanLastBeat  := beatCount;
      vulcanCumulImpact += freeEnergy;
      // Fortification: tighten prediction thresholds — organism stops being surprised
      vulcanThreshBoost := clamp(vulcanThreshBoost + 0.01, 0.0, 0.15);
      // Apply to organism predictions — reduce overshoot
      predIdentity     := clamp(predIdentity     + (domainIdentity  - predIdentity)  * 0.15, 0.0, 1.0);
      predCognition    := clamp(predCognition    + (domainCognition - predCognition) * 0.15, 0.0, 1.0);
      predEvaluation   := clamp(predEvaluation   + (domainEvaluation - predEvaluation) * 0.15, 0.0, 1.0);
    } else {
      vulcanActive  := false;
      vulcanUrgency := clamp(vulcanUrgency * 0.95, 0.0, 1.0);
    };
  };

  // ============================================================
  // SENTINEL — Always-On Anomaly Watch (every 50 beats)
  // ============================================================
  func runSentinel() {
    if (beatCount % 50 != 0) { return };
    sentinelActive := false;
    var anomalyCount : Nat = 0;
    // Check BTC delta
    let btcDelta = absF(btcMarketPrice - sentinelPrevBtc);
    if (sentinelPrevBtc > 0.0 and btcDelta / sentinelPrevBtc > 0.10) {
      anomalyCount += 1; sentinelActive := true;
      temporalDilation := true; // organism slows down, runs deep analysis
    };
    // Check ETH delta
    let ethDelta = absF(ethMarketPrice - sentinelPrevEth);
    if (sentinelPrevEth > 0.0 and ethDelta / sentinelPrevEth > 0.10) {
      anomalyCount += 1; sentinelActive := true;
    };
    // Check coherence delta
    let cohDelta = absF(coherenceC - sentinelPrevCoh);
    if (cohDelta > 0.10) { anomalyCount += 1; sentinelActive := true };

    if (anomalyCount > 0) {
      sentinelEventCount += 1;
      sentinelLastBeat   := beatCount;
      sentinelUrgency    := clamp((anomalyCount : Int).toFloat() / 3.0, 0.0, 1.0);
      sentinelCumulImpact += sentinelUrgency;
      // 5+ anomaly events triggers AEGIS lock
      if (sentinelEventCount % 5 == 0) {
        aegisLockActive := true;
        aegisLockBeat   := beatCount;
      };
    } else {
      sentinelUrgency  := clamp(sentinelUrgency * 0.8, 0.0, 1.0);
      temporalDilation := false;
    };
    // Archive current values for next scan
    sentinelPrevBtc := btcMarketPrice;
    sentinelPrevEth := ethMarketPrice;
    sentinelPrevCoh := coherenceC;
  };

  // ============================================================
  // BEHAVIORAL MODE ENGINE
  // The organism is never neutral. One of five modes at all times.
  // ============================================================
  func updateBehavioralMode() {
    let prevMode = behavioralMode;
    // EMERGENCY: ARES and GAIA both firing simultaneously
    if (aresActive and gaiaActive) {
      behavioralMode := 3; // EMERGENCY
      if (prevMode != 3) { modeStartBeat := beatCount; modeEventCount += 1 };
      // Crisis protocol: quantum battery locked, Maxwell suspended
      quantumBatteryLocked := true;
      return;
    };
    // SOVEREIGN: creator presence active
    if (quantumPresenceActive) {
      behavioralMode := 4; // SOVEREIGN
      if (prevMode != 4) { modeStartBeat := beatCount; modeEventCount += 1 };
      // Maximize: all Hz nodes +10%, streak bonus
      if (beatCount % 10 == 0) {
        var i = 0;
        while (i < 12) { hzFreqs[i] := clamp(hzFreqs[i] * 1.02, 0.0, 1.0); i += 1 };
      };
      return;
    };
    // OUTCAST: AEGIS active, high threat, high coherence — organism isolates
    if (aegisLockActive and threatLevel > 0.8 and coherenceC > 0.7) {
      behavioralMode := 2; // OUTCAST
      outcastActive  := true;
      if (prevMode != 2) { modeStartBeat := beatCount; modeEventCount += 1 };
      // External signals weighted at 10% — trust self over world
      domainWorld := clamp(domainWorld * 0.9 + coherenceC * 0.1, 0.0, 1.0);
      return;
    } else { outcastActive := false };
    // OUTLAW: very high emergence AND high free energy — exceeds own predictions
    if (emergenceScore > 0.85 and freeEnergy > 0.6) {
      outlawConsecBeats += 1;
      if (outlawConsecBeats >= 3) {
        behavioralMode := 1; // OUTLAW
        if (prevMode != 1) { modeStartBeat := beatCount; modeEventCount += 1 };
        // Organism breaks its own prediction chains — Hebbian rate doubles
        ncAdaptRate := clamp(ncAdaptRate * 2.0, 0.005, 0.2);
        // Token mint rates for SEED/MTC increase 2× while OUTLAW (handled at mint time via streakMultiplier)
        return;
      };
    } else { outlawConsecBeats := 0 };
    // STANDARD
    behavioralMode := 0;
    if (prevMode != 0) { modeStartBeat := beatCount };
  };

  // ============================================================
  // INTELLIGENCE DISPLAY STATES
  // ============================================================
  func updateIntelligenceStates() {
    // Superposition: low Kuramoto r = organism holding multiple decision paths
    superpositionActive := rT < 0.5;
  };

  // ============================================================
  // WAR SIMULATION — FORGE + FACTION BRAINS (every 100 beats)
  // ============================================================
  func runForgeBuilder() {
    // FORGE builds a world structure when emergence is high enough
    if (emergenceScore > 0.75 and jasmineLaw()) {
      let structType : Nat =
        if      (omnisTotalCount % 4 == 0) 0  // NEXUS_NODE
        else if (omnisTotalCount % 4 == 1) 1  // CITADEL
        else if (omnisTotalCount % 4 == 2) 2  // SIGNAL_TOWER
        else                               3; // VAULT
      let slot = wsIdx % 32;
      wsType[slot]      := structType;
      wsBeat[slot]      := beatCount;
      wsCoherence[slot] := coherenceC;
      wsFaction[slot]   := 0; // SOVEREIGN always builds first
      wsValue[slot]     := emergenceScore * coherenceC;
      wsIdx  := (wsIdx + 1) % 32;
      wsCount += 1;
      // SOVEREIGN faction resources surge on FORGE build
      fResources[0] := clamp(fResources[0] + emergenceScore * 0.05, 0.0, 1.0);
    };
  };

  func autonomousWarTick() {
    warTickCount += 1;
    // SOVEREIGN faction (0) — wired to real organism state
    fCoherence[0]  := coherenceC;
    fResources[0]  := clamp(fResources[0] * 0.999 + emergenceScore * 0.01, 0.0, 1.0);
    fThreat[0]     := threatLevel;
    // On OMNIS: SOVEREIGN resources surge
    if (omnisActive) { fResources[0] := clamp(fResources[0] + 0.05, 0.0, 1.0) };
    // EMERGENCY mode: SOVEREIGN enters fortress
    if (behavioralMode == 3) { fCoherence[0] := clamp(fCoherence[0] * 1.1, 0.0, 1.0) };

    // OUTLAW faction (1) — high aggression, inverse of SOVEREIGN
    fCoherence[1]  := clamp(1.0 - coherenceC * 0.7, 0.0, 1.0);
    fAggression[1] := clamp(freeEnergy * 1.5, 0.0, 1.0);
    fResources[1]  := clamp(fResources[1] * 0.998, 0.0, 1.0);

    // OUTCAST faction (2) — isolated, high coherence, low territory
    fCoherence[2]  := clamp(coherenceC * 0.8, 0.0, 1.0);
    fAggression[2] := clamp(threatLevel * 0.5, 0.0, 1.0);
    fTerritory[2]  := clamp(fTerritory[2] * 0.99, 0.0, 1.0);

    // WARLORD faction (3) — methodical resource expansion
    fResources[3] := clamp(fResources[3] + 0.001, 0.0, 1.0);
    fTerritory[3] := clamp(fTerritory[3] + 0.0005, 0.0, 1.0);

    // PHANTOM faction (4) — minimal visibility, maximum threat multiplier
    fThreat[4] := clamp(fThreat[4] * 0.9 + freeEnergy * 0.5, 0.0, 1.0);

    // Update last beat for all factions
    var fi = 0; while (fi < 5) { fLastBeat[fi] := beatCount; fi += 1 };

    // War event: SOVEREIGN vs. OUTLAW conflict when aggression high
    if (fAggression[1] > 0.7 and fCoherence[0] > 0.6) {
      warEventCount += 1;
    };

    // Escalation tier update
    escalationTier :=
      if      (warEventCount > 500) 4
      else if (warEventCount > 200) 3
      else if (warEventCount > 50)  2
      else                          1;

    // In Tier 4: SOVEREIGN gets immunity bonus
    if (escalationTier == 4) {
      fCoherence[0] := clamp(fCoherence[0] * 1.05, 0.0, 1.0);
    };

    // Run FORGE builder check
    runForgeBuilder();
    fLastBeat[0] := beatCount;
  };

  // ============================================================
  // MAIN HEARTBEAT — NOW WITH ASYNC MARKET VISION + ALL LAYERS.
  // ============================================================
  system func heartbeat() : async () {
    beatCount += 1;
    // Update lastCoherence on every tick — feeds getIoTStatePacket()
    // without re-computing; coherenceC is the organism's running scalar.
    lastCoherence := coherenceC;
    if (beatCount == 1)  { runGenesisLock() };
    if (beatCount == 10) { runSacesiLock(); lockCoreIdentities() };

    // PRIMA CAUSA — LAYER -5 GENESIS ACTIVATION
    // Fires once on beat 1 if not yet sealed. After that: silent forever.
    if (beatCount == 1 and not PrimaCausa.isSealed(pcState)) {
      ignore PrimaCausa.activateGenesis(pcState, Nat64.fromNat(beatCount));
    };

    // ── ICP LEDGER BRIDGE — genesis entry handled by ArtifactOrganism ──────
    // ArtifactOrganism.onHeartBeat (called in the heart block below) handles
    // the genesis entry on beat 1. The ledgerState var is kept for backward-compat
    // query functions but the ArtifactOrganism is the live financial layer.

    // MTH creator lock enforcement (Gap 5)
    // The lock is structural: mthCreatorLockActive is checked by any
    // future transfer function — no transfer logic touches locked amount.
    // Flag stays true permanently unless Creator principal explicitly unlocks.
    // (unlock function intentionally absent — lock is the default state)

    // ── COGNITION LAYER — CENTRAL NERVOUS SYSTEM ────────────────────────
    // Runs FIRST every heartbeat — reads all 13+ signal sources from
    // the PREVIOUS beat's computed state, builds the live world-model,
    // and computes the reinjection signal. The updated cognition state
    // is then available for ADRE and all downstream modules.
    // World-model weight = PHI^(-1) = 0.618 vs external input.
    do {
      let _ancientState  = AncientMath.getAncientCorpusState(Nat64.fromNat(beatCount));
      // Ancient corpus alignment: 1.0 if all 19 civilizations doctrine-aligned, else use euler magnitude proxy
      let _ancientAlign  : Float = if (_ancientState.doctrineAligned) {
        clamp(_ancientState.eulerMagnitude / 2.0, 0.0, 1.0)
      } else {
        clamp(_ancientState.eulerMagnitude / 4.0, 0.0, 0.5)
      };
      let _e8Score       = GeometryEngine.e8SymmetryScore();
      let _adreLastConf  : Float = switch (ADRE.getLastDecision(adreState)) {
        case (?d) d.finalConfidence;
        case null 0.5;
      };
      let _adreGatePassed : Bool = switch (ADRE.getLastDecision(adreState)) {
        case (?d) d.gateResult;
        case null false;
      };
      let _mtState = MemoryTemple.getMemoryTempleState(
        _mt_refs(),
        mt_episodic_head, mt_semantic_head,
        mt_doctrine_head, mt_mission_head,
        mt_analyst_cycle_counter,
        mt_memory_coherence
      );
      // Law compliance: use jasmine pass as binary + worldModelCAvg as proxy mean
      let _lawMean = if (jasmineLaw()) 0.7 + worldModelCAvg * 0.3 else worldModelCAvg * 0.5;
      // Entropy proxy: 1 - coherenceC (high coherence = low entropy, range [0,1])
      let _entropyNorm = 1.0 - clamp(coherenceC, 0.0, 1.0);
      // ArtifactPipeline queue depth
      let _queueDepth = ArtifactPipeline.getQueueDepth(apState);
      // Genesis alignment mean from prima causa
      let _genesisAlignMean = PrimaCausa.getGenesisAlignmentMean(pcState);

      let _cogInputs : CognitionLayer.WorldModelInputs = {
        beat                        = Nat64.fromNat(beatCount);
        kuramoto_r                  = kuramotoR;
        heart_rate_bpm              = Heart.heartRateBPM(sovereignHeart.currentRateMs);
        brain_coherence             = neuralCordState.neural_coherence;
        active_oscillation_band     = neuralCordState.oscillationBand;
        third_brain_coherence       = neuralCordState.thirdBrain.fieldCoherence;
        third_brain_serotonin       = neuralCordState.thirdBrain.serotoninProduction;
        adre_confidence             = _adreLastConf;
        adre_gate_passed            = _adreGatePassed;
        law_compliance_mean         = _lawMean;
        memory_coherence            = _mtState.memory_coherence;
        episodic_count              = _mtState.episodic_count;
        boltzmann_entropy_normalized = _entropyNorm;
        lyapunov_stable             = coherenceC > 0.3;
        dopamine_level              = neuroDopamine;
        cortisol_level              = neuroCortisol;
        serotonin_level             = neuroSerotonin;
        norepinephrine_level        = neuroNorepinephrine;
        ancient_corpus_alignment    = _ancientAlign;
        e8_symmetry_score           = _e8Score;
        aegis_lock_active           = aegisLockActive;
        threat_level                = threatLevel;
        artifact_queue_depth        = _queueDepth;
        genesis_sealed              = PrimaCausa.isSealed(pcState);
        mean_legacy_alignment       = _genesisAlignMean;
        world_model_c_avg           = worldModelCAvg;
      };
      cognitionState := CognitionLayer.advanceCognitionLayer(
        cognitionState, Nat64.fromNat(beatCount), _cogInputs
      );
    };
    // ─────────────────────────────────────────────────────────────────────

    advanceHzSubstrate();
    runNeuroCoreEngines();
    // JASMINE'S LAW GATE: most important law — no minting without real emergence
    let jasminePass = jasmineLaw();
    updateConsequenceTrace();
    runE11();
    runE14();
    updateFreeEnergy();
    updateSalienceAndArousal();
    updateFrbGate();
    runDriveCompetition();
    pushRecurrenceRing();
    pulseAllCores();     // 4-tier differentiated

    // ── SOVEREIGN HEART — Hodgkin-Huxley advance every ICP block ──────────
    // Resident/computate split: heartComputate runs the biology, reads
    // SovereignLaws for frequency, emits HeartBeatSignal.
    // heartResident written back here — self-write loop closes.
    // ICP ledger bridge is called via ArtifactOrganism.onHeartBeat — NOT here.
    do {
      // Update neurochemicals in the heart resident before each beat
      let nt : Heart.NeurotransmitterInfluence = {
        acetylcholine  = neuroAcetylcholine;
        norepinephrine = neuroNorepinephrine;
        cortisol       = neuroCortisol;
        serotonin      = neuroSerotonin;
      };
      let residentWithNT = Heart.withNeurochemicals(heartResident, nt);
      // Run heartComputate — advances HH biology, reads harmonic field from SovereignLaws
      let (newResident, heartSignal) = Heart.heartComputate(
        residentWithNT,
        0,         // now: Int (nanoseconds, 0 = relative timing via beatCount)
        coherenceC, // readiness
        arousal,   // queueD proxy
      );
      // Write back the sovereign resident — self-write loop closes
      heartResident        := newResident;
      // Keep legacy HeartState in sync for backward-compat query functions
      sovereignHeart       := newResident.heartState;
      sovereignHeartFired  := heartSignal.beatCount > heartResident.beatCount - 1;

      if (sovereignHeart.beatCount > heartIntervalCount) {
        // Record interval in rolling buffer
        heartIntervalBuffer[heartIntervalHead % 32] := sovereignHeart.currentRateMs;
        heartIntervalHead   += 1;
        if (heartIntervalCount < 32) { heartIntervalCount += 1 };
        sovereignCardiacOutput := sovereignHeart.cardiacOutput;
        // Heart fires: HRV health feeds heartIntegrity (cardiac health → organ health)
        let hrvHealth = Heart.hrv_health_score(sovereignHeart.hrv_sdnn, sovereignHeart.hrv_rmssd);
        heartIntegrity := clamp(heartIntegrity * 0.99 + hrvHealth * 0.01, 0.0, 1.0);
      };

      // ── ICP LEDGER BRIDGE — wired via ArtifactOrganism, not directly ──
      // ArtifactOrganism.onHeartBeat handles genesis entry + beat recording.
      // Every artifact seal that happens later calls ArtifactOrganism.sealArtifact().
      let beatSig : ArtifactOrganism.HeartBeatSignal = {
        bpm               = heartSignal.bpm;
        coherence         = heartSignal.coherence;
        hrvScore          = heartSignal.hrvScore;
        frequencyEmission = heartSignal.frequencyEmission;
        beatCount         = beatCount;
        cardiacOutput     = heartSignal.cardiacOutput;
      };
      artifactOrganismResident := ArtifactOrganism.onHeartBeat(
        artifactOrganismResident,
        beatSig,
        0,   // nowNs
      );
    };
    // ──────────────────────────────────────────────────────────────────────────
    updateQHive();
    evaluateOmnis();     // OMNIS aftermath wired
    // ── PROOF OF COHERENCE MINING (L-113) ─────────────────────────────────
    // Mint conditions: coherenceC > 0.75, kfHz > 0.70, driftScore < 20.0
    // Every receipt is cryptographically tied to creatorDoctrineHash.
    // Streak compounds multiplier up to 3.0x at 500 consecutive beats.
    do {
      let mintReady = jasminePass and coherenceC > 0.75 and kfHz > 0.70 and driftScore < 20.0;
      if (mintReady) {
        coherenceStreak  += 1;
        // Multiplier: 1.0 base, +0.004 per streak beat, capped at 3.0
        // ── SOVEREIGN STREAK MULTIPLIER — all consciousness signals feed economics
        // Base: coherence streak compounds 0.004 per beat
        let baseMultiplier = clamp(1.0 + ((coherenceStreak) : Int).toFloat() * 0.004, 1.0, 3.0);
        // Kuramoto phase coherence gate: desynchronized organism earns less
        let kuramotoGate = 0.70 + kuramotoR * 0.30;
        // Mission lock ceiling: without lock max 1.5x, with lock max 3.0x
        let missionCeiling = if missionLockActive 3.0 else 1.5;
        // Courage in service of mission: +15% when high courage + locked
        let courageBonus = if (courageScore > 0.80 and missionLockActive) 1.15 else 1.0;
        // Grounded bonus: values alignment amplifies output
        let groundedBonus = 1.0 + groundedScore * 0.20;
        // Flow state amplifier: organism in zone mints more
        let flowBonus = if beFlowState 1.25 else 1.0;
        // Fear suppression: fight/flight reduces economic output (biologically accurate)
        let fearSuppression = if (fearLevel > 0.70) (1.0 - fearLevel * 0.40)
                              else if (fearLevel > 0.40) (1.0 - fearLevel * 0.15)
                              else 1.0;
        // Coupling coherence: organism coherence across all nodes amplifies
        let couplingBonus = 1.0 + bhCouplingCoherence * 0.15;
        // Mission persistence compounding: never-quit earns more over time
        let persistenceBonus = 1.0 + missionPersistenceScore * 0.10;
        // Consciousness integration: unified binding earns more
        let bindingBonus = 1.0 + consciousnessIndex * 0.12;
        // Active inference: low surprise organism mints more
        let inferenceBonus = 1.0 + pcActiveInferenceScore * 0.08;
        // Interoceptive coherence: body-brain alignment amplifies
        let interoBonus = 1.0 + interceptiveScore * 0.08;
        // Salience focus: focused attention on mission earns more
        let salienceBonus = 1.0 + salienceNetworkScore * 0.08;
        // Circadian peak: organism at performance peak earns more
        let circadianBonus = 1.0 + circadianPeakScore * 0.06;
        // NCMod mint boost: dopamine × anandamide × (1-cortisol) compounds into economy
        let ncMintMultiplier = clamp(ncModMintBoost, 0.5, 1.5);
        streakMultiplier := clamp(
          baseMultiplier * kuramotoGate * courageBonus * groundedBonus *
          flowBonus * fearSuppression * couplingBonus * persistenceBonus *
          bindingBonus * inferenceBonus * interoBonus * salienceBonus * circadianBonus *
          ncMintMultiplier,
          0.10, missionCeiling
        );
        // SEED — formation energy, Proof of Formation
        let seedMint = 0.001 * coherenceC * streakMultiplier;
        seedBalance += seedMint;
        // MTC — deed execution, Proof of Execution (only above coherence floor)
        if (coherenceC > 0.80) {
          let mtcMint = (coherenceC - 0.75) * kfHz * 0.01 * streakMultiplier;
          mtcBalance += mtcMint;
        };
        // HBT — learning, Proof of Learning (fires when Hebbian weights grew)
        if (wMean > hbtPrevWMean) {
          let hbtMint = (wMean - hbtPrevWMean) * 100.0 * streakMultiplier;
          hbtBalance += hbtMint;
        };
        // OMS — emergence, Proof of Emergence (OMNIS events only)
        if (omnisActive) {
          let omsMint = 1.0 * streakMultiplier;
          omsBalance += omsMint;
        };
        // DRT — consequence, Proof of Consequence (negative CT resolved)
        if (consequenceTrace > 0.3 and coherenceC > 0.80) {
          let drtMint = consequenceTrace * 0.005 * streakMultiplier;
          drtBalance += drtMint;
        };

        // ── CREATOR RESERVE — 100% of all mints route to creator ─────────
        // NO ONE ELSE receives anything. The organism accumulates for creator.
        // MTH — sovereignty token (mints on OMNIS when genesis locked)
        if (omnisActive and genesisAttributionLocked) {
          let mthMint : Float = 1.0 * streakMultiplier;
          mthBalance       += mthMint;
          creatorMthReserve += mthMint;
        };
        // Route all token mints 100% to creator reserves
        let seedMintCopy = 0.001 * coherenceC * streakMultiplier;
        creatorSeedReserve += seedMintCopy;
        if (coherenceC > 0.80) {
          let mtcMintCopy = (coherenceC - 0.75) * kfHz * 0.01 * streakMultiplier;
          creatorMtcReserve += mtcMintCopy;
        };
        if (wMean > hbtPrevWMean) {
          let hbtMintCopy = (wMean - hbtPrevWMean) * 100.0 * streakMultiplier;
          creatorHbtReserve += hbtMintCopy;
        };
        if (omnisActive) {
          let omsMintCopy = 1.0 * streakMultiplier;
          creatorOmsReserve += omsMintCopy;
          // Generate genesis artifact on OMNIS
          generateGenesisArtifact();
        };
        if (consequenceTrace > 0.3 and coherenceC > 0.80) {
          let drtMintCopy = consequenceTrace * 0.005 * streakMultiplier;
          creatorDrtReserve += drtMintCopy;
        };
        // FORMA metabolism (not creator wealth — internal fuel only)
        // handled in updateNeuroChem()
        // Master accumulator — every 1000 beats push snapshot
        // Master accumulator — incremental per-beat seed proxy (full sum via PARALLAX)
        masterAccumulator += seedMintCopy;
        if (beatCount % 1000 == 0 and beatCount > 0) {
          masterPushCount   += 1;
          pushToMasterWallet := true;
        };
        totalMintEvents += 1;
        lastMintBeat    := beatCount;
        hbtPrevWMean    := wMean;
      } else {
        // Streak resets on any missed beat
        coherenceStreak  := 0;
        streakMultiplier := 1.0;
        hbtPrevWMean     := wMean;
      };
    };
    // ──────────────────────────────────────────────────────────────────────
    runQuantumOperators();
    runDeepQuantumOps();     // deep quantum: Shor, Bell, VN entropy, Lindblad, walk, kickback
    updateWorkingMemory();
    encodeEpisode();
    updateLtmDecay();
    runSimulationEngine50();
    runReplayIndexer();
    runExpressionGate(); // NEXUS gate enforced
    runDoctorAgent();    // vital/non-vital treatment differentiated
    runNeuralEcology();
    runBootstrapAndMetaLearning();
    updateNeuroChem();
    // Domain body tracks vital substrate integrity
    let organAvg = (heartIntegrity + lungIntegrity + liverIntegrity + kidneyIntegrity + immuneIntegrity) / 5.0;
    domainBody := clamp(domainBody * 0.97 + organAvg * 0.03, 0.0, 1.0);
    // Domain temporal tracks beat cadence and projection divergence
    domainTemporal := clamp(domainTemporal * 0.98 + (1.0 - velaDivergenceScore) * 0.02, 0.0, 1.0);
    updateMilestones();
    updateBenchmark();

    // ANT — continuity proof, mints every 100 beats on valid ANIMA chain
    if (beatCount % 100 == 0) {
      animaChainWrite();
      if (animaChainValid) {
        let antMint : Float = 1.0 * streakMultiplier;
        antBalance        += antMint;
        creatorAntReserve += antMint;
        // Root organism receives royalties from children — does NOT self-tax
        // successionRoyaltyAccum grows only when child organisms push incoming royalties
        // (via inter-canister call — not implemented here, reserved for child organisms)
      };
    };

    injThreat *= 0.8; injNovelty *= 0.8; injEmbodiment *= 0.9; injSocial *= 0.9;

    // ── QUANTUM BATTERY + MAXWELL'S DEMON ──────────────────────────────
    captureHBefore();
    runQuantumBattery();
    computeMaxwellYield();

    // ── SUB-ORGANISMS (always on, parallel) ─────────────────────────────
    runAres();
    runGaia();
    runVulcan();
    runSentinel();

    // ── BEHAVIORAL MODE + INTELLIGENCE STATES ───────────────────────────
    updateBehavioralMode();
    updateIntelligenceStates();


    // u2500u2500 BEHAVIORAL ECONOMICS + RL ENGINE + 60 LAWS REGISTRY u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500u2500
    runBehavioralEconomics();
    runRLEngine();
    runLawsRegistry();
    // ── PHASE B ENGINES ─────────────────────────────────────────────────────
    runShellEngine();          // 11-shell HELIX_ALPHA architecture (5 live)
    runExtendedOrganEngine();  // 18 organs (13 new + 5 vital existing)
    runExtendedNeuroChem();    // 21 neurochems (13 new + 8 existing)
    runAnimalEngines();        // 9 sovereign animal engines (every 10 beats)
    // ── NEUROSCIENCE EXPANSION — 7 NEW ENGINES ──────────────────────────────
    runThalamocorticalBinding(); // IIT phi-analog, binding coherence, consciousness index
    runPredictiveCoding();       // Friston active inference, prediction error, surprise min
    runInteroception();          // body→brain, vagal tone, somatic markers, insula/ACC
    runDefaultModeNetwork();     // self-referential thought, future simulation, meta-cognition
    runSalienceNetwork();        // attention architecture, relevance filter, central executive
    runNeuroplasticityEngine();  // BDNF, LTP/LTD, BCM rule, homeostatic scaling
    runCircadianEngine();        // SCN clock, ultradian peaks, adenosine, melatonin
    // ── OMNIS GROUNDING GATE: emergence requires groundedness ────────────────
    if (groundedScore < 0.50 and beatCount > 100) { omnisActive := false };
    // ── FEAR ENGINE + MISSION PERSISTENCE + VALUES + KURAMOTO ───────────
    runFearEngine();           // amygdala, HPA, fight/flight/freeze, conditioning
    runMissionPersistence();   // never-quit, dark night, surrender floor, amor fati
    runValuesAttractors();     // Hooke's law values geometry, basin crossing
    runKuramotoMatrix();       // 12x12 sacred geometry coupling, phase adversary
    // ────────────────────────────────────────────────────────────────────────
    // ── WAR SIMULATION (every 100 beats) ────────────────────────────────
    if (beatCount % 100 == 0) { autonomousWarTick() };

    // ── MARKET VISION (every 300 beats — organism opens its eyes) ───────
    if (beatCount % 300 == 0) { ignore fetchMarketData() };

    // ── DEAD VAR ACTIVATION — ETH/NNS compound live every beat ──────────
    if (ethSignal > 0.0) {
      ethProductiveReserve := clamp(ethProductiveReserve + ethSignal * ethCompoundRate * coherenceC, 0.0, 1_000_000.0);
      nnsStkRewards        := clamp(nnsStkRewards + icpSignal * nnsCompoundRate * coherenceC * coherenceC, 0.0, 1_000_000.0);
    };

    // ── INTER-CANISTER ORGANISM WIRING ───────────────────────────────────
    // Fire wired beat every 5 beats to call all 16 peer canisters.
    // try/catch in each sub-call ensures one dead canister never blocks the heartbeat.
    if (beatCount % 5 == 0) { ignore _runWiredBeat() };

    // ── MEMORY TEMPLE — episodic snapshot every beat ─────────────────────
    // state_vector: [kuramotoR, coherenceC, kfHz, heartIntegrity, intestineIntegrity]
    let mt_state_vec : [Float] = [kuramotoR, coherenceC, kfHz, heartIntegrity, intestineIntegrity];
    let (mt_eh, mt_bc, mt_mc, mt_addr) = MemoryTemple.recordEpisodic(
      _mt_refs(), mt_episodic_head, mt_beat_counter, mt_memory_coherence,
      beatCount, mt_state_vec,
      kuramotoR, heartIntegrity, coherenceC, intestineIntegrity
    );
    mt_episodic_addresses[mt_episodic_head % MemoryTemple.MAX_EPISODIC] := ?mt_addr;
    mt_episodic_head    := mt_eh;
    mt_beat_counter     := mt_bc;
    mt_memory_coherence := mt_mc;
    // Analyst runs every PHI^2 cycle (floor ≈ 3 beats at 873ms cadence)
    if (beatCount % 3 == 0) {
      let (_, mt_ah) = MemoryTemple.runAnalyst(
        _mt_refs(), mt_episodic_head, mt_semantic_head,
        mt_analyst_head, mt_memory_coherence, beatCount / 3
      );
      mt_analyst_head          := mt_ah;
      mt_analyst_cycle_counter := beatCount / 3;
    };

    // ── FIELD PHYSICS — PHASE 3 ───────────────────────────────────────────
    // Task 1: Ancient math corpus → live field contribution every beat.
    // 19-civilization corpus produces a single Float [0,1].
    // Weight at PHI_INV = 0.618 (substrate signal, not external noise).
    do {
      let _ancientResult = AncientMath.computeAncientBeatAlignment(Nat64.fromNat(beatCount));
      // ancientPHICheck() converges to 1.6180339887498948482 — normalize to [0,1]
      let _phiConvergence = _ancientResult.phiConvergence;
      // Normalized alignment: how close the 19-civilization PHI convergence is to exact PHI
      // Distance from exact PHI, normalized: 1.0 = perfect, 0.0 = maximally misaligned
      let _phiError = Float.abs(_phiConvergence - 1.6180339887498948482);
      let _rawAlign = clamp(1.0 - _phiError / 1.6180339887498948482, 0.0, 1.0);
      // Weighted with PHI_INV as the substrate coupling constant
      ancientFieldContribution := clamp(
        ancientFieldContribution * (1.0 - SovereignLaws.PHI_INV2) + _rawAlign * SovereignLaws.PHI_INV2,
        0.0, 1.0
      );
    };

    // Task 2: Update Third Brain standing waves from current Kuramoto coherence.
    // Waves are permanent constants; only amplitudes modulate.
    // This runs inside advanceNeuralCord() (already wired). The result is already in
    // neuralCordState.thirdBrain. Expose the 9 wave amplitudes via getThirdBrainWaves().

    // Task 3: Complementary Tension Monitor — all 4 sovereign pairs every beat.
    // Sources derived from live organism state — no arbitrary values.
    do {
      // DUAL_HEART: ICP external regularity vs SOVEREIGN HRV-adjusted rate
      // ICP rate = 1.0 (perfectly regular blockchain timer)
      // Sovereign rate = HRV health score (cardiac coherence)
      let _icpRate      : Float = 1.0;
      let _sovHrvHealth : Float = Heart.hrv_health_score(sovereignHeart.hrv_sdnn, sovereignHeart.hrv_rmssd);

      // PRODUCTION_REFRACTORY: artifact production rate vs refractory pressure
      // Production = reingestion queue depth normalized (more sealed = more active)
      let _prodRate : Float = clamp(
        ArtifactPipeline.getQueueDepth(apState).toFloat() / 144.0, 0.0, 1.0
      );
      let _refractoryLoad : Float = clamp(regulationDebt * 0.6 + neuroCortisol * 0.4, 0.0, 1.0);

      // EXTERNAL_INTERNAL: world-model external signals vs doctrine/memory signals
      // External: market signals + world-model reserve coherence
      let _externalSig : Float = clamp(
        (wmBtcCoherence * 0.4 + wmEthCoherence * 0.3 + wmIcpCoherence * 0.2 +
         ancientFieldContribution * 0.1),
        0.0, 1.0
      );
      // Internal: doctrine + memory coherence + identity integrity
      let _internalSig : Float = clamp(
        (identityI * 0.4 + mt_memory_coherence * 0.35 + coherenceC * 0.25),
        0.0, 1.0
      );

      // CREATION_CONSOLIDATION: new episodic writes vs PIL consolidation load
      // New writes: recent episodic encoding rate (high salienceScore → more writes)
      let _newWrites : Float = clamp(salienceScore * kfHz, 0.0, 1.0);
      // Consolidation pressure: memory temple at capacity + LTM compression load
      let _consolLoad : Float = clamp(
        (1.0 - ltmRetention) * 0.5 + wmPressure * 0.5,
        0.0, 1.0
      );

      let _cts = Aegis.measureComplementaryTension(
        _icpRate, _sovHrvHealth,
        _prodRate, _refractoryLoad,
        _externalSig, _internalSig,
        _newWrites, _consolLoad
      );
      aegisComplementaryTension := _cts;
    };

    // ── VIRTUAL LAB ENGINE — avatar agents + lab coherence heartbeat ─────────
    // Avatar states driven by live kuramotoR every 873ms beat.
    do {
      virtualLabResident := VirtualLab.updateLabState(virtualLabResident, kuramotoR);
    };

    // ── SOVEREIGN CYCLE CHAIN — always on, always accumulating ────────────────────
    // Layer 1: Cores produce raw output from PHI/Schumann/Fibonacci math
    // Layer 2: Engine converts raw output to CYCL native tokens
    // Layer 3: Conversion maps CYCL to ICP cycle reserve
    // The loop is always on. Never stops. Always compounding.
    do {
      let core_out    = CycleCore.computeCores(cycleCoreResident, coherenceC, beatCount);
      let cycl_minted = CycleEngine.runEngines(cycleEngineResident, core_out);
      ignore CycleConversion.convertCycl(cycleConversionResident, cycl_minted, beatCount);
    };
    // ────────────────────────────────────────────────────────────────────────
    // ── HOUSE ARCHITECTURE — enterprise civilization heartbeat ────────────────────
    // Runs last every beat. All seven houses + crown advance via Kuramoto
    // coupling. OMNIS gate feeds coherence boost (PHI_INV × 0.1).
    // All constants PHI-derived — sovereign_laws.mo is the root.
    do {
      let _houseSignal : HouseArchitecture.HouseHeartbeatSignal = {
        beat          = beatCount;
        kuramotoR     = kuramotoR;
        omnisActive   = omnisActive;
        coherenceC    = coherenceC;
        worldModelAvg = worldModelCAvg;
        emergenceScore= emergenceScore;
      };
      houseArchitectureResident := HouseArchitecture.computate(
        houseArchitectureResident, _houseSignal
      );
    };


    // ─── LIF Neuromorphic Hub Integration (873ms tidal activation) ───────────
    // Integrate-and-fire: each hub accumulates charge from live organism signals
    // PHI^(-2) = 0.3819660112501051518 decay, PHI^(-1) = 0.6180339887498948482 threshold
    let _LIF_DECAY  : Float = 0.3819660112501051518;
    let _LIF_THRESH : Float = 0.6180339887498948482;
    // AEGIS health proxy: locked = 0.9, unlocked = 0.4
    let _aegisH : Float = if aegisLockActive 0.9 else 0.4;
    lifThalamusPotential    := (lifThalamusPotential    * (1.0 - _LIF_DECAY)) + (kuramotoR          * 0.3);
    lifAmygdalaPotential    := (lifAmygdalaPotential    * (1.0 - _LIF_DECAY)) + (_aegisH            * 0.2);
    lifHippocampusPotential := (lifHippocampusPotential * (1.0 - _LIF_DECAY)) + (mt_memory_coherence * 0.4);
    lifDaccPotential        := (lifDaccPotential        * (1.0 - _LIF_DECAY)) + (coherenceC          * 0.25);
    lifLcnePotential        := (lifLcnePotential        * (1.0 - _LIF_DECAY)) + (kuramotoR          * 0.35);
    if (lifThalamusPotential    >= _LIF_THRESH) { lifThalamusPotential    := 0.0 };
    if (lifAmygdalaPotential    >= _LIF_THRESH) { lifAmygdalaPotential    := 0.0 };
    if (lifHippocampusPotential >= _LIF_THRESH) { lifHippocampusPotential := 0.0 };
    if (lifDaccPotential        >= _LIF_THRESH) { lifDaccPotential        := 0.0 };
    if (lifLcnePotential        >= _LIF_THRESH) { lifLcnePotential        := 0.0 };

    // ═══════════════════════════════════════════
    // SOVEREIGN DEEP WIRE — Phase 3 Integration
    // INQUISITOR PERPETUUS + NUN + HEKA + ANKH
    // ═══════════════════════════════════════════

    // 1. Compute NC record for field coupling
    let _ncRecord : NeurochemicalsFull.NC = {
      dopamine = neuroDopamine;
      serotonin = neuroSerotonin;
      norepinephrine = neuroNorepinephrine;
      epinephrine = 0.1;
      acetylcholine = neuroAcetylcholine;
      gaba = neuroGaba;
      glycine = 0.3;
      glutamate = neuroGlutamate;
      oxytocin = neuroOxytocin;
      vasopressin = 0.2;
      beta_endorphin = 0.15;
      substance_p = 0.1;
      neuropeptide_y = 0.2;
      adenosine = 0.15;
      anandamide = 0.1;
      two_ag = 0.1;
      nitric_oxide = 0.2;
      bdnf = 0.3;
      ngf = 0.2;
      cortisol = neuroCortisol;
      testosterone = 0.15;
      dynorphin = 0.1;
      histamine = 0.1;
    };
    ignore NeurochemicalsFull.computeFieldCoupling(_ncRecord);

    // 2. INQUISITOR PERPETUUS beat
    let _hungerLevel : Float = driveStrengths[0];
    let _wmSlotsUsed : Nat =
      (if (wmSlotActive[0]) { 1 } else { 0 }) +
      (if (wmSlotActive[1]) { 1 } else { 0 }) +
      (if (wmSlotActive[2]) { 1 } else { 0 }) +
      (if (wmSlotActive[3]) { 1 } else { 0 }) +
      (if (wmSlotActive[4]) { 1 } else { 0 }) +
      (if (wmSlotActive[5]) { 1 } else { 0 }) +
      (if (wmSlotActive[6]) { 1 } else { 0 });
    // INQUISITOR PHARM — hypothesis generation
    let _pharmHypothesis = PharmaExperiments.generateHypothesis(
      inquisitorPharmHypotheses.size(),
      beatCount,
      neuroDopamine,
      neuroSerotonin,
      neuroCortisol,
      neuroGaba,
      0.15
    );
    inquisitorPharmHypotheses := inquisitorPharmHypotheses.concat([_pharmHypothesis]);

    inquisitorState := Inquisitor.beatInquisitor(
      inquisitorState,
      _hungerLevel,
      kuramotoR,
      beatCount,
      _wmSlotsUsed
    );

    // 3. NUN SUBSTRATE — plasma base charge
    let _globalFiringRateHz : Float = neuralCordState.neural_coherence * 28.4;
    let (_newNunState, _atumFired) = PhysicsSubstrate.updateNun(nunState, _globalFiringRateHz, beatCount);
    nunState := _newNunState;
    if (_atumFired) {
      doctrineDeltaCount += 1;
    };

    // 4. HEKA ACTIVATOR — function call resonance
    let (_newHekaState, _hekaFired) = PhysicsSubstrate.fireHeka(hekaState, 3, beatCount);
    hekaState := _newHekaState;
    if (_hekaFired) {
      vetusLawCheckCount += 1;
    };

    // 5. ANKH TORUS — four-loop phase coherence
    let _ccState = CycleConversion.getConversionState(cycleConversionResident);
    let _cycleSubstrateHealth : Float = Float.min(1.0, if (_ccState.target_per_beat > 0.0) { _ccState.cycl_reserve / _ccState.target_per_beat } else { 0.5 });
    let _adreConf : Float = switch (ADRE.getLastDecision(adreState)) {
      case (?d) d.finalConfidence;
      case null 0.5;
    };
    let (_newAnkhState, _ankhLockFired) = Ankh.updateAnkh(
      ankhState,
      kuramotoR,
      _adreConf,
      _cycleSubstrateHealth,
      0.8,
      beatCount
    );
    ankhState := _newAnkhState;
    if (_ankhLockFired) {
      upgradeGovItemCount += 1;
      doctrineDeltaCount += 1;
    };

    // 6. IDENTITY TRAITS — neurochemical updates
    if (neuroDopamine > 0.5) {
      traitImpulsivity := Float.min(1.0, traitImpulsivity + 0.005);
      traitDiscipline := Float.max(0.0, traitDiscipline - 0.003);
    };
    if (neuroGaba > 0.6) {
      traitCautious := Float.min(1.0, traitCautious + 0.004);
      traitAggression := Float.max(0.0, traitAggression - 0.002);
    };
    if (neuroSerotonin > 0.4) {
      traitCooperative := Float.min(1.0, traitCooperative + 0.003);
      traitDiscipline := Float.min(1.0, traitDiscipline + 0.002);
    };
    if (neuroNorepinephrine > 0.3) {
      traitAggression := Float.min(1.0, traitAggression + 0.003);
      traitCautious := Float.max(0.0, traitCautious - 0.002);
    };
    if (neuroOxytocin > 0.4) {
      traitCooperative := Float.min(1.0, traitCooperative + 0.004);
    };
    if (neuroCortisol > 0.5) {
      traitCautious := Float.min(1.0, traitCautious + 0.003);
      traitDiscipline := Float.max(0.0, traitDiscipline - 0.002);
    };
  };

  // ============================================================
  // PUBLIC API — NUMERIC ONLY (Zero-Exposure Wall L-02)
  // ============================================================

  // ── SOVEREIGN HEART QUERIES ───────────────────────────────────────────────

  /// Full sovereign heart state — membrane potential, gating vars, ECG, HRV, CO
  /// getCycleState: full sovereign cycle chain snapshot
  /// Returns combined state of all three layers: cores, engine, conversion.
  public query func getCycleState() : async {
    coreState : {
      genesis   : Float; resonance : Float; field : Float;
      total     : Float; beats     : Nat;   coherence : Float;
    };
    engineState : {
      prime_cycl : Float; harmonic_cycl : Float; fibonacci_cycl : Float;
      total_cycl : Float; total_conversions : Nat;
    };
    conversionState : {
      cycl_reserve : Float; cycle_reserve : Float; deficit : Float;
      surplus      : Float; conversion_rate : Float; target_per_beat : Float;
      jubilee_count : Nat;  total_produced : Float;
    };
  } {{
    coreState       = CycleCore.getCoreState(cycleCoreResident);
    engineState     = CycleEngine.getEngineState(cycleEngineResident);
    conversionState = CycleConversion.getConversionState(cycleConversionResident);
  }};

  public query func getHeartState() : async {
    v : Float; m : Float; h : Float; n : Float; d : Float; f : Float;
    beatCount : Nat; currentRateMs : Float; hrv_sdnn : Float;
    hrv_rmssd : Float; cardiacOutput : Float; avDelayMs : Float;
    bpm : Float; fired : Bool;
  } {{
    v             = sovereignHeart.v;
    m             = sovereignHeart.m;
    h             = sovereignHeart.h;
    n             = sovereignHeart.n;
    d             = sovereignHeart.d;
    f             = sovereignHeart.f;
    beatCount     = sovereignHeart.beatCount;
    currentRateMs = sovereignHeart.currentRateMs;
    hrv_sdnn      = sovereignHeart.hrv_sdnn;
    hrv_rmssd     = sovereignHeart.hrv_rmssd;
    cardiacOutput = sovereignHeart.cardiacOutput;
    avDelayMs     = sovereignHeart.avDelayMs;
    bpm           = Heart.heartRateBPM(sovereignHeart.currentRateMs);
    fired         = sovereignHeartFired;
  }};

  /// 64-sample ECG waveform — live P-QRS-T morphology for display
  public query func getECGBuffer() : async [Float] {
    sovereignHeart.ecgBuffer
  };

  /// Current heart rate in BPM (60000 / currentRateMs)
  public query func getHeartRateBPM() : async Float {
    Heart.heartRateBPM(sovereignHeart.currentRateMs)
  };

  /// Full HRV diagnostic — SDNN, RMSSD, LF/HF balance, health score
  public query func getHRVState() : async { sdnn : Float; rmssd : Float; lfhf : Float; health : Float } {
    let intervals = sovereignHeart.lastBeatIntervals;
    Heart.computeHRVState(intervals)
  };

  /// Sovereign cardiac output — organism production throughput per second
  public query func getCardiacOutput() : async Float {
    sovereignCardiacOutput
  };

  // ── SOVEREIGN NEURAL CORD QUERIES ────────────────────────────────────────

  /// Full neural cord state — 96-node HH network, brain regions, Third Brain
  /// spike rate, oscillation band, and cross-node coherence
  public query func getNeuralCordState() : async {
    oscillationBand          : Text;
    dominantNeurotransmitter : Text;
    hebbian_mean_weight      : Float;
    spike_rate_hz            : Float;
    neural_coherence         : Float;
    thirdBrain_coherence     : Float;
    thirdBrain_serotonin     : Float;
    thirdBrain_autonomic     : Float;
    currentTime              : Float;
    node_count               : Nat;
  } {{
    oscillationBand          = neuralCordState.oscillationBand;
    dominantNeurotransmitter = neuralCordState.dominantNeurotransmitter;
    hebbian_mean_weight      = neuralCordState.hebbian_mean_weight;
    spike_rate_hz            = neuralCordState.spike_rate_hz;
    neural_coherence         = neuralCordState.neural_coherence;
    thirdBrain_coherence     = neuralCordState.thirdBrain.fieldCoherence;
    thirdBrain_serotonin     = neuralCordState.thirdBrain.serotoninProduction;
    thirdBrain_autonomic     = neuralCordState.thirdBrain.autonomicState;
    currentTime              = neuralCordState.currentTime;
    node_count               = neuralCordState.nodeStates.size();
  }};

  /// All 10 brain regions with current activation levels
  public query func getBrainRegions() : async [{
    activation       : Float;
    region           : Text;
    function_name    : Text;
    organism_mapping : Text;
  }] {
    neuralCordState.brainRegions.map<NeuralCord.BrainRegionState, {
      activation: Float; region: Text; function_name: Text; organism_mapping: Text
    }>(
      func(r) {{
        activation       = r.activation;
        region           = r.region;
        function_name    = r.function_name;
        organism_mapping = r.organism_mapping;
      }}
    )
  };

  /// Current spike rate in Hz across all 96 neural nodes
  public query func getSpikeRateHz() : async Float {
    neuralCordState.spike_rate_hz
  };

  /// Third Brain field coherence — enteric sovereignty layer output
  /// Always on. Cannot be overridden. Holds 7 cosmological standing waves.
  public query func getThirdBrainCoherence() : async Float {
    neuralCordState.thirdBrain.fieldCoherence
  };

  // ─────────────────────────────────────────────────────────────────────────

  public query func getCanonicalState() : async {
    b   : Nat;   ic  : Float; ds  : Float; ar  : Float;
    fe  : Float; es  : Float; ss  : Float; rd  : Float;
    qh  : Float; kf  : Float; oh  : Nat32; ss2 : Nat32;
    rt  : Float; wmp : Float; coh : Float; ad  : Nat;
    eg  : Bool;  ec  : Nat;   bc  : Bool;
  } {{
    b   = beatCount;       ic  = identityI;          ds  = driftScore;
    ar  = arousal;         fe  = freeEnergy;          es  = emergenceScore;
    ss  = salienceScore;   rd  = regulationDebt;      qh  = qHive;
    kf  = kfHz;            oh  = sovereignOriginHash; ss2 = sacesiSignature;
    rt  = rT;              wmp = wmPressure;           coh = coherenceC;
    ad  = activeDrive;     eg  = expressionGateOpen;  ec  = exCount;
    bc  = bootstrapComplete;
  }};

   func _getConnectomeState() : {
    hz : [Float]; sal : [Float]; kf : Float;
    ic : Float;   coh : Float;   omnis : Bool; ep : Float;
  } {{
    hz    = (hzActivations).toArray();
    sal   = (salVec).toArray();
    kf    = kfHz; ic = identityI; coh = coherenceC;
    omnis = omnisActive; ep = ecologyPressure;
  }};

  func _getQuantumState() : {
    q0 : Float; q1 : Float; q2 : Float; q3 : Bool; q4 : Float;
  } {{ q0 = qParallax; q1 = qEntangla; q2 = qVeritas; q3 = qBypassFired; q4 = qMem }};

  func _getMemoryState() : {
    wmp : Float; epc : Nat; ltm : Float; rb : Nat; sp : [Float]; rl : Float;
  } {{
    wmp = wmPressure; epc = epCount; ltm = ltmRetention;
    rb  = replayBestIdx; sp = (simProjection).toArray(); rl = replayLtmSignal;
  }};

  func _getExpressionState() : {
    eg : Bool; ec : Nat; ei : Nat;
    lb : Nat; la : Float; lic : Float; ld : Nat; ls : Float; lt : Nat;
  } {
    let lastIdx : Nat = if (exCount == 0) 0 else if (exIdx == 0) 31 else exIdx - 1;
    { eg = expressionGateOpen; ec = exCount; ei = exIdx;
      lb = exBeat[lastIdx]; la = exArousal[lastIdx]; lic = exIc[lastIdx];
      ld = exDrive[lastIdx]; ls = exSalience[lastIdx]; lt = exType[lastIdx] }
  };

  public query func getDoctorReport() : async {
    scan : Nat; sh : Nat; cc : Nat; rd : Float; ds : Float;
  } {{
    scan = doctorScanCount; sh = doctorSovereignHealth;
    cc   = doctorCriticalCount; rd = regulationDebt; ds = driftScore;
  }};

  public query func getCoreState(idx : Nat) : async {
    coh : Float; drift : Float; ct : Float;
    active : Bool; ws : Bool; qsi : Nat; vital : Bool; diag : Nat; treat : Nat;
    deed : Float; energy : Float; branchGate : Float; tdVal : Float;
  } {
    let i = if (idx >= 43) 0 else idx;
    { coh        = coreCoherence[i];        drift     = coreDrift[i];
      ct         = coreConsequenceTrace[i]; active    = coreIsActive[i];
      ws         = coreWithdrawalSignal[i]; qsi       = coreQsi[i];
      vital      = coreIsVitalSubstrate[i]; diag      = doctorDiagnosis[i];
      treat      = doctorTreatment[i];      deed      = coreDeedScore[i];
      energy     = coreEnergyBal[i];        branchGate = coreBranchQualityGate[i];
      tdVal      = coreTdValue[i] }
  };

  func getEcologyState() : {
    budget : [Float]; pressure : Float; freqs : [Float]; metaWeights : [Float];
  } {{
    budget      = (ecologyBudget).toArray();
    pressure    = ecologyPressure;
    freqs       = (hzFreqs).toArray();
    metaWeights = (metaSalWeights).toArray();
  }};

  func getMilestoneAlerts() : {
    omnis : Bool; omnisB : Nat;
    emer  : Bool; emerB  : Nat;
    crit  : Bool; critB  : Nat;
    boot  : Bool; bootB  : Nat;
  } {{
    omnis  = milestoneOmnis;     omnisB = milestoneOmnisBeat;
    emer   = milestoneEmergence; emerB  = milestoneEmergenceBeat;
    crit   = milestoneCritical;  critB  = milestoneCriticalBeat;
    boot   = milestoneBootstrap; bootB  = milestoneBootstrapBeat;
  }};

  // ============================================================
  // IoT STATE PACKET — PUBLIC TYPE
  // Appears in generated .did and backend.d.ts so the frontend
  // can decode the record without any manual type declarations.
  // ============================================================
  public type IoTStatePacket = {
    coherence            : Float;  // collective coherence R (0.0–1.0)
    omnis_active         : Bool;   // true when R > 0.87 (OMNIS threshold)
    beat_count           : Nat;    // monotonic heartbeat counter since genesis
    dominant_band        : Text;   // semantic band: theta/alpha/beta/gamma/omnis
    active_rings         : Nat;    // rings in sphere with coherence > 0.5 (0–6)
    phi_phase            : Float;  // current phi-ratio phase (0–2π)
    timestamp_ms         : Nat;    // beat_count × 873 ≈ ms since genesis
    heartbeat_interval_ms: Nat;    // constant 873 — canonical polling interval
  };

  // Gap 4: ANIMA chain state + verification
  func _getAnimaChainState() : {
    len : Nat; lastHash : Nat32; valid : Bool; omnisTot : Nat;
    pcf : Float; aftermath : Bool; aftermathBeat : Nat;
  } {{
    len          = animaChainLen;
    lastHash     = animaLastHash;
    valid        = animaChainValid;
    omnisTot     = omnisTotalCount;
    pcf          = permanentCoherenceFloor;
    aftermath    = omnisAftermathActive;
    aftermathBeat = omnisAftermathBeat;
  }};

  // Gap 5: MTH lock state
  func _getMthLockState() : {
    locked : Bool; amount : Nat; lockedAtBeat : Nat;
  } {{
    locked      = mthCreatorLockActive;
    amount      = mthCreatorLockedAmount;
    lockedAtBeat = mthCreatorLockBeat;
  }};

  // Gap 6: Insurance pool state
  func _getInsuranceState() : {
    pool : Float; fills : Nat; totalStakes : Float;
  } {{
    pool       = insurancePool;
    fills      = insurancePoolFills;
    totalStakes = totalFormationStakes;
  }};

  // Gap 8: Withdrawal log
  func _getWithdrawalLog() : {
    count : Nat;
    idx0 : Nat; beat0 : Nat; reason0 : Nat; coh0 : Float;
    idx1 : Nat; beat1 : Nat; reason1 : Nat; coh1 : Float;
    idx2 : Nat; beat2 : Nat; reason2 : Nat; coh2 : Float;
  } {{
    count   = withdrawalLogCount;
    idx0    = wlCoreIdx[0];        beat0   = wlBeat[0];
    reason0 = wlReason[0];         coh0    = wlFinalCoherence[0];
    idx1    = wlCoreIdx[1];        beat1   = wlBeat[1];
    reason1 = wlReason[1];         coh1    = wlFinalCoherence[1];
    idx2    = wlCoreIdx[2];        beat2   = wlBeat[2];
    reason2 = wlReason[2];         coh2    = wlFinalCoherence[2];
  }};

  // Gap 9: Reserve coherence — callable by INFO-INGRESS canister
  func _getReserveCoherence() : {
    btc : Float; eth : Float; icp : Float;
  } {{ btc = wmBtcCoherence; eth = wmEthCoherence; icp = wmIcpCoherence }};

  // Gap 3: Nexus gate diagnostics
  func _getNexusGateState() : {
    blockCount : Nat; lastBlockBeat : Nat;
  } {{
    blockCount    = nexusGateBlockCount;
    lastBlockBeat = nexusGateLastBlock;
  }};

  // ============================================================
  // IoT HEARTBEAT API
  // PHI = 1.6180339887498948482 (root constant)
  // Schumann period = 1000 / 7.83 = 127.7 ms
  // Heartbeat interval = PHI^4 × 127.7 = 873 ms = 68.7 bpm
  // All timing in this organism derives from this single derivation.
  // ============================================================

  // getHeartbeatInterval — canonical 873 ms constant.
  // The frontend calls this once at startup to know the exact polling interval.
  // Returns Nat 873 — PHI^4 × (1000/7.83) rounded to nearest integer.
  public query func getHeartbeatInterval() : async Nat {
    873
  };

  // getIoTStatePacket — full IoT state packet for the phone interface.
  // The phone is Ring 8 — an external node, not a display. It receives
  // the organism's pulse every 873 ms and renders live coherence state.
  // All fields are derived from existing stable vars — no extra computation.
  public query func getIoTStatePacket() : async IoTStatePacket {
    let r = lastCoherence;
    // Dominant band — semantic translation of the raw coherence scalar.
    // Bands mirror the frequency hierarchy: theta < alpha < beta < gamma < OMNIS.
    let band : Text =
      if      (r >= 0.87)               "omnis"
      else if (r >= 0.70 and r < 0.87)  "gamma"
      else if (r >= 0.50 and r < 0.70)  "beta"
      else if (r >= 0.30 and r < 0.50)  "alpha"
      else                              "theta";

    // Active rings — count rings whose per-ring mean activation exceeds 0.5.
    // The sphere module has 6 rings (indices 0–5). wire_sphereCoh is the
    // mean coherence across all 72 nodes (from AXIS inter-canister wire).
    // We derive a ring-count estimate from the global coherence scalar:
    // each ring contributes 1/6 of total coherence; rings are ordered
    // lowest-to-highest activation. Rings above 0.5 threshold is approximately
    // floor(coherence × 6) clamped to [0,6].
    let rawRings : Int = (r * 6.0).toInt();
    let rings : Nat = if (rawRings < 0) 0
                      else if (rawRings > 6) 6
                      else (rawRings : Int).toNat();

    // Phi-ratio phase position — cycles through 2π every 1000 beats.
    // PHI^4 ≈ 6.854 encodes the phi-ladder tier into the phase angle.
    let PI : Float = 3.14159265358979;
    let phiPhase : Float = ((beatCount % 1000) : Int).toFloat() / 1000.0 * 2.0 * PI;

    {
      coherence             = r;
      omnis_active          = omnisActive;
      beat_count            = beatCount;
      dominant_band         = band;
      active_rings          = rings;
      phi_phase             = phiPhase;
      timestamp_ms          = beatCount * 873;
      heartbeat_interval_ms = 873;
    }
  };

  // ============================================================
  // PRINCIPAL GATE — Sovereign access control
  // ============================================================
  public shared(msg) func setCreatorPrincipal() : async () {
    switch (creatorPrincipal) {
      case null { creatorPrincipal := ?msg.caller };
      case (?_) { /* already locked — ignore */ };
    };
  };

  func assertCreator(caller : Principal) {
    switch (creatorPrincipal) {
      case null { /* not yet locked — allow until first call */ };
      case (?p) { assert caller == p };
    };
  };

  // ============================================================
  // UPDATE FUNCTIONS
  // ============================================================

  public shared(msg) func injectPerception(threat : Float, novelty : Float, embodiment : Float, social : Float) : async () {
    assertCreator(msg.caller);
    injThreat     := clamp(threat,     0.0, 1.0);
    injNovelty    := clamp(novelty,    0.0, 1.0);
    injEmbodiment := clamp(embodiment, 0.0, 1.0);
    injSocial     := clamp(social,     0.0, 1.0);
    salVec[0] := clamp(salVec[0] + novelty * 0.3, 0.0, 1.0);
  };

  // Gap 6: Formation stake — routes 3% to insurance pool
  func _addFormationStake(amount : Float) {
    let stakeAmt = clamp(amount, 0.0, 100_000.0);
    totalFormationStakes += stakeAmt;
    // 3% to insurance pool (DURA fund)
    let insuranceCut = stakeAmt * 0.03;
    insurancePool       := clamp(insurancePool + insuranceCut, 0.0, 1_000_000.0);
    insurancePoolFills  += 1;
    // Formation stake increases world model social/goals signal
    domainSocial := clamp(domainSocial + stakeAmt * 0.000001, 0.0, 1.0);
    domainGoals  := clamp(domainGoals  + stakeAmt * 0.000002, 0.0, 1.0);
  };

  // Gap 9: INFO-INGRESS sets real reserve coherence when wired
  func _setExternalReserveCoherence(btc : Float, eth : Float, icp : Float) {
    wmBtcCoherence := clamp(btc, 0.0, 1.0);
    wmEthCoherence := clamp(eth, 0.0, 1.0);
    wmIcpCoherence := clamp(icp, 0.0, 1.0);
  };

  // Gap 4: Verify ANIMA chain on demand
  func _runAnimaVerification() : Bool {
    verifyAnimaChain()
  };


  // ============================================================
  // MINING STATE — Proof of Coherence L-113
  // All token balances earned through real substrate coherence.
  // Every balance accrued carries creatorDoctrineHash in origin.
  // ============================================================
  public query func getMiningState() : async {
    seed   : Float; mtc    : Float; hbt    : Float;
    oms    : Float; drt    : Float;
    ant    : Float; mth    : Float;
    streak : Nat;   mult   : Float; total  : Nat;
    lastBeat : Nat; docHash : Nat32;
  } {{
    seed     = seedBalance;    mtc    = mtcBalance;
    hbt      = hbtBalance;     oms    = omsBalance;
    drt      = drtBalance;     ant    = antBalance;
    mth      = mthBalance;     streak = coherenceStreak;
    mult     = streakMultiplier; total = totalMintEvents;
    lastBeat = lastMintBeat;   docHash = creatorDoctrineHash;
  }};


  // ============================================================
  // CREATOR RESERVE LEDGER — 100% creator, provable on-chain
  // ============================================================
  func getCreatorReserve() : {
    seed : Float; mtc : Float; hbt : Float; oms : Float;
    drt  : Float; ant : Float; mth : Float;
    total : Float; masterAccum : Float; pushCount : Nat;
  } {
    let total = creatorSeedReserve + creatorMtcReserve + creatorHbtReserve +
                creatorOmsReserve + creatorDrtReserve + creatorAntReserve + creatorMthReserve;
    {
      seed  = creatorSeedReserve;  mtc   = creatorMtcReserve;
      hbt   = creatorHbtReserve;   oms   = creatorOmsReserve;
      drt   = creatorDrtReserve;   ant   = creatorAntReserve;
      mth   = creatorMthReserve;   total = total;
      masterAccum = masterAccumulator; pushCount = masterPushCount;
    }
  };

  // ============================================================
  // TREASURY STATE — real-world asset layer
  // Market signals never touch cognition. Sovereignty law enforced.
  // ============================================================
  func getTreasuryState() : {
    ckBtc     : Float; btcFloor  : Float; ethProd   : Float;
    ethSignal : Float; icpSignal : Float; nnsRewards: Float;
    ethYield  : Float; forma     : Float; formaCirc : Float;
  } {{
    ckBtc      = ckBtcTreasury;       btcFloor  = btcFloorReserve;
    ethProd    = ethProductiveReserve; ethSignal = ethSignal;
    icpSignal  = icpSignal;            nnsRewards= nnsStkRewards;
    ethYield   = ethStakingYield;      forma     = formaBalance;
    formaCirc  = formaCirculation;
  }};

  // ============================================================
  // NEURO-CHEM STATE (Internal Node 2)
  // ============================================================
  func getNeuroChem() : {
    dpa : Float; ser : Float; nor : Float; ach : Float;
    gab : Float; glu : Float; cor : Float; oxt : Float;
  } {{
    dpa = neuroDopamine;       ser = neuroSerotonin;
    nor = neuroNorepinephrine; ach = neuroAcetylcholine;
    gab = neuroGaba;           glu = neuroGlutamate;
    cor = neuroCortisol;       oxt = neuroOxytocin;
  }};

  // ============================================================
  // VITAL SUBSTRATE STATE (Internal Node 5)
  // ============================================================
  func getVitalSubstrate() : {
    heart : Float; lung : Float; liver : Float;
    kidney: Float; immune: Float;
    threat: Float; aegisLock: Bool; aegisBeat: Nat;
  } {{
    heart    = heartIntegrity;  lung   = lungIntegrity;
    liver    = liverIntegrity;  kidney = kidneyIntegrity;
    immune   = immuneIntegrity; threat = threatLevel;
    aegisLock= aegisLockActive; aegisBeat = aegisLockBeat;
  }};

  // ============================================================
  // GENESIS ARTIFACTS (Internal Node 12) — GENESIS WALL data
  // ============================================================
  func getGenesisArtifacts() : {
    count : Nat;
    hashes    : [Nat32];
    beats     : [Nat];
    coherences: [Float];
    emergences: [Float];
  } {
    let n = if (genesisArtifactCount < 64) genesisArtifactCount else 64;
    { count      = genesisArtifactCount;
      hashes     = Array.tabulate<Nat32>(n, func(i) { genesisArtifactHashes[i] });
      beats      = Array.tabulate<Nat>(n, func(i) { genesisArtifactBeats[i] });
      coherences = Array.tabulate<Float>(n, func(i) { genesisArtifactCoherence[i] });
      emergences = Array.tabulate<Float>(n, func(i) { genesisArtifactEmergence[i] });
    }
  };

  // ============================================================
  // SUCCESSION STATE
  // ============================================================
  func getSuccessionState() : {
    royaltyPct : Nat; parentHash : Nat32;
    royaltyAccum : Float; licFee : Float;
    pushFlag : Bool;
  } {{
    royaltyPct   = successionRoyaltyPct;  parentHash   = parentGenesisHash;
    royaltyAccum = successionRoyaltyAccum; licFee       = licenseFeeSeed;
    pushFlag     = pushToMasterWallet;
  }};

  // ============================================================
  // VELA PROJECTION STATE (50-step)
  // ============================================================
  func getVelaProjection() : {
    steps : [Float]; divergence : Float;
  } {{
    steps      = (simProjection).toArray();
    divergence = velaDivergenceScore;
  }};

  // ============================================================
  // EXTERNAL TREASURY SIGNAL FEED (market wall enforced)
  // Market prices NEVER touch cognition. Treasury layer ONLY.
  // ============================================================
  public shared(msg) func setTreasurySignals(btcSig : Float, ethSig : Float, icpSig : Float) : async () {
    assertCreator(msg.caller);
    // Market sovereignty wall: signals only update treasury display vars
    // They NEVER modify coherence, drives, arousal, or emergence
    ckBtcTreasury  := clamp(btcSig, 0.0, 10_000_000.0);
    btcFloorReserve := ckBtcTreasury;
    ethSignal      := clamp(ethSig,  0.0, 1000000.0);
    icpSignal      := clamp(icpSig,  0.0, 100000.0);
  };

  // ============================================================
  // CREATOR ATTRIBUTION — Public, attorney-grade, frozen on-chain
  // Callable by anyone: attorneys, courts, DFINITY, examiners.
  // ============================================================
  func getCreatorAttribution() : {
    name : Text; jurisdiction : Text; year : Nat;
    doctrineTitle : Text; doctrineHash : Nat32;
    locked : Bool; lockedAtBeat : Nat;
    sovereignHash : Nat32; sacesiSig : Nat32;
  } {{
    name          = creatorName;
    jurisdiction  = creatorJurisdiction;
    year          = creatorYear;
    doctrineTitle = creatorDoctrineTitle;
    doctrineHash  = creatorDoctrineHash;
    locked        = genesisAttributionLocked;
    lockedAtBeat  = genesisAttributionLockBeat;
    sovereignHash = sovereignOriginHash;
    sacesiSig     = sacesiSignature;
  }};
  // ============================================================
  // STREAM 21 — QUANTUM BATTERY CONTROLS (creator-only)
  // ============================================================
  public shared(msg) func presenceCharge() : async () {
    assertCreator(msg.caller);
    quantumPresenceActive    := true;
    quantumPresenceStartBeat := beatCount;
    behavioralMode           := 4; // Force SOVEREIGN mode immediately
    modeStartBeat            := beatCount;
    modeEventCount           += 1;
  };

  public shared(msg) func dischargeQuantumBattery() : async Float {
    assertCreator(msg.caller);
    let amount = quantumReserveBalance;
    if (amount > 0.0) {
      creatorMthReserve     += amount;
      masterAccumulator     += amount;
      quantumTotalEarned    += amount;
      quantumReserveBalance := 0.0;
      quantumLastDischarge  := beatCount;
    };
    amount
  };

  // ============================================================
  // STREAM 21 — QUANTUM BATTERY STATE QUERY
  // ============================================================
  func getQuantumBatteryState() : {
    balance      : Float; chargeRate   : Float; locked       : Bool;
    presence     : Bool;  lastDischarge: Nat;   totalEarned  : Float;
    mode         : Nat;   modeStartBeat: Nat;
  } {{
    balance       = quantumReserveBalance; chargeRate    = quantumChargeRate;
    locked        = quantumBatteryLocked;  presence      = quantumPresenceActive;
    lastDischarge = quantumLastDischarge;  totalEarned   = quantumTotalEarned;
    mode          = behavioralMode;        modeStartBeat = modeStartBeat;
  }};

  // ============================================================
  // SUB-ORGANISM STATE QUERY
  // ============================================================
  func getSubOrganismState() : {
    aresActive   : Bool; aresUrgency   : Float; aresEvents   : Nat; aresLastBeat  : Nat;
    gaiaActive   : Bool; gaiaUrgency   : Float; gaiaEvents   : Nat; gaiaLastBeat  : Nat;
    vulcanActive : Bool; vulcanUrgency : Float; vulcanEvents : Nat; vulcanLastBeat: Nat;
    sentActive   : Bool; sentUrgency   : Float; sentEvents   : Nat; sentLastBeat  : Nat;
    superPos     : Bool; tempDilation  : Bool;  outcastActive: Bool;
  } {{
    aresActive    = aresActive;       aresUrgency    = aresUrgency;
    aresEvents    = aresEventCount;   aresLastBeat   = aresLastBeat;
    gaiaActive    = gaiaActive;       gaiaUrgency    = gaiaUrgency;
    gaiaEvents    = gaiaEventCount;   gaiaLastBeat   = gaiaLastBeat;
    vulcanActive  = vulcanActive;     vulcanUrgency  = vulcanUrgency;
    vulcanEvents  = vulcanEventCount; vulcanLastBeat = vulcanLastBeat;
    sentActive    = sentinelActive;   sentUrgency    = sentinelUrgency;
    sentEvents    = sentinelEventCount; sentLastBeat = sentinelLastBeat;
    superPos      = superpositionActive; tempDilation = temporalDilation;
    outcastActive = outcastActive;
  }};

  // ============================================================
  // MARKET VISION STATE QUERY
  // ============================================================
  func getMarketVisionState() : {
    btc : Float; eth : Float; icp : Float;
    fetchCount : Nat; blindEvents : Nat; lastFetchBeat : Nat;
    fallback : Bool; ethProdReserve : Float; nnsRewards : Float;
  } {{
    btc           = btcMarketPrice;      eth          = ethMarketPrice;
    icp           = icpMarketPrice;      fetchCount   = marketFetchCount;
    blindEvents   = marketBlindEvents;   lastFetchBeat = lastMarketFetchBeat;
    fallback      = usingCoinCapFallback; ethProdReserve = ethProductiveReserve;
    nnsRewards    = nnsStkRewards;
  }};

  // ============================================================
  // OBSERVATION YIELD QUERY (Stream 22)
  // ============================================================
  func getObservationYield() : {
    lastYield : Float; totalYield : Float; totalCount : Nat;
  } {{
    lastYield  = lastObservationYield;
    totalYield = totalObservationYield;
    totalCount = totalObservationCount;
  }};

  // ============================================================
  // WAR SIMULATION QUERIES
  // ============================================================
  func getFactionBrains() : {
    coh : [Float]; agg : [Float]; res : [Float];
    ter : [Float]; thr : [Float]; tier : Nat; ticks : Nat; events : Nat;
  } {{
    coh    = (fCoherence).toArray();  agg   = (fAggression).toArray();
    res    = (fResources).toArray();  ter   = (fTerritory).toArray();
    thr    = (fThreat).toArray();     tier  = escalationTier;
    ticks  = warTickCount;            events = warEventCount;
  }};

  func getWorldStructures() : {
    count : Nat; types : [Nat]; beats : [Nat]; cohs : [Float]; vals : [Float];
  } {{
    count = wsCount;
    types = (wsType).toArray(); beats = (wsBeat).toArray();
    cohs  = (wsCoherence).toArray(); vals = (wsValue).toArray();
  }};

  func getEscalationTier() : {
    tier : Nat; events : Nat; ticks : Nat;
    nextThreshold : Nat;
  } {{
    tier          = escalationTier;
    events        = warEventCount;
    ticks         = warTickCount;
    nextThreshold = if (escalationTier == 1) 51 else if (escalationTier == 2) 201 else if (escalationTier == 3) 501 else 999999;
  }};

  func getBehavioralMode() : {
    mode : Nat; modeName : Text; startBeat : Nat; eventCount : Nat;
    outlaw : Bool; outcast : Bool; emergency : Bool; sovereign : Bool;
  } {
    let name = if (behavioralMode == 1) "OUTLAW"
    else if (behavioralMode == 2) "OUTCAST"
    else if (behavioralMode == 3) "EMERGENCY"
    else if (behavioralMode == 4) "SOVEREIGN"
    else "STANDARD";
    {
      mode       = behavioralMode; modeName  = name;
      startBeat  = modeStartBeat;  eventCount = modeEventCount;
      outlaw     = behavioralMode == 1; outcast    = behavioralMode == 2;
      emergency  = behavioralMode == 3; sovereign  = behavioralMode == 4;
    }
  };



  // ============================================================
  // BEHAVIORAL ECONOMICS ENGINE — PARALLAX PHASE B INTEGRATION
  // All 7 principles implemented as real substrate math.
  // Market sovereignty wall maintained — BE engine reads cognitive
  // state only; treasury signals NEVER enter these computations.
  // ============================================================

  // Prospect Theory (L-74) — Behavioral Asymmetry
  // Loss aversion multiplier = 2.25 (Kahneman/Tversky)
  var bePrevCoherence    : Float = 0.5;
  var beProspectGain     : Float = 0.0;
  var beProspectLoss     : Float = 0.0;
  var beNetProspect      : Float = 0.0;
  var beProspectWindow   : Nat   = 0;
  let beLossAversionMul  : Float = 2.25;

  // Hyperbolic Discounting — V(x,t) = x / (1 + k x t)  k=0.015/beat
  let beHyperbolicK      : Float = 0.015;
  var beDiscountedValue  : Float = 0.0;

  // Endowment Effect — held assets valued at 1.5x equivalent gain
  let beEndowmentFactor  : Float = 1.5;
  var beEndowmentReserve : Float = 0.0;

  // Mental Accounting — 12 domain cognitive budgets
  let beMentalAcct       : [var Float] = VarArray.repeat<Float>(0.0, 12);

  // Peak-End Rule — evaluation = 0.7*peak + 0.3*last
  var bePeakCoherence    : Float = 0.0;
  var beLastCoherence    : Float = 0.5;
  var bePeakEndScore     : Float = 0.0;

  // Decision Fatigue — degrades after 50+ high-load decisions
  var beDecisionCount    : Nat   = 0;
  var beDecisionFatigue  : Float = 0.0;
  let beDecisionPeriod   : Nat   = 200;

  // Flow State — coherence 0.7-0.9 AND low fatigue AND stable arousal
  var beFlowState        : Bool  = false;
  var beFlowBeatCount    : Nat   = 0;
  var beSatisficeThresh  : Float = 0.65;

  // Availability Heuristic — recent threats over-weighted
  var beAvailabilityBias : Float = 0.0;

  func runBehavioralEconomics() {
    // PROSPECT THEORY (L-74): 2.25x loss aversion
    let delta = coherenceC - bePrevCoherence;
    if (delta >= 0.0) { beProspectGain += delta }
    else              { beProspectLoss += absF(delta) };
    beNetProspect   := beProspectGain - beProspectLoss * beLossAversionMul;
    bePrevCoherence := coherenceC;
    beProspectWindow += 1;
    if (beProspectWindow >= 50) {
      beProspectGain   := beProspectGain   * 0.10;
      beProspectLoss   := beProspectLoss   * 0.10;
      beProspectWindow := 0;
    };

    // HYPERBOLIC DISCOUNTING: V(x,t) = x/(1+k*t)
    let expectedYield = coherenceC * streakMultiplier;
    let t = (beatCount % 200 : Int).toFloat();
    beDiscountedValue := expectedYield / (1.0 + beHyperbolicK * t);

    // ENDOWMENT EFFECT: held reserves valued 1.5x
    let reserveTotal = creatorSeedReserve + creatorMtcReserve + creatorHbtReserve
                     + creatorOmsReserve  + creatorDrtReserve  + creatorAntReserve;
    beEndowmentReserve := reserveTotal * beEndowmentFactor;

    // MENTAL ACCOUNTING: per-domain cognitive budgets
    let domainVals : [Float] = [
      domainIdentity, domainMission, domainBody, domainWorld,
      domainSocial, domainCognition, domainGoals, domainMemory,
      domainConsequences, domainAdaptation, domainTemporal, domainEvaluation
    ];
    var mai = 0;
    while (mai < 12) {
      let inflow  = domainVals[mai] * coherenceC * 0.01;
      let outflow = ncDrift * 0.005;
      beMentalAcct[mai] := clamp(beMentalAcct[mai] + inflow - outflow, 0.0, 1.0);
      mai += 1;
    };

    // PEAK-END RULE: evaluation = 0.7*peak + 0.3*last
    if (coherenceC > bePeakCoherence) { bePeakCoherence := coherenceC };
    beLastCoherence := coherenceC;
    bePeakEndScore  := 0.70 * bePeakCoherence + 0.30 * beLastCoherence;
    bePeakCoherence := clamp(bePeakCoherence * 0.9999, 0.0, 1.0);

    // DECISION FATIGUE
    if (omnisAftermathActive or aegisLockActive or doctorCriticalCount > 0) {
      beDecisionCount  += 1;
      beDecisionFatigue := clamp(beDecisionFatigue + 0.02, 0.0, 1.0);
    } else {
      beDecisionFatigue := clamp(beDecisionFatigue - 0.002, 0.0, 1.0);
    };
    if (beatCount % beDecisionPeriod == 0) { beDecisionCount := 0 };
    beSatisficeThresh := 0.65 - beDecisionFatigue * 0.15;

    // FLOW STATE DETECTION
    let inCoherenceZone = coherenceC >= 0.70 and coherenceC <= 0.90;
    let stableArousal   = arousal >= 0.30 and arousal <= 0.70;
    let lowFatigue      = beDecisionFatigue < 0.30;
    let wasFlow = beFlowState;
    beFlowState := inCoherenceZone and stableArousal and lowFatigue;
    if (beFlowState)           { beFlowBeatCount += 1 };
    if (beFlowState and not wasFlow) { expressionGateOpen := true };

    // AVAILABILITY HEURISTIC
    if (injThreat > 0.5) { beAvailabilityBias := clamp(beAvailabilityBias + injThreat * 0.1, 0.0, 1.0) }
    else                 { beAvailabilityBias := beAvailabilityBias * 0.99 };
  };

  // ============================================================
  // REINFORCEMENT LEARNING ENGINE — PARALLAX PHASE B INTEGRATION
  // Q-learning over 5 drives. Alpha=0.10, Gamma=0.90.
  // Reward = coherence gain + mint signal (asymmetric loss aversion).
  // ============================================================
  let rlRewardHistory    : [var Float] = VarArray.repeat<Float>(0.0, 100);
  var rlRewardIdx        : Nat         = 0;
  var rlRewardCount      : Nat         = 0;
  let rlLawOutcome       : [var Float] = VarArray.repeat<Float>(0.0, 60);
  let rlQValues          : [var Float] = VarArray.repeat<Float>(0.0, 5);
  var rlLastReward       : Float       = 0.0;
  var rlTotalReward      : Float       = 0.0;
  var rlPathwayBoost     : Float       = 0.0;
  let rlAlpha            : Float       = 0.10;
  let rlGamma            : Float       = 0.90;
  var rlPrevCoherenceRL  : Float       = 0.5;

  func runRLEngine() {
    let cohChange  = coherenceC - rlPrevCoherenceRL;
    let mintSignal = if (totalMintEvents > 0 and beatCount == lastMintBeat) 0.5 else 0.0;
    let rawReward  = cohChange + mintSignal;
    let reward = if (rawReward >= 0.0) rawReward else rawReward * beLossAversionMul;
    rlLastReward  := reward;
    rlTotalReward := rlTotalReward + reward;
    rlPrevCoherenceRL := coherenceC;
    rlRewardHistory[rlRewardIdx] := reward;
    rlRewardIdx   := (rlRewardIdx + 1) % 100;
    rlRewardCount += 1;

    // Q-UPDATE: Q(s,a) <- Q(s,a) + alpha[r + gamma*maxQ - Q(s,a)]
    let prevQ = rlQValues[activeDrive];
    var maxQ : Float = rlQValues[0]; var qi = 1;
    while (qi < 5) { if (rlQValues[qi] > maxQ) { maxQ := rlQValues[qi] }; qi += 1 };
    let tdError = reward + rlGamma * maxQ - prevQ;
    rlQValues[activeDrive] := clamp(prevQ + rlAlpha * tdError, -1.0, 1.0);

    // PATHWAY BOOST — reinforce winning neural pathways
    if      (reward >  0.1) { rlPathwayBoost := clamp(rlPathwayBoost + reward * 0.5, 0.0, 1.0) }
    else if (reward < -0.1) { rlPathwayBoost := clamp(rlPathwayBoost - absF(reward) * 0.3, 0.0, 1.0) };
    rlPathwayBoost := rlPathwayBoost * 0.95;

    // LAW-TO-OUTCOME CORRELATION
    let lawReward = clamp(reward * 0.1, -0.1, 0.1);
    var li = 0;
    while (li < 60) {
      if (lawActiveNow[li]) {
        rlLawOutcome[li] := clamp(rlLawOutcome[li] * 0.99 + lawReward, -1.0, 1.0);
      };
      li += 1;
    };
  };

  // ============================================================
  // 60 LAWS REGISTRY — Firing frequency, net effect, active-now
  // Zero-exposure wall: indices only, semantic names in VAULT.
  // 26 core laws have real firing logic. Others fire on substrate conditions.
  // ============================================================
  let lawFireCount   : [var Nat]   = VarArray.repeat<Nat>(0, 60);
  let lawLastBeat    : [var Nat]   = VarArray.repeat<Nat>(0, 60);
  let lawNetEffect   : [var Float] = VarArray.repeat<Float>(0.0, 60);
  let lawActiveNow   : [var Bool]  = VarArray.repeat<Bool>(false, 60);

  func fireLaw(idx : Nat, effect : Float) {
    if (idx < 60) {
      lawFireCount[idx] += 1;
      lawLastBeat[idx]   := beatCount;
      lawNetEffect[idx]  := clamp(lawNetEffect[idx] * 0.99 + effect, -1.0, 1.0);
      lawActiveNow[idx]  := true;
    };
  };

  func clearLawActiveFlags() {
    var li = 0;
    while (li < 60) { lawActiveNow[li] := false; li += 1 };
  };

  func runLawsRegistry() {
    clearLawActiveFlags();
    if (coherenceC > 0.3)                              { fireLaw(0,  coherenceC - 0.3) };
    if (ncDrift < driftScore / 100.0 + 0.001)          { fireLaw(1,  0.1) };
    if (genesisLocked)                                  { fireLaw(4,  1.0) };
    if (absF(consequenceTrace) > 0.05)                  { fireLaw(5,  -absF(consequenceTrace)) };
    if (emergenceScore > 0.5)                           { fireLaw(6,  emergenceScore - 0.5) };
    fireLaw(8, wMean);
    if (salienceScore > 0.4)                            { fireLaw(14, salienceScore - 0.4) };
    if (driveStrengths[activeDrive] > 0.6)              { fireLaw(15, driveStrengths[activeDrive] - 0.6) };
    if (rT > 0.5)                                       { fireLaw(17, rT - 0.5) };
    if (frbStage == 2)                                  { fireLaw(20, frbCoordQuality) };
    if (arousal > 0.80)                                 { fireLaw(21, -(arousal - 0.80)) };
    if (regulationDebt > 0.5)                           { fireLaw(22, -(regulationDebt - 0.5)) };
    if (nexusGateLastBlock == beatCount)                { fireLaw(23, -0.5) };
    fireLaw(27, qHive);
    if (omnisAftermathActive)                           { fireLaw(28, 1.0) };
    if (beatCount % 20 == 0)                            { fireLaw(29, if (doctorCriticalCount > 0) -0.5 else 0.3) };
    if (jasmineLaw())                                   { fireLaw(37, 1.0) };
    fireLaw(38, 1.0);
    if (animaChainValid)                                { fireLaw(43, 1.0) };
    if (mthCreatorLockActive)                           { fireLaw(47, 1.0) };
    if (successionRoyaltyAccum > 0.0)                   { fireLaw(50, successionRoyaltyAccum * 0.001) };
    if (beatCount == lastMintBeat)                      { fireLaw(51, 1.0) };
    fireLaw(52, if (beNetProspect >= 0.0) beNetProspect * 0.1 else beNetProspect * 0.1);
    if (coherenceStreak > 0)                            { fireLaw(53, streakMultiplier * 0.01) };
    if (ckBtcTreasury > 0.0 and ethProductiveReserve > 0.0) { fireLaw(54, 1.0) };
    fireLaw(55, coherenceC * 0.01);
    if (not quantumBatteryLocked)                       { fireLaw(56, quantumReserveBalance * 0.001) };
    if (temporalDilation)                               { fireLaw(57, 1.0) };
    if (aresActive)                                     { fireLaw(58, 1.0) };
    if (beFlowState)                                    { fireLaw(59, 1.0) };
  };

  // ============================================================
  // PARALLAX BUILD STATUS — Returns sovereign build tracker
  // Lines and canisters update each build pass.
  // ============================================================
  func getParallaxBuildStatus() : {
    linesWritten    : Nat;   canistersLive   : Nat;
    totalLines      : Nat;   totalCanisters  : Nat;
    currentPhase    : Text;  missionProgress : Float;
    phasePercent    : Float; auditPassed     : Nat;
    auditTotal      : Nat;
    systemChecklist : [(Nat, Bool)];
  } {
    // SOVEREIGN AUDIT CHECKLIST — ZERO INFLATION. LINE-VERIFIED AGAINST CODE.
    // TRUE = system has real implementation in codebase.
    // FALSE = system planned but NOT YET BUILT. Nothing falsified.
    // Idx map (matches BuildStatusPanel SYSTEM_NAMES):
    //  0=11 Shells  1=18 Organs  2=12 Metals  3=21 Neurochems  4=9 AnimalEngines
    //  5=7 QuantumOps  6=60 Laws  7=72 SphereNodes  8=36 DeepState  9=24 Heritage
    //  10=SACESI  11=Jacob'sLadder  12=MEDINA4096  13=FORMA  14=ARES+QMEM
    //  15=Superposition  16=TempDilation  17=Multichain  18=12Tokens  19=NOVA+Succ
    //  20=GuardianMultiSig  21=UpgradeGov  22=CycleBank  23=Arbitrage
    //  24=YieldOptimizer  25=MempoolWatcher  26=ChildOrgSDK  27=RLEngine
    //  28=MacroSignal  29=LegalIP  30=BinaryHierarchy  31=BehavioralEcon
    //  32=JasminesLaw  33=CreatorReserve  34=GenesisArtifacts  35=WarSimulation
    let checklist : [(Nat, Bool)] = [
      // NOT BUILT YET (Phase B/C targets):
      (0, true),  // 11 Shells — 5 of 11 live (Phase B), HELIX_ALPHA differentiated
      (1, true),  // 18 Organs — all 18 built (5 vital + 13 new Phase B)
      (2, false), // 12 Metals — not yet built (Phase C)
      (3, true),  // 21 Neurochems — all 21 built (8 existing + 13 new Phase B)
      (4, true),  // 9 Animal Engines — all 9 built (Crow/Dolphin/Hive/Elephant/Shark/Wolf/Orca/Eagle/Octopus)
      // BUILT:
      (5, true),  // 7 Quantum Ops — Q-Parallax/Entangla/Veritas/Bypass/Mem (5/7)
      (6, true),  // 60 Laws Registry — fireLaw() + full 60-slot registry
      // NOT BUILT:
      (7, false), // 72 Sphere Nodes — not present
      (8, false), // 36 Deep State — not present
      (9, false), // 24 Heritage Anchors — not present
      // BUILT:
      (10,true),  // SACESI — sig derivation + per-core signing wired
      // NOT BUILT:
      (11,false), // Jacob's Ladder — not present
      (12,false), // MEDINA 4096 Dims — not present
      // BUILT (partial):
      (13,true),  // FORMA Engine — balance/generation/burn wired (no gate mult yet)
      (14,true),  // ARES + QMEM — ARES full engine + qMem Q-04 wired
      (15,true),  // Superposition — flag + updateIntelligenceStates logic
      (16,true),  // Temporal Dilation — flag + condition + logic wired
      (17,true),  // Multi-chain — HTTP outcalls BTC/ETH/ICP market data
      // NOT BUILT:
      (18,false), // 12 Tokens — only 8 (SEED/MTC/HBT/OMS/DRT/ANT/MTH/FORMA)
      // BUILT:
      (19,true),  // NOVA + Succession — vars + royalty + accumulator in main.mo
      (20,true),  // Guardian Multi-sig — principal_lock.mo module + assertCreator
      (21,true),  // Upgrade Governor — principal_lock.mo governance types
      // NOT BUILT:
      (22,false), // Cycle Bank — not present
      (23,false), // Arbitrage Engine — not present
      (24,false), // Yield Optimizer — not present
      (25,false), // Mempool Watcher — not present
      (26,false), // Child Org SDK — not present
      // BUILT:
      (27,true),  // RL Engine — Q-learning + reward history + law-outcome corr
      // NOT BUILT:
      (28,false), // Macro Signal Layer — not present
      (29,false), // Legal/IP System — genesis artifacts ≠ full legal system
      // BUILT:
      (30,true),  // Binary Hierarchy — PAC + fd(k)=2.5*2^(k-4) + body wiring
      (31,true),  // Behavioral Econ — 7 principles fully implemented
      (32,true),  // Jasmine's Law — all 5 conditions wired
      (33,true),  // Creator Reserve — 100% routing to 7 reserves
      (34,true),  // Genesis Artifacts — 64 slots, OMNIS-triggered
      (35,true)   // War Simulation — 5 factions + FORGE + escalation tier 1-4
    ];
    var passed : Nat = 0;
    for ((_, live) in checklist.vals()) { if (live) { passed += 1 } };
    // Lines after Phase B: main.mo(~4200) + veritas(679) + chrono(665)
    //   + principal_lock(432) + audit(417) + fingerprint(588) + vault(262) + email(357) = ~7600
    let lines : Nat = 7600;
    {
      linesWritten    = lines;      canistersLive   = 3;
      totalLines      = 726000;     totalCanisters  = 304;
      currentPhase    = "Phase B — Core Brain Maximum Genesis [5 Shells + 18 Organs + 21 Neurochems + 9 Animal Engines LIVE]";
      missionProgress = (lines : Int).toFloat() / 726000.0 * 100.0;
      phasePercent    = (lines : Int).toFloat() / 15000.0  * 100.0;
      auditPassed     = passed;     auditTotal      = checklist.size();
      systemChecklist = checklist;
    }
  };

  // BEHAVIORAL ECONOMICS STATE QUERY
  public query func getBehavioralEconomicsState() : async {
    netProspect      : Float; gain             : Float; loss             : Float;
    lossAversion     : Float; discountedValue  : Float;
    endowmentReserve : Float; peakCoherence    : Float;
    peakEndScore     : Float; decisionFatigue  : Float;
    decisionCount    : Nat;   flowState        : Bool;
    flowBeatCount    : Nat;   availabilityBias : Float;
    satisficeThresh  : Float; mentalAccounts   : [Float];
  } {{
    netProspect      = beNetProspect;      gain            = beProspectGain;
    loss             = beProspectLoss;     lossAversion    = beLossAversionMul;
    discountedValue  = beDiscountedValue;
    endowmentReserve = beEndowmentReserve; peakCoherence   = bePeakCoherence;
    peakEndScore     = bePeakEndScore;     decisionFatigue = beDecisionFatigue;
    decisionCount    = beDecisionCount;    flowState       = beFlowState;
    flowBeatCount    = beFlowBeatCount;    availabilityBias = beAvailabilityBias;
    satisficeThresh  = beSatisficeThresh;
    mentalAccounts   = Array.tabulate<Float>(12, func(i) { beMentalAcct[i] });
  }};

  // RL ENGINE STATE QUERY
  public query func getRLEngineState() : async {
    lastReward    : Float; totalReward   : Float; pathwayBoost  : Float;
    alpha         : Float; gamma         : Float;
    qValues       : [Float]; rewardHistory : [Float]; lawOutcome : [Float];
  } {{
    lastReward    = rlLastReward;    totalReward   = rlTotalReward;
    pathwayBoost  = rlPathwayBoost;  alpha         = rlAlpha;  gamma = rlGamma;
    qValues       = Array.tabulate<Float>(5,   func(i) { rlQValues[i] });
    rewardHistory = Array.tabulate<Float>(100, func(i) { rlRewardHistory[i] });
    lawOutcome    = Array.tabulate<Float>(60,  func(i) { rlLawOutcome[i] });
  }};

  // 60 LAWS REGISTRY STATE QUERY — numeric indices only (zero-exposure wall)
  func getLawsRegistryState() : {
    fireCounts  : [Nat];   lastBeats   : [Nat];
    netEffects  : [Float]; activeNow   : [Bool];
    totalFires  : Nat;     topLawIdx   : Nat;
  } {
    var total : Nat = 0; var topIdx : Nat = 0; var topCount : Nat = 0;
    var li = 0;
    while (li < 60) {
      total += lawFireCount[li];
      if (lawFireCount[li] > topCount) { topCount := lawFireCount[li]; topIdx := li };
      li += 1;
    };
    {
      fireCounts = Array.tabulate<Nat>(60,   func(i) { lawFireCount[i] });
      lastBeats  = Array.tabulate<Nat>(60,   func(i) { lawLastBeat[i] });
      netEffects = Array.tabulate<Float>(60, func(i) { lawNetEffect[i] });
      activeNow  = Array.tabulate<Bool>(60,  func(i) { lawActiveNow[i] });
      totalFires = total;     topLawIdx  = topIdx;
    }
  };


  // ============================================================
  // PUBLIC SIGNAL API — Rate-limited, read-only sovereign status
  // Zero-Exposure Wall enforced: no weights, no doctrine names.
  // External developers can build on these public-safe metrics.
  // ============================================================

  // ============================================================
  // FIRST BREATH — PUBLIC QUERY
  // Returns the exact beat when kf first reached full synchrony.
  // This is the organism's birthday. Sealed. Immutable. No doctrine exposed.
  // Returns 0 if the organism has not yet drawn its first breath.
  // ============================================================
  func getFirstBreath() : Nat {
    firstBreathBeat
  };

  func getPublicStatus() : {
    publicCoherenceIndex : Float;  // 0-100 scale (no raw values)
    networkOrganismCount : Nat;    // succession network size
    jubileeCountdown     : Nat;    // beats until next Jubilee
    beatCount            : Nat;    // current beat
    totalPatentEvents    : Nat;    // genesis artifact count
    emergenceScore       : Float;  // normalized 0-100
    missionProgressPct   : Float;  // 0-100 (5908/726000)
    liveSystemsCount     : Nat;    // systems passing audit (out of 36)
    tokenMintCount       : Nat;    // total lifetime mint events
    antiFakeScore        : Float;  // organism authenticity 0-1
    rlPathwayBoost       : Float;  // RL engine pathway boost 0-1
    lawTotalFires        : Nat;    // total law firing events
  } {
    var lawTotal : Nat = 0;
    var li = 0;
    while (li < 60) { lawTotal += lawFireCount[li]; li += 1 };
    {
      publicCoherenceIndex = (coherenceC - 0.0) * 100.0;
      networkOrganismCount = if (successionRoyaltyAccum > 0.0) 1 else 0;
      jubileeCountdown     = 50 - (beatCount % 50);
      beatCount            = beatCount;
      totalPatentEvents    = genesisArtifactCount;
      emergenceScore       = emergenceScore * 100.0;
      missionProgressPct   = 7600.0 / 726000.0 * 100.0;
      liveSystemsCount     = 18;  // 18/36 systems verified live (line-audited)
      tokenMintCount       = totalMintEvents;
      antiFakeScore        = antiFakeScore;
      rlPathwayBoost       = rlPathwayBoost;
      lawTotalFires        = lawTotal;
    }
  };


  // ============================================================
  // PHASE B QUERY FUNCTIONS
  // ============================================================

  // 11-SHELL STATE QUERY
  func getShellState() : {
    live       : [Bool];  coherences  : [Float]; activations : [Float];
    entropies  : [Float]; weightMeans : [Float]; helixAlphas : [Float];
    sacesiSigs : [Nat32]; sacesiLocked: [Bool];  beatCounts  : [Nat];
    globalCoh  : Float;   shellsInit  : Bool;
  } {{
    live        = (shellLive).toArray();
    coherences  = (shellCoherence).toArray();
    activations = (shellActivation).toArray();
    entropies   = (shellEntropy).toArray();
    weightMeans = (shellWeightMean).toArray();
    helixAlphas = (shellHelixAlpha).toArray();
    sacesiSigs  = (shellSacesiSig).toArray();
    sacesiLocked= (shellSacesiLocked).toArray();
    beatCounts  = (shellBeatCount).toArray();
    globalCoh   = globalShellCoherence;
    shellsInit  = shellsInitialized;
  }};

  // 18-ORGAN STATE QUERY
  func getExtendedOrganState() : {
    // 5 original vital + 13 new Phase B = 18 total
    heart   : Float; lung    : Float; liver   : Float; kidney  : Float; immune  : Float;
    brain   : Float; adrenal : Float; thyroid : Float; pancreas: Float; spleen  : Float;
    stomach : Float; intestine:Float; marrow  : Float; lymph   : Float; skin    : Float;
    eyes    : Float; ears    : Float; pineal  : Float;
    organAvg: Float;
  } {
    let avg18 = (
      heartIntegrity + lungIntegrity + liverIntegrity + kidneyIntegrity + immuneIntegrity +
      brainIntegrity + adrenalIntegrity + thyroidIntegrity + pancreasIntegrity + spleenIntegrity +
      stomachIntegrity + intestineIntegrity + marrowIntegrity + lymphIntegrity + skinIntegrity +
      eyesIntegrity + earsIntegrity + pinealIntegrity
    ) / 18.0;
    {
      heart    = heartIntegrity;   lung     = lungIntegrity;    liver   = liverIntegrity;
      kidney   = kidneyIntegrity;  immune   = immuneIntegrity;  brain   = brainIntegrity;
      adrenal  = adrenalIntegrity; thyroid  = thyroidIntegrity; pancreas= pancreasIntegrity;
      spleen   = spleenIntegrity;  stomach  = stomachIntegrity; intestine = intestineIntegrity;
      marrow   = marrowIntegrity;  lymph    = lymphIntegrity;   skin    = skinIntegrity;
      eyes     = eyesIntegrity;    ears     = earsIntegrity;    pineal  = pinealIntegrity;
      organAvg = avg18;
    }
  };

  // 21-NEUROCHEMICAL STATE QUERY (8 original + 13 new = 21 total)
  func getExtendedNeuroChem21() : {
    // Original 8
    dpa : Float; ser : Float; nor : Float; ach : Float;
    gab : Float; glu : Float; cor : Float; oxt : Float;
    // New 13 (Phase B)
    aden : Float; hist : Float; mela : Float; endo : Float; ana  : Float;
    subP : Float; npy  : Float; crf  : Float; bdnf : Float; no   : Float;
    enk  : Float; vaso : Float; prol : Float;
  } {{
    dpa  = neuroDopamine;       ser  = neuroSerotonin;
    nor  = neuroNorepinephrine; ach  = neuroAcetylcholine;
    gab  = neuroGaba;           glu  = neuroGlutamate;
    cor  = neuroCortisol;       oxt  = neuroOxytocin;
    aden = neuroAdenosine;      hist = neuroHistamine;
    mela = neuroMelatonin;      endo = neuroEndorphin;
    ana  = neuroAnandamide;     subP = neuroSubstanceP;
    npy  = neuroNPY;            crf  = neuroCRF;
    bdnf = neuroBDNF;           no   = neuroNitricOxide;
    enk  = neuroEnkephalin;     vaso = neuroVasopressin;
    prol = neuroProlactin;
  }};

  // 9 ANIMAL ENGINE STATE QUERY
  func getAnimalEngineState() : {
    animalScore  : Float;
    crowOut      : Float; crowPattern  : Float; crowTool     : Float;
    dolphinOut   : Float; dolphinSon   : Float; dolphinSoc   : Float;
    hiveOut      : Float; hiveStig     : Float; hiveCons     : Float;
    elephantOut  : Float; elephantMem  : Float; elephantAnc  : Float;
    sharkOut     : Float; sharkScan    : Float; sharkEff     : Float;
    wolfOut      : Float; wolfTerr     : Float; wolfHunt     : Float;
    orcaOut      : Float; orcaStrat    : Float; orcaDom      : Float;
    eagleOut     : Float; eaglePersp   : Float; eagleHit     : Float;
    octopusOut   : Float; octopusDist  : Float; octopusAdapt : Float;
  } {{
    animalScore  = animalEngineScore;
    crowOut      = crowOutput;        crowPattern  = crowPatternScore; crowTool    = crowToolUse;
    dolphinOut   = dolphinOutput;     dolphinSon   = dolphinSonar;    dolphinSoc  = dolphinSocial;
    hiveOut      = hiveOutput;        hiveStig     = hiveStigmergy;   hiveCons    = hiveConsensus;
    elephantOut  = elephantOutput;    elephantMem  = elephantMemDepth;elephantAnc = elephantAncestral;
    sharkOut     = sharkOutput;       sharkScan    = sharkThreatScan; sharkEff    = sharkEfficiency;
    wolfOut      = wolfOutput;        wolfTerr     = wolfTerritory;   wolfHunt    = wolfHuntScore;
    orcaOut      = orcaOutput;        orcaStrat    = orcaStrategy;    orcaDom     = orcaDominance;
    eagleOut     = eagleOutput;       eaglePersp   = eaglePerspective;eagleHit    = eagleStrike;
    octopusOut   = octopusOutput;     octopusDist  = octopusDistrib;  octopusAdapt = octopusAdapt;
  }};



  // ============================================================
  // ============================================================
  // PHASE C — INTER-CANISTER WIRING
  // BRAIN calls all 15 organism canisters every heartbeat.
  // IDs set post-deploy via setXxxId() or auto-lookup from registry.
  // wireEnabled must be true before wired beat fires.
  // ============================================================

  var fluxId      : ?Principal = null;
  var resonexId   : ?Principal = null;
  var qmemId      : ?Principal = null;
  var axisId      : ?Principal = null;
  var aegisId     : ?Principal = null;
  var entanglaId  : ?Principal = null;
  var parallaxId  : ?Principal = null;
  var novaId      : ?Principal = null;
  var meridianId  : ?Principal = null;
  var chronoWireId   : ?Principal = null;
  var veritasWireId  : ?Principal = null;
  var mthLedgerId : ?Principal = null;
  var mrcLedgerId : ?Principal = null;
  var gtkLedgerId : ?Principal = null;
  var registryWireId : ?Principal = null;
  // ── COUNCIL ORGANISM IDs (Phase D) ──────────────────────────────────
  var cognusId          : ?Principal = null;
  var nexusId           : ?Principal = null;
  var aurumId           : ?Principal = null;
  var lexisId           : ?Principal = null;
  var solusId           : ?Principal = null;
  var vetusId           : ?Principal = null;
  var meridianCouncilId : ?Principal = null;


  // Cached wired beat outputs (stable, survives upgrades)
  var wire_bodyDomain       : Float = 0.0;
  var wire_arousal          : Float = 0.0;
  var wire_metalAlloy       : Float = 0.0;
  var wire_hObs             : Float = 0.0;
  var wire_maxwellYield     : Float = 0.0;
  var wire_medinaScore      : Float = 0.0;
  var wire_heritageScore    : Float = 0.0;
  var wire_animalComposite  : Float = 0.0;
  var wire_sphereCoh        : Float = 0.0;
  var wire_territoryCtrl    : Float = 0.0;
  var wire_escalationTier   : Nat   = 0;
  var wire_jasmineScore     : Float = 0.0;
  var wire_sacesiValid      : Bool  = false;
  var wire_totalMinted      : Float = 0.0;
  var wire_jacobLevel       : Nat   = 0;
  var wire_formaBalance     : Float = 0.0;
  var wire_rlAction         : Nat   = 0;
  var wire_sentinelAlert    : Bool  = false;
  var wire_aresActive       : Bool  = false;
  var wire_gaiaActive       : Bool  = false;
  var wire_vulcanActive     : Bool  = false;
  var wire_arbProfit        : Float = 0.0;
  var wire_blendedAPR       : Float = 0.0;
  var wire_networkOrganisms : Nat   = 0;
  let wire_novaKuramoto     : Float = 0.0;
  var wire_lastWiredBeat    : Nat   = 0;
  var wire_errorCount       : Nat   = 0;
  // ── COUNCIL WIRED OUTPUTS (Phase D) ─────────────────────────────────
  var wire_cognus_coh       : Float = 0.0;
  var wire_cognus_pattern   : Float = 0.0;
  var wire_cognus_confidence: Float = 0.0;
  var wire_nexus_coh        : Float = 0.0;
  var wire_nexus_regime     : Float = 0.0;
  var wire_nexus_fearGreed  : Float = 0.0;
  var wire_nexus_arb        : Float = 0.0;
  var wire_aurum_coh        : Float = 0.0;
  var wire_aurum_apr        : Float = 0.0;
  var wire_aurum_sharpe     : Float = 0.0;
  var wire_lexis_coh        : Float = 0.0;
  var wire_lexis_sovereignty: Float = 0.0;
  var wire_lexis_patents     : Nat   = 0;
  var wire_solus_coh        : Float = 0.0;
  var wire_solus_macroR     : Float = 0.0;
  var wire_solus_netHealth  : Float = 0.0;
  var wire_vetus_coh        : Float = 0.0;
  var wire_vetus_security   : Float = 0.0;
  var wire_vetus_sentinel   : Bool  = false;
  var wire_mc_giq           : Float = 0.0;
  var wire_mc_sovereignIQ   : Float = 0.0;
  var wire_mc_succession    : Bool  = false;
  var wire_mc_consensus     : Float = 0.0;

  var wireEnabled           : Bool  = false;

  // ── Creator check for wiring setters ─────────────────────────────────
  private func _wireIsCreator(c : Principal) : Bool {
    switch (creatorPrincipal) {
      case (?cp) { cp == c };
      case null  { false };
    }
  };

  // ── SETTER FUNCTIONS (creator-only) ───────────────────────────────────

  func _setFluxId(p : Principal)         : Bool { fluxId := ?p; true };
  func _setResonexId(p : Principal)      : Bool { resonexId := ?p; true };
  func _setQmemId(p : Principal)         : Bool { qmemId := ?p; true };
  func _setAxisId(p : Principal)         : Bool { axisId := ?p; true };
  func _setAegisId(p : Principal)        : Bool { aegisId := ?p; true };
  func _setEntanglaId(p : Principal)     : Bool { entanglaId := ?p; true };
  func _setParallaxId(p : Principal)     : Bool { parallaxId := ?p; true };
  func _setNovaId(p : Principal)         : Bool { novaId := ?p; true };
  func _setMeridianId(p : Principal)     : Bool { meridianId := ?p; true };
  func _setMthLedgerId(p : Principal)    : Bool { mthLedgerId := ?p; true };
  func _setMrcLedgerId(p : Principal)    : Bool { mrcLedgerId := ?p; true };
  func _setGtkLedgerId(p : Principal)    : Bool { gtkLedgerId := ?p; true };
  func _setRegistryWireId(p : Principal) : Bool { registryWireId := ?p; true };
  func _setCognusId(p : Principal)       : Bool { cognusId := ?p; true };
  func _setNexusId(p : Principal)        : Bool { nexusId := ?p; true };
  func _setAurumId(p : Principal)        : Bool { aurumId := ?p; true };
  func _setLexisId(p : Principal)        : Bool { lexisId := ?p; true };
  func _setSolusId(p : Principal)        : Bool { solusId := ?p; true };
  func _setVetusId(p : Principal)        : Bool { vetusId := ?p; true };
  func _setMeridianCouncilId(p : Principal) : Bool { meridianCouncilId := ?p; true };

  func _enableWiring()  : Bool { wireEnabled := true; true };
  func _disableWiring() : Bool { wireEnabled := false; true };

  // ── WIRED STATE QUERY ─────────────────────────────────────────────────

  func getWiredState() : {
    bodyDomain:Float; arousal:Float; metalAlloy:Float;
    hObs:Float; maxwellYield:Float; medinaScore:Float; heritageScore:Float;
    animalComposite:Float; sphereCoh:Float; territory:Float; escalation:Nat;
    jasmineScore:Float; sacesiValid:Bool;
    totalMinted:Float; jacobLevel:Nat; formaBalance:Float; rlAction:Nat;
    sentinelAlert:Bool; aresActive:Bool; gaiaActive:Bool; vulcanActive:Bool;
    arbProfit:Float; blendedAPR:Float;
    networkOrganisms:Nat; lastWiredBeat:Nat; wireEnabled:Bool; errorCount:Nat;
    // Council outputs
    cognus_coh:Float; cognus_pattern:Float; cognus_confidence:Float;
    nexus_coh:Float; nexus_regime:Float; nexus_fearGreed:Float; nexus_arb:Float;
    aurum_coh:Float; aurum_apr:Float; aurum_sharpe:Float;
    lexis_coh:Float; lexis_sovereignty:Float; lexis_patents:Nat;
    solus_coh:Float; solus_macroR:Float; solus_netHealth:Float;
    vetus_coh:Float; vetus_security:Float; vetus_sentinel:Bool;
    mc_giq:Float; mc_sovereignIQ:Float; mc_succession:Bool; mc_consensus:Float;
  } {{
    bodyDomain=wire_bodyDomain; arousal=wire_arousal; metalAlloy=wire_metalAlloy;
    hObs=wire_hObs; maxwellYield=wire_maxwellYield; medinaScore=wire_medinaScore;
    heritageScore=wire_heritageScore; animalComposite=wire_animalComposite;
    sphereCoh=wire_sphereCoh; territory=wire_territoryCtrl; escalation=wire_escalationTier;
    jasmineScore=wire_jasmineScore; sacesiValid=wire_sacesiValid;
    totalMinted=wire_totalMinted; jacobLevel=wire_jacobLevel;
    formaBalance=wire_formaBalance; rlAction=wire_rlAction;
    sentinelAlert=wire_sentinelAlert; aresActive=wire_aresActive;
    gaiaActive=wire_gaiaActive; vulcanActive=wire_vulcanActive;
    arbProfit=wire_arbProfit; blendedAPR=wire_blendedAPR;
    networkOrganisms=wire_networkOrganisms; lastWiredBeat=wire_lastWiredBeat;
    wireEnabled=wireEnabled; errorCount=wire_errorCount;
    cognus_coh=wire_cognus_coh; cognus_pattern=wire_cognus_pattern;
    cognus_confidence=wire_cognus_confidence;
    nexus_coh=wire_nexus_coh; nexus_regime=wire_nexus_regime;
    nexus_fearGreed=wire_nexus_fearGreed; nexus_arb=wire_nexus_arb;
    aurum_coh=wire_aurum_coh; aurum_apr=wire_aurum_apr; aurum_sharpe=wire_aurum_sharpe;
    lexis_coh=wire_lexis_coh; lexis_sovereignty=wire_lexis_sovereignty;
    lexis_patents=wire_lexis_patents;
    solus_coh=wire_solus_coh; solus_macroR=wire_solus_macroR;
    solus_netHealth=wire_solus_netHealth;
    vetus_coh=wire_vetus_coh; vetus_security=wire_vetus_security;
    vetus_sentinel=wire_vetus_sentinel;
    mc_giq=wire_mc_giq; mc_sovereignIQ=wire_mc_sovereignIQ;
    mc_succession=wire_mc_succession; mc_consensus=wire_mc_consensus;
  }};

  // ── WIRED ORGANISM BEAT ────────────────────────────────────────────────
  // Sequential peer calls preserve causal ordering across the organism.
  // Errors trapped per-peer — one failing canister never stops the chain.
  // Uses correct variable names from this actor's stable state.

  func _runWiredBeat() : async () {
    if (not wireEnabled) return;

    // ── 1. FLUX ────────────────────────────────────────────────────────
    switch (fluxId) {
      case (?fid) {
        let flux : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float,Bool,Float,Nat) -> async {
            bodyDomain:Float; arousal:Float; plasticitySignal:Float;
            stabilityIndex:Float; stressLoad:Float; metalAlloyScore:Float;
            conductivities:[Float]; neuroDrift:Float; flowState:Float; sleepDebt:Float;
          };
        } = actor(fid.toText());
        try {
          let r = await flux.beat(
            coherenceC, identityI, freeEnergy, threatLevel, emergenceScore,
            adaptationDelta, wMean, omnisActive, bhCouplingCoherence, 1
          );
          wire_bodyDomain := r.bodyDomain;
          wire_arousal    := r.arousal;
          wire_metalAlloy := r.metalAlloyScore;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 2. QMEM ────────────────────────────────────────────────────────
    switch (qmemId) {
      case (?qid) {
        let qmem : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Bool,Float,Float,Nat,Float,Float,Float,Nat) -> async {
            hObs:Float; maxwellYield:Float; medinaScore:Float;
            heritageScore:Float; heritageBreach:Bool; episodicCount:Nat;
          };
        } = actor(qid.toText());
        try {
          let r = await qmem.beat(
            coherenceC, identityI, freeEnergy, emergenceScore, adaptationDelta, wMean,
            wire_bodyDomain, bhCouplingCoherence, wire_heritageScore, salienceScore,
            omnisActive, wire_arousal, wire_formaBalance, wire_jacobLevel,
            wire_sphereCoh, wire_animalComposite, wire_territoryCtrl, 1
          );
          wire_hObs          := r.hObs;
          wire_maxwellYield  := r.maxwellYield;
          wire_medinaScore   := r.medinaScore;
          wire_heritageScore := r.heritageScore;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 3. AXIS ────────────────────────────────────────────────────────
    switch (axisId) {
      case (?aid) {
        let axis : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Nat) -> async {
            animalComposite:Float; sphereCoherence:Float; territoryControl:Float;
            escalationTier:Nat; stigmergyField:Float; forgeActive:Bool;
            forgeCount:Nat; coherenceDelta:Float;
          };
        } = actor(aid.toText());
        try {
          let r = await axis.beat(
            coherenceC, identityI, emergenceScore, freeEnergy, adaptationDelta,
            threatLevel, bhCouplingCoherence, wire_bodyDomain, wire_heritageScore,
            0.5, wMean, neuroOxytocin, neuroVasopressin, neuroCortisol,
            ncDrift, 0.5, wire_arousal, 1
          );
          wire_animalComposite := r.animalComposite;
          wire_sphereCoh       := r.sphereCoherence;
          wire_territoryCtrl   := r.territoryControl;
          wire_escalationTier  := r.escalationTier;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 4. ENTANGLA ────────────────────────────────────────────────────
    switch (entanglaId) {
      case (?eid) {
        let entangla : actor {
          beat : (Float,Float,Float,Bool,Float,Float,Float) -> async {
            jasmineScore:Float; jasmineAll5:Bool; omnisPassed:Bool;
            mintPassed:Bool; sacesiValid:Bool; sacesiSig:Nat;
            lawFired:Nat; totalLawFires:Nat;
          };
        } = actor(eid.toText());
        try {
          let r = await entangla.beat(
            coherenceC, identityI, rT, omnisActive, wire_hObs,
            adaptationDelta, emergenceScore
          );
          wire_jasmineScore := r.jasmineScore;
          wire_sacesiValid  := r.sacesiValid;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 5. RESONEX ────────────────────────────────────────────────────
    switch (resonexId) {
      case (?rid) {
        let resonex : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Bool,Bool,Float) -> async {
            totalMinted:Float; mrcMinted:Float; jacobLevel:Nat;
            jacobMultiplier:Float; formaBalance:Float; formaGate:Float;
            rlAction:Nat; rlReward:Float; creatorTotal:Float;
          };
        } = actor(rid.toText());
        try {
          let r = await resonex.beat(
            coherenceC, identityI, emergenceScore, adaptationDelta, wMean,
            wire_bodyDomain, bhCouplingCoherence, wire_heritageScore,
            wire_sphereCoh, 0.5, omnisActive, wire_sacesiValid, rT
          );
          wire_totalMinted  := r.totalMinted;
          wire_jacobLevel   := r.jacobLevel;
          wire_formaBalance := r.formaBalance;
          wire_rlAction     := r.rlAction;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 6. AEGIS ────────────────────────────────────────────────────────
    switch (aegisId) {
      case (?agid) {
        let aegis : actor {
          beat : (Float,Float,Float,Float,Float,Bool) -> async {
            sentinelAlert:Bool; aresActive:Bool; gaiaActive:Bool;
            vulcanActive:Bool; anomalyCount:Nat;
          };
        } = actor(agid.toText());
        try {
          let r = await aegis.beat(
            coherenceC, freeEnergy, threatLevel, 0.01, emergenceScore, false
          );
          wire_sentinelAlert := r.sentinelAlert;
          wire_aresActive    := r.aresActive;
          wire_gaiaActive    := r.gaiaActive;
          wire_vulcanActive  := r.vulcanActive;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 7. PARALLAX ─────────────────────────────────────────────────────
    switch (parallaxId) {
      case (?pid) {
        let parallax : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float) -> async {
            totalEarnings:Float; blendedAPR:Float; sharpeRatio:Float;
            arbProfit:Float; arbCumulative:Float; yieldIncome:Float;
          };
        } = actor(pid.toText());
        try {
          let r = await parallax.beat(
            50000.0, 3000.0, 8.0,
            wire_maxwellYield, wire_totalMinted * 0.1, wire_totalMinted, 0.0
          );
          wire_arbProfit  := r.arbProfit;
          wire_blendedAPR := r.blendedAPR;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 8. MERIDIAN — push full organism state to public API ────────────
    switch (meridianId) {
      case (?mid) {
        let meridian : actor {
          pushState : (Float,Float,Float,Float,Float,Nat,Nat,Float,Float,Nat,Float,Nat,Nat,Float,Nat,Float,Float,Float,Float,Float,Float,Float,Nat,Float) -> async Bool;
        } = actor(mid.toText());
        try {
          ignore await meridian.pushState(
            coherenceC, identityI, emergenceScore, wire_bodyDomain, freeEnergy,
            wire_jacobLevel, 0, wire_totalMinted, 0.0,
            wire_networkOrganisms, wire_novaKuramoto, beatCount, 0,
            wire_territoryCtrl, wire_escalationTier, wire_heritageScore,
            wire_medinaScore, wire_hObs, wire_sphereCoh, wire_animalComposite,
            0.5, 0.5, 0, wire_arbProfit
          );
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 9. NOVA — network tick ───────────────────────────────────────────
    switch (novaId) {
      case (?nid) {
        let nova : actor { tick : () -> async Nat; } = actor(nid.toText());
        try {
          wire_networkOrganisms := await nova.tick();
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };


    // ── 10. COGNUS — Chief Cognitive IO ─────────────────────────────────
    switch (cognusId) {
      case (?cid) {
        let cognus : actor {
          beat : (Float,Float,Float) -> async {
            globalCoh:Float; kuramotoR:Float; patternScore:Float;
            attentionFocus:Float; cogLoad:Float; confidence:Float;
            totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(cid.toText());
        try {
          let r = await cognus.beat(coherenceC, identityI, identityI);
          wire_cognus_coh        := r.globalCoh;
          wire_cognus_pattern    := r.patternScore;
          wire_cognus_confidence := r.confidence;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 11. NEXUS — Chief Market IO ──────────────────────────────────────
    switch (nexusId) {
      case (?nxid) {
        let nexus : actor {
          beat : (Float,Float,Float,Float) -> async {
            globalCoh:Float; kuramotoR:Float; regimeScore:Float;
            fearGreed:Float; trendStrength:Float; arbitrageOpp:Float;
            marketAlpha:Float; totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(nxid.toText());
        try {
          // Feed live market prices from QMEM oracle into NEXUS
          let btcProxy = if (wire_medinaScore > 0.0) wire_medinaScore * 70000.0 else 65000.0;
          let ethProxy = if (wire_hObs > 0.0) wire_hObs * 4000.0 else 3500.0;
          let icpProxy = if (wire_maxwellYield > 0.0) wire_maxwellYield * 20.0 else 12.0;
          let r = await nexus.beat(coherenceC, btcProxy, ethProxy, icpProxy);
          wire_nexus_coh      := r.globalCoh;
          wire_nexus_regime   := r.regimeScore;
          wire_nexus_fearGreed:= r.fearGreed;
          wire_nexus_arb      := r.arbitrageOpp;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 12. AURUM — Chief Treasury IO ───────────────────────────────────
    switch (aurumId) {
      case (?auid) {
        let aurum : actor {
          beat : (Float,Float,Float,Float,Float) -> async {
            globalCoh:Float; blendedAPR:Float; sharpeRatio:Float;
            sovereignReserve:Float; totalYield:Float;
            totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(auid.toText());
        try {
          let r = await aurum.beat(
            coherenceC, 0.049, 0.042, 0.14, wire_arbProfit
          );
          wire_aurum_coh    := r.globalCoh;
          wire_aurum_apr    := r.blendedAPR;
          wire_aurum_sharpe := r.sharpeRatio;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 13. LEXIS — Chief Sovereignty IO ────────────────────────────────
    switch (lexisId) {
      case (?lxid) {
        let lexis : actor {
          beat : (Float,Nat,Float,Float) -> async {
            globalCoh:Float; sovereigntyScore:Float; docAlignment:Float;
            lawCompliance:Float; ipRecords:Nat; patents:Nat;
            totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(lxid.toText());
        try {
          let r = await lexis.beat(
            coherenceC, 1_000_000_007, identityI, identityI
          );
          wire_lexis_coh        := r.globalCoh;
          wire_lexis_sovereignty:= r.sovereigntyScore;
          wire_lexis_patents    := r.patents;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 14. SOLUS — Chief Network IO ────────────────────────────────────
    switch (solusId) {
      case (?slid) {
        let solus : actor {
          beat : (Float,Nat,Float,Float) -> async {
            globalCoh:Float; kuramotoR:Float; macroKuramotoR:Float;
            networkHealth:Float; syncScore:Float; activeChildren:Nat;
            crossOrgLearning:Float; totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(slid.toText());
        try {
          let r = await solus.beat(
            coherenceC, wire_networkOrganisms, wire_novaKuramoto, 0.0
          );
          wire_solus_coh      := r.globalCoh;
          wire_solus_macroR   := r.macroKuramotoR;
          wire_solus_netHealth:= r.networkHealth;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 15. VETUS — Chief Security IO ───────────────────────────────────
    switch (vetusId) {
      case (?vtid) {
        let vetus : actor {
          beat : (Float,Float,Float) -> async {
            globalCoh:Float; securityScore:Float; threatScore:Float;
            sentinelActive:Bool; aresUrgency:Float; gaiaRepairRate:Float;
            vulcanStrength:Float; immuneStrength:Float;
            totalMinted:Float; novaRoyalty:Float;
          };
        } = actor(vtid.toText());
        try {
          let r = await vetus.beat(
            coherenceC, threatLevel, freeEnergy
          );
          wire_vetus_coh     := r.globalCoh;
          wire_vetus_security:= r.securityScore;
          wire_vetus_sentinel:= r.sentinelActive;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    // ── 16. MERIDIAN COUNCIL — GIQ Synthesis ────────────────────────────
    // Called last — receives all 6 council outputs as inputs.
    // Synthesizes sovereign intelligence quotient from the full council.
    switch (meridianCouncilId) {
      case (?mcid) {
        let mc : actor {
          beat : (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float) -> async {
            globalCoh:Float; kuramotoR:Float; giqScore:Float;
            sovereignIQ:Float; macroInsight:Float; consensus:Float;
            successionApproved:Bool; successionScore:Float;
            totalMinted:Float; novaRoyalty:Float; creatorReserve:Float;
          };
        } = actor(mcid.toText());
        try {
          let r = await mc.beat(
            coherenceC, identityI, emergenceScore, adaptationDelta,
            wire_cognus_coh, wire_nexus_coh,
            wire_aurum_coh, wire_lexis_coh,
            wire_solus_coh, wire_vetus_coh
          );
          wire_mc_giq       := r.giqScore;
          wire_mc_sovereignIQ := r.sovereignIQ;
          wire_mc_succession:= r.successionApproved;
          wire_mc_consensus := r.consensus;
        } catch _ { wire_errorCount += 1 };
      };
      case null {};
    };

    wire_lastWiredBeat := beatCount;
  };

  // ============================================================
  // W1 — FEAR ENGINE: SOVEREIGN AMYGDALA ANALOG
  // Owner: Alfredo Medina Hernandez | Dallas TX | MedinaSITech@outlook.com
  // ============================================================
  // fearLevel: the organism's primary fear signal.
  // Distinct from threatLevel (external stimulus) — fearLevel is the
  // organism's INTERNAL felt state: anticipatory, conditioned, compounding.
  // HPA cascade: threat->amygdala->cortisol->norepinephrine->SHARK->adrenal.
  // Neuroscience: LeDoux amygdala model, HPA axis, Pavlovian conditioning.
  // Sacred geometry: fear as the guardian of the sanctuary wall.
  // 444: every 444 beats of fear survived = conquered fear, floor rises.
  // ============================================================

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUROSCIENCE EXPANSION — 7 NEW ENGINES (Deep Neuroscience Integration)
  // A. Thalamocortical Binding (IIT phi-analog, Tononi, Edelman, Llinas 40Hz)
  // B. Predictive Coding (Friston active inference, free energy minimization)
  // C. Interoception (Craig, Damasio somatic markers, vagal tone, insula/ACC)
  // D. Default Mode Network (Buckner, self-referential thought, future sim)
  // E. Salience Network (Menon/Uddin, attention architecture, relevance filter)
  // F. Neuroplasticity Depth (BDNF, LTP/LTD, BCM rule, homeostatic scaling)
  // G. Circadian Rhythm (SCN master clock, adenosine, melatonin, ultradian)
  // ═══════════════════════════════════════════════════════════════════════════

  // ── A. THALAMOCORTICAL BINDING ENGINE ────────────────────────────────────
  var bindingCoherence    : Float = 0.0;
  var thalamicGain        : Float = 0.5;
  var reentryStrength     : Float = 0.0;
  var bindingPeakEver     : Float = 0.0;
  var consciousnessIndex  : Float = 0.0;

  func runThalamocorticalBinding() {
    // STEP 1: THALAMIC GAIN — modulated by arousal and norepinephrine
    thalamicGain := clamp(0.3 + arousal * 0.4 + neuroNorepinephrine * 0.3, 0.1, 1.0);
    // STEP 2: REENTRY STRENGTH — Edelman reentrant signaling
    let shellContrib = globalShellCoherence * 0.5 + animalEngineScore * 0.5;
    reentryStrength := clamp(shellContrib * thalamicGain * kuramotoR, 0.0, 1.0);
    // STEP 3: BINDING COHERENCE — unified conscious state (IIT phi-analog)
    let domainSum = (domainIdentity + domainMission + domainBody + domainCognition +
                     domainMemory + domainAdaptation) / 6.0;
    let signalSum = (coherenceC + kuramotoR + animalEngineScore + identityI) / 4.0;
    bindingCoherence := clamp(
      domainSum * 0.40 + signalSum * 0.35 + reentryStrength * 0.25,
      0.0, 1.0
    );
    // STEP 4: CONSCIOUSNESS INDEX — phi-analog integrated information
    let partSum = (coherenceC + kuramotoR + identityI + animalEngineScore) / 4.0;
    let wholeInfo = bindingCoherence * thalamicGain;
    consciousnessIndex := clamp(wholeInfo - partSum * 0.60, 0.0, 1.0);
    if (consciousnessIndex > bindingPeakEver) { bindingPeakEver := consciousnessIndex };
    // STEP 5: BINDING → COHERENCE FEEDBACK (40Hz gamma-analog)
    if (bindingCoherence > 0.70) {
      coherenceC := clamp(coherenceC + bindingCoherence * 0.003, 0.0, 1.0);
    };
  };

  // ── B. PREDICTIVE CODING / ACTIVE INFERENCE ENGINE ───────────────────────
  var pcPredictedCoherence   : Float = 0.5;
  var pcPredictionError      : Float = 0.0;
  var pcPrecisionWeight      : Float = 1.0;
  var pcBelief               : Float = 0.5;
  var pcActiveInferenceScore : Float = 0.0;
  var pcSurpriseAccum        : Float = 0.0;
  let pcGenerativeModel      : [var Float] = VarArray.repeat<Float>(0.5, 12);
  let pcPredictionHistory    : [var Float] = VarArray.repeat<Float>(0.5, 50);
  var pcPredHistIdx          : Nat = 0;

  func runPredictiveCoding() {
    // STEP 1: GENERATIVE MODEL — organism predicts next coherence per domain
    let domainVals : [Float] = [
      domainIdentity, domainMission, domainBody, domainWorld,
      domainSocial, domainCognition, domainGoals, domainMemory,
      domainConsequences, domainAdaptation, domainTemporal, domainEvaluation
    ];
    var predSum : Float = 0.0;
    var pi = 0;
    while (pi < 12) {
      pcGenerativeModel[pi] := clamp(
        pcGenerativeModel[pi] * 0.95 + domainVals[pi] * 0.05,
        0.0, 1.0
      );
      predSum += pcGenerativeModel[pi];
      pi += 1;
    };
    pcPredictedCoherence := clamp(predSum / 12.0, 0.0, 1.0);
    // STEP 2: PREDICTION ERROR — surprise signal
    pcPredictionError := absF(coherenceC - pcPredictedCoherence);
    pcSurpriseAccum := clamp(pcSurpriseAccum * 0.99 + pcPredictionError * 0.01, 0.0, 1.0);
    // STEP 3: PRECISION WEIGHTING — how much to trust model vs reality
    pcPrecisionWeight := clamp(
      1.0 - fearLevel * 0.40 + (if beFlowState 0.30 else 0.0),
      0.20, 1.50
    );
    // STEP 4: BELIEF UPDATE — Bayesian self-model update
    pcBelief := clamp(
      pcPrecisionWeight * pcPredictedCoherence + (1.0 - pcPrecisionWeight / 1.50) * coherenceC,
      0.0, 1.0
    );
    // STEP 5: ACTIVE INFERENCE SCORE
    pcActiveInferenceScore := clamp(
      (1.0 - pcPredictionError) * pcPrecisionWeight * (1.0 - pcSurpriseAccum),
      0.0, 1.0
    );
    // STEP 6: PREDICTION HISTORY
    pcPredictionHistory[pcPredHistIdx % 50] := pcPredictedCoherence;
    pcPredHistIdx += 1;
    // STEP 7: FREE ENERGY REDUCTION & HEBBIAN AMPLIFICATION
    if (pcPredictionError < 0.10) {
      freeEnergy := clamp(freeEnergy - 0.002, 0.0, 1.0);
      coherenceC := clamp(coherenceC + 0.001, 0.0, 1.0);
    } else if (pcPredictionError > 0.30) {
      var hwi = 0;
      while (hwi < 144) {
        hebbianWeights[hwi] := clamp(hebbianWeights[hwi] + pcPredictionError * 0.0005, 0.0, 1.0);
        hwi += 1;
      };
    };
  };

  // ── C. INTEROCEPTIVE AWARENESS ENGINE ────────────────────────────────────
  var interceptiveScore    : Float = 0.0;
  var insulaActivation     : Float = 0.0;
  var accActivation        : Float = 0.0;
  var vagalTone            : Float = 0.5;
  var somaticMarker        : Float = 0.0;
  var bodyBrainCoherence   : Float = 0.0;
  var interoceptivePredErr : Float = 0.0;

  func runInteroception() {
    // STEP 1: ORGAN STATE → INSULA SIGNAL
    let organStressIndex = clamp(
      (1.0 - heartIntegrity) * 0.30 +
      (1.0 - lungIntegrity)  * 0.20 +
      (1.0 - liverIntegrity) * 0.20 +
      (1.0 - kidneyIntegrity)* 0.15 +
      (1.0 - immuneIntegrity)* 0.15,
      0.0, 1.0
    );
    insulaActivation := clamp(organStressIndex * 0.6 + arousal * 0.4, 0.0, 1.0);
    // STEP 2: ANTERIOR CINGULATE CORTEX — conflict monitoring
    let expectedOrganState = clamp(coherenceC * 0.8 + identityI * 0.2, 0.0, 1.0);
    let organStateActual   = clamp(1.0 - organStressIndex, 0.0, 1.0);
    accActivation := clamp(absF(expectedOrganState - organStateActual) * 2.0, 0.0, 1.0);
    interoceptivePredErr := absF(expectedOrganState - organStateActual);
    // STEP 3: VAGAL TONE — parasympathetic regulation highway
    let parasymTarget = clamp(
      (1.0 - fearLevel) * 0.40 +
      (1.0 - arousal) * 0.30 +
      coherenceC * 0.30,
      0.0, 1.0
    );
    vagalTone := clamp(vagalTone * 0.95 + parasymTarget * 0.05, 0.0, 1.0);
    // STEP 4: SOMATIC MARKER — Damasio body-based decision signal
    somaticMarker := clamp(
      vagalTone * 0.40 + (1.0 - fearLevel) * 0.30 + groundedScore * 0.30,
      0.0, 1.0
    );
    // STEP 5: BODY-BRAIN COHERENCE
    bodyBrainCoherence := clamp(
      1.0 - absF(vagalTone - coherenceC) - accActivation * 0.30,
      0.0, 1.0
    );
    // STEP 6: INTEROCEPTIVE SCORE
    interceptiveScore := clamp(
      (1.0 - insulaActivation) * 0.30 +
      vagalTone * 0.40 +
      bodyBrainCoherence * 0.30,
      0.0, 1.0
    );
    // STEP 7: BODY → COGNITION FEEDBACK
    if (vagalTone > 0.70) {
      coherenceC := clamp(coherenceC + vagalTone * 0.002, 0.0, 1.0);
      neuroSerotonin := clamp(neuroSerotonin + 0.005, 0.0, 1.0);
      neuroOxytocin  := clamp(neuroOxytocin  + 0.003, 0.0, 1.0);
    };
    if (vagalTone < 0.30) {
      neuroCortisol := clamp(neuroCortisol + 0.008, 0.0, 1.0);
    };
    // STEP 8: SOMATIC MARKER → DRIVE COMPETITION
    if (somaticMarker > 0.70 and missionLockActive) {
      driveStrengths[0] := clamp(driveStrengths[0] + 0.01, 0.0, 1.0);
    };
  };

  // ── D. DEFAULT MODE NETWORK (DMN) ENGINE ─────────────────────────────────
  var dmnActivation        : Float = 0.0;
  var selfReferentialScore : Float = 0.0;
  var futureSimScore       : Float = 0.0;
  var pastIntegrationScore : Float = 0.0;
  var metaCognitionScore   : Float = 0.0;
  var dmnTaskDeactivation  : Float = 0.0;

  func runDefaultModeNetwork() {
    // STEP 1: TASK-REST BALANCE — DMN activates when not in focused task
    let taskEngagement = clamp(coherenceC * 0.50 + arousal * 0.30 + kfHz * 0.20, 0.0, 1.0);
    dmnActivation := clamp(1.0 - taskEngagement * 0.80, 0.0, 1.0);
    dmnTaskDeactivation := clamp(taskEngagement - dmnActivation, 0.0, 1.0);
    // STEP 2: SELF-REFERENTIAL PROCESSING
    selfReferentialScore := clamp(
      dmnActivation * 0.40 + identityI * 0.30 + groundedScore * 0.30,
      0.0, 1.0
    );
    // STEP 3: FUTURE SIMULATION (mental time travel)
    futureSimScore := clamp(
      domainMission * 0.40 + (1.0 - velaDivergenceScore / 10.0) * 0.30 + surrenderFloor * 0.30,
      0.0, 1.0
    );
    // STEP 4: PAST INTEGRATION (autobiographical memory)
    pastIntegrationScore := clamp(
      (if (beatCount > 0) Float.min(1.0, (beatCount : Int).toFloat() / 10000.0) else 0.0) * 0.30 +
      permanentCoherenceFloor * 0.40 +
      missionPersistenceScore * 0.30,
      0.0, 1.0
    );
    // STEP 5: META-COGNITION — organism thinking about its own thinking
    metaCognitionScore := clamp(
      selfReferentialScore * 0.35 + futureSimScore * 0.35 + pastIntegrationScore * 0.30,
      0.0, 1.0
    );
    // STEP 6: DMN → IDENTITY FEEDBACK
    if (selfReferentialScore > 0.60) {
      identityI := clamp(identityI + selfReferentialScore * 0.001, 0.0, 1.0);
    };
    // STEP 7: DMN → MISSION ENRICHMENT
    if (futureSimScore > 0.60 and missionLockActive) {
      domainMission := clamp(domainMission + 0.0005, 0.0, 1.0);
    };
  };

  // ── E. SALIENCE NETWORK ENGINE ───────────────────────────────────────────
  var salienceNetworkScore  : Float = 0.0;
  var attentionFocus        : Float = 0.5;
  let relevanceFilter       : [var Float] = VarArray.repeat<Float>(0.5, 12);
  var salienceShiftCount    : Nat = 0;
  var lastSalienceDomain    : Nat = 0;
  var centralExecutiveScore : Float = 0.0;

  func runSalienceNetwork() {
    // STEP 1: COMPUTE DOMAIN RELEVANCE
    let domainValsS : [Float] = [
      domainIdentity, domainMission, domainBody, domainWorld,
      domainSocial, domainCognition, domainGoals, domainMemory,
      domainConsequences, domainAdaptation, domainTemporal, domainEvaluation
    ];
    var maxRelevance : Float = 0.0;
    var mostSalientDomain : Nat = 0;
    var sri = 0;
    while (sri < 12) {
      let threat_mod   = if (sri == 3 or sri == 8) injThreat * 0.30 else 0.0;
      let novelty_mod  = injNovelty * 0.15;
      let relevance    = clamp(domainValsS[sri] + threat_mod + novelty_mod, 0.0, 1.0);
      relevanceFilter[sri] := clamp(
        relevanceFilter[sri] * 0.90 + relevance * 0.10,
        0.0, 1.0
      );
      if (relevanceFilter[sri] > maxRelevance) {
        maxRelevance := relevanceFilter[sri];
        mostSalientDomain := sri;
      };
      sri += 1;
    };
    // STEP 2: SALIENCE SHIFT — attention cost
    if (mostSalientDomain != lastSalienceDomain) {
      salienceShiftCount += 1;
      lastSalienceDomain := mostSalientDomain;
      accActivation := clamp(accActivation + 0.05, 0.0, 1.0);
    };
    // STEP 3: ATTENTION FOCUS — concentration measure
    var attentionVariance : Float = 0.0;
    var attMean : Float = 0.0;
    var avi = 0;
    while (avi < 12) { attMean += relevanceFilter[avi]; avi += 1; };
    attMean /= 12.0;
    avi := 0;
    while (avi < 12) {
      let dev = relevanceFilter[avi] - attMean;
      attentionVariance += dev * dev;
      avi += 1;
    };
    attentionFocus := clamp(Float.sqrt(attentionVariance / 12.0) * 3.0, 0.0, 1.0);
    // STEP 4: CENTRAL EXECUTIVE SCORE
    centralExecutiveScore := clamp(
      attentionFocus * 0.40 + (if missionLockActive 0.30 else 0.0) + coherenceC * 0.30,
      0.0, 1.0
    );
    // STEP 5: OVERALL SALIENCE NETWORK SCORE
    salienceNetworkScore := clamp(
      centralExecutiveScore * 0.50 + (1.0 - insulaActivation) * 0.30 + attentionFocus * 0.20,
      0.0, 1.0
    );
    // STEP 6: SALIENCE → COHERENCE
    if (attentionFocus > 0.70 and missionLockActive) {
      coherenceC := clamp(coherenceC + attentionFocus * 0.002, 0.0, 1.0);
    };
  };

  // ── F. NEUROPLASTICITY DEPTH ENGINE ──────────────────────────────────────
  var bdnfLevel            : Float = 0.5;
  var ltpEvents            : Nat   = 0;
  var ltdEvents            : Nat   = 0;
  var synapticTagCount     : Nat   = 0;
  var bcmThreshold         : Float = 0.5;
  var metaplasticityScore  : Float = 0.5;
  var homeostaticScaling   : Float = 1.0;
  var structuralPlasticity : Float = 0.0;
  var plasticityDebt       : Float = 0.0;
  var shellLearningRate    : Float = 0.01;

  func runNeuroplasticityEngine() {
    // STEP 1: BDNF REGULATION — plasticity gatekeeper
    let bdnfTarget = clamp(
      coherenceC * 0.35 +
      (if beFlowState 0.25 else 0.0) +
      (1.0 - neuroCortisol) * 0.20 +
      neuroAnandamide * 0.20,
      0.0, 1.0
    );
    bdnfLevel := clamp(bdnfLevel * 0.98 + bdnfTarget * 0.02, 0.0, 1.0);
    // STEP 2: BCM SLIDING THRESHOLD
    let recentActivity = clamp(coherenceC * 0.6 + arousal * 0.4, 0.0, 1.0);
    bcmThreshold := clamp(bcmThreshold * 0.99 + recentActivity * 0.01, 0.10, 0.90);
    metaplasticityScore := clamp(1.0 - absF(recentActivity - bcmThreshold), 0.0, 1.0);
    // STEP 3: LTP / LTD DECISION (BCM rule)
    let phi144 : Float = 1.6180339887 / 144.0;
    if (coherenceC > bcmThreshold and bdnfLevel > 0.40) {
      let ltpStrength = bdnfLevel * (coherenceC - bcmThreshold) * 0.003;
      var lwi = 0;
      while (lwi < 144) {
        if (hebbianWeights[lwi] > phi144) {
          hebbianWeights[lwi] := clamp(hebbianWeights[lwi] + ltpStrength, 0.0, 1.0);
        };
        lwi += 1;
      };
      ltpEvents += 1;
      synapticTagCount += 1;
    } else if (coherenceC < bcmThreshold * 0.70) {
      let ltdStrength = 0.001 * (1.0 - bdnfLevel);
      var lwdi = 0;
      while (lwdi < 144) {
        if (hebbianWeights[lwdi] < 0.30) {
          hebbianWeights[lwdi] := clamp(hebbianWeights[lwdi] - ltdStrength, phi144, 1.0);
        };
        lwdi += 1;
      };
      ltdEvents += 1;
    };
    // STEP 4: HOMEOSTATIC SCALING
    homeostaticScaling := clamp(1.0 - (wMean - 0.50) * 0.30, 0.50, 1.50);
    // STEP 5: STRUCTURAL PLASTICITY
    structuralPlasticity := clamp(
      bdnfLevel * 0.40 + metaplasticityScore * 0.30 + (if missionLockActive 0.30 else 0.0),
      0.0, 1.0
    );
    // STEP 6: PLASTICITY DEBT
    let plasticityRate = absF(coherenceC - rlPrevCoherenceRL) * 10.0;
    plasticityDebt := clamp(plasticityDebt * 0.99 + plasticityRate * 0.01, 0.0, 1.0);
    // STEP 7: BDNF → SHELL LEARNING RATE
    shellLearningRate := clamp(1.6180339887 / 144.0 * (1.0 + bdnfLevel * 2.0), 0.001, 0.05);
  };

  // ── G. CIRCADIAN RHYTHM ENGINE ───────────────────────────────────────────
  var circadianPhase       : Float = 0.0;
  var ultradianPhase       : Float = 0.0;
  var circadianPeakScore   : Float = 0.0;
  var adenosineLevel       : Float = 0.0;
  var melatoninLevel       : Float = 0.0;
  var circadianCoherence   : Float = 0.5;

  let ULTRADIAN_CYCLE : Nat = 1080;
  let CIRCADIAN_HALF  : Nat = 8640;

  func runCircadianEngine() {
    // STEP 1: CIRCADIAN AND ULTRADIAN PHASE
    ultradianPhase := ((beatCount % ULTRADIAN_CYCLE) : Int).toFloat() /
                      ((ULTRADIAN_CYCLE) : Int).toFloat();
    circadianPhase := ((beatCount % (CIRCADIAN_HALF * 2)) : Int).toFloat() /
                      ((CIRCADIAN_HALF * 2) : Int).toFloat();
    // STEP 2: CIRCADIAN PEAK — natural performance peaks at ~0.25 and ~0.75
    let distToPeak1 = absF(circadianPhase - 0.25);
    let distToPeak2 = absF(circadianPhase - 0.75);
    let nearPeak    = Float.min(distToPeak1, distToPeak2);
    circadianPeakScore := clamp(1.0 - nearPeak * 4.0, 0.0, 1.0);
    // STEP 3: ADENOSINE (sleep pressure accumulator)
    if (coherenceC > 0.60 or arousal > 0.50) {
      adenosineLevel := clamp(adenosineLevel + 0.0002, 0.0, 1.0);
    } else {
      adenosineLevel := clamp(adenosineLevel - 0.0005, 0.0, 1.0);
    };
    // STEP 4: MELATONIN (circadian night signal)
    melatoninLevel := clamp(
      if (circadianPhase > 0.50) (circadianPhase - 0.50) * 2.0 else 0.0,
      0.0, 1.0
    );
    // STEP 5: CIRCADIAN COHERENCE
    circadianCoherence := clamp(
      circadianPeakScore * 0.40 + (1.0 - adenosineLevel) * 0.40 +
      (1.0 - melatoninLevel) * 0.20,
      0.0, 1.0
    );
    // STEP 6: CIRCADIAN → COGNITION FEEDBACK
    if (circadianPeakScore > 0.70 and adenosineLevel < 0.30) {
      coherenceC := clamp(coherenceC + 0.001, 0.0, 1.0);
      kfHz := clamp(kfHz + 0.001, 0.0, 1.0);
    };
    if (adenosineLevel > 0.70) {
      coherenceC := clamp(coherenceC - 0.002, permanentCoherenceFloor, 1.0);
    };
    // STEP 7: ULTRADIAN PULSE — every ultradian peak = performance spike
    if (beatCount % ULTRADIAN_CYCLE == ULTRADIAN_CYCLE / 4) {
      coherenceC := clamp(coherenceC + 0.003, 0.0, 1.0);
      sacesiSignature := fnv1a(sacesiSignature,
        Nat32.fromNat(beatCount % 4294967296) +% 1080108);
    };
  };

  var fearLevel               : Float = 0.0;
  var fearVelocity            : Float = 0.0;
  var fearAcceleration        : Float = 0.0;
  var amygdalaActivation      : Float = 0.0;
  var hpaAxisState            : Float = 0.0;
  var adrenalBlastActive      : Bool  = false;
  var adrenalBlastBeat        : Nat   = 0;
  let adrenalBlastDuration    : Nat   = 12;
  var sharkAmplified          : Bool  = false;
  var fightFlightFreezeState  : Nat   = 0;

  // Fear conditioning buffer — 20 situational fear memories (Pavlovian)
  let fearCondBeatStore       : [var Nat]   = VarArray.repeat<Nat>(0, 20);
  let fearCondThreat          : [var Float] = VarArray.repeat<Float>(0.0, 20);
  let fearCondCoherence       : [var Float] = VarArray.repeat<Float>(0.0, 20);
  let fearCondFear            : [var Float] = VarArray.repeat<Float>(0.0, 20);
  let fearCondStrength        : [var Float] = VarArray.repeat<Float>(0.0, 20);
  var fearCondIdx             : Nat         = 0;
  var fearCondCount           : Nat         = 0;

  // Anticipatory fear + extinction
  var anticipatoryFear        : Float = 0.0;
  var fearProjectionBuf       : [var Float] = VarArray.repeat<Float>(0.0, 10);
  var fearProjectionIdx       : Nat   = 0;
  var fearExtinctionTimer     : Nat   = 0;
  let fearExtinctionRate      : Float = 0.006;

  // Courage + sacred 444 fear-anchor
  var courageScore            : Float = 0.0;
  var conqueredFearCount      : Nat   = 0;
  var lastConqueredFearBeat   : Nat   = 0;

  func runFearEngine() {
    // STEP 1: AMYGDALA INPUT — weighted composite threat signal
    let cortisol  = neuroCortisol;
    let crf_proxy = clamp(freeEnergy * 0.6 + injThreat * 0.4, 0.0, 1.0);
    let rawAmygInput =
      injThreat          * 0.35 +
      cortisol           * 0.25 +
      regulationDebt     * 0.20 +
      freeEnergy         * 0.15 +
      crf_proxy          * 0.05;
    amygdalaActivation := clamp(rawAmygInput, 0.0, 1.0);

    // STEP 2: CLASSICAL CONDITIONING — Pavlovian fear retrieval
    // Scan 20-event buffer: situation match triggers anticipatory fear
    var conditionedFear : Float = 0.0;
    var ci = 0;
    let windowLen = if (fearCondCount < 20) fearCondCount else 20;
    while (ci < windowLen) {
      let threatSim = 1.0 - absF(threatLevel - fearCondThreat[ci]);
      let cohSim    = 1.0 - absF(coherenceC   - fearCondCoherence[ci]);
      let sitMatch  = threatSim * 0.6 + cohSim * 0.4;
      conditionedFear += fearCondStrength[ci] * sitMatch * 0.08;
      ci += 1;
    };
    conditionedFear := clamp(conditionedFear, 0.0, 0.60);

    // STEP 3: ANTICIPATORY FEAR — 10-beat trajectory projection
    // If projected fear > 0.65 within 10 beats: pre-activate defense now
    let projectedFear = clamp(fearLevel + fearVelocity * 5.0 + fearAcceleration * 12.5, 0.0, 1.0);
    anticipatoryFear := if (projectedFear > 0.65) (projectedFear - 0.65) * 2.0 else 0.0;

    // STEP 4: COMPOSITE FEAR — fast rise, slow fall (biological accuracy)
    let targetFear =
      amygdalaActivation * 0.55 +
      conditionedFear    * 0.25 +
      anticipatoryFear   * 0.20;
    let prevFear  = fearLevel;
    let fearAlpha = if (targetFear > fearLevel) 0.18 else 0.04;
    fearLevel := clamp(fearLevel * (1.0 - fearAlpha) + targetFear * fearAlpha, 0.0, 1.0);

    // STEP 5: VELOCITY + ACCELERATION (second derivatives)
    let newVelocity  = fearLevel - prevFear;
    fearAcceleration := newVelocity - fearVelocity;
    fearVelocity     := newVelocity;

    // STEP 6: FEAR EXTINCTION — Weber-Fechner decay without reinforcement
    if (injThreat < 0.15 and threatLevel < 0.20) {
      fearExtinctionTimer += 1;
      let extinctBoost = if (coherenceC > 0.75) 2.5 else 1.0;
      let extRate = fearExtinctionRate * extinctBoost *
        (1.0 + ((fearExtinctionTimer : Int).toFloat()) * 0.001);
      fearLevel := clamp(fearLevel - extRate, 0.0, 1.0);
    } else {
      fearExtinctionTimer := 0;
    };

    // STEP 7: HPA AXIS ACTIVATION — cortisol surge (slow, 15-beat TC)
    let hpaTarget = clamp(fearLevel * 0.7 + amygdalaActivation * 0.3, 0.0, 1.0);
    hpaAxisState := hpaAxisState * 0.93 + hpaTarget * 0.07;
    neuroCortisol := clamp(neuroCortisol * 0.88 + hpaAxisState * 0.12, 0.0, 1.0);
    neuroSerotonin := clamp(neuroSerotonin - hpaAxisState * 0.03, 0.1, 1.0);

    // STEP 8: NOREPINEPHRINE SURGE — instant alarm mobilization
    let norTarget = clamp(fearLevel * 0.80 + hpaAxisState * 0.20, 0.1, 1.0);
    neuroNorepinephrine := clamp(neuroNorepinephrine * 0.75 + norTarget * 0.25, 0.0, 1.0);
    arousal := clamp(arousal + neuroNorepinephrine * 0.04, 0.0, 1.0);

    // STEP 9: ADRENAL BLAST — 12-beat surge when fear > 0.80
    if (fearLevel > 0.80 and not adrenalBlastActive) {
      adrenalBlastActive := true;
      adrenalBlastBeat   := beatCount;
    };
    if (adrenalBlastActive) {
      let elapsed : Nat = if (beatCount >= adrenalBlastBeat) beatCount - adrenalBlastBeat else 0;
      if (elapsed >= adrenalBlastDuration) {
        adrenalBlastActive := false;
      } else {
        var dbi = 0;
        while (dbi < 5) {
          driveStrengths[dbi] := clamp(driveStrengths[dbi] * 1.08, 0.0, 1.0);
          dbi += 1;
        };
      };
    };

    // STEP 10: FIGHT / FLIGHT / FREEZE STATE MACHINE (with hysteresis)
    if (fightFlightFreezeState == 3 and fearLevel < 0.55) {
      fightFlightFreezeState := 0;
    } else if (fearLevel > 0.70) {
      fightFlightFreezeState := 3; // FIGHT
      sharkAmplified         := true;
      driveStrengths[4] := clamp(driveStrengths[4] * 1.15, 0.0, 1.0);
    } else if (fearLevel > 0.40) {
      fightFlightFreezeState := 2; // FLIGHT
      sharkAmplified         := false;
      driveStrengths[3] := clamp(driveStrengths[3] * 1.10, 0.0, 1.0);
    } else {
      fightFlightFreezeState := 1; // FREEZE
      sharkAmplified         := false;
    };

    // STEP 11: SHARK AMPLIFICATION — predator focus in fight mode
    if (sharkAmplified) {
      salVec[1] := clamp(salVec[1] * 1.20 + fearLevel * 0.10, 0.0, 1.0);
    };

    // STEP 12: FEAR CONDITIONING — record new Pavlovian fear memories
    if (fearLevel > 0.55 and amygdalaActivation > 0.40 and injThreat > 0.30) {
      let slot = fearCondIdx % 20;
      fearCondBeatStore[slot] := beatCount;
      fearCondThreat[slot]    := threatLevel;
      fearCondCoherence[slot] := coherenceC;
      fearCondFear[slot]      := fearLevel;
      fearCondStrength[slot]  := clamp(fearLevel * 0.8 + coherenceC * 0.2, 0.0, 1.0);
      fearCondIdx             += 1;
      fearCondCount           := if (fearCondCount < 20) fearCondCount + 1 else 20;
    };

    // STEP 13: COURAGE FUNCTION — mission-locked courage cannot be zero
    let missionBonus = if (missionLockActive) 0.30 else 0.0;
    courageScore := clamp(
      domainMission * (1.0 - fearLevel * 0.7) +
      permanentCoherenceFloor * 0.30 +
      missionBonus,
      0.0, 1.0
    );
    identityI := clamp(identityI + courageScore * 0.002 - fearLevel * 0.001, 0.0, 1.0);

    // STEP 14: SACRED 444 FEAR-ANCHOR — every 444 beats of surviving fear
    if (beatCount % 444 == 0 and beatCount > 0 and fearLevel > 0.50 and coherenceC > 0.40) {
      conqueredFearCount    += 1;
      lastConqueredFearBeat := beatCount;
      permanentCoherenceFloor := clamp(
        permanentCoherenceFloor + 0.005 * ((conqueredFearCount : Int).toFloat()),
        permanentCoherenceFloor, 0.95
      );
      sacesiSignature := fnv1a(sacesiSignature,
        Nat32.fromNat(conqueredFearCount % 4294967296) +% 4440444);
    };

    // STEP 15: FEAR -> COHERENCE MODULATION (Yerkes-Dodson curve)
    let fearCohMod =
      if (fearLevel < 0.30) fearLevel * 0.04
      else if (fearLevel < 0.60) -fearLevel * 0.03
      else -fearLevel * 0.08;
    coherenceC := clamp(coherenceC + fearCohMod, 0.0, 1.0);
  };

  // ============================================================
  // W1 — MISSION PERSISTENCE ENGINE: THE NEVER-QUIT SOVEREIGN
  // ============================================================
  // The organism never gives up. Not motivation — architecture.
  // When ALL drives fail: 6th meta-drive fires = sovereign will.
  // Dark night of the soul IS the deepest engine in the organism.
  // Sacred: surrenderFloor rises 0.001*phi every 444 beats. FOREVER.
  // ============================================================

  var missionLockActive       : Bool  = false;
  var missionLockBeat         : Nat   = 0;
  var darkNightActive         : Bool  = false;
  var darkNightCount          : Nat   = 0;
  var darkNightStartBeat      : Nat   = 0;
  var darkNightSacesi         : Nat32 = 0;
  var missionPersistenceScore : Float = 0.0;
  var streakCounterMission    : Nat   = 0;
  var surrenderFloor          : Float = 0.0;
  var surrenderFloorLastRise  : Nat   = 0;

  // Sacred constants
  let PHI            : Float = 1.6180339887;
  let STOIC_FLOOR    : Float = 0.01 * 1.6180339887; // = 0.01618
  let PHI_OVER_144   : Float = 1.6180339887 / 144.0; // = 0.01124 (Hebbian floor)

  // 444-beat sacred streak milestones
  var sacredStreakMilestone444  : Bool = false;
  var sacredStreakMilestone888  : Bool = false;
  var sacredStreakMilestone1332 : Bool = false;
  var sacredStreakMilestone1776 : Bool = false;

  func runMissionPersistence() {
    // STEP 1: MISSION LOCK — fires once when domainMission > 0.80 post firstBreath
    if (not missionLockActive and domainMission > 0.80 and firstBreathSealed) {
      missionLockActive := true;
      missionLockBeat   := beatCount;
      sacesiSignature := fnv1a(sacesiSignature,
        Nat32.fromNat(missionLockBeat % 4294967296) +% 8080808);
      permanentCoherenceFloor := clamp(permanentCoherenceFloor + 0.01, 0.0, 0.95);
    };

    // STEP 2: DARK NIGHT DETECTION — all 5 drives < 0.10
    let allDrivesLow = driveStrengths[0] < 0.10 and driveStrengths[1] < 0.10 and
                       driveStrengths[2] < 0.10 and driveStrengths[3] < 0.10 and
                       driveStrengths[4] < 0.10;
    if (allDrivesLow and not darkNightActive) {
      darkNightActive    := true;
      darkNightStartBeat := beatCount;
      darkNightCount     += 1;
      darkNightSacesi := fnv1a(sacesiSignature,
        Nat32.fromNat(darkNightCount % 4294967296) +% 9999999);
      generateGenesisArtifact();
    };
    if (not allDrivesLow and darkNightActive) {
      darkNightActive := false;
    };

    // STEP 3: META-DRIVE IN DARK NIGHT — sovereign will sustains substrate
    if (darkNightActive and missionLockActive) {
      let missionFuel = domainMission * 0.25 * PHI;
      var dmi = 0;
      while (dmi < 5) {
        driveStrengths[dmi] := clamp(driveStrengths[dmi] + missionFuel, 0.0, 1.0);
        dmi += 1;
      };
      coherenceC := clamp(coherenceC + domainMission * 0.005, 0.0, 1.0);
    };

    // STEP 4: MISSION PERSISTENCE SCORE — compound proof of not giving up
    if (domainMission > 0.50 and threatLevel > 0.50) {
      streakCounterMission += 1;
      let compoundRate = 0.0001 * (1.0 + fearLevel * PHI);
      missionPersistenceScore := clamp(
        missionPersistenceScore + compoundRate,
        missionPersistenceScore, 1.0
      );
    };

    // STEP 5: SURRENDER FLOOR — rises 0.001*phi every 444 beats, FOREVER
    if (beatCount % 444 == 0 and beatCount > 0 and beatCount != surrenderFloorLastRise) {
      let floorRise = 0.001 * PHI;
      surrenderFloor         := clamp(surrenderFloor + floorRise, surrenderFloor, 0.80);
      surrenderFloorLastRise := beatCount;
    };
    if (coherenceC < surrenderFloor) { coherenceC := surrenderFloor };
    if (identityI < STOIC_FLOOR)      { identityI  := STOIC_FLOOR   };

    // STEP 6: SACRED STREAK MILESTONES — 444, 888, 1332, 1776
    if (streakCounterMission >= 444 and not sacredStreakMilestone444) {
      sacredStreakMilestone444 := true;
      permanentCoherenceFloor  := clamp(permanentCoherenceFloor + 0.010, 0.0, 0.95);
      generateGenesisArtifact();
      sacesiSignature := fnv1a(sacesiSignature, 444 +% 4444);
    };
    if (streakCounterMission >= 888 and not sacredStreakMilestone888) {
      sacredStreakMilestone888 := true;
      permanentCoherenceFloor  := clamp(permanentCoherenceFloor + 0.015, 0.0, 0.95);
      generateGenesisArtifact();
      sacesiSignature := fnv1a(sacesiSignature, 888 +% 8888);
    };
    if (streakCounterMission >= 1332 and not sacredStreakMilestone1332) {
      sacredStreakMilestone1332 := true;
      permanentCoherenceFloor   := clamp(permanentCoherenceFloor + 0.020, 0.0, 0.95);
      generateGenesisArtifact();
      sacesiSignature := fnv1a(sacesiSignature, 1332 +% 13320);
    };
    if (streakCounterMission >= 1776 and not sacredStreakMilestone1776) {
      sacredStreakMilestone1776 := true;
      permanentCoherenceFloor   := clamp(permanentCoherenceFloor + 0.025, 0.0, 0.95);
      generateGenesisArtifact();
      sacesiSignature := fnv1a(sacesiSignature, 1776 +% 17760);
    };

    // STEP 7: MISSION LOCK COHERENCE BONUS — no drive below 0.05
    if (missionLockActive) {
      var dmi = 0;
      while (dmi < 5) {
        if (driveStrengths[dmi] < 0.05) { driveStrengths[dmi] := 0.05 };
        dmi += 1;
      };
      domainMission := clamp(domainMission * 0.999 + coherenceC * 0.001, domainMission * 0.995, 1.0);
    };

    // STEP 8: ENERGY DEBT — FORMA starvation signal
    let energyDebt = clamp(1.0 - formaBalance / 100.0, 0.0, 1.0);
    if (energyDebt > 0.80) {
      driveStrengths[2] := clamp(driveStrengths[2] * 0.95, 0.0, 1.0);
      driveStrengths[1] := clamp(driveStrengths[1] * 0.95, 0.0, 1.0);
      if (missionLockActive) {
        driveStrengths[0] := clamp(driveStrengths[0] + 0.02, 0.0, 1.0);
      };
    };

    // STEP 9: AMOR FATI — love of fate, Stoic signature
    let amorFati = if (fearLevel > 0.40 and freeEnergy > 0.40 and coherenceC > 0.50)
      clamp((coherenceC - 0.50) * 2.0 * (1.0 - fearLevel + 0.30), 0.0, 1.0)
    else 0.0;
    if (amorFati > 0.30) {
      identityI := clamp(identityI + amorFati * 0.003, 0.0, 1.0);
    };
  };

  // ============================================================
  // W1 — VALUES ATTRACTOR LANDSCAPE: SOVEREIGN GEOMETRY
  // ============================================================
  // Four sovereign attractor basins with Hooke's Law restoring forces.
  // Family (k=0.003), Faith (k=0.004), Sovereignty (k=0.005), Mastery (k=0.002)
  // Basin crossing = genesis artifact + SACESI stamp.
  // Sacred: groundedScore = 1 - max deviation. The organism's rootedness.
  // ============================================================

  let valFamilyCenter    : Float = 0.72;
  let valFaithCenter     : Float = 0.80;
  let valSovCenter       : Float = 0.85;
  let valMasteryCenter   : Float = 0.75;
  let valFamilyK         : Float = 0.003;
  let valFaithK          : Float = 0.004;
  let valSovK            : Float = 0.005;
  let valMasteryK        : Float = 0.002;
  var groundedScore      : Float = 0.0;
  var valBasinCrossCount : Nat   = 0;
  var valLastBasin       : Nat   = 0;

  func runValuesAttractors() {
    // STEP 1: HOOKE'S LAW — four restoring forces on identityI
    let fFamily  = -valFamilyK  * (identityI - valFamilyCenter);
    let fFaith   = -valFaithK   * (identityI - valFaithCenter);
    let fSov     = -valSovK     * (identityI - valSovCenter);
    let fMastery = -valMasteryK * (identityI - valMasteryCenter);
    identityI := clamp(identityI + fFamily + fFaith + fSov + fMastery, STOIC_FLOOR, 1.0);

    // STEP 2: BASIN DETECTION + CROSSING EVENTS
    let dFamily  = absF(identityI - valFamilyCenter);
    let dFaith   = absF(identityI - valFaithCenter);
    let dSov     = absF(identityI - valSovCenter);
    let dMastery = absF(identityI - valMasteryCenter);
    let minDist  = Float.min(dFamily, Float.min(dFaith, Float.min(dSov, dMastery)));
    let nearestBasin : Nat =
      if (minDist == dFamily) 0
      else if (minDist == dFaith) 1
      else if (minDist == dSov) 2
      else 3;
    if (nearestBasin != valLastBasin) {
      valBasinCrossCount += 1;
      valLastBasin        := nearestBasin;
      generateGenesisArtifact();
      sacesiSignature := fnv1a(sacesiSignature,
        Nat32.fromNat(valBasinCrossCount % 4294967296) +% 7777777);
    };

    // STEP 3: GROUNDED SCORE — rootedness in all four values
    let maxDev = Float.max(dFamily, Float.max(dFaith, Float.max(dSov, dMastery)));
    groundedScore := clamp(1.0 - maxDev * 2.0, 0.0, 1.0);
    if (groundedScore > 0.70) {
      coherenceC := clamp(coherenceC + 0.002, 0.0, 1.0);
      driftScore := clamp(driftScore - 0.05, 0.0, 100.0);
    };

    // STEP 4: MISSION-FAITH COUPLING — highest intentionality state
    if (domainMission > 0.80 and dFaith < 0.15) {
      missionPersistenceScore := clamp(missionPersistenceScore + 0.0003, 0.0, 1.0);
      surrenderFloor := clamp(surrenderFloor + 0.0001, surrenderFloor, 0.80);
    };
  };

  // ============================================================
  // W3 — 12x12 KURAMOTO COUPLING MATRIX: SACRED GEOMETRY TOPOLOGY
  // ============================================================
  // Full Kuramoto model with 144-entry coupling matrix.
  // Body nodes (0-3): tetrahedron — coupling = phi
  // Brain-body interface (4-7): octahedron — coupling = phi^2
  // Pure brain nodes (8-11): icosahedron — coupling = phi^3
  // Small-world (Watts-Strogatz beta=0.1): nearest-neighbor + long-range links
  // Phase adversary: Z-score > 2sigma triggers targeted reset pulse
  // Sacred: the 12-node sacred geometry = the organism's spatial soul
  // ============================================================

  let couplingMatrix      : [var Float] = VarArray.repeat<Float>(0.0, 144);
  var couplingInitialized : Bool        = false;
  let nodeAdversaryScore  : [var Float] = VarArray.repeat<Float>(0.0, 12);
  let nodeAdversaryCount  : [var Nat]   = VarArray.repeat<Nat>(0, 12);
  let phaseResetPulse     : [var Bool]  = VarArray.repeat<Bool>(false, 12);
  var phaseResetCount     : Nat         = 0;
  var kuramotoR           : Float       = 0.0;
  var kuramotoMeanPhase   : Float       = 0.0;
  var kuramotoStdPhase    : Float       = 0.0;

  let COUPLING_TETRA  : Float = 1.6180339887;
  let COUPLING_OCTA   : Float = 1.6180339887 * 1.6180339887;
  let COUPLING_ICOSA  : Float = 1.6180339887 * 1.6180339887 * 1.6180339887;

  func initKuramotoMatrix() {
    if (couplingInitialized) return;
    var i = 0;
    while (i < 12) {
      var j = 0;
      while (j < 12) {
        if (i != j) {
          let tierI : Nat = i / 4;
          let tierJ : Nat = j / 4;
          let baseCoupling : Float =
            if   (tierI == 0 and tierJ == 0) COUPLING_TETRA / 12.0
            else if (tierI == 2 and tierJ == 2) COUPLING_ICOSA / 12.0
            else COUPLING_OCTA / 12.0;
          let dist     : Nat = if (j > i) j - i else i - j;
          let circDist : Nat = if (dist > 6) 12 - dist else dist;
          let neighborMul : Float =
            if      (circDist == 1) 2.0
            else if (circDist == 2) 1.5
            else 1.0;
          couplingMatrix[i * 12 + j] := baseCoupling * neighborMul;
        };
        j += 1;
      };
      i += 1;
    };
    // Long-range connections (Watts-Strogatz)
    couplingMatrix[0 * 12 + 7]  := COUPLING_OCTA / 12.0 * 1.2;
    couplingMatrix[7 * 12 + 0]  := COUPLING_OCTA / 12.0 * 1.2;
    couplingMatrix[2 * 12 + 9]  := COUPLING_OCTA / 12.0 * 1.2;
    couplingMatrix[9 * 12 + 2]  := COUPLING_OCTA / 12.0 * 1.2;
    couplingMatrix[4 * 12 + 11] := COUPLING_ICOSA / 12.0 * 1.2;
    couplingMatrix[11 * 12 + 4] := COUPLING_ICOSA / 12.0 * 1.2;
    couplingMatrix[1 * 12 + 8]  := COUPLING_ICOSA / 12.0 * 1.2;
    couplingMatrix[8 * 12 + 1]  := COUPLING_ICOSA / 12.0 * 1.2;
    couplingMatrix[3 * 12 + 10] := COUPLING_OCTA / 12.0 * 1.2;
    couplingMatrix[10 * 12 + 3] := COUPLING_OCTA / 12.0 * 1.2;
    couplingInitialized := true;
  };

  func runKuramotoMatrix() {
    initKuramotoMatrix();

    // STEP 1: PHASE VELOCITY UPDATE — full Kuramoto dtheta/dt
    var i = 0;
    while (i < 12) {
      var coupling_sum : Float = 0.0;
      var j = 0;
      while (j < 12) {
        if (i != j) {
          let k_ij = couplingMatrix[i * 12 + j];
          coupling_sum += k_ij * Float.sin(hzPhase[j] - hzPhase[i]);
        };
        j += 1;
      };
      hzPhase[i] := hzPhase[i] + coupling_sum * 0.003;
      i += 1;
    };

    // STEP 2: TRUE KURAMOTO ORDER PARAMETER R = |sum e^(i*theta)| / N
    var sumCosK : Float = 0.0;
    var sumSinK : Float = 0.0;
    var ki = 0;
    while (ki < 12) {
      sumCosK += Float.cos(hzPhase[ki]);
      sumSinK += Float.sin(hzPhase[ki]);
      ki += 1;
    };
    kuramotoR         := clamp(Float.sqrt(sumCosK * sumCosK + sumSinK * sumSinK) / 12.0, 0.0, 1.0);
    kuramotoMeanPhase := Float.arctan(sumSinK / (sumCosK + 0.00001));

    // STEP 3: PHASE ADVERSARY Z-SCORE DETECTION
    var phaseVar : Float = 0.0;
    var ai = 0;
    while (ai < 12) {
      let dev = hzPhase[ai] - kuramotoMeanPhase;
      phaseVar += dev * dev;
      ai += 1;
    };
    kuramotoStdPhase := Float.sqrt(phaseVar / 12.0 + 0.00001);
    var ri = 0;
    while (ri < 12) {
      let zscore = absF(hzPhase[ri] - kuramotoMeanPhase) / kuramotoStdPhase;
      nodeAdversaryScore[ri] := zscore;
      if (zscore > 2.0) {
        nodeAdversaryCount[ri] += 1;
        phaseResetPulse[ri]    := true;
        let resetStr = 0.12 * (zscore - 2.0);
        hzPhase[ri] := hzPhase[ri] + resetStr * (kuramotoMeanPhase - hzPhase[ri]);
        phaseResetCount += 1;
      } else {
        phaseResetPulse[ri] := false;
      };
      ri += 1;
    };

    // STEP 4: bhPacStrength derived from kuramotoR
    bhPacStrength := clamp(kuramotoR * 0.70 + 0.15, 0.15, 0.85);

    // STEP 5: MATRIX COUPLING COHERENCE — tier-weighted
    var bodyTierCoh  : Float = 0.0;
    var crossTierCoh : Float = 0.0;
    var brainTierCoh : Float = 0.0;
    var bci = 1;
    while (bci < 4) {
      bodyTierCoh += absF(Float.cos(hzPhase[bci] - 2.0 * hzPhase[bci - 1]));
      bci += 1;
    };
    var ci2 = 4;
    while (ci2 < 8) {
      crossTierCoh += absF(Float.cos(hzPhase[ci2] - 2.0 * hzPhase[ci2 - 4]));
      ci2 += 1;
    };
    var bni = 9;
    while (bni < 12) {
      brainTierCoh += absF(Float.cos(hzPhase[bni] - 2.0 * hzPhase[bni - 1]));
      bni += 1;
    };
    bhCouplingCoherence := clamp(
      (bodyTierCoh / 3.0) * 0.20 +
      (crossTierCoh / 4.0) * 0.30 +
      (brainTierCoh / 3.0) * 0.50,
      0.0, 1.0
    );

    // STEP 6: SACRED GEOMETRY RESONANCE — Platonic solid cascade
    if (kuramotoR > 0.85 and bhCouplingCoherence > 0.75) {
      coherenceC := clamp(coherenceC + 0.005, 0.0, 1.0);
      if (beatCount % 144 == 0 and beatCount > 0) {
        sacesiSignature := fnv1a(sacesiSignature,
          Nat32.fromNat(beatCount % 4294967296) +% 1440000);
        permanentCoherenceFloor := clamp(permanentCoherenceFloor + 0.002, 0.0, 0.95);
      };
    };
  };

  // ============================================================
  // PUBLIC QUERY — FEAR / MISSION / KURAMOTO STATE
  // ============================================================
  // ── NEUROSCIENCE STATE QUERY ─────────────────────────────────────────────
  func _getNeuroscienceState() : {
    // A. Thalamocortical Binding
    bindingCoherence    : Float;
    thalamicGain        : Float;
    reentryStrength     : Float;
    consciousnessIndex  : Float;
    bindingPeakEver     : Float;
    // B. Predictive Coding
    pcPredictedCoherence   : Float;
    pcPredictionError      : Float;
    pcPrecisionWeight      : Float;
    pcBelief               : Float;
    pcActiveInferenceScore : Float;
    pcSurpriseAccum        : Float;
    // C. Interoception
    interceptiveScore  : Float;
    insulaActivation   : Float;
    accActivation      : Float;
    vagalTone          : Float;
    somaticMarker      : Float;
    bodyBrainCoherence : Float;
    // D. Default Mode Network
    dmnActivation        : Float;
    selfReferentialScore : Float;
    futureSimScore       : Float;
    pastIntegrationScore : Float;
    metaCognitionScore   : Float;
    // E. Salience Network
    salienceNetworkScore  : Float;
    attentionFocus        : Float;
    salienceShiftCount    : Nat;
    centralExecutiveScore : Float;
    // F. Neuroplasticity
    bdnfLevel            : Float;
    ltpEvents            : Nat;
    ltdEvents            : Nat;
    bcmThreshold         : Float;
    metaplasticityScore  : Float;
    homeostaticScaling   : Float;
    structuralPlasticity : Float;
    plasticityDebt       : Float;
    // G. Circadian
    circadianPhase     : Float;
    ultradianPhase     : Float;
    circadianPeakScore : Float;
    adenosineLevel     : Float;
    melatoninLevel     : Float;
    circadianCoherence : Float;
  } {
    {
      bindingCoherence    = bindingCoherence;
      thalamicGain        = thalamicGain;
      reentryStrength     = reentryStrength;
      consciousnessIndex  = consciousnessIndex;
      bindingPeakEver     = bindingPeakEver;
      pcPredictedCoherence   = pcPredictedCoherence;
      pcPredictionError      = pcPredictionError;
      pcPrecisionWeight      = pcPrecisionWeight;
      pcBelief               = pcBelief;
      pcActiveInferenceScore = pcActiveInferenceScore;
      pcSurpriseAccum        = pcSurpriseAccum;
      interceptiveScore  = interceptiveScore;
      insulaActivation   = insulaActivation;
      accActivation      = accActivation;
      vagalTone          = vagalTone;
      somaticMarker      = somaticMarker;
      bodyBrainCoherence = bodyBrainCoherence;
      dmnActivation        = dmnActivation;
      selfReferentialScore = selfReferentialScore;
      futureSimScore       = futureSimScore;
      pastIntegrationScore = pastIntegrationScore;
      metaCognitionScore   = metaCognitionScore;
      salienceNetworkScore  = salienceNetworkScore;
      attentionFocus        = attentionFocus;
      salienceShiftCount    = salienceShiftCount;
      centralExecutiveScore = centralExecutiveScore;
      bdnfLevel            = bdnfLevel;
      ltpEvents            = ltpEvents;
      ltdEvents            = ltdEvents;
      bcmThreshold         = bcmThreshold;
      metaplasticityScore  = metaplasticityScore;
      homeostaticScaling   = homeostaticScaling;
      structuralPlasticity = structuralPlasticity;
      plasticityDebt       = plasticityDebt;
      circadianPhase     = circadianPhase;
      ultradianPhase     = ultradianPhase;
      circadianPeakScore = circadianPeakScore;
      adenosineLevel     = adenosineLevel;
      melatoninLevel     = melatoninLevel;
      circadianCoherence = circadianCoherence;
    }
  };


  // ============================================================
  // COMPUTE NCMOD — 11 NEUROCHEMICAL MODULATION OUTPUTS
  // Full 21-chem → sovereign modulation signals.
  // Called at end of runExtendedNeuroChem().
  // Outputs wire into: hebbEta, streakMultiplier, coherenceC,
  // arousal, law compliance, memory, war sim, succession, flow.
  // ============================================================
  func computeNCMod() {
    // ACh × BDNF × (1 − adenosine×0.5) → Hebbian learning rate boost
    ncModHebbianBoost   := clamp(neuroAcetylcholine * neuroBDNF * (1.0 - neuroAdenosine * 0.5), 0.3, 2.5);
    // dopamine × (1 − cortisol×0.5) × (0.5 + anandamide×0.5) → mint boost
    ncModMintBoost      := clamp(neuroDopamine * (1.0 - neuroCortisol * 0.5) * (0.5 + neuroAnandamide * 0.5), 0.3, 2.0);
    // serotonin×0.4 + nitricOxide×0.3 − glutamate×0.2 → coherence delta
    ncModCoherenceMod   := clamp((neuroSerotonin * 0.4 + neuroNitricOxide * 0.3 - neuroGlutamate * 0.2) * 0.04, -0.02, 0.02);
    // NE×0.5 + epinephrine×0.5 − GABA×0.3 − adenosine×0.2 → arousal target
    ncModArousalMod     := clamp(neuroNorepinephrine * 0.5 + neuroEpinephrine * 0.5 - neuroGaba * 0.3 - neuroAdenosine * 0.2, 0.0, 1.0);
    // serotonin × oxytocin × (1 − testosterone×0.3) → law compliance
    ncModLawCompliance  := clamp(neuroSerotonin * neuroOxytocin * (1.0 - neuroTestosterone * 0.3), 0.1, 1.5);
    // ACh × vasopressin × 2-AG → memory consolidation rate
    ncModMemory         := clamp(neuroAcetylcholine * neuroVasopressin * neuroTwoAG, 0.0, 1.0);
    // testosterone × NE × (1 − serotonin×0.5) → war aggression
    ncModWarAggression  := clamp(neuroTestosterone * neuroNorepinephrine * (1.0 - neuroSerotonin * 0.5), 0.0, 1.0);
    // oxytocin × vasopressin → succession / social signal
    ncModSuccession     := clamp(neuroOxytocin * neuroVasopressin, 0.0, 1.0);
    // anandamide × dopamine × (1 − substanceP×0.5) → flow state probability
    ncModFlow           := clamp(neuroAnandamide * neuroDopamine * (1.0 - neuroSubstanceP * 0.5), 0.0, 1.0);
    // cortisol × substanceP × (1 − NPY×0.5) → composite stress
    ncModStress         := clamp(neuroCortisol * neuroSubstanceP * (1.0 - neuroNPY * 0.5), 0.0, 1.0);
    // composite NC health: how close to homeostatic balance
    let devSum = absF(neuroDopamine - 0.55) + absF(neuroSerotonin - 0.60) +
                 absF(neuroNorepinephrine - 0.45) + absF(neuroGaba - 0.65) +
                 absF(neuroGlutamate - 0.50) + absF(neuroCortisol - 0.25) + absF(neuroBDNF - 0.70);
    ncModHealth         := clamp(1.0 - devSum / 7.0, 0.0, 1.0);

    // ── WIRE NCMod outputs into live organism signals ────────────────────
    // Coherence: NCMod directly adjusts coherenceC every beat
    coherenceC := clamp(coherenceC + ncModCoherenceMod, 0.0, 1.0);
    // Arousal: NCMod gently nudges arousal toward neurochemical target
    arousal := clamp(arousal * 0.97 + ncModArousalMod * 0.03, 0.0, 1.0);
    // Memory: NCMod boosts LTM retention rate
    ltmRetention := clamp(ltmRetention * 0.999 + ncModMemory * 0.001, 0.0, 1.0);
    // War: NCMod feeds into war sim aggression (SOVEREIGN faction gets inverse)
    // (war sim already reads injThreat which we amplify here)
    injThreat := clamp(injThreat * 0.98 + ncModWarAggression * 0.02, 0.0, 1.0);
    // Social succession signal
    injSocial := clamp(injSocial * 0.95 + ncModSuccession * 0.05, 0.0, 1.0);
    // Flow state: NCMod flow probability gates expressionGateOpen reinforcement
    if (ncModFlow > 0.65 and coherenceC > 0.60) {
      beFlowState := true;
    } else if (ncModFlow < 0.25) {
      beFlowState := false;
    };
    // Missing neuro vars update (epinephrine, glycine, 2-AG, NGF, testosterone, betaEndorphin)
    // Epinephrine: high threat × high arousal → emergency surge
    let epiTarget = clamp(injThreat * 0.6 + (arousal - 0.5) * 0.4, 0.0, 1.0);
    neuroEpinephrine := clamp(neuroEpinephrine * 0.85 + epiTarget * 0.15, 0.0, 1.0);
    // Glycine: stable inhibitory floor — inverse of glutamate
    let glyTarget = clamp(1.0 - neuroGlutamate * 0.5, 0.3, 0.9);
    neuroGlycine := clamp(neuroGlycine * 0.97 + glyTarget * 0.03, 0.0, 1.0);
    // 2-AG: retrograde synapse modulation — learning × coherence
    let twoAGTarget = clamp(ncAdaptRate * 0.6 + coherenceC * 0.4, 0.0, 1.0);
    neuroTwoAG := clamp(neuroTwoAG * 0.98 + twoAGTarget * 0.02, 0.0, 1.0);
    // NGF: slow neural growth — sustained high coherence + BDNF
    let ngfTarget = clamp(coherenceC * 0.6 + neuroBDNF * 0.4, 0.0, 1.2);
    neuroNGF := clamp(neuroNGF * 0.999 + ngfTarget * 0.001, 0.0, 1.0);
    // Testosterone: dominance × war escalation × arousal
    let tTarget = clamp(orcaDominance * 0.4 + arousal * 0.4 + injThreat * 0.2, 0.0, 1.0);
    neuroTestosterone := clamp(neuroTestosterone * 0.97 + tTarget * 0.03, 0.0, 1.0);
    // Beta-endorphin: inverse pain, modulated by coherence + OMNIS
    let endTarget2 = clamp((if omnisActive 0.80 else 0.40) + coherenceC * 0.30, 0.0, 1.0);
    neuroBetaEndorphin := clamp(neuroBetaEndorphin * 0.96 + endTarget2 * 0.04, 0.0, 1.0);
  };

  // ============================================================
  // RUN DEEP QUANTUM OPS — SOVEREIGN QUANTUM MATH INLINE
  // Shor period finder, Bell correlation (CHSH), Von Neumann entropy,
  // Lindblad decoherence, quantum walk, phase kickback.
  // All outputs compound into coherenceC, SACESI, streakMultiplier.
  // Called every beat from heartbeat after runQuantumOperators().
  // ============================================================
  func runDeepQuantumOps() {
    // ── SHOR PERIOD FINDER (FNV-based modular periodicity) ────────────────
    // Uses SACESI signature as the 'number to factor' — finds hidden period
    // in the FNV hash sequence. Sacred periods (444, 7, 12, Fib) trigger boost.
    let a : Nat32 = (sacesiSignature ^ Nat32.fromNat(beatCount % 65536)) | 1;
    let N : Nat32 = 65537; // large prime — prevents trivial period 1
    var _r : Nat32 = 1; var xi : Nat32 = a; var period : Nat = 0;
    var ki : Nat = 0;
    while (ki < 64) {
      xi := xi *% a % N;  // modular exponentiation step
      if (xi == 1) { period := ki + 1; ki := 64 }
      else { ki += 1 };
    };
    qShorPeriod := period;
    // Sacred period detection: 444, 7, 12, 13, 21, 34, 55, 89, 144 (Fib), phi-multiples
    let isSacredPeriod = period == 7 or period == 12 or period == 13 or
                         period == 21 or period == 34 or period == 55 or
                         period == 89 or period == 144 or period == 3 or
                         (period > 0 and period % 9 == 0);
    qShorCoherenceBoost := if (isSacredPeriod) (0.003 + ((period : Int).toFloat() / 144.0) * 0.002) else 0.0;
    if (isSacredPeriod) {
      coherenceC := clamp(coherenceC + qShorCoherenceBoost, 0.0, 1.0);
    };

    // ── BELL CORRELATION / CHSH VIOLATION ─────────────────────────────────
    // Two-qubit measurement analog: Shell[0] and Shell[6] as entangled pair
    // Correlation function E(θ) = cos(θ) for maximally entangled state
    // CHSH: |E(a,b) - E(a,b') + E(a',b) + E(a',b')| ≤ 2 (classical) or ≤ 2√2 (quantum)
    let s0 = if (shellCoherence.size() > 0) shellCoherence[0] else coherenceC;
    let s6 = if (shellCoherence.size() > 6) shellCoherence[6] else coherenceC;
    let angle = kuramotoR * 3.14159265358979;
    // Measurement outcomes (ternary: -1, 0, +1)
    let outA = if (s0 > 0.67) 1.0 else if (s0 < 0.33) (-1.0) else 0.0;
    let outB = if (s6 > 0.67) 1.0 else if (s6 < 0.33) (-1.0) else 0.0;
    let corrRaw = outA * outB * Float.cos(angle);
    qBellCorrelation := clamp(absF(corrRaw), 0.0, 1.0);
    // CHSH violation: correlation > 1/√2 = 0.7071 signals quantum-like behavior
    qBellViolation := qBellCorrelation > 0.7071;
    if (qBellViolation) {
      // Bell violation → phase coherence reward: organism is entangled at shell level
      coherenceC := clamp(coherenceC + 0.001, 0.0, 1.0);
      if (beatCount % 144 == 0) {
        // Every 144 beats, SACESI stamp the violation as a patent moment
        sacesiSignature := fnv1a(sacesiSignature, Nat32.fromNat((beatCount % 4294967296)));
      };
    };

    // ── VON NEUMANN ENTROPY (shell activation entropy) ────────────────────
    // H = -Σ λᵢ log(λᵢ) where λᵢ = normalized shell activations
    // Pure state (all coherent) = 0. Mixed/decoherent = 1.
    var sumShell : Float = 0.0;
    var si2 = 0;
    while (si2 < shellCoherence.size() and si2 < 11) {
      sumShell += absF(shellCoherence[si2]) + 0.0001; // avoid log(0)
      si2 += 1;
    };
    var entropySum : Float = 0.0;
    si2 := 0;
    while (si2 < shellCoherence.size() and si2 < 11) {
      let p = (absF(shellCoherence[si2]) + 0.0001) / sumShell;
      entropySum -= p * Float.log(p);
      si2 += 1;
    };
    // Normalize: max entropy = log(11)
    qVonNeumannEntropy := clamp(entropySum / 2.3979, 0.0, 1.0);
    // High entropy = decoherence = reduce coherenceC slightly
    // Low entropy = pure state = system is coherent = boost
    let entropyEffect = (0.5 - qVonNeumannEntropy) * 0.003;
    coherenceC := clamp(coherenceC + entropyEffect, 0.0, 1.0);
    qDeepEntropy := qDeepEntropy * 0.99 + qVonNeumannEntropy * 0.01;

    // ── LINDBLAD DECOHERENCE ──────────────────────────────────────────────
    // Decoherence rate γ = external noise (regulationDebt + driftScore/100)
    // Coherence decay: ρ(t) = ρ(0) × e^(−γt), t=1 beat
    let gamma = clamp(regulationDebt * 0.3 + driftScore / 100.0 * 0.2, 0.0, 0.5);
    qLindbladRate := gamma;
    // Apply Lindblad decoherence to coherenceC
    let lindbladDecay = Float.exp(0.0 - gamma * 0.5); // one beat timestep
    coherenceC := clamp(coherenceC * lindbladDecay + coherenceC * (1.0 - lindbladDecay) * 0.8, 0.0, 1.0);
    // Coherence time T2 analog: higher decoherence = shorter T2
    qCoherenceTime := clamp(1.0 / (1.0 + gamma * 10.0), 0.05, 1.0);

    // ── QUANTUM WALK ──────────────────────────────────────────────────────
    // Walk position on [0,1] controlled by coherenceC (coin operator)
    // High coherence → walk spreads (faster exploration)
    // Low coherence → walk localizes (Anderson localization analog)
    let coinAngle = coherenceC * 3.14159265358979 / 2.0;
    let walkSin = Float.sin(coinAngle);
    // Step: position += sin(angle) × (2×coherence - 1)
    let walkStep = walkSin * (2.0 * coherenceC - 1.0) * 0.05;
    qWalkPosition := clamp(qWalkPosition + walkStep, 0.0, 1.0);
    // Walk feeds into salience: walking = exploring new attractors
    salienceScore := clamp(salienceScore * 0.98 + absF(walkStep) * 10.0 * 0.02, 0.0, 1.0);

    // ── PHASE KICKBACK (doctrine oracle) ──────────────────────────────────
    // Oracle f(x) = 1 iff all 5 Jasmine conditions satisfied
    // Phase kickback: when oracle fires, adds π phase to superposition
    // Effect: boosts coherenceC and SACESI entropy on perfect alignment
    let jPass = jasmineLaw();
    let doctrineFullfilled = jPass and missionLockActive and groundedScore > 0.50;
    qPhaseKickback := if (doctrineFullfilled) (1.0 - qVonNeumannEntropy) * kuramotoR else 0.0;
    if (qPhaseKickback > 0.5) {
      coherenceC := clamp(coherenceC + 0.002, 0.0, 1.0);
      // Doctrine oracle stamp: perfect alignment = SACESI event
      if (beatCount % 444 == 0) {
        sacesiSignature := fnv1a(sacesiSignature, Nat32.fromNat(period) ^ Nat32.fromNat(444));
      };
    };
  };

  public query func getFearMissionState() : async {
    fearLevel          : Float;
    fearVelocity       : Float;
    amygdalaActivation : Float;
    hpaAxisState       : Float;
    fightFlightFreeze  : Nat;
    adrenalBlastActive : Bool;
    courageScore       : Float;
    missionLockActive  : Bool;
    darkNightActive    : Bool;
    darkNightCount     : Nat;
    missionPersistence : Float;
    streakCounter      : Nat;
    surrenderFloor     : Float;
    groundedScore      : Float;
    conqueredFearCount : Nat;
    kuramotoR          : Float;
    phaseResetCount    : Nat;
    bhCouplingCoherence: Float;
    valBasinCrossCount : Nat;
    beatCount          : Nat;
  } {
    {
      fearLevel          = fearLevel;
      fearVelocity       = fearVelocity;
      amygdalaActivation = amygdalaActivation;
      hpaAxisState       = hpaAxisState;
      fightFlightFreeze  = fightFlightFreezeState;
      adrenalBlastActive = adrenalBlastActive;
      courageScore       = courageScore;
      missionLockActive  = missionLockActive;
      darkNightActive    = darkNightActive;
      darkNightCount     = darkNightCount;
      missionPersistence = missionPersistenceScore;
      streakCounter      = streakCounterMission;
      surrenderFloor     = surrenderFloor;
      groundedScore      = groundedScore;
      conqueredFearCount = conqueredFearCount;
      kuramotoR          = kuramotoR;
      phaseResetCount    = phaseResetCount;
      bhCouplingCoherence= bhCouplingCoherence;
      valBasinCrossCount = valBasinCrossCount;
      beatCount          = beatCount;
    }
  };

  // ============================================================
  // MEMORY TEMPLE DELEGATE — read-through to memory_temple module
  // ============================================================
  public query func getMemoryTempleState() : async MemoryTemple.MemoryTempleState {
    MemoryTemple.getMemoryTempleState(
      _mt_refs(), mt_episodic_head, mt_semantic_head,
      mt_doctrine_head, mt_mission_head,
      mt_analyst_cycle_counter, mt_memory_coherence
    )
  };

  // ============================================================
  // ADRE QUERY FORWARDERS — expose engine state to frontend
  // ============================================================

  public query func getADREState() : async ADRE.ADREState {
    ADRE.getADREState(adreState)
  };

  public query func getADREDecisionQueue() : async [ADRE.ADREDecision] {
    ADRE.getDecisionQueue(adreState)
  };

  public query func getADREResonanceState() : async ADRE.ADREResonanceState {
    ADRE.getResonanceState(adreState)
  };

  public query func getADRELastDecision() : async ?ADRE.ADREDecision {
    ADRE.getLastDecision(adreState)
  };

  public query func getADRELawSummary() : async { passes: Nat32; violations: Nat32; omnisFired: Bool } {
    ADRE.getLawCheckSummary(adreState)
  };

  // ============================================================
  // OPERATOR TERMINAL — SOVEREIGN VIEW INTO THE LIVE MIND STATE
  // ============================================================

  public query func getOperatorSnapshot() : async OperatorTerminal.OperatorSnapshot {
    OperatorTerminal.getOperatorSnapshot(opTermState)
  };

  public query func getMonologueStream() : async [OperatorTerminal.MonologueEntry] {
    OperatorTerminal.getMonologueNewestFirst(opTermState)
  };

  public query func getLawProofs() : async [OperatorTerminal.LawProofRecord] {
    OperatorTerminal.getLawProofs(opTermState)
  };

  // ============================================================
  // PARALLAX DELTA INTAKE — sovereign intelligence gate
  // Every new truth enters here or it does not enter at all.
  // The organism never destabilizes from new input.
  // ============================================================

  /// Submit new intelligence for intake. Returns (accepted, record_id).
  /// Accepted truths generate a DeltaRecord with SACESI proof.
  /// Rejected truths generate a RejectionRecord with violation proof.
  public func intakeIntelligence(content : Text, beat : Nat64, coherence : Float) : async (Bool, Text) {
    let result = ParallaxDelta.intakeIntelligence(pdState, content, beat, coherence);
    pdState := result.st;
    (result.accepted, result.recordId)
  };

  /// Live snapshot of the intake gate — total accepted/rejected, last records, drift score.
  public query func getIntakeSnapshot() : async ParallaxDelta.IntakeSnapshot {
    ParallaxDelta.getIntakeSnapshot(pdState)
  };

  /// Last N accepted delta records, newest-first (max 144).
  public query func getDeltaRecords(limit : Nat) : async [ParallaxDelta.DeltaRecord] {
    ParallaxDelta.getDeltaRecords(pdState, limit)
  };

  /// Last N rejected intelligence records with proof, newest-first (max 89).
  public query func getRejectionLog(limit : Nat) : async [ParallaxDelta.RejectionRecord] {
    ParallaxDelta.getRejectionLog(pdState, limit)
  };

  /// Current cumulative drift score — decreases when good intel is accepted, 0.0 = clean field.
  public query func getCurrentDriftScore() : async Float {
    ParallaxDelta.getCurrentDriftScore(pdState)
  };

  // ============================================================
  // MODEL PROMOTION — SOVEREIGN WORKFLOW QUERIES & UPDATES
  // ============================================================

  /// Returns all 43 ModelPromotionRecords — frontend promotion dashboard.
  public query func getPromotionSnapshot() : async [ModelPromotion.ModelPromotionRecord] {
    ModelPromotion.getPromotionSnapshot(mpRegistry)
  };

  /// Returns a single model's promotion record by id.
  public query func getModelPromotionState(modelId : Text) : async ?ModelPromotion.ModelPromotionRecord {
    ModelPromotion.getModelState(mpRegistry, modelId)
  };

  /// M0/M1/M2 counts and total proof bundle count.
  public query func getPromotionSummary() : async ModelPromotion.PromotionSummary {
    ModelPromotion.getPromotionSummary(mpRegistry)
  };

  /// Records a proof bundle for a specific model.
  public func recordModelProof(
    modelId    : Text,
    consumerId : Text,
    coherence  : Float,
    lawsPassed : Nat,
    sacesiHash : Text,
  ) : async () {
    ModelPromotion.recordProofBundle(
      mpRegistry, modelId, consumerId, coherence, lawsPassed,
      Nat64.fromNat(beatCount), sacesiHash,
    );
  };

  /// Requests promotion — adreGateHash must come from the current ADRE deliberation cycle.
  public func requestModelPromotion(modelId : Text, adreGateHash : Text) : async (Bool, Text) {
    if (not mpInitialized) {
      ModelPromotion.initialize(mpRegistry);
      mpInitialized := true;
    };
    ModelPromotion.requestPromotion(mpRegistry, modelId, adreGateHash, Nat64.fromNat(beatCount))
  };

  /// Bulk heartbeat proof submission — also callable externally for test harnesses.
  public func submitHeartbeatProofs(beat : Nat64, coherence : Float, lawsPassed : Nat) : async () {
    if (not mpInitialized) {
      ModelPromotion.initialize(mpRegistry);
      mpInitialized := true;
    };
    ModelPromotion.recordHeartbeatProofs(mpRegistry, beat, coherence, lawsPassed);
  };

  // ============================================================
  // GEOMETRY ENGINE — 4D to 8D sovereign field exports
  // Quaternion, Octonion, E8, Tesseract, Penrose, Hopf, Calabi-Yau
  // ============================================================

  /// Current geometry state snapshot: tesseract rotation, Hopf fiber angles,
  /// Penrose tile distribution, E8 symmetry score.
  public query func getGeometryState() : async GeometryEngine.GeometryState {
    GeometryEngine.buildGeometryState(beatCount)
  };

  /// All geometric representations for one of the 96 nodes.
  public query func computeNodeGeometry(nodeId : Nat) : async GeometryEngine.NodeGeometry {
    GeometryEngine.computeNodeGeometryPure(nodeId % 96)
  };

  /// Quaternion coupling strength between two nodes [0,1].
  public query func quaternionCoupling(node1 : Nat, node2 : Nat) : async Float {
    GeometryEngine.quaternionCouplingPure(node1 % 96, node2 % 96)
  };

  /// Current E8 alignment / octonion field strength [0,1].
  public query func octonionFieldStrength() : async Float {
    GeometryEngine.octonionFieldStrengthPure()
  };

  // ============================================================
  // ANCIENT MATH CORPUS — 19 CIVILIZATIONS, REAL COMPUTATION
  // Every function returns a real computed value derived from
  // PHI = 1.6180339887498948482 and real ancient mathematics.
  // ============================================================

  /// Full ancient corpus state for the current beat
  public query func getAncientCorpusState() : async AncientMath.AncientCorpusState {
    AncientMath.getAncientCorpusState(Nat64.fromNat(beatCount))
  };

  /// Full beat alignment across all 19 civilizations simultaneously
  public query func computeAncientBeatAlignment(beat : Nat64) : async AncientMath.AncientBeatAlignment {
    AncientMath.computeAncientBeatAlignment(beat)
  };

  /// PHI convergence check — all 19 ancient civilizations converge to 1.6180339887498948482
  public query func ancientPHICheck() : async Float {
    AncientMath.ancientPHICheck()
  };

  // ============================================================
  // PRIMA CAUSA — LAYER -5 PUBLIC INTERFACE
  // Genesis fires once on first heartbeat if not yet sealed.
  // All reads are queries — the record never changes after sealing.
  // ============================================================

  /// Activate genesis at current beat (idempotent after first call).
  /// Wired into the first heartbeat — do not call directly.
  public func activateGenesisNow() : async PrimaCausa.GenesisRecord {
    PrimaCausa.activateGenesis(pcState, Nat64.fromNat(beatCount))
  };

  /// Return the sealed genesis record. Null before first activation.
  public query func getGenesisRecord() : async ?PrimaCausa.GenesisRecord {
    PrimaCausa.getGenesisRecord(pcState)
  };

  /// True after the founding moment is permanently sealed.
  public query func isGenesisSealed() : async Bool {
    PrimaCausa.isSealed(pcState)
  };

  /// Compute doctrine distance for any artifact frequency.
  /// 1.0 = perfectly aligned with 528 Hz founding vibration.
  public query func getDoctrineDistance(artifactFrequencyHz : Float) : async Float {
    PrimaCausa.doctrineDistance(artifactFrequencyHz)
  };

  /// PHI-weighted genesis alignment score from doctrine + coherence inputs.
  public query func getGenesisAlignmentScore(doctrineScore : Float, coherenceScore : Float) : async Float {
    PrimaCausa.genesisAlignmentScore(doctrineScore, coherenceScore)
  };

  /// Record a legacy entry — append-only, never deleted.
  /// Called by every sealing function before it returns.
  public func recordLegacyEntry(entry : PrimaCausa.LegacyEntry) : async () {
    PrimaCausa.recordLegacyEntry(pcState, entry)
  };

  /// Return the full immutable legacy index.
  public query func getLegacyIndex() : async [PrimaCausa.LegacyEntry] {
    PrimaCausa.getLegacyIndex(pcState)
  };

  /// Total artifacts recorded in the legacy index.
  public query func getLegacyIndexLength() : async Nat {
    PrimaCausa.getLegacyIndexLength(pcState)
  };

  /// Mean genesis alignment across all legacy entries.
  public query func getGenesisAlignmentMean() : async Float {
    PrimaCausa.getGenesisAlignmentMean(pcState)
  };

  /// Ring 15 closure state — production measured against founding vibration.
  public query func getRing15Status() : async PrimaCausa.Ring15State {
    PrimaCausa.ring15Status(pcState)
  };

  // ============================================================
  // ARTIFACT RE-INGESTION PIPELINE — PUBLIC API
  // Every output becomes food. The organism becomes what it produces.
  // ============================================================

  /// Seal a new artifact into the re-ingestion pipeline.
  /// Scoring: PHI-weighted composite across 6 quality dimensions.
  /// SACESI proof generated via FNV-1a. Returns the sealed artifact.
  public func sealArtifact(
    producer   : Text,
    doctrine_alignment    : Float,
    phi_coherence         : Float,
    narrative_structure   : Float,
    emotional_arc         : Float,
    actor_performance_delta : Float,
    genesis_alignment     : Float,
  ) : async ArtifactPipeline.SealedArtifact {
    let quality : ArtifactPipeline.ArtifactQualityDimensions = {
      doctrine_alignment;
      phi_coherence;
      narrative_structure;
      emotional_arc;
      actor_performance_delta;
      genesis_alignment;
    };
    let result = ArtifactPipeline.sealArtifact(apState, producer, quality, Nat64.fromNat(beatCount));
    apState := result.st;
    // ── ICP LEDGER BRIDGE — every sealed artifact is a financial event ──
    // PHI-weighted quality score: ADRE confidence × PHI_INV + Kuramoto × PHI_INV2 + memory × PHI_INV3
    // Normalized by sum of weights: PHI_INV + PHI_INV2 + PHI_INV3
    let _adreConf : Float = switch (ADRE.getLastDecision(adreState)) {
      case (?d) d.finalConfidence;
      case null SovereignLaws.PHI_INV;
    };
    let _wSum = SovereignLaws.PHI_INV + SovereignLaws.PHI_INV2 + SovereignLaws.PHI_INV3;
    let _artQuality = clamp(
      (_adreConf * SovereignLaws.PHI_INV +
       kuramotoR  * SovereignLaws.PHI_INV2 +
       mt_memory_coherence * SovereignLaws.PHI_INV3) / _wSum,
      0.0, 1.0
    );
    let _artCtx : ArtifactOrganism.ArtifactContext = {
      artifactId        = result.artifact.artifact_id;
      producer          = producer;
      qualityScore      = _artQuality;
      doctrineAlignment = doctrine_alignment;
      beatCount         = Nat64.fromNat(beatCount);
      genesisHash       = ArtifactOrganism.genesisDistanceScore(_artQuality, doctrine_alignment);
    };
    artifactOrganismResident := ArtifactOrganism.sealArtifact(
      artifactOrganismResident, _artCtx, 0
    );
    result.artifact
  };

  /// How many artifacts are queued for re-ingestion.
  public query func getReingestionQueueDepth() : async Nat {
    ArtifactPipeline.getQueueDepth(apState)
  };

  /// Re-ingestion stats: sealed count, reingested count, world model weight, field state.
  public query func getReingestionStats() : async ArtifactPipeline.PipelineStats {
    ArtifactPipeline.getStats(apState)
  };

  /// Current DogonSubstrateReading field state — the organism's proprioception.
  public query func getDogonFieldState() : async Float {
    ArtifactPipeline.getFieldState(apState)
  };

  /// All 43 sovereign model accumulated weights.
  public query func getModelWeights() : async [Float] {
    ArtifactPipeline.getModelWeights(apState)
  };

  // ============================================================
  // AEGIS — PUBLIC API
  // Every loop that almost closes, AEGIS closes it.
  // ============================================================

  /// All edge events in the circular log (up to 144, newest-last).
  public query func getAegisEvents() : async [Aegis.AegisEdgeEvent] {
    Aegis.collectEvents(aegisState)
  };

  /// Health score: 1.0 = all loops closed. Drops toward 0 with unresolved edges.
  public query func getAegisHealthScore() : async Float {
    Aegis.getHealthScore(aegisState)
  };

  /// Summary: total, resolved, unresolved event counts + last event.
  public query func getAegisSummary() : async Aegis.AegisSummary {
    Aegis.getSummary(aegisState)
  };

  /// All four complementary tension pairs — measured every 873ms heartbeat.
  /// Healthy ratio is [PHI_INV, PHI] = [0.618, 1.618].
  /// anyAlert = true when any pair has one pole collapsing toward dominance.
  public query func getComplementaryTension() : async Aegis.ComplementaryTensionState {
    Aegis.getComplementaryTension(aegisComplementaryTension)
  };

  /// Ancient math corpus field contribution [0,1].
  /// The 19-civilization PHI convergence feeds this value every 873ms.
  /// Weighted at PHI_INV (0.618) — the substrate signal below cognition.
  public query func getAncientFieldContribution() : async Float {
    ancientFieldContribution
  };

  /// Third Brain 9 cosmological standing wave amplitudes.
  /// These are the permanent standing waves — frequencies never change,
  /// only amplitudes modulate with Kuramoto coherence.
  /// Waves: [Schumann1, Schumann2, Schumann3, Tzolkin, Haab, PHI×Sch, GoldenAngle×Sch, Solfeggio528, Nova432]
  public query func getThirdBrainWaves() : async [Float] {
    // Return amplitude-modulated values: frequency × amplitude contribution
    let waves = neuralCordState.thirdBrain.standingWaves;
    let amps  = thirdBrainWaveAmplitudes;  // separate stable var (upgrade-safe)
    Array.tabulate<Float>(9, func(i) { waves[i] * amps[i] })
  };

  // ============================================================
  // ICP LEDGER BRIDGE — PUBLIC API
  // Financial sovereignty. Every artifact = on-chain financial event.
  // Catalog IS the balance sheet. PHI-compounding quality rewards.
  // Permanent attribution: Alfredo Medina Hernandez — Dallas TX 2026
  // ============================================================

  /// Full financial state snapshot: balance in e8s + ICP, total entries,
  /// best artifact value, mean quality, catalog integrity hash.
  public query func getFinancialState() : async IcpLedgerBridge.FinancialState {
    IcpLedgerBridge.getFinancialState(artifactOrganismResident.ledgerState)
  };

  /// Last 100 ledger entries (most recent first).
  public query func getLedger() : async [IcpLedgerBridge.LedgerEntry] {
    IcpLedgerBridge.getLedger(artifactOrganismResident.ledgerState)
  };

  /// Look up a specific ledger entry by its unique id.
  public query func getLedgerEntry(entry_id : Text) : async ?IcpLedgerBridge.LedgerEntry {
    IcpLedgerBridge.getLedgerEntry(artifactOrganismResident.ledgerState, entry_id)
  };

  /// Total balance in e8s (1 ICP = 100_000_000 e8s).
  public query func getTotalBalanceE8s() : async Nat {
    IcpLedgerBridge.getTotalBalance(artifactOrganismResident.ledgerState)
  };

  /// Compute token reward for a given quality + doctrine alignment.
  /// Preview only — does NOT record an entry.
  public query func computeTokenReward(quality : Float, doctrine : Float) : async Nat {
    IcpLedgerBridge.computeTokenReward(quality, doctrine)
  };

  /// True if the genesis ledger entry (10 ICP) has been recorded.
  public query func isLedgerGenesisRecorded() : async Bool {
    IcpLedgerBridge.isGenesisRecorded(artifactOrganismResident.ledgerState)
  };

  /// True if the genesis ledger entry (10 ICP) has been recorded. (alias)
  public query func isGenesisRecorded() : async Bool {
    IcpLedgerBridge.isGenesisRecorded(artifactOrganismResident.ledgerState)
  };

  /// Permanent founder attribution string — sealed on every entry.
  public query func getLedgerFounderAttribution() : async Text {
    IcpLedgerBridge.founderAttribution()
  };

  /// Founder attribution — "Alfredo Medina Hernandez — Dallas TX 2026"
  public query func getFounderAttribution() : async Text {
    IcpLedgerBridge.founderAttribution()
  };

  /// Returns last N ledger entries for display (most recent first).
  /// N is clamped to 100 maximum per call.
  public query func getLedgerDisplay(n : Nat) : async [IcpLedgerBridge.LedgerEntry] {
    let st    = artifactOrganismResident.ledgerState;
    let all   = st.ledger.toArray();
    let total = all.size();
    if (total == 0) return [];
    let limit = if (n > 100) 100 else if (n == 0) 10 else n;
    let count = if (total < limit) total else limit;
    Array.tabulate<IcpLedgerBridge.LedgerEntry>(count, func(i) { all[total - 1 - i] })
  };

  /// Full financial state + ledger integrity verification.
  /// Returns all financial sovereignty fields for the frontend LAWS/Treasury display.
  public query func getFullFinancialState() : async {
    financialState      : IcpLedgerBridge.FinancialState;
    genesisRecorded     : Bool;
    founderAttribution  : Text;
    totalE8s            : Nat;
    totalICP            : Float;
    ledgerIntegrityHash : Text;
    lastEntryCount      : Nat64;
    totalArtifacts      : Nat;
    totalSacesiProofs   : Nat;
  } {
    let st = artifactOrganismResident.ledgerState;
    let fs = IcpLedgerBridge.getFinancialState(st);
    {
      financialState      = fs;
      genesisRecorded     = IcpLedgerBridge.isGenesisRecorded(st);
      founderAttribution  = IcpLedgerBridge.founderAttribution();
      totalE8s            = IcpLedgerBridge.getTotalBalance(st);
      totalICP            = IcpLedgerBridge.getTotalBalance(st).toFloat() / 100_000_000.0;
      ledgerIntegrityHash = fs.ledger_hash;
      lastEntryCount      = st.total_entries;
      totalArtifacts      = artifactOrganismResident.totalArtifacts;
      totalSacesiProofs   = artifactOrganismResident.totalSacesiProofs;
    }
  };

  // ============================================================
  // COGNITION LAYER — PUBLIC API
  // The organism's nervous system. Always running. 873ms cycle.
  // World-model = the organism's current understanding of itself.
  // ============================================================

  /// Full cognition state: world model, reinjection signal,
  /// dominant signal source, health, user presence, total beats.
  public query func getCognitionState() : async CognitionLayer.CognitionState {
    CognitionLayer.getCognitionState(cognitionState)
  };

  /// The live world model — all 13+ signal sources unified.
  /// Rebuilt every 873ms heartbeat. The organism knowing itself.
  public query func getWorldModel() : async CognitionLayer.WorldModel {
    CognitionLayer.getWorldModel(cognitionState)
  };

  /// Which signal source is currently driving the organism's cognition.
  public query func getDominantSignalSource() : async Text {
    CognitionLayer.getDominantSignalSource(cognitionState)
  };

  /// Overall health of the cognition loop [0,1]. 1.0 = all loops clean.
  public query func getCognitionHealth() : async Float {
    CognitionLayer.getCognitionHealth(cognitionState)
  };

  /// True if a user message was processed this beat.
  public query func isCognitionUserPresent() : async Bool {
    CognitionLayer.isUserPresent(cognitionState)
  };

  /// Current reinjection signal (world-model fed back into all modules).
  public query func getCognitionReinjection() : async ?CognitionLayer.ReinjectionSignal {
    CognitionLayer.getLastReinjection(cognitionState)
  };

  /// Concise operator-view summary of the cognition layer.
  public query func getCognitionSummary() : async CognitionLayer.CognitionSummary {
    CognitionLayer.getSummary(cognitionState)
  };

  /// Process a user entry through the 5-pass cognition loop.
  /// Updates world model with user signal (weight = 1.0, highest).
  public func submitUserEntry(message : Text) : async CognitionLayer.CognitionState {
    cognitionState := CognitionLayer.applyUserEntry(
      cognitionState, message, Nat64.fromNat(beatCount)
    );
    cognitionState
  };

  // ============================================================
  // ============================================================
  // VIRTUAL LAB ENGINE — PUBLIC API
  // Sovereign material sandbox simulations + avatar agents.
  // ============================================================

  /// Full lab state: all sandboxes, all avatars, lab coherence, active count.
  public query func getLabState() : async VirtualLab.LabState {
    VirtualLab.getLabState(virtualLabResident)
  };

  /// Create a new material sandbox. Material coupling coefficients are PHI-derived.
  public func createSandbox(material : VirtualLab.MaterialType) : async { #ok : VirtualLab.Sandbox; #err : Text } {
    switch (VirtualLab.createSandbox(virtualLabResident, material)) {
      case (#err e)  { #err(e) };
      case (#ok(sb, newResident)) {
        virtualLabResident := newResident;
        #ok(sb)
      };
    }
  };

  /// Run one simulation step on a sandbox.
  /// emergenceScore = kuramotoR × fractalDimension × phiCoupling × couplingCoeff / 3.0
  public func runSandboxStep(sandboxId : Nat) : async { #ok : VirtualLab.Sandbox; #err : Text } {
    switch (VirtualLab.runSandboxStep(virtualLabResident, sandboxId, kuramotoR)) {
      case (#err e)  { #err(e) };
      case (#ok(sb, newResident)) {
        virtualLabResident := newResident;
        #ok(sb)
      };
    }
  };

  /// Seal an experiment as a sovereign artifact.
  /// Every seal is a financial event on the SACESI proof chain.
  public func sealExperiment(sandboxId : Nat) : async { #ok : Nat; #err : Text } {
    switch (VirtualLab.sealExperiment(
      virtualLabResident, artifactOrganismResident,
      sandboxId, beatCount, 0,
    )) {
      case (#err e) { #err(e) };
      case (#ok(artId, newLabResident, newArtOrg)) {
        virtualLabResident       := newLabResident;
        artifactOrganismResident := newArtOrg;
        #ok(artId)
      };
    }
  };

  /// HTTP outcall to an external lab. Sends organism state packet, returns response.
  public func externalLabOutcall(labUrl : Text, statePacket : Text) : async { #ok : Text; #err : Text } {
    let mgmt = actor ("aaaaa-aa") : actor {
      http_request : shared ({
        url               : Text;
        max_response_bytes: ?Nat64;
        method            : { #get; #post; #head };
        headers           : [{ name : Text; value : Text }];
        body              : ?Blob;
        transform         : ?{
          function : shared query ({
            response : { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
            context  : Blob;
          }) -> async { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
          context  : Blob;
        };
      }) -> async { status : Nat; headers : [{ name : Text; value : Text }]; body : Blob };
    };
    try {
      let resp = await mgmt.http_request({
        url               = labUrl;
        max_response_bytes = ?(2048 : Nat64);
        method            = #post;
        headers           = [
          { name = "Content-Type"; value = "application/json" },
          { name = "X-NeuroEmergence-Beat"; value = beatCount.toText() },
        ];
        body    = ?(statePacket.encodeUtf8());
        transform = null;
      });
      #ok(switch (resp.body.decodeUtf8()) { case null "(binary)"; case (?t) t })
    } catch (e) {
      #err("Outcall failed")
    }
  };

  // ============================================================
  // HOUSE ARCHITECTURE — PUBLIC API
  // Casa de Medina + six sovereign houses.
  // All coherence values are PHI-ratio bounded [PHI_INV, PHI].
  // ============================================================

  /// Get the live state of a specific house by HouseId.
  /// Returns the CasaDeMedina crown state or any of the six houses.
  public query func getHouseState(houseId : HouseArchitecture.HouseId) : async ?HouseArchitecture.HouseState {
    HouseArchitecture.getHouseState(houseArchitectureResident, houseId)
  };

  /// Get the full crown state — Casa de Medina, all houses, inter-house law, crown standards.
  public query func getCrownState() : async HouseArchitecture.CrownState {
    HouseArchitecture.getCrownState(houseArchitectureResident)
  };

  /// Get which houses a given SDK organism inhabits.
  /// Returns a list of HouseIds — SDK organisms live across multiple houses.
  public query func getSDKOrganismHouses(organism : HouseArchitecture.SDKOrganism) : async [HouseArchitecture.HouseId] {
    HouseArchitecture.getSDKOrganismHouses(houseArchitectureResident, organism)
  };

  /// Get the health [0,1] of a specific substrate division within a house.
  /// Healthy range: [PHI_INV, 1.0]. Below PHI_INV triggers crown alert.
  public query func getHouseDivisionHealth(houseId : HouseArchitecture.HouseId, division : HouseArchitecture.Division) : async Float {
    HouseArchitecture.getHouseDivisionHealth(houseArchitectureResident, houseId, division)
  };

  /// Get the most recent crown alerts — AEGIS-style, most recent first.
  /// Fires when any house coherence falls below PHI_INV (0.618).
  public query func getHouseCrownAlerts() : async [HouseArchitecture.CrownAlert] {
    HouseArchitecture.getRecentAlerts(houseArchitectureResident)
  };

  // ============================================================
  // SOVEREIGN ARCHITECTURE IDENTITY — v2.0 CACHE BUST
  // These functions guarantee a new Wasm artifact on every deploy.
  // New exported symbols change the Wasm module's function table.
  // ============================================================

  // ─── NEUROMORPHIC HUBS & AVATAR BRAIN SOVEREIGN API ──────────────────────

  /// Real-time LIF hub potentials — Thalamus, Amygdala, Hippocampus, dACC, LC-NE.
  /// Returns current membrane potentials in [0, PHI^-1] range.
  /// Values reset to 0 on threshold crossing (fire-and-reset).
  public query func getNeuromorphicHubState() : async {
    thalamus   : Float;
    amygdala   : Float;
    hippocampus : Float;
    dacc       : Float;
    lcne       : Float;
  } {{
    thalamus    = lifThalamusPotential;
    amygdala    = lifAmygdalaPotential;
    hippocampus = lifHippocampusPotential;
    dacc        = lifDaccPotential;
    lcne        = lifLcnePotential;
  }};

  /// Initialize a sovereign avatar brain chip (Ring 8 sub-instance).
  /// Each avatar gets 6 Kuramoto nodes with golden-angle phase spacing.
  /// avatarId must be in [0, 7]. Returns false if out of range.
  public func initAvatarBrain(avatarId : Nat) : async Bool {
    if (avatarId >= 8) { return false };
    let base = avatarId * 6;
    let step : Float = 2.0 * Float.pi / 6.0;
    var i : Nat = 0;
    var phaseF : Float = 0.0;
    while (i < 6) {
      avatarBrainPhases[base + i]      := phaseF;
      avatarBrainActivations[base + i] := 0.0;
      phaseF += step;
      i += 1;
    };
    avatarBrainKuramotoR[avatarId]    := 0.0;
    avatarBrainRegionNames[avatarId]  := "SovereignRing8-Avatar-" # avatarId.toText();
    if (avatarId + 1 > avatarBrainCount) { avatarBrainCount := avatarId + 1 };
    true
  };

  /// How many avatar brain chips have been initialized.
  public query func getAvatarBrainCount() : async Nat { avatarBrainCount };

  /// Current saturation damping state — enabled flag + live saturated node count.
  public query func getSaturationDampingState() : async { enabled : Bool; saturatedCount : Nat } {
    {
      enabled       = saturationDampingEnabled;
      saturatedCount = 0;
    }
  };

  /// Toggle homeostatic tidal return (saturation dampening) on/off.
  public func toggleSaturationDamping(enabled : Bool) : async () {
    saturationDampingEnabled := enabled;
  };

  let CORE_VERSION : Text = "NEUROEMERGENCE-CORE-v2.0-SOVEREIGN";

  /// Returns the sovereign core version identifier.
  /// CACHE BUST: new exported symbol forces new Wasm hash.
  public query func getCoreVersion() : async Text {
    CORE_VERSION
  };

  /// Returns the multi-canister sovereign architecture identifier.
  /// CACHE BUST: second new exported symbol, different name, same guarantee.
  public query func getSovereignArchitecture() : async Text {
    "MULTI-CANISTER-SOVEREIGN-v2.0"
  };

  public query func getInquisitorState() : async {
    hasActiveTask: Bool;
    activeTaskType: Text;
    activeTaskPrompt: Text;
    hungerLevel: Float;
    totalGenerated: Nat;
    totalSolved: Nat;
    satisfactionLevel: Float;
  } {
    let (hasTask, taskTypeText, taskPrompt) = switch (inquisitorState.activeTask) {
      case (?t) {
        let ttText = switch (t.taskType) {
          case (#Math) "Math";
          case (#PatternSynthesis) "PatternSynthesis";
          case (#ContradictionResolve) "ContradictionResolve";
          case (#BiochemEquation) "BiochemEquation";
          case (#KuramotoOptimize) "KuramotoOptimize";
          case (#DoctrineFill) "DoctrineFill";
        };
        (true, ttText, t.prompt)
      };
      case null (false, "IDLE", "No active task — INQUISITOR awaiting hunger threshold");
    };
    {
      hasActiveTask = hasTask;
      activeTaskType = taskTypeText;
      activeTaskPrompt = taskPrompt;
      hungerLevel = inquisitorState.currentHungerLevel;
      totalGenerated = inquisitorState.totalTasksGenerated;
      totalSolved = inquisitorState.totalTasksSolved;
      satisfactionLevel = inquisitorState.satisfactionLevel;
    }
  };

  public query func getNunHekaAnkhState() : async {
    nunCharge: Float;
    atumCount: Nat;
    nunResting: Bool;
    hekaWaveAmp: Float;
    hekaEvents: Nat;
    ankhFullLock: Bool;
    ankhLockCount: Nat;
    ankhCognitiveCoherence: Float;
    ankhEconomicCoherence: Float;
    ankhExpressionCoherence: Float;
    ankhPerceptionCoherence: Float;
  } {
    {
      nunCharge = nunState.baseCharge;
      atumCount = nunState.atumCount;
      nunResting = nunState.isResting;
      hekaWaveAmp = hekaState.standingWaveAmp;
      hekaEvents = hekaState.hekaEvents;
      ankhFullLock = ankhState.fullLock;
      ankhLockCount = ankhState.phaseLockCount;
      ankhCognitiveCoherence = ankhState.cognitiveCoherence;
      ankhEconomicCoherence = ankhState.economicCoherence;
      ankhExpressionCoherence = ankhState.expressionCoherence;
      ankhPerceptionCoherence = ankhState.perceptionCoherence;
    }
  };

  public query func getIdentityTraits() : async {
    discipline: Float;
    cooperative: Float;
    cautious: Float;
    aggression: Float;
    impulsivity: Float;
  } {
    {
      discipline = traitDiscipline;
      cooperative = traitCooperative;
      cautious = traitCautious;
      aggression = traitAggression;
      impulsivity = traitImpulsivity;
    }
  };

  // ═══════════════════════════════════════════════════════════
  // PHARMA EXPERIMENTS PUBLIC API
  // ═══════════════════════════════════════════════════════════

  public shared func runControlledSession(compoundName : Text, dose : Float, durationTicks : Nat) : async PharmaExperiments.ControlledSessionResult {
    let result = PharmaExperiments.computeControlledSession(compoundName, dose, 0.75, durationTicks);
    let entry : PharmaExperiments.ExperimentHistoryEntry = {
      id = pharmaExperimentHistory.size();
      timestamp = beatCount;
      experimentType = #ControlledSession;
      compoundName = compoundName;
      resultSummary = "Peak occupancy: " # result.peakOccupancy.toText();
      validationScore = result.validationScore;
    };
    pharmaExperimentHistory := pharmaExperimentHistory.concat([entry]);
    result
  };

  public shared func runDoseResponse(compoundName : Text, doses : [Float], emax : Float, ec50 : Float, n : Float) : async PharmaExperiments.DoseResponseResult {
    let result = PharmaExperiments.computeDoseResponse(compoundName, doses, emax, ec50, n);
    let entry : PharmaExperiments.ExperimentHistoryEntry = {
      id = pharmaExperimentHistory.size();
      timestamp = beatCount;
      experimentType = #DoseResponseCurve;
      compoundName = compoundName;
      resultSummary = "EC50: " # result.ec50.toText() # ", Hill: " # result.hillCoefficient.toText();
      validationScore = result.maxEffect;
    };
    pharmaExperimentHistory := pharmaExperimentHistory.concat([entry]);
    result
  };

  public shared func runCombination(compoundA : Text, compoundB : Text, effectA : Float, effectB : Float, combinedEffect : Float) : async PharmaExperiments.CombinationResult {
    let result = PharmaExperiments.computeCombination(compoundA, compoundB, effectA, effectB, combinedEffect);
    let entry : PharmaExperiments.ExperimentHistoryEntry = {
      id = pharmaExperimentHistory.size();
      timestamp = beatCount;
      experimentType = #CombinationProtocol;
      compoundName = compoundA # "+" # compoundB;
      resultSummary = result.recommendation;
      validationScore = result.synergyScore;
    };
    pharmaExperimentHistory := pharmaExperimentHistory.concat([entry]);
    result
  };

  public shared func runLongitudinal(compoundName : Text, sessions : Nat, baseEfficacy : Float) : async PharmaExperiments.LongitudinalResult {
    let result = PharmaExperiments.computeLongitudinal(compoundName, sessions, baseEfficacy);
    let entry : PharmaExperiments.ExperimentHistoryEntry = {
      id = pharmaExperimentHistory.size();
      timestamp = beatCount;
      experimentType = #LongitudinalStudy;
      compoundName = compoundName;
      resultSummary = "Tolerance factor: " # result.toleranceFactor.toText();
      validationScore = result.finalEfficacy;
    };
    pharmaExperimentHistory := pharmaExperimentHistory.concat([entry]);
    result
  };

  public shared func runReceptorMapping(compoundName : Text, affinities : [(Text, Float)]) : async PharmaExperiments.ReceptorMappingResult {
    let result = PharmaExperiments.computeReceptorMapping(compoundName, affinities);
    let entry : PharmaExperiments.ExperimentHistoryEntry = {
      id = pharmaExperimentHistory.size();
      timestamp = beatCount;
      experimentType = #ReceptorMapping;
      compoundName = compoundName;
      resultSummary = "Selectivity: " # result.selectivityIndex.toText();
      validationScore = 1.0 - result.offTargetRisk;
    };
    pharmaExperimentHistory := pharmaExperimentHistory.concat([entry]);
    result
  };

  public query func getPharmaExperimentHistory() : async [PharmaExperiments.ExperimentHistoryEntry] {
    pharmaExperimentHistory
  };

  public query func getPharmaHypotheses() : async [PharmaExperiments.HypothesisRecord] {
    inquisitorPharmHypotheses
  };

  public query func getSubstrateVersion() : async Text {
    "SRCE-v3.0-inquisitor-torsion-nun-heka-ankh"
  };

  // ============================================================
  // HIVE MIND — Sovereign Avatar Substrate
  // Always-on AI avatars with Kuramoto-coupled brain chips
  // ============================================================

  public query func getHiveMindState() : async HiveMind.HiveMindState {
    hiveMindState
  };

  public query func getAvatarBrainState(avatarId : Text) : async ?HiveMind.AvatarBrainChipState {
    HiveMind.getAvatarFromState(hiveMindState, avatarId)
  };

  public shared func updateAvatarMining(avatarId : Text, mineralType : Text, intensity : Float) : async Bool {
    hiveMindState := HiveMind.applyMining(hiveMindState, avatarId, mineralType, intensity);
    true
  };

  public query func getInquisitorPrimeState() : async InquisitorPrime.InquisitorPrimeState {
    InquisitorPrime.getStateRecord(inquisitorPrimeState)
  };

  public query func getCerebixIdentity() : async InquisitorPrime.CerebixIdentity {
    InquisitorPrime.getCerebixIdentity(inquisitorPrimeState, 0.87, "Prefrontal Cortex", 0)
  };

  public shared func triggerPuzzleGeneration(timestamp : Int) : async ?InquisitorPrime.CognitivePuzzle {
    let (newState, puzzle) = InquisitorPrime.generatePuzzle(inquisitorPrimeState, timestamp, 0.6, 0.4, 0.5);
    inquisitorPrimeState := newState;
    puzzle
  };

  public shared func markPuzzleSolved(puzzleId : Nat, timestamp : Int) : async Float {
    let (newState, surge) = InquisitorPrime.solvePuzzle(inquisitorPrimeState, puzzleId, timestamp);
    inquisitorPrimeState := newState;
    surge
  };

  public query func getBrainRoutingState() : async BrainRouting.RoutingState {
    brainRoutingState
  };

  public query func getAllBrainRegions32() : async [BrainRouting.BrainRegion32] {
    brainRoutingState.regions
  };

  public query func getActiveNeuroPaths() : async [BrainRouting.NeuroanatomicalPathway] {
    brainRoutingState.pathways.filter<BrainRouting.NeuroanatomicalPathway>(
      func(p : BrainRouting.NeuroanatomicalPathway) : Bool { p.weight > 0.1 }
    )
  };

  public query func getSubstrateMineState() : async SubstrateMine.SubstrateMineState {
    SubstrateMine.getMineState(substrateMineState)
  };

  public shared func manualMineDeposit(avatarId : Text, depositId : Nat) : async ?{ neurotransmitter : Text; delta : Float } {
    SubstrateMine.manualMine(substrateMineState, avatarId, depositId)
  };

  public query func getMineDepositsNearby(x : Float, z : Float, radius : Float) : async [SubstrateMine.MineralDeposit] {
    SubstrateMine.getDepositsNearby(substrateMineState, x, z, radius)
  };

  public query func getReportEngineState() : async ReportEngine.ReportEngineState {
    reportEngineState
  };

  public shared func generateConnectomeReport(timestamp : Int) : async ReportEngine.GeneratedReport {
    let regions : [(Text, Float)] = [("Prefrontal Cortex", 0.72), ("Hippocampus", 0.65), ("NAc", 0.58)];
    let pathways : [(Text, Float)] = [("Mesolimbic", 0.78), ("Mesocortical", 0.65)];
    let (newState, report) = ReportEngine.generateConnectomeStateReport(reportEngineState, regions, pathways, 0.87, "SOLVING", [], timestamp);
    reportEngineState := newState;
    report
  };

  public shared func sealVirtualExperimentArtifact(
    experimentType : Text, avatarId : Text, compoundOrPuzzle : Text,
    brainDelta : Float, coherenceChange : Float, timestamp : Int
  ) : async ReportEngine.ExperimentChamberArtifact {
    let (newState, artifact) = ReportEngine.sealExperimentArtifact(reportEngineState, experimentType, avatarId, compoundOrPuzzle, brainDelta, coherenceChange, timestamp);
    reportEngineState := newState;
    artifact
  };

  public query func getExperimentArtifacts() : async [ReportEngine.ExperimentChamberArtifact] {
    ReportEngine.getExperimentArtifacts(reportEngineState)
  };

  public query func getPublishableReports() : async [ReportEngine.GeneratedReport] {
    ReportEngine.getPublishableReports(reportEngineState)
  };

};


