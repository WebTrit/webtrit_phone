import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshots/router.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() async {
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
      runApp(ScreenshotsApp(appBloc: appBloc));
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  ScreenshotsApp({super.key, required this.appBloc, this.deepLink});

  final AppBloc appBloc;

  /// Overrides the deep link to be used for the screenshot.
  final String? deepLink;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) => previous.themeSettings != current.themeSettings,
        builder: (context, state) {
          return ThemeProvider(
            settings: state.themeSettings,
            lightDynamic: null,
            darkDynamic: null,
            child: BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  previous.effectiveLocale != current.effectiveLocale ||
                  previous.effectiveThemeMode != current.effectiveThemeMode,
              builder: (context, state) {
                final themeProvider = ThemeProvider.of(context);
                return MaterialApp.router(
                  locale: state.effectiveLocale,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  title: EnvironmentConfig.APP_NAME,
                  themeMode: state.effectiveThemeMode,
                  theme: themeProvider.light(),
                  darkTheme: themeProvider.dark(),
                  debugShowCheckedModeBanner: false,
                  routerConfig: _appRouter.config(deepLinkBuilder: (platformLink) {
                    if (deepLink != null) return DeepLink.path(deepLink!);
                    return platformLink;
                  }),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
