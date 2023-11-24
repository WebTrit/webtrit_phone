# webtrit_phone

WebTrit Phone application.

## Variables

### Dart define

* `WEBTRIT_APP_ID_SUFFIX` - suffix added to `applicationId` (_with value `com.webtrit.app`_) on Android and to `CFBundleIdentifier` (_with value `com.webtrit.app`_) on iOS (_default is empty_)
* `WEBTRIT_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_APP_DESCRIPTION` (_default is empty_)
* `WEBTRIT_APP_CORE_URL` (_optional_)
* `WEBTRIT_APP_DEMO_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_APP_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_APP_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_APP_DATABASE_LOG_STATEMENTS` (_default **false**_)

Default build variables located in [dart_define.json](dart_define.json) and could be add to `flutter` `run` or `build` with `--dart-define-from-file=dart_define.json` parameter.

### Environment

* `WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` - path to folder structure created by `keystore-generate` command of [webtrit_phone_tools](https://github.com/WebTrit/webtrit_phone_tools) (KeystoreGenerator)

## Build

### Localization

##### Download ARBs
To manage localization in the WebTrit Phone application, [localizely](https://localizely.com/) is used. To download ARB (Application Resource Bundle) files for translation, use the following command:

```bash
flutter pub run intl_utils:localizely_download --project-id xxx --api-token xxx --arb-dir lib/l10n/arb
```
##### Generate localization
After obtaining the translated ARB files, you can generate the localization files using the following command:

```bash
flutter gen-l10n
```

### Android

Command line example:
```bash
WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH=<path for KeystoreGenerator created folder structure> && \
flutter build appbundle --dart-define-from-file=dart_define.json
```

### iOS

Command line example: 
```bash
flutter build ipa --dart-define-from-file=dart_define.json
```

### Web

Command line example:
```bash
flutter build web --dart-define-from-file=dart_define.json
  
dart run tool/extenvsubst.dart dart_define.json build/web/index.html
```

## Renaming

To rename the default fields for each platform project within the WebTrit Phone application, the [`package_rename`](https://pub.dev/packages/package_rename) package can be used.

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
