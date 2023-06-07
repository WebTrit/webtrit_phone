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

  final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'main');

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
              final step = LoginStep.values.byName(state.pathParameters[LoginStep.pathParameterName]!);
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
                initialUri: Uri.parse(state.queryParameters['initialUrl'] ?? kBlankUri),
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
            navigatorKey: _mainNavigatorKey,
            builder: (context, state, child) {
              return MainShell(
                child: BlocListener<CallBloc, CallState>(
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
                  child: child,
                ),
              );
            },
            routes: [
              GoRoute(
                name: AppRoute.main,
                path: '/main',
                redirect: (context, state) => '/main/${MainFlavor.defaultValue.name}',
              ),
              StatefulShellRoute.indexedStack(
                branches: [
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/main/${MainFlavor.favorites.name}',
                        name: MainRoute.favorites,
                        builder: (context, state) {
                          const widget = FavoritesScreen();
                          final provider = BlocProvider(
                            create: (context) => FavoritesBloc(
                              favoritesRepository: context.read<FavoritesRepository>(),
                            )..add(const FavoritesStarted()),
                            child: widget,
                          );
                          return provider;
                        },
                        routes: [
                          GoRoute(
                            path: ':$contactIdPathParameterName',
                            name: MainRoute.favoritesDetails,
                            builder: (context, state) {
                              const widget = ContactScreen();
                              final provider = BlocProvider(
                                create: (context) {
                                  return ContactBloc(
                                    int.parse(state.pathParameters[contactIdPathParameterName]!),
                                    contactsRepository: context.read<ContactsRepository>(),
                                  )..add(const ContactStarted());
                                },
                                child: widget,
                              );
                              return provider;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/main/${MainFlavor.recents.name}',
                        name: MainRoute.recents,
                        builder: (context, state) {
                          final widget = RecentsScreen(
                            initialFilter: context.read<RecentsBloc>().state.filter,
                          );
                          return widget;
                        },
                        routes: [
                          GoRoute(
                            path: ':$recentIdPathParameterName',
                            name: MainRoute.recentsDetails,
                            builder: (context, state) {
                              const widget = RecentScreen();
                              var provider = BlocProvider(
                                create: (context) {
                                  return RecentBloc(
                                    int.parse(state.pathParameters[recentIdPathParameterName]!),
                                    recentsRepository: context.read<RecentsRepository>(),
                                  )..add(const RecentStarted());
                                },
                                child: widget,
                              );
                              return provider;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/main/${MainFlavor.contacts.name}',
                        name: MainRoute.contacts,
                        builder: (context, state) {
                          final widget = ContactsScreen(
                            sourceTypes: const [
                              ContactSourceType.local,
                              ContactSourceType.external,
                            ],
                            sourceTypeWidgetBuilder: _contactSourceTypeWidgetBuilder,
                          );
                          final provider = BlocProvider(
                            create: (context) => ContactsSearchBloc(),
                            child: widget,
                          );
                          return provider;
                        },
                        routes: [
                          GoRoute(
                            path: ':$contactIdPathParameterName',
                            name: MainRoute.contactsDetails,
                            builder: (context, state) {
                              const widget = ContactScreen();
                              final provider = BlocProvider(
                                create: (context) {
                                  return ContactBloc(
                                    int.parse(state.pathParameters[contactIdPathParameterName]!),
                                    contactsRepository: context.read<ContactsRepository>(),
                                  )..add(const ContactStarted());
                                },
                                child: widget,
                              );
                              return provider;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/main/${MainFlavor.keypad.name}',
                        name: MainRoute.keypad,
                        builder: (context, state) {
                          const widget = KeypadScreen();
                          final provider = BlocProvider(
                            create: (context) => KeypadCubit(
                              callBloc: context.read<CallBloc>(),
                            ),
                            child: widget,
                          );
                          return provider;
                        },
                      ),
                    ],
                  ),
                ],
                builder: (context, state, navigationShell) {
                  final widget = MainScreen(
                    navigationBarFlavor: MainFlavor.values[navigationShell.currentIndex],
                    body: navigationShell,
                    onNavigationBarTap: (index) {
                      navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      );
                    },
                  );
                  return BlocProvider(
                    create: (context) {
                      return MainBloc(
                        infoRepository: context.read<InfoRepository>(),
                        storeInfoExtractor: StoreInfoExtractor(),
                      )..add(const MainStarted());
                    },
                    child: widget,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _mainNavigatorKey,
                path: '/main/call',
                name: MainRoute.call,
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
                parentNavigatorKey: _mainNavigatorKey,
                path: '/main/settings',
                name: MainRoute.settings,
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
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'about',
                    name: MainRoute.settingsAbout,
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
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'help',
                    name: MainRoute.settingsHelp,
                    builder: (context, state) {
                      const widget = HelpScreen();
                      return widget;
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'language',
                    name: MainRoute.settingsLanguage,
                    builder: (context, state) {
                      const widget = LanguageScreen();
                      return widget;
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'network',
                    name: MainRoute.settingsNetwork,
                    builder: (context, state) {
                      const widget = NetworkScreen();
                      return widget;
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'terms-conditions',
                    name: MainRoute.settingsTermsConditions,
                    builder: (context, state) {
                      const widget = TermsConditionsScreen();
                      return widget;
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'theme-mode',
                    name: MainRoute.settingsThemeMode,
                    builder: (context, state) {
                      const widget = ThemeModeScreen();
                      return widget;
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _mainNavigatorKey,
                    path: 'log-records-console',
                    name: MainRoute.logRecordsConsole,
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
            ],
            observers: [
              context.read<AppAnalyticsRepository>().createObserver(),
            ],
          ),
        ],
        observers: [
          context.read<AppAnalyticsRepository>().createObserver(),
        ],
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

  Widget _contactSourceTypeWidgetBuilder(BuildContext context, ContactSourceType sourceType) {
    switch (sourceType) {
      case ContactSourceType.local:
        const widget = ContactsLocalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsSearchBloc>();
            return ContactsLocalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              localContactsSyncBloc: context.read<LocalContactsSyncBloc>(),
            )..add(ContactsLocalTabStarted(search: contactsSearchBloc.state));
          },
          child: widget,
        );
        return provider;
      case ContactSourceType.external:
        const widget = ContactsExternalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsSearchBloc>();
            return ContactsExternalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              externalContactsSyncBloc: context.read<ExternalContactsSyncBloc>(),
            )..add(ContactsExternalTabStarted(search: contactsSearchBloc.state));
          },
          child: widget,
        );
        return provider;
    }
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
