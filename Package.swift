// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "yttrium",
    platforms: [
        .macOS(.v14),
        .iOS(.v13),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "Yttrium",
            targets: ["Yttrium"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/thebarndog/swift-dotenv.git", from: "2.0.0")
    ],
    targets: [
        .binaryTarget(
            name: "RustXcframework",
            url: "https://github.com/reown-com/yttrium/releases/download/0.22.0/RustXcframework.xcframework.zip",
            checksum: "09f6bab3fbfee5227f6929a4fa39e26a777aaf4177f1398601e47ca818b761e8"
        ),
        .target(
            name: "YttriumCore",
            dependencies: [
                "RustXcframework"
            ],
            path: "crates/ffi/YttriumCore/Sources/YttriumCore"
        ),
        .target(
            name: "Yttrium",
            dependencies: [
                "YttriumCore",
                .product(name: "SwiftDotenv", package: "swift-dotenv")
            ],
            path: "platforms/swift/Sources/Yttrium"
        ),
        .testTarget(
            name: "YttriumTests",
            dependencies: [
                "Yttrium",
                .product(name: "SwiftDotenv", package: "swift-dotenv")
            ],
            path: "platforms/swift/Tests/YttriumTests"
        ),
    ]
)
