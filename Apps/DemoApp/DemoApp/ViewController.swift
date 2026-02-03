//
//  ViewController.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import UIKit
import CoreLogging
import CoreBenchmarks

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        Log.info("DemoApp launched")

        let result = Measure.time(label: "noop", iterations: 10000) {
            _ = 1 + 1
        }
        
        Log.info("Measure \(result.label) avg(us)=\(result.avgMicroseconds)")
        
        _ = Signpost.scoped("initial-work") {
            Thread.sleep(forTimeInterval: 0.05)
        }
    }
}
