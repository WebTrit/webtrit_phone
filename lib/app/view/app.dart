import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/app/router/app_router_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.appPreferences,
    required this.secureStorage,
    required this.appDatabase,
    required this.appPermissions,
    required this.appThemes,
  });

  final AppPreferences appPreferences;
  final SecureStorage secureStorage;
  final AppDatabase appDatabase;
  final AppPermissions appPermissions;
  final AppThemes appThemes;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc appBloc;

  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc(
      appPreferences: widget.appPreferences,
      secureStorage: widget.secureStorage,
      appDatabase: widget.appDatabase,
      appThemes: widget.appThemes,
      pendingCallHandler: AndroidPendingCallHandler(),
    );
    _appRouter = AppRouter(
      appBloc,
      widget.appPermissions,
      context.read<FeatureAccess>().bottomMenuFeature.activeTab.flavor,
    );
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = BlocBuilder<AppBloc, AppState>(
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
                // restorationScopeId: 'App', // TODO: temporary comment to prevent AppShell's AutoRouter placeholder blink - additional investigation necessary
                title: EnvironmentConfig.APP_NAME,
                themeMode: state.effectiveThemeMode,
                theme: themeProvider.light(),
                darkTheme: themeProvider.dark(),
                routerConfig: _appRouter.config(
                  deepLinkBuilder: _appRouter.deepLinkBuilder,
                  navigatorObservers: () => [
                    AppRouterObserver(),
                    context.read<AppAnalyticsRepository>().createObserver(),
                    AutoRouteObserver(),
                  ],
                  reevaluateListenable: ReevaluateListenable.stream(appBloc.stream),
                ),
              );
            },
          ),
        );
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<OrientationsBloc>(
          lazy: false,
          create: (context) => OrientationsBloc()..add(const OrientationsChanged(PreferredOrientation.regular)),
        ),
        BlocProvider<NotificationsBloc>(
          create: (context) => NotificationsBloc(),
        ),
        BlocProvider<AppBloc>.value(
          value: appBloc,
        ),
      ],
      child: materialApp,
    );
  }
}
