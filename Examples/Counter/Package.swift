// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Counter",
  products: [],
  dependencies: [
    .package(path: "../../")
  ],
  targets: [
    .target(name: "App"),
    .target(name: "Server"),
    .target(name: "Shared"),
  ]
)
