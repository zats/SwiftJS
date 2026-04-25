// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SwiftJS",
    platforms: [
        .iOS("26.1")
    ],
    products: [
        .library(
            name: "SwiftJSCore",
            targets: ["SwiftJSCore"]
        ),
        .library(
            name: "SwiftJS",
            targets: ["SwiftJS"]
        ),
        .library(
            name: "SwiftJSLocation",
            targets: ["SwiftJSLocation"]
        ),
        .library(
            name: "SwiftJSCalendar",
            targets: ["SwiftJSCalendar"]
        )
    ],
    targets: [
        .target(
            name: "SwiftJSCore"
        ),
        .target(
            name: "SwiftJS",
            dependencies: ["SwiftJSCore"],
            exclude: ["Package"],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "SwiftJSLocation",
            dependencies: ["SwiftJSCore"],
            exclude: ["Package"]
        ),
        .target(
            name: "SwiftJSCalendar",
            dependencies: ["SwiftJSCore"],
            exclude: ["Package"]
        )
    ],
    swiftLanguageModes: [.v6]
)
