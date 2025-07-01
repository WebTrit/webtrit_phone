import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

class AppPairingContent extends StatelessWidget {
  const AppPairingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebTrit App Pairing',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/0');
        final indexStr = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '0';
        final index = int.tryParse(indexStr) ?? 0;
        return MaterialPageRoute(
          builder: (_) => IndexInputScreen(index: index),
          settings: settings,
        );
      },
    );
  }
}

class IndexInputScreen extends StatefulWidget {
  final int index;

  const IndexInputScreen({super.key, required this.index});

  @override
  State<IndexInputScreen> createState() => _IndexInputScreenState();
}

class _IndexInputScreenState extends State<IndexInputScreen> {
  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    final screenshots = [
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginModeSelectScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginCoreUrlAssignScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginOtpSignInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginOtpVerifyInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginPasswordSignInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginSignUpScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const PrivacyScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginSignUpVerifyScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.favorites,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.recents,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.keypad,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: Builder(
          builder: (context) => const MainScreenScreenshot(
            MainFlavor.messaging,
            Text(EnvironmentConfig.APP_NAME),
          ),
        ),
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

    return DefaultTabController(
      key: ValueKey(widget.index),
      length: screenshots.length,
      initialIndex: widget.index,
      child: TabBarView(
        children: screenshots,
      ),
    );
  }
}
