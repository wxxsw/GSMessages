// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "GSMessages",
  platforms: [
    .iOS(.v8),
  ],
  products: [
    .library(name: "GSMessages", targets: ["GSMessages"])
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "GSMessages", path: "GSMessages"),
  ]
)
