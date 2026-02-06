//
//  RaceConditionViewController.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 5.02.2026.
//

import UIKit
import CoreLogging
import RaceConditionDemo

final class RaceConditionViewController: UIViewController {

    static func make() -> RaceConditionViewController {
        RaceConditionViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Race Condition"
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Run", style: .plain, target: self, action: #selector(didTapRun)),
            UIBarButtonItem(title: "Benchmark", style: .plain, target: self, action: #selector(didTapBenchmark))
        ]
    }

    @objc private func didTapRun() {
        run()
    }
    
    private func run() {
        let iterations = 200_000

        // 1️⃣ Broken counter — race condition demonstration
        for i in 1...5 {
            let broken = RaceRunner.runBroken(iterations: iterations)
            Log.info("Run \(i) | Broken: \(broken) / \(iterations)")
        }

        // 2️⃣ Fixed implementations — deterministic correctness
        Task {
            for i in 1...5 {
                let lock = RaceRunner.runLockBased(iterations: iterations)
                let queue = RaceRunner.runSerialQueue(iterations: iterations)
                let actor = await RaceRunner.runActor(iterations: iterations)

                Log.info(
                    "Run \(i) | Lock: \(lock) | Queue: \(queue) | Actor: \(actor) / \(iterations)"
                )
            }
        }
    }

    @objc private func didTapBenchmark() {
        benchmark()
    }
    
    private func benchmark() {
        let iterations = 200_000

        let sync = BenchmarkRunner.benchmarkSync(iterations: iterations)
        for r in sync {
            Log.info("Benchmark | \(r.label): \(String(format: "%.2f", r.elapsedMs)) ms")
        }

        Task {
            let actor = await BenchmarkRunner.benchmarkActor(iterations: iterations)
            Log.info("Benchmark | \(actor.label): \(String(format: "%.2f", actor.elapsedMs)) ms")
        }
    }
}
