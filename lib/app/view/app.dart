import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'main.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.appDatabase,
  }) : super(key: key);

  final AppDatabase appDatabase;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ValueNotifier<ThemeSettings> themeSettings;
  late final AppBloc appBloc;

  @override
  void initState() {
    super.initState();
    themeSettings = ValueNotifier(portaoneThemeSettings);
    appBloc = AppBloc(
      secureStorage: SecureStorage(),
      appDatabase: widget.appDatabase,
    );
  }

  @override
  void dispose() async {
    await appBloc.close();
    themeSettings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = ThemeProvider(
      settings: themeSettings,
      lightDynamic: null,
      darkDynamic: null,
      child: NotificationListener<ThemeSettingsChangedNotification>(
        onNotification: (notification) {
          themeSettings.value = notification.settings;
          return true;
        },
        child: ValueListenableBuilder<ThemeSettings>(
          valueListenable: themeSettings,
          builder: (context, value, _) {
            final themeProvider = ThemeProvider.of(context);
            return MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              restorationScopeId: 'App',
              title: EnvironmentConfig.APP_NAME,
              theme: themeProvider.light(),
              darkTheme: themeProvider.dark(),
              themeMode: themeProvider.themeMode(),
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
            );
          },
        ),
      ),
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

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoute.login,
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoute.webRegistration,
        path: '/web-registration',
        builder: (context, state) => WebRegistrationScreen(
          initialUrl: state.queryParams['initialUrl'] ?? '',
        ),
      ),
      GoRoute(
        name: AppRoute.main,
        path: '/main',
        builder: (context, state) => const Main(),
      ),
    ],
    redirect: _redirect,
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    initialLocation: '/main',
    navigatorBuilder: (context, state, child) => MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              context.showErrorSnackBar(lastNotification.l10n(context));
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
      ],
      child: child,
    ),
  );

  String? _redirect(GoRouterState state) {
    final coreUrl = appBloc.state.coreUrl;
    final token = appBloc.state.token;
    final webRegistrationInitialUrl = appBloc.state.webRegistrationInitialUrl;

    final isLoginPath = state.subloc == '/login';
    final isWebRegistrationPath = state.subloc == '/web-registration';

    if (coreUrl != null && token != null) {
      if (isLoginPath || isWebRegistrationPath) {
        return '/main';
      }
    } else if (webRegistrationInitialUrl != null && !isWebRegistrationPath) {
      return '/web-registration?initialUrl=$webRegistrationInitialUrl';
    } else if (!isLoginPath) {
      return '/login';
    }

    return null;
  }
}
