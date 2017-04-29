import PackageDescription

let package = Package(
    name: "VinXML",
    dependencies: [
        .Package(url: "https://github.com/vincode-io/Clibxml2.git", majorVersion: 1)
    ]
)
