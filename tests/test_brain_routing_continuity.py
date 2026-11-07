#!/usr/bin/env python3
"""Regression gate for the live 32-region brain routing integration.

This is a SOURCE-CONTRACT check. It is intentionally not a substitute for
`mops check` or a deployed canister integration test.
"""
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]
ACTOR = ROOT / "src/backend/main.mo"
ENGINE = ROOT / "src/backend/brain_routing.mo"


class BrainRoutingContinuityContract(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.actor = ACTOR.read_text(encoding="utf-8")
        cls.engine = ENGINE.read_text(encoding="utf-8")

    def test_persistent_actor_resident(self):
        self.assertIn(
            "var brainRoutingState : BrainRouting.RoutingState = BrainRouting.initializeState();",
            self.actor,
        )
        self.assertEqual(self.actor.count("BrainRouting.initializeState()"), 1)

    def test_heartbeat_evolves_live_resident(self):
        self.assertIn("brainRoutingState := BrainRouting.runRoutingCycle(", self.actor)
        self.assertIn("brainRoutingState := BrainRouting.propagateSignal(", self.actor)
        self.assertIn("strength = clamp(0.5 * kuramotoR + 0.5 * coherenceC", self.actor)
        self.assertIn("strength = clamp(mt_memory_coherence", self.actor)

    def test_neuroanatomical_pathways_exist(self):
        self.assertRegex(
            self.engine, r"source\s*=\s*18;\s*target\s*=\s*4;"
        )
        self.assertRegex(
            self.engine, r"source\s*=\s*26;\s*target\s*=\s*1;"
        )

    def test_public_queries_use_live_state(self):
        queries = {
            "getBrainRoutingState": "brainRoutingState",
            "getAllBrainRegions32": "brainRoutingState.regions",
            "getActiveNeuroPaths": "brainRoutingState.pathways.filter",
        }
        for method, expected in queries.items():
            with self.subTest(method=method):
                m = re.search(
                    rf"public query func {method}\([^)]*\)[^{{]*\{{([\s\S]*?)\n  \}};",
                    self.actor,
                )
                self.assertIsNotNone(m, f"missing query {method}")
                self.assertIn(expected, m.group(1))
                self.assertNotIn("initializeState()", m.group(1))

    def test_engine_tracks_beat_and_coherence(self):
        self.assertIn("public func runRoutingCycle(", self.engine)
        self.assertIn("lastUpdateBeat = currentBeat", self.engine)
        self.assertIn("computeGlobalCoherence(s)", self.engine)
        self.assertIn("applyHomeostaticDampening(s, currentBeat)", self.engine)


if __name__ == "__main__":
    unittest.main()
