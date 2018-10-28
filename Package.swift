// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TicTacToe",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "TicTacToeCore",
      targets: ["TicTacToeCore"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/Quick/Quick.git", from: "1.3.2"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0"),
    .package(url: "https://github.com/mattmusc/Mustard", .branch("master")),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "TicTacToe",
      dependencies: [
        "TicTacToeCore",
      ]),
    .target(
      name: "TicTacToeCore",
      dependencies: [
        "Mustard",
      ]),
    .testTarget(
      name: "TicTacToeCoreTests",
      dependencies: [
        "TicTacToeCore",
        "Quick", "Nimble"
      ]),
  ]
)
