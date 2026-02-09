//
//  ViewModelStyleCancellation.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 9.02.2026.
//

// ViewModelStyleCancellation.swift
import Foundation

public enum ViewModelStyleCancellation {

    public static func run() {
        print("▶️ ViewModel-style cancellation demo started")

        let vm = ViewModel()
        vm.start()

        Task {
            try? await Task.sleep(nanoseconds: 600_000_000)
            print("🛑 cancel() from outside")
            vm.cancel()
        }
    }

    // MARK: - Demo “ViewModel”
    final class ViewModel {
        private var task: Task<Void, Never>?

        func start() {
            task = Task {
                do {
                    for i in 1...10 {
                        try Task.checkCancellation()
                        print("tick \(i)")
                        try await Task.sleep(nanoseconds: 200_000_000)
                        try Task.checkCancellation()
                    }
                } catch is CancellationError {
                    print("🛑 ViewModel task cancelled (CancellationError)")
                } catch {
                    print("⚠️ unexpected error: \(error)")
                }
            }
        }

        func cancel() {
            task?.cancel()
        }
    }
}
