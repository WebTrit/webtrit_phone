import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/utils.dart';

void main() {
  const channel = MethodChannel('plugins.flutter.io/url_launcher');

  late List<String> launched;
  late bool deviceHasMailApp;
  late bool launchThrows;

  setUp(() {
    launched = [];
    deviceHasMailApp = true;
    launchThrows = false;
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
      switch (call.method) {
        case 'canLaunch':
          return deviceHasMailApp;
        case 'launch':
          if (launchThrows) throw PlatformException(code: 'ACTIVITY_NOT_FOUND');
          launched.add((call.arguments as Map)['url'] as String);
          return true;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('opens the mail app on the address', () async {
    expect(await launchMailTo('anna@example.com'), isTrue);
    expect(launched, ['mailto:anna@example.com']);
  });

  test('does nothing when the device has no mail app', () async {
    deviceHasMailApp = false;

    expect(await launchMailTo('anna@example.com'), isFalse);
    expect(launched, isEmpty);
  });

  test('a failing launch is not raised at the caller', () async {
    launchThrows = true;

    // This is called straight from a button; an uncaught failure would reach
    // the crash reporter over a tap that simply did not open anything.
    expect(await launchMailTo('anna@example.com'), isFalse);
  });
}
