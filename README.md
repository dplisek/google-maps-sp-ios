# Google Maps Swift Package for iOS

Google doesn't yet provide Google Maps as a package for Swift Package Manager. This repository re-links and packages Google-provided binaries into xcframeworks, and exposes the xcframeworks as a Swift package.

## Usage

To use Google Maps, add this repository as a Swift Package Manager dependency to your project.

## Updating

If a new version of Google-provided binaries gets released, this repository should be updated:

1. Download `Google Maps` and `Google Places` releases.

2. Inside the downloaded releases, find and extract the following frameworks, placing them in the `GoogleFrameworks/` folder of this repository:
- GoogleMaps.xcframework
- GoogleMapsBase.xcframework
- GoogleMapsCore.xcframework
- GooglePlaces.xcframework

3. Open `GoogleMaps.xcodeproj`. Check the file structure inside the project. The files in the project structure are pointed at files inside the `GoogleFrameworks/` folder, which have just been put in place in the previous step. Make sure that the files correspond, and perform any updates of the project file structure accordingly. Make sure that the file attributes stay consistent, e.g. when adding new headers, make sure that the headers are added to the same target as the existing headers, and that they are also marked as public.

4. Open `GoogleMaps-Sim.xcodeproj`, which is structurally very similar, but points to a different set of files in the `GoogleFrameworks/` folder. Perform the same respective checks.

5. Run `make_xcframeworks.sh`. There should be 8 occurances of the phrase `ARCHIVE SUCCEEDED` in the output of the command.

6. Make sure that the `Build/` folder contains four xcframeworks when the script finishes.

When these updates are done and commited, the package now exposes updated xcframeworks, and the repository should be marked with a new tag, corresponding to the version of the Google-provided binaries.
