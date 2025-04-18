# WebTrit Phone

WebTrit Phone is a feature-rich application designed for seamless communication.

## Documentation Overview

- **Environment**: See the [Environment](doc/environment.md) documentation for details on environment properties.
- **SSL Certificates**: Refer to the [SSL Certificates](doc/certificates.md) documentation for information on SSL
  certificate handling.
- **Build Process**: Learn more about build configurations in the [Build](doc/build.md) documentation.
- **Application Properties**: Customize properties such as the Bundle ID and App Name in the  [Application Settings](doc/application_properties.md) documentation.
- **Application Launch Assets**: Configure the application launch assets in the [Launch Assets](doc/launch_assets.md) documentation.
- **Localization**: For information on localization settings, see [Localizely](doc/localization.md).

## Application Configuration

The application offers extensive customization options:

- **[Color Scheme](doc/color_scheme.md)** – Customize the application's color palette.
- **[Widgets](doc/widgets_configuration.md)** – Configure UI widgets according to your needs.
- **[Pages](doc/page_configuration.md)** – Customize pages and their layouts.
- **[Features](doc/feature_configuration.md)** – Enable or disable specific features.
  - [Custom Login](doc/custom_login.md) – Implement a custom login page.

## Development & Build

 - **Make Commands**: See the  [Make Commands](doc/make_file.md) for available build and automation commands.

# Testing

## Test commands
* Run unit and widget tests
  ```bash
  flutter test
  ```
* Run integration tests
  ```bash
  flutter test integration_test --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json 
  ```
* Run specific integration test
  ```bash
  flutter drive --driver=test_driver/integration_test.dart --target=integration_test/login_system.dart --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json 
  ```

### Test variables

* `WEBTRIT_APP_TEST_CUSTOM_CORE_URL` (_example **http://localhost:4000\/tenant\/123123**_)
* `WEBTRIT_APP_TEST_EMAIL_CREDENTIAL` (_example mail@mail.com_)
* `WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_OTP_CREDENTIAL` (_example +1234566789_)
* `WEBTRIT_APP_TEST_OTP_VERIFY_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_PASSWORD_USER_CREDENTIAL`  (_example username_)
* `WEBTRIT_APP_TEST_PASSWORD_PASSWORD_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_DEFAULT_LOGIN_METHOD` (_email_ | _password_ | _otp_)


Default test variables located in `dart_define.integration_test.json` and could be add to flutter drive or test with `--dart-define-from-file=dart_define.integration_test.json` parameter.
Also can be used multiple times to combine with regular `dart_define.json` file as on example above.

## Contributing

We welcome contributions from the community! Please follow our contribution guidelines when submitting pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
