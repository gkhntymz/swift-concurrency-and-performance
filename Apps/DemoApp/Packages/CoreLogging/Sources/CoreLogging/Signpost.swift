//
//  Signpost.swift
//  CoreLogging
//
//  Created by Gökhan Taymaz on 2.02.2026.
//

import Foundation
import os

public enum Signpost {
    private static let log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "swift-concurrency-and-performance",
                                   category: "performance")

    /// Time Profiler / Instruments'ta aralık ölçmek için kullanılır.
    @discardableResult
    public static func begin(_ name: StaticString) -> OSSignpostID {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: name, signpostID: id)
        return id
    }

    public static func end(_ name: StaticString, id: OSSignpostID) {
        os_signpost(.end, log: log, name: name, signpostID: id)
    }

    /// Scoped kullanım: otomatik end
    public static func scoped<T>(_ name: StaticString, _ work: () throws -> T) rethrows -> T {
        let id = begin(name)
        defer { end(name, id: id) }
        return try work()
    }
}
