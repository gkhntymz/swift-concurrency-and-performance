//
//  ActorCounter.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 4.02.2026.
//

import Foundation

public actor ActorCounter {
    private var value: Int = 0

    public init() {}

    public func increment() {
        value += 1
    }

    public func current() -> Int {
        value
    }
}
