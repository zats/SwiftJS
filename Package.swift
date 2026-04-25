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
            resources: [
                .copy("Package"),
                .process("Resources")
            ]
        ),
        .target(
            name: "SwiftJSLocation",
            dependencies: ["SwiftJSCore"]
        ),
        .target(
            name: "SwiftJSCalendar",
            dependencies: ["SwiftJSCore"]
        )
    ],
    swiftLanguageModes: [.v6]
)
