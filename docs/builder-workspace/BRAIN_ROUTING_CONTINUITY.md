# BRAIN-AI: 32-region routing continuity

The actor previously exposed `BrainRouting.initializeState()` on every read.
Those queries returned the same seed atlas rather than an evolving brain.

## Runtime change

- `brainRoutingState` is retained as actor-owned orthogonally persistent state
  alongside `neuralCordState`. No old actor state fields are deleted.
- Every `pulseAllCores()` tick feeds a bounded LC→thalamus packet derived
  from observed Kuramoto and coherence signals, plus an
  entorhinal→hippocampus packet derived from the memory-resident coherence.
- Existing thalamic gating, amygdala modulation, hippocampal theta and
  homeostatic update functions are reused rather than reconstructed.
- The three existing public query signatures are preserved, now reading
  the resident state rather than the initial state.

## Proof and limitations

Run `python3 -m unittest discover -s tests -p test_brain_routing_continuity.py -v`
for the structural regression gate. This checks the wiring, but does **not**
prove Motoko compile success, on-chain persistence, neuroscience validity,
predictive power or benchmark performance.

The 32-region model is a computational abstraction; the labels do not
constitute evidence that this system has biological brain function.
Before a production promotion, perform `mops check`, frontend bindgen,
actor upgrade-compatibility verification and a two-session canister test
showing beat increments and state continuity across upgrades.
