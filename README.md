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
- **[Features](docs/application_config.md)** – Enable or disable specific features.
  - [Custom Login](docs/custom_login.md) – Implement a custom login page.
  - [Embedded pages](docs/application_embedded_config.md) –  Implements embedded pages that extend the WebTrit app with custom web content.

## Development & Build
 - **Build and run**: See the [Build and Run](docs/build.md) documentation for details on how to build and run the application.
 - **Flavors**: See the [Build Flavors](docs/flavors.md) documentation for details on how to configure and use build flavors.
 - **Melos Commands**: See the [Melos Commands](docs/make_file.md) for all available build, run, and automation commands.
 - **Development Workflow and Git Hooks**: See the [Development Guide](docs/development.md) for details on commit conventions, hook setup, and workflow tools.

# Testing

### Unit and widget tests
* Run unit and widget tests:
  ```bash
  flutter test
  ```
### Integration tests
- **Framework**: We use Patrol framework for integration testing.
It helps us to automate native iOS and Android behaviors and simplifyes routine tasks during testing.
You can find more information about it here: https://patrol.dev/ 
Integration tests are located in the `patrol_test` folder.

- **Configuration**: The configuration file `dart_define.integration_test.json` defines all the environment variables (login credentials, contacts, user info, and call settings) for the integration tests. [Integration Test Variables](docs/integration_test_variables.md).

- **Calls test**: For simulating SIP calls during tests, here is [pjsua Companion](packages/pjsua_companion/README.md) — an HTTP server that wraps the `pjsua` CLI to place and answer calls programmatically when app tests is running.

- **Commands**: See [Integration Test Commands](docs/integration_test_commands.md) for all patrol build, run, Firebase Test Lab, and local companion commands.

- **Coverage**: See [Integration Test Coverage](docs/integration_test_coverage.md) for a description of every test file and its steps.

## Contributing

We welcome contributions from the community! Please follow our contribution guidelines when submitting pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

This project is tested with [BrowserStack](https://www.browserstack.com/).
