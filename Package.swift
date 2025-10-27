// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-vortex",
  products: [],
  dependencies: [
    // .package(url: "https://github.com/apple/swift-collections.git", from: "1.3.0")
  ],
  targets: [
    .target(
      name: "Vortex",
      dependencies: ["VortexHTML"]
    ),
    .target(
      name: "VortexHTML", 
      // dependencies: [.product(name: "OrderedCollections", package: "swift-collections")]
    ),
    .target(
      name: "VortexDOM",
      dependencies: ["Vortex"]
    ),
    .testTarget(
      name: "VortexTests",
      dependencies: ["Vortex", "VortexHTML"]
    )
  ]
)
