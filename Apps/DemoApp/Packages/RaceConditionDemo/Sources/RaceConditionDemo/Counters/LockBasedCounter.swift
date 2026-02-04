//
//  LockBasedCounter.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 4.02.2026.
//

import Foundation

/// Thread-safe using NSLock.
public final class LockBasedCounter: @unchecked Sendable {
    private var value: Int = 0
    private let lock = NSLock()

    public init() {}

    public func increment() {
        lock.lock()
        value += 1
        lock.unlock()
    }

    public func current() -> Int {
        lock.lock()
        let v = value
        lock.unlock()
        return v
    }
}
