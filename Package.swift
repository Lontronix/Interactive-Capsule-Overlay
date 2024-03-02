// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InteractiveCapsuleOverlay",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "InteractiveCapsuleOverlay",
            targets: ["InteractiveCapsuleOverlay"]),
    ], 
    dependencies: [
        .package(url: "https://github.com/EmergeTools/Pow", from: .init(1, 0, 0)),
        .package(url: "https://github.com/davedelong/time", from: .init(1, 0, 0))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "InteractiveCapsuleOverlay",
            dependencies: [
                .product(name: "Time", package: "time"),
                .product(name: "Pow", package: "Pow")
            ]
        ),
        .testTarget(
            name: "InteractiveCapsuleOverlayTests",
            dependencies: ["InteractiveCapsuleOverlay"]
        )
    ]
)
