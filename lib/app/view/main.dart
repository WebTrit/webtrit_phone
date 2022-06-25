import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late final Callkeep callkeep;

  @override
  void initState() {
    super.initState();
    callkeep = Callkeep();
    callkeep.setUp(CallkeepOptions(
      ios: CallkeepIOSOptions(
        localizedName: PackageInfo().appName,
        iconTemplateImageAssetName: Assets.logoIconTemplateImage.path,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        supportedHandleTypes: const {CallkeepHandleType.number},
      ),
    ));
  }

  @override
  void dispose() {
    callkeep.tearDown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebtritApiClient>(
          create: (context) => WebtritApiClient(Uri.parse(context.read<AppBloc>().state.coreUrl!)),
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
            token: context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<ExternalContactsRepository>(
          create: (context) => ExternalContactsRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
            periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
          ),
        ),
        RepositoryProvider<AccountRepository>(
          create: (context) => AccountRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
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
                appBloc: context.read<AppBloc>(),
                callkeep: callkeep,
              )..add(const CallStarted());
            },
          ),
        ],
        child: Router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        ),
      ),
    );
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: MainRoute.main,
        path: '/',
        builder: (context, state) => BlocListener<CallBloc, CallState>(
          listenWhen: (previous, current) => previous.activeCalls.length != current.activeCalls.length,
          listener: (context, state) {
            // TODO push/pop of call screen mechanism must be remake
            final isCallLocation = GoRouter.of(context).location == '/call';
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
          child: const MainScreen(),
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
                name: MainRoute.settingsNetwork,
                path: 'network',
                builder: (context, state) => const NetworkScreen(),
              ),
              GoRoute(
                name: MainRoute.settingsAbout,
                path: 'about',
                builder: (context, state) => const AboutScreen(),
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
                name: MainRoute.settingsTermsConditions,
                path: 'terms-conditions',
                builder: (context, state) => const TermsConditionsScreen(),
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
            path: 'contact',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: ContactScreen(state.extra as Contact),
            ),
          ),
          GoRoute(
            name: MainRoute.recent,
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
