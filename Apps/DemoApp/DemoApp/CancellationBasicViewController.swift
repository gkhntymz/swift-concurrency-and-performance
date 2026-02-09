//
//  CancellationBasicViewController.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 9.02.2026.
//

import UIKit

final class CancellationBasicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cancellation Basics"
        view.backgroundColor = .systemBackground

        let button = UIButton(type: .system)
        button.setTitle("Run Basics", for: .normal)
        button.addTarget(self, action: #selector(didTapRun), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapRun() {
        CancellationBasics.run()
    }
}
