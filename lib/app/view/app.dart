import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

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
            builder: (context, state) {
              final step = LoginStep.values.byName(state.params[LoginStep.pathParameterName]!);
              final widget = LoginScreen(step);
              final provider = BlocProvider(
                create: (context) => LoginCubit(
                  step,
                ),
                child: widget,
              );
              return provider;
            },
          ),
          GoRoute(
            name: AppRoute.webRegistration,
            path: '/web-registration',
            builder: (context, state) {
              final widget = WebRegistrationScreen(
                initialUri: Uri.parse(state.queryParams['initialUrl'] ?? kBlankUri),
              );
              return widget;
            },
          ),
          GoRoute(
            name: AppRoute.permissions,
            path: '/permissions',
            builder: (context, state) {
              const widget = PermissionsScreen();
              final provider = BlocProvider(
                create: (context) => PermissionsCubit(
                  appPermissions: this.widget.appPermissions,
                ),
                child: widget,
              );
              return provider;
            },
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
                builder: (context, state) {
                  final flavor = MainFlavor.values.byName(state.queryParams[MainFlavor.queryParameterName]!);
                  final widget = MainScreen(flavor);
                  final provider = BlocProvider(
                    create: (context) {
                      return MainBloc(
                        infoRepository: context.read<InfoRepository>(),
                        storeInfoExtractor: StoreInfoExtractor(),
                      )..add(const MainStarted());
                    },
                    child: widget,
                  );
                  return BlocListener<CallBloc, CallState>(
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
                    child: provider,
                  );
                },
                routes: [
                  GoRoute(
                    name: MainRoute.call,
                    path: 'call',
                    pageBuilder: (context, state) {
                      const widget = CallScreen();
                      return CustomTransitionPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: widget,
                        transitionsBuilder: (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation, Widget child) {
                          const builder = ZoomPageTransitionsBuilder();
                          return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
                        },
                      );
                    },
                  ),
                  GoRoute(
                    name: MainRoute.settings,
                    path: 'settings',
                    pageBuilder: (context, state) {
                      const widget = SettingsScreen();
                      final provider = BlocProvider(
                        create: (context) {
                          return SettingsBloc(
                            appBloc: context.read<AppBloc>(),
                            accountRepository: context.read<AccountRepository>(),
                            appRepository: context.read<AppRepository>(),
                            appPreferences: AppPreferences(),
                          )..add(const SettingsRefreshed());
                        },
                        child: widget,
                      );
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: provider,
                      );
                    },
                    routes: [
                      GoRoute(
                        name: MainRoute.settingsAbout,
                        path: 'about',
                        builder: (context, state) {
                          if (EnvironmentConfig.APP_ABOUT_URL.isNotEmpty) {
                            final widget = WebAboutScreen(
                              baseAppAboutUrl: Uri.parse(EnvironmentConfig.APP_ABOUT_URL),
                              packageInfo: PackageInfo(),
                              infoRepository: context.read<InfoRepository>(),
                            );
                            return widget;
                          } else {
                            const widget = AboutScreen();
                            final provider = BlocProvider(
                              create: (context) {
                                return AboutBloc(
                                  packageInfo: PackageInfo(),
                                  infoRepository: context.read<InfoRepository>(),
                                )..add(const AboutStarted());
                              },
                              child: widget,
                            );
                            return provider;
                          }
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsHelp,
                        path: 'help',
                        builder: (context, state) {
                          const widget = HelpScreen();
                          return widget;
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsLanguage,
                        path: 'language',
                        builder: (context, state) {
                          const widget = LanguageScreen();
                          return widget;
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsNetwork,
                        path: 'network',
                        builder: (context, state) {
                          const widget = NetworkScreen();
                          return widget;
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsTermsConditions,
                        path: 'terms-conditions',
                        builder: (context, state) {
                          const widget = TermsConditionsScreen();
                          return widget;
                        },
                      ),
                      GoRoute(
                        name: MainRoute.settingsThemeMode,
                        path: 'theme-mode',
                        builder: (context, state) {
                          const widget = ThemeModeScreen();
                          return widget;
                        },
                      ),
                      GoRoute(
                        name: MainRoute.logRecordsConsole,
                        path: 'log-records-console',
                        builder: (context, state) {
                          const widget = LogRecordsConsoleScreen();
                          final provider = BlocProvider(
                            create: (context) => LogRecordsConsoleCubit(
                              logRecordsRepository: context.read<LogRecordsRepository>(),
                            )..load(),
                            child: widget,
                          );
                          return provider;
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    name: MainRoute.contact,
                    path: 'contact/:$contactIdPathParameterName',
                    pageBuilder: (context, state) {
                      const widget = ContactScreen();
                      final provider = BlocProvider(
                        create: (context) {
                          return ContactBloc(
                            int.parse(state.params[contactIdPathParameterName]!),
                            contactsRepository: context.read<ContactsRepository>(),
                          )..add(const ContactStarted());
                        },
                        child: widget,
                      );
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: provider,
                      );
                    },
                  ),
                  GoRoute(
                    name: MainRoute.recent,
                    path: 'recent/:$recentIdPathParameterName',
                    pageBuilder: (context, state) {
                      const widget = RecentScreen();
                      var provider = BlocProvider(
                        create: (context) {
                          return RecentBloc(
                            int.parse(state.params[recentIdPathParameterName]!),
                            recentsRepository: context.read<RecentsRepository>(),
                          )..add(const RecentStarted());
                        },
                        child: widget,
                      );
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: provider,
                      );
                    },
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
