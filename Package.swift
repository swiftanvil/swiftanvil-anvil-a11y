// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "A11yIdentifiers",
    platforms: [.iOS(.v18), .macOS(.v15), .tvOS(.v18), .watchOS(.v11), .visionOS(.v2)],
    products: [
        .library(name: "A11yIdentifiers", targets: ["A11yIdentifiers"]),
    ],
    targets: [
        .target(name: "A11yIdentifiers"),
        .testTarget(name: "A11yIdentifiersTests", dependencies: ["A11yIdentifiers"]),
    ],
    swiftLanguageModes: [.v6]
)
