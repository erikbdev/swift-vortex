// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Counter",
  products: [],
  dependencies: [
    .package(path: "../../"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0"),
  ],
  targets: [
    .target(name: "App"),
    .target(name: "Server", dependencies: [.product(name: "Hummingbird", package: "hummingbird")]),
    .target(name: "Shared"),
  ]
)
