# Configure Application Properties (Bundle ID, App Name)

## Table of Contents

- [Using Make Commands](#commands)
- [Renaming the Application](#renaming-the-application)
- [Script Dependencies](#script-dependencies)
- [Using `package_rename` Directly](#using-package_rename-directly)
- [Variables](#variables)

## Commands

`tool/configs/package_rename_config.yaml` is written by `webtrit_phone_tools` as part of
`melos run configurator:generate`, from the brand the configurator holds. Applying it is a
separate step:

```sh
melos run package:rename
```

## Renaming the Application

To update the package name, bundle ID, and application name for Android and iOS, run the following
command:

```sh
melos run package:rename
```

The names come from the config file rather than from arguments: the same brand that a build is
made for decides them, and typing them twice is how the two disagree.

## Script Dependencies

This script is based on the [`package_rename`](https://pub.dev/packages/package_rename) package,
which facilitates renaming default fields for each platform project within the WebTrit Phone
application.

## Using `package_rename` Directly

If you prefer to use `package_rename` manually, follow these steps:

1. Add `package_rename` as a development dependency:
   ```sh
   dart pub add package_rename --dev
   ```
2. Create a `package_rename_config.yaml` file with the following content:
   ```yaml
   package_rename_config:
     android:
       app_name: "New App"
       package_name: com.webtrit.newapp
       override_old_package: com.webtrit.phone # N
       lang: kotlin
     ios:
       app_name: "New App"
       package_name: com.webtrit.newapp
   ```
3. Run the rename command:
   ```sh
   dart run package_rename
   ```

## Variables

- `PACKAGE_NAME` - Android package name
- `BUNDLE_ID` - iOS bundle ID
- `ANDROID_APP_NAME` - Android application name
- `IOS_APP_NAME` - iOS application name

These commands automate the renaming process and ensure consistent configuration across platforms.
