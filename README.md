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

## Localizely

### Preparation

- Install the [Localizely CLI](https://github.com/localizely/localizely-cli#install).

### Workflow

Follow these steps according to your specific activity to manage the localization of your application efficiently.

#### Developing

1. Add, update, or remove the necessary key(s) in `lib/l10n/arb/app_en.arb`.
1. Push the key(s) to [Localizely](https://localizely.com) using the command: `localizely-cli push`.
1. If necessary, translate the key(s) on the [Localizely](https://localizely.com) platform, ensuring to remove helper tags from the key(s).
1. Pull the key(s) from [Localizely](https://localizely.com) using the command: `localizely-cli pull`.
1. Generate the localizations with the command: `flutter gen-l10n`.
1. Commit the changes.

#### Refinement

1. Pull the key(s) from [Localizely](https://localizely.com) using the command: `localizely-cli pull`.
1. Generate the localizations with the command: `flutter gen-l10n`.
1. Commit the changes.

#### Adding a New Locale

1. Add the new locale to the `download files` list in `localizely.yml`.
1. Insert `locale_<locale code>` in `lib/l10n/arb/app_en.arb`.
1. Push the newly added key to [Localizely](https://localizely.com) using the command: `localizely-cli push`.
1. Translate the added key on the [Localizely](https://localizely.com) platform, remembering to remove helper tags from the key(s).
1. Pull the newly added key from [Localizely](https://localizely.com) using the command: `localizely-cli pull`.
1. Generate the localizations with the command: `flutter gen-l10n`.
1. Commit the changes.

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
