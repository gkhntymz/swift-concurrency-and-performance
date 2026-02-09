//
//  DemoItem.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 5.02.2026.
//

import Foundation

enum DemoItem: Int, CaseIterable {
    case cancellationBasics
    case cooperativeCancellation
    case viewModelStyleCancellation

    var title: String {
        switch self {
        case .cancellationBasics:
            return "Cancellation Basics"
        case .cooperativeCancellation:
            return "Cooperative Cancellation"
        case .viewModelStyleCancellation:
            return "ViewModel-style Cancellation"
        }
    }

    func run() {
        switch self {
        case .cancellationBasics:
            CancellationBasics.run()
        case .cooperativeCancellation:
            CooperativeCancellation.run()
        case .viewModelStyleCancellation:
            ViewModelStyleCancellation.run()
        }
    }
}
