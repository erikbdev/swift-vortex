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
      name: "Vortex",
      dependencies: ["VortexHTML"]
    ),
    .target(
      name: "VortexHTML", 
    ),
    .target(
      name: "VortexDOM",
      dependencies: ["Vortex"]
    ),
    .testTarget(
      name: "VortexTests",
      dependencies: ["Vortex"]
    )
  ]
)
