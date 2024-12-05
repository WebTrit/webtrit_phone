# webtrit_phone

WebTrit Phone application.

## Variables

### Dart define

* `WEBTRIT_APP_LINK_DOMAIN` - domain used to set up [Android app links](https://docs.flutter.dev/cookbook/navigation/set-up-app-links) and [iOS universal links](https://docs.flutter.dev/cookbook/navigation/set-up-universal-links) (to generate the required `.well-known` files, use the `assetlinks-generate` command from [webtrit_phone_tools](https://github.com/WebTrit/webtrit_phone_tools)
* `WEBTRIT_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_APP_DESCRIPTION` (_default is empty_)
* `WEBTRIT_APP_CORE_URL` (_optional_)
* `WEBTRIT_APP_DEMO_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_APP_CORE_VERSION_CONSTRAINT` (_default **">=0.7.0-alpha <2.0.0"**_)
* `WEBTRIT_APP_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_APP_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_APP_DATABASE_LOG_STATEMENTS` (_default **false**_)

Default build variables located in [dart_define.json](dart_define.json) and could be add to `flutter` `run` or `build` with `--dart-define-from-file=dart_define.json` parameter.

### Environment

* `WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` - path to folder structure created by `keystore-generate` command of [webtrit_phone_tools](https://github.com/WebTrit/webtrit_phone_tools) (KeystoreGenerator)


### SSL Certificates
To use SSL certificates, you need to: 
1. add the following files to the `assets/certificates` folder
2. for PKCS12 add passwords to the `assets/certificates/credentials.json` where the key is the file name and the value is the password
2. run flutter_gen or buid_runner to generate the necessary code

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


## Application Configuration

### 1. Theme Settings
For guidance on configuring themes in your application, refer to the [Theme Settings](doc/theme_config/index.md) documentation.

### 2. Custom Login Setup
To learn how to configure and customize the login process, please consult the [Custom Login Setup](doc/custom_login/index.md) guide.

### 3. Custom Bottom Menu
To configure the bottom menu according to your application’s needs, refer to the [Bottom Menu Configuration](doc/bottom_menu_config/index.md) guide. 

## Make commands
* `run` - Run the Flutter application
  ```bash
  make run
  ```

* `build` - Build the Flutter application
  ```bash
  make build
  ```

* `configure` - Configure application resources
  ```bash
  make configure id=<application_id>
  ```
  
* `configure-demo` - Create demo configuration
  ```bash
  make configure-demo id=<application_id>
  ```

* `configure-classic` - Create demo configuration
  ```bash
  make configure-classic id=<application_id>
  ```

* `build-ios` - Create iOS build
  ```bash
  make build-ios
  ```

* `build-apk` - Create APK build
  ```bash
  make build-apk
  ```

* `build-appbundle` - Create App Bundle build
  ```bash
  make build-appbundle
  ```

* `clean-git` - Clean git files
  ```bash
  make clean-git
  ```

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
