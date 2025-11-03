// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-vortex",
  platforms: [.macOS(.v14), .iOS(.v14)],
  products: [],
  dependencies: [],
  targets: [
    .target(
      name: "VortexHTML", 
    ),
    .testTarget(
      name: "VortexTests",
      dependencies: ["VortexHTML"]
    )
  ]
)
