// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SwiftJS",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
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
                .process("Resources")
            ]
        ),
        .target(
            name: "SwiftJSLocation",
            dependencies: ["SwiftJSCore"]
        )
    ],
    swiftLanguageModes: [.v6]
)
