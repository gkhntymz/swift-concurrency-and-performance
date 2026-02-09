//
//  DemoListViewController.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import UIKit
import CoreLogging
import CoreBenchmarks
import RaceConditionDemo

final class DemoListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let demos = DemoItem.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Demos"

        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension DemoListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DemoItem.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DemoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        demos[indexPath.row].run()
    }
}
