// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayfareiSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PayfareiSDK",
            targets: ["PayfareiSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
                    name: "PayfareiSDK",
                    path: "Sources/Framework/PayfareiSDK.xcframework"
                ),
    ]
)
