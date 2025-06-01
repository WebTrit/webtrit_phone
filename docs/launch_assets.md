# Assets Configuration

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Generating Both Launcher Icons and Splash Screen](#generating-both-launcher-icons-and-splash-screen)
- [Generating Launcher Icons Only](#generating-launcher-icons-only)
- [Generating Splash Screen Only](#generating-splash-screen-only)
- [Summary of Makefile Commands](#summary-of-makefile-commands)
- [Configuration File Examples](#configuration-file-examples)

## Overview

This document explains how to configure and generate launcher icons and the splash screen for your Flutter project using
`Makefile` commands.

## Prerequisites

- Ensure that `make` is installed on your system.
- Flutter and Dart must be installed and properly configured.
- Required configuration files are stored in:
    - `flutter_launcher_icons.yaml`
    - `flutter_native_splash.yaml`

These configuration files should be located at:

```
/Users/serdun/Documents/work/webtrit/webtrit_phone/tool/configs
```

## Generating Both Launcher Icons and Splash Screen

You can generate both launcher icons and the splash screen at once using:

```sh
make generate-assets
```

This command will:

1. Add [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) and [
   `flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) as development dependencies.
2. Use the predefined configuration files to generate assets.
3. Apply the changes automatically to the Flutter project.

## Generating Launcher Icons Only

If you need to generate only the launcher icons, use:

```sh
make generate-launcher-icons
```

This command will:

- Add [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) to `dev_dependencies`.
- Run `dart run flutter_launcher_icons:generate` using the configuration file at
  `/Users/serdun/Documents/work/webtrit/webtrit_phone/tool/configs/flutter_launcher_icons.yaml`.

## Generating Splash Screen Only

If you need to generate only the splash screen, use:

```sh
make generate-native-splash
```

This command will:

- Add [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) to `dev_dependencies`.
- Run `dart run flutter_native_splash:create` using the configuration file at
  `/Users/serdun/Documents/work/webtrit/webtrit_phone/tool/configs/flutter_native_splash.yaml`.

## Summary of Makefile Commands

| Command                        | Description                                     |
|--------------------------------|-------------------------------------------------|
| `make generate-assets`         | Generates both launcher icons and splash screen |
| `make generate-launcher-icons` | Generates launcher icons only                   |
| `make generate-native-splash`  | Generates splash screen only                    |

These commands automate the configuration process and ensure that assets are generated correctly without requiring
manual file modifications.

## Configuration File Examples

### `flutter_launcher_icons.yaml`

```yaml
flutter_launcher_icons:
  # Enables launcher icon generation for Android.
  android: true

  # Specifies the location of the launcher icon image for Android.
  image_path_android: "tool/assets/launcher_icons/android.png"

  # Sets the minimum Android SDK version required for adaptive icons.
  min_sdk_android: 23

  # Sets the background color for the adaptive icon on Android.
  adaptive_icon_background: "#123752"

  # Specifies the foreground image for the adaptive icon on Android.
  adaptive_icon_foreground: "tool/assets/launcher_icons/ic_foreground.png"

  # Enables launcher icon generation for iOS.
  ios: true

  # Specifies the location of the launcher icon image for iOS.
  image_path_ios: "tool/assets/launcher_icons/ios.png"

  web:
    # Enables launcher icon generation for web.
    generate: true

    # Specifies the location of the launcher icon image for web.
    image_path: "tool/assets/launcher_icons/web.png"

    # Sets the background color for the web manifest.
    background_color: "#FFFFFF"

    # Sets the theme color for the web manifest.
    theme_color: "#F3F5F6"
```

### `flutter_native_splash.yaml`

```yaml
flutter_native_splash:
  # Sets the background color of the splash screen. This should be a hexadecimal color code.
  color: "#123752"

  # Specifies the image to be used as the splash screen icon. The image must be a PNG file.
  image: "tool/assets/native_splash/image.png"

  android_12:
    # Sets the background color for the splash screen on Android 12 and later.
    color: "#123752"
```

These configuration files define how launcher icons and splash screens are generated for different platforms.

