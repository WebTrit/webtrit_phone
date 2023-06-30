import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';
import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppStyleConfig.init();
  await AppTheme.init();
  final theme = AppTheme().theme;

  final appBloc = MockAppBloc.allScreen(
    themeSettings: theme,
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
      child: const CallScreenScreenshot(
        true,
        localePlaceholderImageUrl:
            'https://firebasestorage.googleapis.com/v0/b/webtrit-configurator-stage.appspot.com/o/screenshots%20_video_call%2Fref1.png?alt=media&token=692ccd4f-d43d-48b0-8e1d-9fd7b2f90220',
        remotePlaceholderImageUrl:
            'https://firebasestorage.googleapis.com/v0/b/webtrit-configurator-stage.appspot.com/o/screenshots%20_video_call%2Fref2.png?alt=media&token=3d469e82-9a64-4852-b593-9133f304bbef',
      ),
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
