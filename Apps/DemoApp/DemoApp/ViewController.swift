//
//  ViewController.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import UIKit
import CoreLogging
import CoreBenchmarks
import RaceConditionDemo

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let iterations = 10_000
//
//        let broken = RaceRunner.runBroken(iterations: iterations) //unsafe
//        let lock = RaceRunner.runLockBased(iterations: iterations) //thread safe
//        let queue = RaceRunner.runSerialQueue(iterations: iterations) //thread safe
//
//        Log.info("Broken: \(broken) / \(iterations)")
//        Log.info("Lock:   \(lock) / \(iterations)")
//        Log.info("Queue:  \(queue) / \(iterations)")
//
//        Task {
//            let actor = await RaceRunner.runActor(iterations: iterations) //thread safe
//            Log.info("Actor:  \(actor) / \(iterations)")
//        }
        
        //Amaç: aynı anda çok erişim yaratıp TSAN’ın data race’i yakalamasını garanti etmek.
        let iterations = 200_000
        for i in 1...5 {
            let lock = RaceRunner.runLockBased(iterations: iterations)
            let queue = RaceRunner.runSerialQueue(iterations: iterations)
            Log.info("Lock:  \(lock) / \(iterations)")
            Log.info("Queue: \(queue) / \(iterations)")

            Task {
                let actor = await RaceRunner.runActor(iterations: iterations)
                Log.info("Actor: \(actor) / \(iterations)")
            }
        }
    }
}
