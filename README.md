# webtrit_phone

WebTrit Phone application.

## Build variables

* `WEBTRIT_PHONE_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_PHONE_APP_DESCRIPTION` (_default **<WEBTRIT_PHONE_APP_NAME> application**_)
* `WEBTRIT_PHONE_WEBTRIT_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_PHONE_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_PHONE_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_PHONE_DATABASE_LOG_STATEMENTS` (_default **false**_)

### Build iOS app

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

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
