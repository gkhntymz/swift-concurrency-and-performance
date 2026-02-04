//
//  RaceRunner.swift
//  RaceConditionDemo
//
//  Created by Gökhan Taymaz on 3.02.2026.
//

import Foundation

public enum RaceRunner {

    public static func runBroken(iterations: Int) -> Int {
        let counter = BrokenCounter()
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            counter.increment()
        }
        return counter.current()
    }

    public static func runLockBased(iterations: Int) -> Int {
        let counter = LockBasedCounter()
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            counter.increment()
        }
        return counter.current()
    }

    public static func runSerialQueue(iterations: Int) -> Int {
        let counter = SerialQueueCounter()
        DispatchQueue.concurrentPerform(iterations: iterations) { _ in
            counter.increment()
        }
        return counter.current()
    }

    public static func runActor(iterations: Int) async -> Int {
        let counter = ActorCounter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<iterations {
                group.addTask {
                    await counter.increment()
                }
            }
        }

        return await counter.current()
    }
}
