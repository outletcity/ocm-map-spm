// swift-tools-version:5.7
import PackageDescription

let unityFrameworkXCFramework = Target.binaryTarget(
  name: "UnityFramework",
  url: "https://github.com/outletcity/ocm-map-spm/releases/download/3.40.0/UnityFramework.xcframework.zip",
  checksum: "bc2fe6ff4a15a0064ced084b994d8c73f0563c9fbcef15f3070a0c400be75ed8"
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
