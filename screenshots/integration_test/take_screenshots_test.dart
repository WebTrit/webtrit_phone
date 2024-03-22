import 'dart:async';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:screenshots/data/data.dart';
import 'package:screenshots/main.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:screenshots/mocks/mocks.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late final String screenshotNamePrefix;
  late final AppBloc appBloc;

  setUpAll(() async {
    await AppThemes.init();
    final themeSettings = AppThemes().values.first.settings;

    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    if (deviceInfo is AndroidDeviceInfo) {
      screenshotNamePrefix = deviceInfo.model;
    } else if (deviceInfo is IosDeviceInfo) {
      screenshotNamePrefix = deviceInfo.name;
    } else if (deviceInfo is WebBrowserInfo) {
      screenshotNamePrefix = 'web';
    } else {
      screenshotNamePrefix = 'undefined';
    }

    appBloc = MockAppBloc.allScreen(
      themeSettings: themeSettings,
      themeMode: ThemeMode.light,
      locale: const Locale('en'),
    );
  });

  void takeScreenshotTestWidgets(String name, FutureOr<Widget> Function() buildWidget) {
    return testWidgets(name, (tester) async {
      final screenshotName = '$screenshotNamePrefix/$name';

      final widget = await withClock(Clock.fixed(dFixedTime), buildWidget);

      await tester.pumpWidget(widget);
      if (Platform.isAndroid) await binding.convertFlutterSurfaceToImage();

      // such odd loop logic is necessary to wait for all navigation and images to be processed completely
      var countMinSequence = 0;
      do {
        final count = await tester.pumpAndSettle();
        if (count > 1) {
          countMinSequence = 0;
        } else {
          countMinSequence++;
        }
      } while (countMinSequence <= 3);

      await binding.takeScreenshot(screenshotName);
    });
  }

  // group('take login screen screenshots', () {
  takeScreenshotTestWidgets('login_screen__modeSelect', () {
    return ScreenshotsApp(appBloc: appBloc, deepLink: '/0');
  });
  // });

  // group('take main screen screenshots', () {
  takeScreenshotTestWidgets('main_screen__favorites', () {
    return ScreenshotsApp(appBloc: appBloc, deepLink: '/1');
  });
  takeScreenshotTestWidgets('main_screen__recents', () {
    return ScreenshotsApp(appBloc: appBloc, deepLink: '/2');
  });
  takeScreenshotTestWidgets('main_screen__keypad', () {
    return ScreenshotsApp(appBloc: appBloc, deepLink: '/3');
  });
  // });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('settings_screen', () {
      return ScreenshotsApp(appBloc: appBloc, deepLink: '/4');
    });
  });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('call_screen__audio', () {
      return ScreenshotsApp(appBloc: appBloc, deepLink: '/5');
    });
    takeScreenshotTestWidgets('call_screen__video', () {
      return ScreenshotsApp(appBloc: appBloc, deepLink: '/6');
    });
  });
}


// TODO: deepLinks to constants
