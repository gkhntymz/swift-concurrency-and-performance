//
//  CooperativeCancellation.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 9.02.2026.
//

import Foundation

public enum CooperativeCancellation {

    public static func run() {
        print("▶️ CooperativeCancellation.run()")

        let task = Task {
            try await cooperativeWork()
        }

        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            print("🛑 cancelling cooperative task")
            task.cancel()

            do {
                try await task.value
                print("⚠️ cooperative task finished without throwing (unexpected)")
            } catch is CancellationError {
                print("✅ cooperative task cancelled correctly")
            } catch {
                print("❌ unexpected error: \(error)")
            }
        }
    }

    private static func cooperativeWork() async throws {
        for i in 1...20 {
            try Task.checkCancellation()
            print("step \(i)")
            try await Task.sleep(nanoseconds: 150_000_000)
        }
        print("✅ cooperative work finished")
    }
}
