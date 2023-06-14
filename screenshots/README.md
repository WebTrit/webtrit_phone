# screenshots

WebTrit Phone screenshots application.

This application intends to run integration tests over it to generate WebTrit Phone screenshots used with app marketplaces.

Also, widgets, mocks and data from this application are going to be used by configuration tools.

To run take screenshots integration test next command needs to be executed:
```shell
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/take_screenshots_test.dart
```

## Deep linking

[Deep linking](https://docs.flutter.dev/development/ui/navigation/deep-linking) is used to navigate to a specific screen in the app using a command line.

Android command example:
```shell
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://webtrit-phone-screenshots.firebaseapp.com/1"' \
    com.webtrit.phone.screenshots
```

iOS command example:
```shell
xcrun simctl openurl booted https://webtrit-phone-screenshots.firebaseapp.com/1
```

### Firebase Hosting

[Firebase Hosting](https://firebase.google.com/docs/hosting) is used to host `apple-app-site-association` is used to host the apple-app-site-association file, which is necessary for iOS universal links to work.

To update the `apple-app-site-association` file on hosting (in case of any changes) use following command:
```shell
firebase deploy --only hosting
```
