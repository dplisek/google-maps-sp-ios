// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "GoogleMaps",
    products: [
        .library(
            name: "GoogleMapsBase",
            targets: [
                "GoogleMapsBase"
            ]
        ),
        .library(
            name: "GoogleMapsCore",
            targets: [
                "GoogleMapsCore"
            ]
        ),
        .library(
            name: "GoogleMaps",
            targets: [
                "GoogleMaps",
                "GoogleMapsBase",
                "GoogleMapsCore"
            ]
        ),
        .library(
            name: "GooglePlaces",
            targets: [
                "GooglePlaces",
                "GoogleMapsBase"
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "GoogleMaps",
            path: "Build/GoogleMaps.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMapsBase",
            path: "Build/GoogleMapsBase.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMapsCore",
            path: "Build/GoogleMapsCore.xcframework"
        ),
        .binaryTarget(
            name: "GooglePlaces",
            path: "Build/GooglePlaces.xcframework"
        )
    ]
)
