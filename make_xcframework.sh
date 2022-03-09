#!/bin/bash

BUILD_DIRECTORY="Build"
CARTHAGE_XCFRAMEWORK_DIRECTORY="Carthage/Build/"

function archive_project() {
  project_name=$1
  framework_name=$2
  
  # Archive iOS project.
  xcodebuild archive\
    -project "../$project_name.xcodeproj"\
    -scheme "$framework_name"\
    -configuration "Release"\
    -destination "generic/platform=iOS"\
    -archivePath "$framework_name.framework-iphoneos.xcarchive"\
    SKIP_INSTALL=NO\
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
  # Archive iOS Simulator project.
  xcodebuild archive\
    -project "../$project_name-Sim.xcodeproj"\
    -scheme "$framework_name"\
    -configuration "Simulator Release"\
    -destination "generic/platform=iOS Simulator"\
    -archivePath "$framework_name.framework-iphonesimulator.xcarchive"\
    SKIP_INSTALL=NO\
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
}

function create_xcframework() {
  project_name=$1
  framework_name=$2
  
  # Archive Xcode project.
  archive_project $project_name $framework_name
  
  # Create XCFramework from the archived project.
  xcodebuild -create-xcframework\
    -framework "$framework_name.framework-iphoneos.xcarchive/Products/Library/Frameworks/$framework_name.framework"\
    -framework "$framework_name.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$framework_name.framework"\
    -output "$framework_name.xcframework"
}

function prepare() {
  # Install Google Maps SDK for iOS.
  carthage bootstrap
  
  # Recreate Build directory.
  if [ -d "$BUILD_DIRECTORY" ]; then
    rm -r $BUILD_DIRECTORY
  fi
  mkdir $BUILD_DIRECTORY
}

function cleanup() {
  rm -r *.xcarchive
}

function print_completion_message() {
  echo $'\n** XCFRAMEWORK CREATION FINISHED **\n'
}

function build_xcproject_project() {
  prepare
  
  cd $BUILD_DIRECTORY
  
  create_xcframework "GoogleMaps" "GoogleMaps"
  create_xcframework "GoogleMaps" "GoogleMapsBase"
  create_xcframework "GoogleMaps" "GoogleMapsCore"
  create_xcframework "GoogleMaps" "GoogleMapsM4B"
  create_xcframework "GoogleMaps" "GooglePlaces"
  
  cleanup
}

build_xcproject_project
print_completion_message
