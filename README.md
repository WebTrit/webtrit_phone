# webtrit_phone

WebTrit Phone application.

## Build variables

* `WEBTRIT_PHONE_APP_NAME` (_default **WebTrit**_)
* `WEBTRIT_PHONE_WEBTRIT_CORE_URL` (_default **http://localhost:4000**_)
* `WEBTRIT_PHONE_PERIODIC_POLLING` (_default **true**_)
* `WEBTRIT_PHONE_DEBUG_LEVEL` (_default **INFO**_)
* `WEBTRIT_PHONE_DATABASE_LOG_STATEMENTS` (_default **false**_)

Example 
```bash
flutter build ipa --dart-define WEBTRIT_PHONE_APP_NAME="PortaPhone 2" --dart-define WEBTRIT_PHONE_WEBTRIT_CORE_URL=https://core.demo.portaone.com --dart-define WEBTRIT_PHONE_DEBUG_LEVEL=ALL --dart-define WEBTRIT_PHONE_PERIODIC_POLLING=true
```

## Contributing

Contributions are always welcome!

## License

[MIT LICENSE](LICENSE)

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
