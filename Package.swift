// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmfiBaasSDK",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "EmfiBaasSDK",
            targets: ["EmfiBaasSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
                    name: "EmfiBaasSDK",
                    path: "Sources/Framework/EmfiBaasSDK.xcframework"
                ),
    ]
)
