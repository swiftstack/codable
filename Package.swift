// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Codable",
    products: [
        .library(name: "Codable", targets: ["Codable"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-stack/test.git",
            .branch("master"))
    ],
    targets: [
        .target(
            name: "Codable",
            dependencies: []),
        .testTarget(
            name: "CodableTests",
            dependencies: ["Test", "Codable"])
    ]
)
