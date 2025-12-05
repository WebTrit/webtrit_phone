import 'dart:async';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:device_info_plus/device_info_plus.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';
import 'package:screenshots/bootstrap.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final String screenshotNamePrefix;

  late final AppContext appContext;

  setUpAll(() async {
    final deviceInfoPlugin = await DeviceInfoPlugin().deviceInfo;
    if (deviceInfoPlugin is AndroidDeviceInfo) {
      screenshotNamePrefix = deviceInfoPlugin.model;
    } else if (deviceInfoPlugin is IosDeviceInfo) {
      screenshotNamePrefix = deviceInfoPlugin.name;
    } else if (deviceInfoPlugin is WebBrowserInfo) {
      screenshotNamePrefix = 'web';
    } else {
      screenshotNamePrefix = 'undefined';
    }

    appContext = await bootstrap();
  });

  void takeScreenshotTestWidgets(String name, FutureOr<Widget> Function() buildWidget) {
    testWidgets(name, (tester) async {
      final screenshotName = '$screenshotNamePrefix/$name';

      final innerWidget = await withClock(
        Clock.fixed(dFixedTime),
        buildWidget,
      );

      final wrappedWidget = MultiProvider(
        providers: appContext.providers,
        child: PresenceViewParams(
          viewSource: PresenceViewSource.contactInfo,
          child: innerWidget,
        ),
      );

      await tester.pumpWidget(wrappedWidget);

      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
      }

      try {
        await tester.pumpAndSettle(
          const Duration(milliseconds: 100),
          EnginePhase.sendSemanticsUpdate,
          const Duration(seconds: 2),
        );
      } catch (e) {
        await tester.pump();
      }

      await binding.takeScreenshot(screenshotName);
    });
  }

  group('take login screen screenshots', () {
    takeScreenshotTestWidgets('login_screen__modeSelect', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const LoginModeSelectScreenScreenshot(),
      );
    });
  });

  group('take main screen screenshots', () {
    takeScreenshotTestWidgets('main_screen__favorites', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.favorites,
          Text(EnvironmentConfig.APP_NAME),
        ),
      );
    });
    takeScreenshotTestWidgets('main_screen__recents', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.recents,
          Text(EnvironmentConfig.APP_NAME),
        ),
      );
    });
    takeScreenshotTestWidgets('main_screen__keypad', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.keypad,
          Text(EnvironmentConfig.APP_NAME),
        ),
      );
    });
  });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('settings_screen', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const SettingScreenScreenshot(),
      );
    });
  });

  group('take call screen screenshots', () {
    takeScreenshotTestWidgets('call_screen__audio', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const CallScreenScreenshot(false),
      );
    });
    takeScreenshotTestWidgets('call_screen__video', () {
      return ScreenshotApp(
        appBloc: appContext.appBloc,
        child: const CallScreenScreenshot(true),
      );
    });
  });
}
