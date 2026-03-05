// swift-tools-version:5.7
import PackageDescription

let unityFrameworkXCFramework = Target.binaryTarget(
  name: "UnityFramework",
  url: "https://github.com/outletcity/ocm-map-spm/releases/download/3.38.0/UnityFramework.xcframework.zip",
  checksum: "feb977ad2aefb7b09d68a6812e0c77ad600741e7c16c8cb95d106cb903f821e3"
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
