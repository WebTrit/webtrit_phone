import 'package:flutter/material.dart';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/settings.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/utils/utils.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required this.webRegistrationInitialUrl,
    required this.isRegistered,
  }) : super(key: key);

  final String? webRegistrationInitialUrl;
  final bool isRegistered;

  String _initialRoute(String? webRegistrationInitialUrl, bool isRegistered) => isRegistered
      ? '/main'
      : webRegistrationInitialUrl == null
          ? '/login'
          : '/web-registration';

  @override
  Widget build(BuildContext context) {
    setDefaultOrientations();

    final materialApp = MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      restorationScopeId: 'App',
      title: EnvironmentConfig.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      builder: (BuildContext context, Widget? child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(
            appBarTheme: AppBarTheme(
              color: themeData.canvasColor,
              iconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              actionsIconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              titleTextStyle: themeData.primaryTextTheme.headline6!.copyWith(
                color: themeData.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
            ),
            tabBarTheme: TabBarTheme(
              labelColor: themeData.textTheme.caption!.color,
            ),
          ),
          child: child ?? Container(),
        );
      },
      routeInformationParser: _routerTop.routeInformationParser,
      routerDelegate: _routerTop.routerDelegate,
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
            create: (context) => AppBloc(),
          ),
        ],
        child: materialApp,
      ),
    );
  }

  late final _routerTop = GoRouter(
    initialLocation: _initialRoute(webRegistrationInitialUrl, isRegistered),
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
          initialUrl: state.extra != null ? state.extra! as String : webRegistrationInitialUrl!,
        ),
      ),
      GoRoute(
        name: 'main',
        path: '/main',
        builder: (context, state) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<CallRepository>(
              create: (context) => CallRepository(),
            ),
            RepositoryProvider<FavoritesRepository>(
              create: (context) => FavoritesRepository(
                appDatabase: context.read<AppDatabase>(),
              ),
            ),
            RepositoryProvider<RecentsRepository>(
              create: (context) => RecentsRepository(
                appDatabase: context.read<AppDatabase>(),
              ),
            ),
            RepositoryProvider<ContactsRepository>(
              create: (context) => ContactsRepository(
                appDatabase: context.read<AppDatabase>(),
              ),
            ),
            RepositoryProvider<LocalContactsRepository>(
              create: (context) => LocalContactsRepository(),
            ),
            RepositoryProvider<PushTokensRepository>(
              create: (context) => PushTokensRepository(
                webtritApiClient: context.read<WebtritApiClient>(),
                secureStorage: SecureStorage(),
              ),
            ),
            RepositoryProvider<ExternalContactsRepository>(
              create: (context) => ExternalContactsRepository(
                webtritApiClient: context.read<WebtritApiClient>(),
                periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
              ),
            ),
            RepositoryProvider<AccountInfoRepository>(
              create: (context) => AccountInfoRepository(
                webtritApiClient: context.read<WebtritApiClient>(),
                periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<PushTokensBloc>(
                lazy: false,
                create: (context) {
                  return PushTokensBloc(
                    pushTokensRepository: context.read<PushTokensRepository>(),
                    firebaseMessaging: FirebaseMessaging.instance,
                    callkeep: FlutterCallkeep(),
                  )..add(const PushTokensStarted());
                },
              ),
              BlocProvider<RecentsBloc>(
                create: (context) {
                  return RecentsBloc(
                    recentsRepository: context.read<RecentsRepository>(),
                  )..add(const RecentsInitialLoaded());
                },
              ),
              BlocProvider<LocalContactsSyncBloc>(
                lazy: false,
                create: (context) {
                  return LocalContactsSyncBloc(
                    localContactsRepository: context.read<LocalContactsRepository>(),
                    appDatabase: context.read<AppDatabase>(),
                  )..add(const LocalContactsSyncStarted());
                },
              ),
              BlocProvider<ExternalContactsSyncBloc>(
                lazy: false,
                create: (context) {
                  return ExternalContactsSyncBloc(
                    externalContactsRepository: context.read<ExternalContactsRepository>(),
                    appDatabase: context.read<AppDatabase>(),
                  )..add(const ExternalContactsSyncStarted());
                },
              ),
              BlocProvider<CallBloc>(
                create: (context) {
                  return CallBloc(
                    callRepository: context.read<CallRepository>(),
                    recentsRepository: context.read<RecentsRepository>(),
                    notificationsBloc: context.read<NotificationsBloc>(),
                    appBloc: context.read<AppBloc>(),
                  )..add(const CallAttached());
                },
              ),
            ],
            child: Router(
              routerDelegate: _routerMain.routerDelegate,
            ),
          ),
        ),
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
              } else if (lastNotification is CallAttachErrorNotification) {
                context.showErrorSnackBar(context.l10n.notifications_errorSnackBar_callAttach);
              }
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            if (state is AppUnregister) {
              final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
              final isRegistered = await SecureStorage().readToken() != null;

              context.go(_initialRoute(webRegistrationInitialUrl, isRegistered), extra: webRegistrationInitialUrl);
            }
          },
        ),
      ],
      child: child,
    ),
  );

  late final _routerMain = GoRouter(
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) => BlocListener<CallBloc, CallState>(
          listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
          listener: (context, state) {
            if (state is CallActive) {
              setCallOrientations().then((_) {
                context.pushNamed('call');
              });
            }
            if (state is CallIdle && Navigator.canPop(context)) {
              // TODO canPop must be removed by reorganise states
              setDefaultOrientations().then((_) {
                context.pop();
              });
            }
          },
          child: const MainPage(),
        ),
        routes: [
          GoRoute(
            name: 'call',
            path: 'call',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const CallPage(),
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                const builder = ZoomPageTransitionsBuilder();
                return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
              },
            ),
          ),
          GoRoute(
            name: 'settings',
            path: 'settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const SettingsPage(),
            ),
            routes: [
              GoRoute(
                name: 'log-records-console',
                path: 'log-records-console',
                builder: (context, state) => const LogRecordsConsolePage(),
              ),
            ],
          ),
          GoRoute(
            name: 'contact',
            path: 'contact',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: ContactPage(state.extra as Contact),
            ),
          ),
          GoRoute(
            name: 'recent',
            path: 'recent',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: RecentScreen(state.extra! as Recent),
            ),
          ),
        ],
      ),
    ],
  );
}
