import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'main.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.webRegistrationInitialUrl,
    required this.isRegistered,
  }) : super(key: key);

  final String? webRegistrationInitialUrl;
  final bool isRegistered;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String _initialRoute(String? webRegistrationInitialUrl, bool isRegistered) => isRegistered
      ? '/main'
      : webRegistrationInitialUrl == null
          ? '/login'
          : '/web-registration';

  late final ValueNotifier<ThemeSettings> themeSettings;

  @override
  void initState() {
    super.initState();
    setDefaultOrientations();
    themeSettings = ValueNotifier(portaoneThemeSettings);
  }

  @override
  void dispose() {
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
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
            );
          },
        ),
      ),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebtritApiClient>(
          create: (context) => WebtritApiClient(Uri.parse(EnvironmentConfig.CORE_URL)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc(),
          ),
          BlocProvider<AppBloc>(
            create: (context) => AppBloc(
              webtritApiClient: context.read<WebtritApiClient>(),
              secureStorage: SecureStorage(),
              appDatabase: context.read<AppDatabase>(),
            ),
          ),
        ],
        child: materialApp,
      ),
    );
  }

  late final _router = GoRouter(
    initialLocation: _initialRoute(widget.webRegistrationInitialUrl, widget.isRegistered),
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'web-registration',
        path: '/web-registration',
        builder: (context, state) => WebRegistrationPage(
          initialUrl: state.extra != null ? state.extra! as String : widget.webRegistrationInitialUrl!,
        ),
      ),
      GoRoute(
        name: 'main',
        path: '/main',
        builder: (context, state) => const Main(),
      ),
    ],
    navigatorBuilder: (context, state, child) => MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              if (lastNotification is CallNotIdleErrorNotification) {
                context.showErrorSnackBar(context.l10n.notifications_errorSnackBar_callNotIdle);
              } else if (lastNotification is CallConnectErrorNotification) {
                context.showErrorSnackBar(context.l10n.notifications_errorSnackBar_callConnect);
              }
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            // TODO: move this awaits to bloc - this will prevent next context warning
            final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
            final isRegistered = await SecureStorage().readToken() != null;

            // ignore: use_build_context_synchronously
            context.go(_initialRoute(webRegistrationInitialUrl, isRegistered), extra: webRegistrationInitialUrl);
          },
        ),
      ],
      child: child,
    ),
  );
}
