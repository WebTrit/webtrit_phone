import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'app_shell.dart';
import 'main_shell.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.appDatabase,
    required this.appPermissions,
  }) : super(key: key);

  final AppDatabase appDatabase;
  final AppPermissions appPermissions;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc appBloc;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc(
      appPreferences: AppPreferences(),
      secureStorage: SecureStorage(),
      appDatabase: widget.appDatabase,
    );
  }

  @override
  void dispose() async {
    await appBloc.close();
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
                restorationScopeId: 'App',
                title: EnvironmentConfig.APP_NAME,
                themeMode: state.effectiveThemeMode,
                theme: themeProvider.light(),
                darkTheme: themeProvider.dark(),
                routerConfig: _router,
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

  late final GoRouter _router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: AppRoute.login,
            path: '/login',
            redirect: (context, state) => '/login/${LoginStep.modeSelect.name}',
          ),
          GoRoute(
            name: AppRoute.loginStep,
            path: '/login/:${LoginStep.pathParameterName}(${LoginStep.values.map((e) => e.name).join('|')})',
            builder: (context, state) => LoginScreen(
              LoginStep.values.byName(state.params[LoginStep.pathParameterName]!),
            ),
          ),
          GoRoute(
            name: AppRoute.webRegistration,
            path: '/web-registration',
            builder: (context, state) => WebRegistrationScreen(
              initialUri: Uri.parse(state.queryParams['initialUrl'] ?? kBlankUri),
            ),
          ),
          GoRoute(
            name: AppRoute.permissions,
            path: '/permissions',
            builder: (context, state) => PermissionsScreen(
              appPermissions: widget.appPermissions,
            ),
          ),
          ShellRoute(
            builder: (context, state, child) {
              return MainShell(
                child: child,
              );
            },
            routes: [
              GoRoute(
                name: AppRoute.main,
                path: '/main',
                redirect: (context, state) {
                  // propagate MainFlavor query parameter from the current router location to the new one if needed
                  if (state.queryParams.containsKey(MainFlavor.queryParameterName)) {
                    return null;
                  } else {
                    final routerLocation = Uri.parse(_router.location);
                    final flavor =
                        routerLocation.queryParameters[MainFlavor.queryParameterName] ?? MainFlavor.defaultValue.name;
                    final stateLocation = Uri.parse(state.location);
                    return stateLocation.replace(queryParameters: {
                      ...stateLocation.queryParameters,
                      MainFlavor.queryParameterName: flavor,
                    }).toString();
                  }
                },
                builder: (context, state) => BlocListener<CallBloc, CallState>(
                  listenWhen: (previous, current) => previous.activeCalls.length != current.activeCalls.length,
                  listener: (context, state) {
                    // TODO push/pop of call screen mechanism must be remake
                    final router = GoRouter.of(context);
                    final isCallLocation = router.location.startsWith(router.namedLocation(MainRoute.call));
                    if (state.isActive) {
                      if (!isCallLocation) {
                        context.pushNamed(MainRoute.call);
                        if (state.activeCall.video) {
                          context.read<OrientationsBloc>().add(const OrientationsChanged(PreferredOrientation.call));
                        }
                      }
                    } else {
                      if (isCallLocation) {
                        context.pop();
                        context.read<OrientationsBloc>().add(const OrientationsChanged(PreferredOrientation.regular));
                      }
                    }
                  },
                  child: MainScreen(
                    MainFlavor.values.byName(state.queryParams[MainFlavor.queryParameterName]!),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: MainRoute.call,
                    path: 'call',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: const CallScreen(),
                      transitionsBuilder: (BuildContext context, Animation<double> animation,
                          Animation<double> secondaryAnimation, Widget child) {
                        const builder = ZoomPageTransitionsBuilder();
                        return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
                      },
                    ),
                  ),
                  GoRoute(
                    name: MainRoute.settings,
                    path: 'settings',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: const SettingsScreen(),
                    ),
                    routes: [
                      GoRoute(
                        name: MainRoute.settingsAbout,
                        path: 'about',
                        builder: (context, state) {
                          if (EnvironmentConfig.APP_ABOUT_URL.isNotEmpty) {
                            return WebAboutScreen(
                              baseAppAboutUrl: Uri.parse(EnvironmentConfig.APP_ABOUT_URL),
                              packageInfo: PackageInfo(),
                              infoRepository: context.read<InfoRepository>(),
                            );
                          } else {
                            return BlocProvider(
                              create: (context) {
                                return AboutBloc(
                                  packageInfo: PackageInfo(),
                                  infoRepository: context.read<InfoRepository>(),
                                )..add(const AboutStarted());
                              },
                              child: const AboutScreen(),
                            );
                          }
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsHelp,
                        path: 'help',
                        builder: (context, state) => const HelpScreen(),
                      ),
                      GoRoute(
                        name: MainRoute.settingsLanguage,
                        path: 'language',
                        builder: (context, state) => const LanguageScreen(),
                      ),
                      GoRoute(
                        name: MainRoute.settingsNetwork,
                        path: 'network',
                        builder: (context, state) => const NetworkScreen(),
                      ),
                      GoRoute(
                        name: MainRoute.settingsTermsConditions,
                        path: 'terms-conditions',
                        builder: (context, state) => const TermsConditionsScreen(),
                      ),
                      GoRoute(
                        name: MainRoute.settingsThemeMode,
                        path: 'theme-mode',
                        builder: (context, state) => const ThemeModeScreen(),
                      ),
                      GoRoute(
                        name: MainRoute.logRecordsConsole,
                        path: 'log-records-console',
                        builder: (context, state) => const LogRecordsConsoleScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    name: MainRoute.contact,
                    path: 'contact/:$contactIdPathParameterName',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: ContactScreen(int.parse(state.params[contactIdPathParameterName]!)),
                    ),
                  ),
                  GoRoute(
                    name: MainRoute.recent,
                    path: 'recent/:$recentIdPathParameterName',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: RecentScreen(int.parse(state.params[recentIdPathParameterName]!)),
                    ),
                  ),
                ],
              ),
            ],
            // TODO: uncomment on https://github.com/flutter/packages/pull/2664 merged
            // observers: [
            //   context.read<AppAnalyticsRepository>().createObserver(),
            // ],
          ),
        ],
        // TODO: uncomment on https://github.com/flutter/packages/pull/2664 merged
        // observers: [
        //   context.read<AppAnalyticsRepository>().createObserver(),
        // ],
      ),
    ],
    redirect: _redirect,
    refreshListenable: GoRouterRefreshBloc(appBloc),
    initialLocation: '/main',
    observers: [
      context.read<AppAnalyticsRepository>().createObserver(),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final coreUrl = appBloc.state.coreUrl;
    final token = appBloc.state.token;
    final webRegistrationInitialUrl = appBloc.state.webRegistrationInitialUrl;
    final appPermissionsDenied = widget.appPermissions.isDenied;

    final isLoginPath = state.location.startsWith('/login');
    final isWebRegistrationPath = state.location.startsWith('/web-registration');
    final isMainPath = state.location.startsWith('/main');

    if (coreUrl != null && token != null) {
      if (isLoginPath || isWebRegistrationPath) {
        return '/main';
      } else if (isMainPath) {
        if (appPermissionsDenied) {
          return '/permissions';
        }
      }
    } else if (webRegistrationInitialUrl != null && !isWebRegistrationPath) {
      return '/web-registration?initialUrl=$webRegistrationInitialUrl';
    } else if (!isLoginPath) {
      return '/login';
    }

    return null;
  }
}

class GoRouterRefreshBloc extends ChangeNotifier {
  GoRouterRefreshBloc(BlocBase<dynamic> bloc) {
    notifyListeners();
    _subscription = bloc.stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
