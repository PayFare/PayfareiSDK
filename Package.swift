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
