//
//  CancellationBasics.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 9.02.2026.
//

import Foundation

import Foundation

public enum CancellationBasics {

    public static func run() {
        print("▶️ CancellationBasics.run()")

        let task = Task {
            for i in 1...10 {
                print("working \(i)")
                try await Task.sleep(nanoseconds: 200_000_000)
            }
            print("✅ finished without cancellation")
        }

        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            print("🛑 cancelling task")
            task.cancel()

            do {
                try await task.value
                print("⚠️ task completed even after cancel (unexpected)")
            } catch is CancellationError {
                print("✅ task cancelled (CancellationError)")
            } catch {
                print("❌ unexpected error: \(error)")
            }
        }
    }
}
