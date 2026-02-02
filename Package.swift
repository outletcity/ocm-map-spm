// swift-tools-version:5.7
import PackageDescription

let unityFrameworkXCFramework = Target.binaryTarget(
  name: "UnityFramework",
  url: "https://github.com/outletcity/ocm-map-spm/releases/download/3.37.1/UnityFramework.xcframework.zip",
  checksum: "6646057d00f8e97faeff4f747f71a35ca1de5af9e06a5e915a02e0c0c3f77831"
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
