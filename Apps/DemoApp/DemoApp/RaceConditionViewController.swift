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

        run()
    }

    private func run() {
        let iterations = 200_000

        for i in 1...5 {
            let broken = RaceRunner.runBroken(iterations: iterations)
            Log.info("Run \(i) | Broken: \(broken) / \(iterations)")
        }

        Task {
            for i in 1...5 {
                let lock = RaceRunner.runLockBased(iterations: iterations)
                let queue = RaceRunner.runSerialQueue(iterations: iterations)
                let actor = await RaceRunner.runActor(iterations: iterations)

                Log.info("Run \(i) | Lock: \(lock) | Queue: \(queue) | Actor: \(actor) / \(iterations)")
            }
        }
    }
}
