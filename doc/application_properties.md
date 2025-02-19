# Configure Application Properties (Bundle ID, App Name)

## Renaming the Application

To update the package name, bundle ID, and application name for Android and iOS, run the following command:

```sh
make rename-package PACKAGE_NAME=com.webtrit.app BUNDLE_ID=com.webtrit.app ANDROID_APP_NAME="WebTrit" IOS_APP_NAME="WebTrit"
```

## Script Dependencies

This script is based on the [`package_rename`](https://pub.dev/packages/package_rename) package, which facilitates renaming default fields for each platform project within the WebTrit Phone application.

