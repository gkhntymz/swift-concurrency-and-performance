// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaceConditionDemo",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "RaceConditionDemo", targets: ["RaceConditionDemo"])
    ],
    dependencies: [
        // RaceConditionDemo -> CoreBenchmarks (local package)
        .package(path: "../CoreBenchmarks")
    ],
    targets: [
        .target(
            name: "RaceConditionDemo",
            dependencies: [
                "CoreBenchmarks"
            ]
        ),
        .testTarget(
            name: "RaceConditionDemoTests",
            dependencies: ["RaceConditionDemo"]
        )
    ]
)
