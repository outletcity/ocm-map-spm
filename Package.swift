// swift-tools-version:5.7
import PackageDescription

let unityFrameworkXCFramework = Target.binaryTarget(
  name: "UnityFramework",
  url: "https://github.com/outletcity/ocm-map-spm/releases/download/3.33.0/UnityFramework.xcframework.zip",
  checksum: "f7f402fd7cdf34e4f4618e0c68168342a010fc292ef801c32af0c7fcd2f9deb4"
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
