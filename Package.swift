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
            name: "SwiftJS",
            targets: ["SwiftJS"]
        )
    ],
    targets: [
        .target(
            name: "SwiftJS",
            resources: [
                .process("Resources")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
