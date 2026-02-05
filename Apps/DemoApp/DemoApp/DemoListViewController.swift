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

    private let demos: [DemoItem] = DemoItem.allCases

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
        demos.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let item = demos[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DemoCell",
            for: indexPath
        )

        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - UITableViewDelegate
extension DemoListViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = demos[indexPath.row]
        switch item {
        case .raceCondition:
            navigationController?.pushViewController(
                RaceConditionViewController.make(),
                animated: true
            )
        }
    }
}
