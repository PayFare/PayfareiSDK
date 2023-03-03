// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayfareiOSSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PayfareiOSSDK",
            targets: ["PayfareiOSSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PayfareiOSSDK",
            dependencies: [.byName(name: "PayfareiSDK")]),
        .testTarget(
            name: "PayfareiOSSDKTests",
            dependencies: ["PayfareiOSSDK"]),
        .binaryTarget(
                    name: "PayfareiSDK",
                    path: "../PayfareiSDK.xcframework"
                ),
    ]
)
