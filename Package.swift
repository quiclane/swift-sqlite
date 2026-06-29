// swift-tools-version:5.9
import PackageDescription

// swift-sqlite — prebuilt SQLite as a binary XCFramework for macOS, iOS, and
// the iOS Simulator. Add it in Xcode via:  File ▸ Add Package Dependencies… and
// paste this repo's URL, then add the "SQLite" library to your target.
let package = Package(
    name: "swift-sqlite",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
    ],
    products: [
        .library(name: "SQLite", targets: ["SQLite"]),
    ],
    targets: [
        // Static-library XCFramework with sqlite3.h + a `SQLite` module map, so
        // it works from both Swift (`import SQLite`) and Objective-C/C
        // (`#import <sqlite3.h>` / `@import SQLite;`).
        .binaryTarget(name: "SQLite", path: "SQLite.xcframework"),
    ]
)
