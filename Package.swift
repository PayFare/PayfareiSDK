// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmfiBaasiSDK",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "EmfiBaasiSDK",
            targets: ["EmfiBaasiSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
                    name: "EmfiBaasiSDK",
                    path: "Sources/Framework/EmfiBaasiSDK.xcframework"
                ),
    ]
)
