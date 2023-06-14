import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

class ScreenshotApp extends StatelessWidget {
  const ScreenshotApp({
    super.key,
    required this.appBloc,
    required this.child,
  });

  final AppBloc appBloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget materialApp = BlocBuilder<AppBloc, AppState>(
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
                routerDelegate: ScreenshotRouterDelegate(child),
              );
            },
          ),
        );
      },
    );

    materialApp = IgnorePointer(
      child: materialApp,
    );

    final provider = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(
          value: appBloc,
        ),
      ],
      child: materialApp,
    );

    return provider;
  }
}

class ScreenshotRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  ScreenshotRouterDelegate(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          child: child,
        ),
      ],
      onPopPage: (route, result) {
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {
    return;
  }

  @override
  Future<bool> popRoute() async {
    return false;
  }
}
