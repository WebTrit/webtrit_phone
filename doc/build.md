# Build Instructions

This document provides commands for building the Flutter application for different platforms.

## Table of Contents
- [Android](#android)
- [iOS](#ios)
- [Web](#web)
- [Notes](#notes)

## Android

To build an Android release app bundle, use the following command:

```bash
WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH=<path to keystore folder> && \
flutter build appbundle --dart-define-from-file=dart_define.json
```

- Ensure that `WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` is set correctly.
- The `dart_define.json` file should contain all necessary environment variables.

## iOS

To build an iOS release IPA, run:

```bash
flutter build ipa --dart-define-from-file=dart_define.json
```

- Make sure you have configured the necessary provisioning profiles and signing certificates.

## Web

To build the web version of the application, use:

```bash
flutter build web --dart-define-from-file=dart_define.json

dart run tool/extenvsubst.dart dart_define.json build/web/index.html
```

- The `extenvsubst.dart` script processes environment variables inside `index.html` after the build completes.

---

## Notes
- Ensure Flutter and all necessary dependencies are properly installed.
- Use `flutter clean` before rebuilding if issues arise.
- If using Firebase, verify that configurations are correctly set for each platform.

