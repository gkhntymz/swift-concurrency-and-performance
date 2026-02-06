//
//  Measure.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 6.02.2026.
//

import Foundation

public enum Measure {

    /// Measures elapsed time for a synchronous block (milliseconds).
    public static func elapsedMs(_ block: () -> Void) -> Double {
        let start = DispatchTime.now().uptimeNanoseconds
        block()
        let end = DispatchTime.now().uptimeNanoseconds
        return Double(end - start) / 1_000_000.0
    }

    /// Measures elapsed time for an async block (milliseconds).
    public static func elapsedMsAsync(_ block: () async -> Void) async -> Double {
        let start = DispatchTime.now().uptimeNanoseconds
        await block()
        let end = DispatchTime.now().uptimeNanoseconds
        return Double(end - start) / 1_000_000.0
    }
}
