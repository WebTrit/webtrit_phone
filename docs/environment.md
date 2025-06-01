## Variables

This file describes environment variables and Dart define variables used in the WebTrit application configuration.

### Dart define

* `WEBTRIT_APP_LINK_DOMAIN` - The domain used to set up [Android app links](https://docs.flutter.dev/cookbook/navigation/set-up-app-links) and [iOS universal links](https://docs.flutter.dev/cookbook/navigation/set-up-universal-links). To generate the required `.well-known` files, use the `assetlinks-generate` command from [webtrit_phone_tools](https://github.com/WebTrit/webtrit_phone_tools).
* `WEBTRIT_APP_NAME` - The application name (_default **WebTrit**_).
* `WEBTRIT_APP_DESCRIPTION` - A brief description of the application (_default is empty_).
* `WEBTRIT_APP_CORE_URL` - The URL of the WebTrit core service (_optional_).
* `WEBTRIT_APP_DEMO_CORE_URL` - The URL of the demo WebTrit core service (_default **http://localhost:4000**_).
* `WEBTRIT_APP_CORE_VERSION_CONSTRAINT` - Specifies the allowed version range for the WebTrit core service (_default **">=0.7.0-alpha <2.0.0"**_).
* `WEBTRIT_APP_PERIODIC_POLLING` - Enables or disables periodic polling for updates (_default **true**_).
* `WEBTRIT_APP_DEBUG_LEVEL` - Defines the level of debug information to be logged (_default **INFO**_).
* `WEBTRIT_APP_DATABASE_LOG_STATEMENTS` - Enables or disables logging of database statements (_default **false**_).
* `WEBTRIT_APP_FCM_VAPID_KEY` - VAPID key used for Firebase Cloud Messaging push notifications (_required for FCM_).
* `WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_URL` - URL for remote logging using Logz.io (_optional_).
* `WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_TOKEN` - Authentication token for Logz.io logging (_optional_).
* `WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_BUFFER_SIZE` - Buffer size for remote Logz.io logging (_optional_).

Default build variables are located in [dart_define.json](dart_define.json) and can be added to `flutter` `run` or `build` with the `--dart-define-from-file=dart_define.json` parameter.

### Environment

* `WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` - Path to the folder structure created by the `keystore-generate` command of [webtrit_phone_tools](https://github.com/WebTrit/webtrit_phone_tools) (KeystoreGenerator), used for Android release signing.

### Usage

These variables are used in the WebTrit application to configure runtime behavior, build settings, and security parameters for Android and iOS applications.
