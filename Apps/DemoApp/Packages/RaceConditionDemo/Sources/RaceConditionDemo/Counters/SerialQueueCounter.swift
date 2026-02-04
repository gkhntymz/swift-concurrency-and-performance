//
//  SerialQueueCounter.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 4.02.2026.
//

import Foundation

/// Thread-safe using a private serial queue.
public final class SerialQueueCounter: @unchecked Sendable {
    private var value: Int = 0
    private let queue = DispatchQueue(label: "race-condition-demo.serial-queue-counter")

    public init() {}

    public func increment() {
        queue.sync {
            value += 1
        }
    }

    public func current() -> Int {
        queue.sync { value }
    }
}
