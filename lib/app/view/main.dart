import 'package:flutter/material.dart';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late final FlutterCallkeep callkeep;

  @override
  void initState() {
    super.initState();
    callkeep = FlutterCallkeep();
    callkeep.setup(null, <String, dynamic>{
      'ios': {
        'appName': 'WebTrit',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription': 'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
        'foregroundService': {
          'channelId': 'com.webtrit.phone',
          'channelName': 'Foreground service for WebTrit app',
          'notificationTitle': 'WebTrit app is running on background',
          'notificationIcon': 'Path to the resource icon of the notification',
        },
        'additionalPermissions': [],
        // TODO remove after https://github.com/flutter-webrtc/callkeep/pull/127 merged and released
      },
    });
  }

  @override
  void dispose() {
    // TODO add callkeep unsetup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
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
                callkeep: callkeep,
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
                recentsRepository: context.read<RecentsRepository>(),
                notificationsBloc: context.read<NotificationsBloc>(),
                callkeep: callkeep,
              )..add(const CallStarted());
            },
          ),
        ],
        child: Router(
          routerDelegate: _router.routerDelegate,
        ),
      ),
    );
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) => BlocListener<CallBloc, CallState>(
          listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
          listener: (context, state) {
            if (state is ActiveCallState) {
              setCallOrientations().then((_) {
                context.pushNamed('call');
              });
            }
            if (state is IdleCallState && Navigator.canPop(context)) {
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
              child: const SettingsScreen(),
            ),
            routes: [
              GoRoute(
                name: 'network-settings-tab',
                path: 'network-settings-tab',
                builder: (context, state) => const NetworkSettingsTabScreen(),
              ),
              GoRoute(
                name: 'about-app-tab',
                path: 'about-app-tab',
                builder: (context, state) => const AboutAppTabScreen(),
              ),
              GoRoute(
                name: 'help-tab',
                path: 'help-tab',
                builder: (context, state) => const HelpTabScreen(),
              ),
              GoRoute(
                name: 'language-tab',
                path: 'language-tab',
                builder: (context, state) => const LanguageTabScreen(),
              ),
              GoRoute(
                name: 'terms-conditions-tab',
                path: 'terms-conditions-tab',
                builder: (context, state) => const TermsConditionsTabScreen(),
              ),
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
