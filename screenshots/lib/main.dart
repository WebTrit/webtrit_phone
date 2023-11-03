import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';
import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

import 'data/clock.dart';

void main() {
  withClock(
    Clock.fixed(dFixedTime),
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await AppThemes.init();
      final themeSettings = AppThemes().values.first.settings;

      final appBloc = MockAppBloc.allScreen(
        themeSettings: themeSettings,
        themeMode: ThemeMode.light,
        locale: const Locale('en'),
      );

      runApp(ScreenshotsApp(
        appBloc: appBloc,
      ));
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  ScreenshotsApp({
    super.key,
    required this.appBloc,
  });

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }

  late final _screenshots = [
    ScreenshotApp(
      appBloc: appBloc,
      child: AuthModeSelectScreenScreenshot(
        appGreeting: EnvironmentConfig.APP_GREETING.isEmpty ? null : EnvironmentConfig.APP_GREETING,
      ),
    ),
    ScreenshotApp(
      appBloc: appBloc,
      child: const AuthCoreUrlAssignScreenScreenshot(),
    ),
    ScreenshotApp(
      appBloc: appBloc,
      child: const AuthTypesScreenshot(
        selected: SupportedLoginType.otpSignIn,
      ),
    ),
    ScreenshotApp(
      appBloc: appBloc,
      child: const AuthTypesScreenshot(
        selected: SupportedLoginType.passwordSignIn,
      ),
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

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return '/0';
        },
      ),
      GoRoute(
        path: '/:$_kInitialIndexParameterName',
        builder: (context, state) {
          return DefaultTabController(
            key: ValueKey(state.initialIndexParameter),
            length: _screenshots.length,
            initialIndex: state.initialIndexParameter,
            child: TabBarView(
              children: _screenshots,
            ),
          );
        },
      ),
    ],
  );
}

const _kInitialIndexParameterName = 'initialIndex';

extension _GoRouterStateParams on GoRouterState {
  int get initialIndexParameter => int.parse(pathParameters[_kInitialIndexParameterName]!);
}
