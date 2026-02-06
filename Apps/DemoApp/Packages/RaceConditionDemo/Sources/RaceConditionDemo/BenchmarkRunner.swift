//
//  BenchmarkRunner.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 6.02.2026.
//

import Foundation
import CoreBenchmarks

public enum BenchmarkRunner {

    public struct Result: Sendable {
        public let label: String
        public let elapsedMs: Double

        public init(label: String, elapsedMs: Double) {
            self.label = label
            self.elapsedMs = elapsedMs
        }
    }

    /// Benchmarks synchronous counters (lock / serial queue) using the same workload.
    public static func benchmarkSync(iterations: Int) -> [Result] {
        var results: [Result] = []

        let lockMs = Measure.elapsedMs {
            _ = RaceRunner.runLockBased(iterations: iterations)
        }
        results.append(.init(label: "Lock", elapsedMs: lockMs))

        let queueMs = Measure.elapsedMs {
            _ = RaceRunner.runSerialQueue(iterations: iterations)
        }
        results.append(.init(label: "SerialQueue", elapsedMs: queueMs))

        return results
    }

    /// Benchmarks actor-based counter (async).
    public static func benchmarkActor(iterations: Int) async -> Result {
        let ms = await Measure.elapsedMsAsync {
            _ = await RaceRunner.runActor(iterations: iterations)
        }
        return .init(label: "Actor", elapsedMs: ms)
    }
}
