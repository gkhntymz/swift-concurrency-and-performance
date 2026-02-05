//
//  DemoItem.swift
//  DemoApp
//
//  Created by Gökhan Taymaz on 5.02.2026.
//

import Foundation

enum DemoItem: CaseIterable {
    case raceCondition

    var title: String {
        switch self {
        case .raceCondition: return "Race Condition"
        }
    }

    var subtitle: String {
        switch self {
        case .raceCondition: return "Broken vs Lock vs Serial Queue vs Actor (+ TSAN evidence)"
        }
    }
}
