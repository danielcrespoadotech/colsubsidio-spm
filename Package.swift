// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SMSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SMSDK",
            targets: ["SMSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/socketio/socket.io-client-swift.git", from: "16.0.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git",from: "3.5.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SMSDK",
            dependencies: [
                .product(name: "Lottie",
                         package: "lottie-ios"),
                .product(name: "SocketIO",
                         package: "socket.io-client-swift"),
                "Alamofire",
                "ScanovateManualCapture"
            ],
            exclude: ["Info.plist"],
            resources: [
                .process("Resources")
            ]
        ),
        .binaryTarget(name: "ScanovateManualCapture",
                      path: "Dependencies/ScanovateManualCapture.xcframework"),
        .testTarget(name: "SmSdkPackageTests",
                    dependencies: ["SMSDK"]),
    ],
    swiftLanguageVersions: [.v5]
)
