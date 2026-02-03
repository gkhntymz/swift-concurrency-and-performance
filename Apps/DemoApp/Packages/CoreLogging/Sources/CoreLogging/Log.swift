//
//  Log.swift
//  CoreLogging
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import Foundation
import os

public enum Log {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "swift-concurrency-and-performance",
                                       category: "app")

    public static func info(_ message: String) {
        logger.info("\(message, privacy: .public)")
    }

    public static func error(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }
}
