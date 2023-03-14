import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';
import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

void main() {
  final appBloc = MockAppBloc.allScreen(
    themeSettings: portaoneThemeSettings,
    themeMode: ThemeMode.light,
    locale: const Locale('en'),
  );

  withClock(
    Clock.fixed(dFixedTime),
    () {
      runApp(ScreenshotsApp(
        appBloc: appBloc,
      ));
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  const ScreenshotsApp({
    super.key,
    required this.appBloc,
  });

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    final screenshots = [
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginScreenScreenshot(LoginStep.modeSelect),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.favorites),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.recents),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(MainFlavor.keypad),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const SettingScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(false),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(true),
      ),
    ];

    return MaterialApp(
      home: DefaultTabController(
        length: screenshots.length,
        child: TabBarView(
          children: screenshots,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
