# webtrit_phone

WebTrit Phone application.

## Build variables

* `WEBTRIT_APP_ID_SUFFIX` - suffix added to `applicationId` (_with value `com.webtrit.app`_) on Android and to `CFBundleIdentifier` (_with value `com.webtrit.app`_) on iOS (_default is empty_)
* `WEBTRIT_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_APP_DESCRIPTION` (_default is empty_)
* `WEBTRIT_APP_CORE_URL` (_optional_)
* `WEBTRIT_APP_DEMO_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_APP_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_APP_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_APP_DATABASE_LOG_STATEMENTS` (_default **false**_)

Default build variables located in [dart_define.json](dart_define.json) and could be add to `flutter` `run` or `build` with `--dart-define-from-file=dart_define.json` parameter. 

### Build Android app

Command line example:
```bash
flutter build appbundle --dart-define-from-file=dart_define.json
```

### Build iOS app

Command line example: 
```bash
flutter build ipa --dart-define-from-file=dart_define.json
```

### Build Web app

Command line example:
```bash
flutter build web --dart-define-from-file=dart_define.json
  
dart run tool/extenvsubst.dart dart_define.json build/web/index.html
```

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
