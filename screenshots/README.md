# screenshots

WebTrit Phone screenshots application.

This application intends to run integration tests over it to generate WebTrit Phone screenshots used with app marketplaces.

Also, widgets, mocks and data from this application are going to be used by configuration tools.

To run take screenshots integration test next command needs to be executed:
```shell
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/take_screenshots_test.dart
```
