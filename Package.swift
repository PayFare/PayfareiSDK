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
            targets: ["PayfareiSDK"]),
           // targets: ["PayfareiOSSDK", "PayfareiSDK"]),
    ],
    dependencies: [
    ],
    targets: [
       // .target(name: "PayfareiOSSDK"),
//        .target(
//            name: "PayfareiOSSDK",
//            dependencies: [.byName(name: "PayfareiSDK")]),
//        .testTarget(
//            name: "PayfareiOSSDKTests",
//            dependencies: ["PayfareiOSSDK"]),
        .binaryTarget(
                    name: "PayfareiSDK",
                    path: "Sources/Framework/PayfareiSDK.xcframework"
                ),
    ]
)
