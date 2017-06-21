// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "protobuf-server",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/apple/swift-protobuf.git", Version(0,9,903))
    ]
)
