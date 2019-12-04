// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "RazzleDazzle",
    platforms: [
        .iOS(.v8),
    ],
    products: [
        .library(
            name: "RazzleDazzle",
            targets: ["RazzleDazzle"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RazzleDazzle",
            dependencies: [],
            path: "Source"),
    ],
    swiftLanguageVersions: [.v5]
)
