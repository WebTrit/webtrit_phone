# WebTrit Phone

WebTrit Phone is a feature-rich application designed for seamless communication.

## Flutter Project Environment Setup

Use the following setup to ensure compatibility with this branch:

- **Flutter**: 3.32.4 (stable channel)
- **Android SDK**: 35.0.1

Please align your local environment with these versions for consistent behavior across development and testing workflows.

## Documentation Overview

- **Environment**: See the [Environment](docs/environment.md) documentation for details on environment properties.
- **SSL Certificates**: Refer to the [SSL Certificates](docs/certificates.md) documentation for information on SSL
  certificate handling.
- **Build Process**: Learn more about build configurations in the [Build](docs/build.md) documentation.
- **Application Properties**: Customize properties such as the Bundle ID and App Name in the  [Application Settings](docs/application_properties.md) documentation.
- **Application Launch Assets**: Configure the application launch assets in the [Launch Assets](docs/launch_assets.md) documentation.
- **Localization**: For information on localization settings, see [Localizely](docs/localization.md).

## Application Configuration

The application offers extensive customization options:

- **[Color Scheme](docs/color_scheme.md)** – Customize the application's color palette.
- **[Widgets](docs/widgets_configuration.md)** – Configure UI widgets according to your needs.
- **[Pages](docs/page_configuration.md)** – Customize pages and their layouts.
- **[Features](docs/feature_configuration.md)** – Enable or disable specific features.
  - [Custom Login](docs/custom_login.md) – Implement a custom login page.
  - [Embedded pages](docs/embedded_pages.md) –  Implements embedded pages that extend the WebTrit app with custom web content.

## Development & Build
 - **Build and run**: See the [Build and Run](docs/build.md) documentation for details on how to build and run the application.
 - **Flavors**: See the [Build Flavors](docs/flavors.md) documentation for details on how to configure and use build flavors.
 - **Make Commands**: See the  [Make Commands](docs/make_file.md) for available build and automation commands.

# Testing

## Test commands
* Run unit and widget tests
  ```bash
  flutter test
  ```
* Run integration tests in dev mode
  ```bash
  patrol develop --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json --flavor=deeplinkssmsReceiver
  ```
* Build integration tests
  ```bash
  patrol build android/ios --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json --flavor=deeplinkssmsReceiver
  ```
* To specify a test file, use the `-t` option:
  ```bash
  patrol build -t integration_test/call_and_recent_test.dart ...
  ```
* For build and deploy to Firebase Test Lab, use the following command from the `tool/scripts` directory:
  ```bash
  ./testlab_assemble_android.sh <testfile(optional)>
  ./testlab_assemble_ios.sh <testfile(optional)>
  ```

### Test variables

* `WEBTRIT_APP_TEST_CUSTOM_CORE_URL` (_example core.demo.mycompany.com_)
* `WEBTRIT_APP_TEST_EMAIL_CREDENTIAL` (_example myaccount@mail.com_)
* `WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_OTP_CREDENTIAL` (_example +1234566789_)
* `WEBTRIT_APP_TEST_OTP_VERIFY_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_PASSWORD_USER_CREDENTIAL`  (_example username_)
* `WEBTRIT_APP_TEST_PASSWORD_PASSWORD_CREDENTIAL` (_example 123456_)
* `WEBTRIT_APP_TEST_DEFAULT_LOGIN_METHOD` (_email_ | _password_ | _otp_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_A` (_example User A_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_NUMBER` (_example 00123_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B` (_example User B_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_NUMBER` (_example 00456_)
* `WEBTRIT_APP_TEST_ACCOUNT_NAME` (_example Test Account_)
* `WEBTRIT_APP_TEST_ACCOUNT_MAIN_NUMBER` (_example 1230000_)
* `WEBTRIT_APP_TEST_CALL_NUMBER_A` (_example 1111_)
* `WEBTRIT_APP_TEST_CALL_NUMBER_B` (_example 2222_)
* `WEBTRIT_APP_TEST_CROSS_CALL_SLEEP_SECONDS` (_example 10_)

## Contributing

We welcome contributions from the community! Please follow our contribution guidelines when submitting pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
