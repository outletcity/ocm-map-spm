// swift-tools-version:5.7
import PackageDescription

let unityFrameworkXCFramework = Target.binaryTarget(
  name: "UnityFramework",
  url: "https://github.com/outletcity/ocm-map-spm/releases/download/3.41.7/UnityFramework.xcframework.zip",
  checksum: "3b913669873d3cce1d4162044682b857aa1b1f346e00b571e36d203e7b59002d"
)

let package = Package(
    name: "UnityMapFramework",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "UnityMapFramework",
            targets: ["UnityFramework", "UnityFrameworkStub"])
    ],
    targets: [
        unityFrameworkXCFramework,

        // Without at least one regular (non-binary) target, this package doesn't show up
        // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
        // LinkKit from being embedded in the app product, causing the app to crash when
        // ran on a physical device. As a workaround, we can include a stub target
        // with at least one source file.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(name: "UnityFrameworkStub", path: "Sources", resources: [.copy("Resources/PrivacyInfo.xcprivacy")]),
    ]
)
