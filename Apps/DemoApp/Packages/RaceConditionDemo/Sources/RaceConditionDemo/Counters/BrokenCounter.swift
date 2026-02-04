//
//  BrokenCounter.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 3.02.2026.
//

import Foundation

/// Intentionally NOT thread-safe.
/// Used to demonstrate race conditions under concurrent access.
public final class BrokenCounter: @unchecked Sendable {
    private var value: Int = 0

    public init() {}

    public func increment() {
        value += 1
    }

    public func current() -> Int {
        value
    }
}
