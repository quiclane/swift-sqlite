# swift-sqlite

Prebuilt **SQLite 3.54.0** as a binary **XCFramework** for Apple platforms,
packaged for Swift Package Manager. No build step, no system-library guessing —
add the URL and link the `SQLite` product.

## Platforms

| Slice | Architectures |
|---|---|
| macOS | arm64 + x86_64 |
| iOS (device) | arm64 |
| iOS Simulator | arm64 + x86_64 |

## Add it in Xcode

1. **File ▸ Add Package Dependencies…**
2. Paste this repository's URL.
3. Choose the version (use the immutable tag, e.g. `3.54.0`).
4. Add the **SQLite** library to your app target.

Or in a `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/quiclane/swift-sqlite.git", from: "3.54.0"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "SQLite", package: "swift-sqlite"),
    ]),
]
```

## Use it

Swift:

```swift
import SQLite

var db: OpaquePointer?
sqlite3_open(":memory:", &db)
```

Objective-C / C:

```objc
@import SQLite;          // module form
// or, with the headers on your search path:
#import <sqlite3.h>

sqlite3 *db = NULL;
sqlite3_open(":memory:", &db);
```

> Remove any `-lsqlite3` you were linking against the system SQLite — this
> package vends its own static SQLite and the two should not both be linked.

## What's in the repo

Everything is committed at the repository root so it can also be used without
SPM:

- `SQLite.xcframework/` — the binary target consumed by SPM
- `libsqlite3-macos.a`, `libsqlite3-ios.a`, `libsqlite3-iossimulator.a` — the raw static libraries
- `sqlite3.h`, `sqlite3ext.h` — public headers
- `module.modulemap` — the `SQLite` module map

## Build provenance

Built from the official [sqlite/sqlite](https://github.com/sqlite/sqlite)
source (amalgamation generated via `make sqlite3.c`) with:

```
-O2 -fPIC -DSQLITE_THREADSAFE=1
-DSQLITE_ENABLE_FTS5 -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS
-DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_JSON1
-DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_DBSTAT_VTAB
-DSQLITE_ENABLE_API_ARMOR
```

## License

SQLite is in the Public Domain. This packaging is likewise released into the
Public Domain — see [LICENSE](LICENSE).
