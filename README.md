# ocm-map-spm

Provides Swift Package Manager support for ocm-map
This repository provides Swift Package Manager support for ocm-map, allowing to easily integrate the MapFramework into iOS applications.

## Why is there a separate repository for Swift Package Manager support?

The generated files are to large to be hosted as sourcecode files (> 100 MB) and Swift Package Manger does not support LFS. Therefore this repository contains a pointer the the precompiled XCFramework.