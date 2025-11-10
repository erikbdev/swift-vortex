// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-vortex",
  platforms: [.macOS(.v14), .iOS(.v14)],
  products: [],
  dependencies: [
    .package(url: "https://github.com/swiftwasm/JavaScriptKit", revision: "0.36.0")
  ],
  targets: [
    .target(
      name: "VortexHTML",
      dependencies: [
        .product(name: "JavaScriptKit", package: "JavaScriptKit", condition: .when(platforms: [.wasi]))
      ]
    ),
    .testTarget(
      name: "VortexTests",
      dependencies: ["VortexHTML"]
    ),
  ]
)
