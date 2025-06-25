// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PetstoreClient",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .watchOS(.v8),
        .tvOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PetstoreSDK",
            targets: ["PetstoreSDK"]),
        .executable(
            name: "PetstoreApplication",
            targets: ["PetstoreApplication"]),
    ],
    targets: [
        // SDK Library Target
        .target(
            name: "PetstoreSDK",
            dependencies: []),
        // Client Executable Target
        .executableTarget(
            name: "PetstoreApplication",
            dependencies: ["PetstoreSDK"]),
    ]
)
