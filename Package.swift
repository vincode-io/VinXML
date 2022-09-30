// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "VinXML",
	platforms: [.macOS(.v11), .iOS(.v14)],
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "VinXML",
			type: .dynamic,
			targets: ["VinXML"]),
	],
	targets: [
		.systemLibrary(name: "libxml2", pkgConfig: "libxml2"),
		.target(
			name: "VinXML",
			dependencies: ["libxml2"]),
		.testTarget(
			name: "VinXMLTests",
			dependencies: ["VinXML"],
			resources: [.copy("Resources")]),
	]
)
