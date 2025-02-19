# webtrit_phone

WebTrit Phone application.

### Environment
A detailed description of environment properties can be found in the [Environment](doc/environment.md) documentation.

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
A detailed description of localizely properties can be found in the [Localizely](doc/localization.md) documentation.

## Application Configuration

### 1. Colors scheme configuration
A detailed description of colors properties can be found in the [Colors scheme](doc/color_scheme.md) documentation.

### 2. Widgets configuration
To configure the widgets according to your application’s needs, refer to the [Widgets Configuration](doc/widgets_configuration.md) guide.

### 3. Pages configuration
To configure the pages according to your application’s needs, refer to the [Pages Configuration](doc/pages_configuration.md) guide.

### 4. Feature configuration
To configure the features according to your application’s needs, refer to the [Feature Configuration](doc/feature_configuration.md) guide.

## Make commands
A detailed description of make commands can be found in the [Make commands](doc/make_file.md) documentation.

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
