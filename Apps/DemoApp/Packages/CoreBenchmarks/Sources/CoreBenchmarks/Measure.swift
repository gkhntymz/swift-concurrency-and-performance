//
//  Measure.swift
//  CoreBenchmarks
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import Foundation

public struct MeasureResult: Sendable {
    public let label: String
    public let iterations: Int
    public let totalSeconds: Double
    public let avgMicroseconds: Double
}

public enum Measure {
    public static func time(label: String, iterations: Int = 1, _ work: () -> Void) -> MeasureResult {
        precondition(iterations > 0)

        let start = CFAbsoluteTimeGetCurrent()
        for _ in 0..<iterations { work() }
        let end = CFAbsoluteTimeGetCurrent()

        let total = end - start
        let avgMicro = (total / Double(iterations)) * 1_000_000

        return MeasureResult(label: label,
                             iterations: iterations,
                             totalSeconds: total,
                             avgMicroseconds: avgMicro)
    }
}
