import 'dart:async';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:screenshots/data/data.dart';
import 'package:screenshots/screenshots/screenshots.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/portaone.dart';

import 'package:screenshots/mocks/mocks.dart';
import 'package:screenshots/widgets/widgets.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final String screenshotNamePrefix;
  late final AppBloc appBloc;

  void takeScreenshotTestWidgets(String name, FutureOr<Widget> Function() buildWidget) {
    testWidgets(name, (tester) async {
      final screenshotName = '$screenshotNamePrefix/$name';

      final widget = await withClock(
        Clock.fixed(dFixedTime),
        buildWidget,
      );

      await tester.pumpWidget(widget);
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
      }

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

  setUpAll(() async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    if (deviceInfo is AndroidDeviceInfo) {
      screenshotNamePrefix = deviceInfo.model;
    } else if (deviceInfo is IosDeviceInfo) {
      screenshotNamePrefix = deviceInfo.name!;
    } else if (deviceInfo is WebBrowserInfo) {
      screenshotNamePrefix = 'web';
    } else {
      screenshotNamePrefix = 'undefined';
    }

    appBloc = MockAppBloc.allScreen(
      themeSettings: portaoneThemeSettings,
      themeMode: ThemeMode.light,
      locale: const Locale('en'),
    );
  });

  group('take login screen screenshots', () {
    takeScreenshotTestWidgets('login_screen__modeSelect', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const LoginScreenScreenshot(LoginStep.modeSelect),
      );
    });
  });

  group('take main screen screenshots', () {
    takeScreenshotTestWidgets('main_screen__favorites', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.favorites),
      );
    });
    takeScreenshotTestWidgets('main_screen__recents', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.recents),
      );
    });
    takeScreenshotTestWidgets('main_screen__keypad', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.keypad),
      );
    });
  });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('settings_screen', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const SettingScreenScreenshot(),
      );
    });
  });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('call_screen__audio', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(false),
      );
    });
    takeScreenshotTestWidgets('call_screen__video', () {
      return ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(true),
      );
    });
  });
}
