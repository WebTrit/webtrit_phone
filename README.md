# webtrit_phone

WebTrit Phone application.

## Build variables

* `WEBTRIT_PHONE_APP_ID_SUFFIX` - suffix added to `applicationId` (_with value `com.webtrit.phone`_) on Android and to `CFBundleIdentifier` (_with value `com.webtrit.phone`_) on iOS (_default is empty_)
* `WEBTRIT_PHONE_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_PHONE_APP_DESCRIPTION` (_default **<WEBTRIT_PHONE_APP_NAME> application**_)
* `WEBTRIT_PHONE_WEBTRIT_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_PHONE_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_PHONE_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_PHONE_DATABASE_LOG_STATEMENTS` (_default **false**_)

### Build Android app

Command line example:
```bash
flutter build appbundle
  --dart-define=WEBTRIT_PHONE_APP_NAME="PortaPhone 2"
  --dart-define=WEBTRIT_PHONE_APP_DESCRIPTION="PortaPhone 2 Android application"
  --dart-define=WEBTRIT_PHONE_DEMO_WEBTRIT_CORE_URL=https://core-dev.demo.portaone.com
  --dart-define=WEBTRIT_PHONE_DEBUG_LEVEL=ALL
  --dart-define=WEBTRIT_PHONE_PERIODIC_POLLING=true
  --dart-define=WEBTRIT_PHONE_APP_TERMS_AND_CONDITIONS_URL=https://www.portaone.com/portaphone/installation
```

### Build iOS app

Command line example: 
```bash
flutter build ipa \
  --dart-define=WEBTRIT_PHONE_APP_NAME="PortaPhone 2" \
  --dart-define=WEBTRIT_PHONE_APP_DESCRIPTION="PortaPhone 2 iOS application" \
  --dart-define=WEBTRIT_PHONE_WEBTRIT_CORE_URL=https://core.demo.portaone.com \
  --dart-define=WEBTRIT_PHONE_DEBUG_LEVEL=ALL \
  --dart-define WEBTRIT_PHONE_PERIODIC_POLLING=true \
  --dart-define=WEBTRIT_PHONE_APP_TERMS_AND_CONDITIONS_URL=https://www.portaone.com/portaphone/installation
```

### Build Web app

Command line example:
```bash
export APP_NAME="PortaPhone 2"
export APP_DESCRIPTION="PortaPhone 2 Web application"

flutter build web \
  --dart-define=WEBTRIT_PHONE_APP_NAME=$APP_NAME \
  --dart-define=WEBTRIT_PHONE_APP_DESCRIPTION=$APP_DESCRIPTION \
  --dart-define=WEBTRIT_PHONE_DEMO_WEBTRIT_CORE_URL=https://core-dev.demo.portaone.com \
  --dart-define=WEBTRIT_PHONE_DEBUG_LEVEL=ALL \
  --dart-define=WEBTRIT_PHONE_PERIODIC_POLLING=true \
  --dart-define=WEBTRIT_PHONE_APP_TERMS_AND_CONDITIONS_URL=https://www.portaone.com/portaphone/installation
  
dart run \
  --define=WEBTRIT_PHONE_APP_NAME=$APP_NAME \
  --define=WEBTRIT_PHONE_APP_DESCRIPTION=$APP_DESCRIPTION \
  tool/extenvsubst.dart build/web/index.html
```

### Change branding style

Command line example:

```bash
 dart run webtrit_phone_publisher --config "publisher.json"
```

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
