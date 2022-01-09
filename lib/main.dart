import 'dart:convert';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/logging_bloc_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/settings.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/environment_config.dart';

void main() async {
  final logger = Logger('main');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.info('onMessage: ${message.toS()}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.info('onMessageOpenedApp: ${message.toS()}');
  });
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    logger.info('initialMessage: ${initialMessage.toS()}');
  }

  final notificationSettings = await FirebaseMessaging.instance.requestPermission();
  if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
    logger.info('FirebaseMessaging request permission: User granted permission');
  } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
    logger.info('FirebaseMessaging request permission: User granted provisional permission');
  } else {
    logger.info('FirebaseMessaging request permission: User declined or has not accepted permission');
  }

  await AppPath.init();
  await DeviceInfo.init();
  await PackageInfo.init();

  final assetManifestJson = await rootBundle.loadString('AssetManifest.json');
  final assetManifest = jsonDecode(assetManifestJson) as Map<String, dynamic>;
  await Future.wait(
    assetManifest.keys.where((String key) => key.endsWith('.svg')).map(
          (assetName) => precachePicture(
            ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, assetName),
            null,
          ),
        ),
  );

  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);

  Bloc.observer = LoggingBlocObserver();

  final app = Provider<AppDatabase>(
    create: (context) => AppDatabase(AppPath().databasePath),
    dispose: (context, value) => value.close(),
    child: MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: logRecordsRepository,
        ),
        RepositoryProvider<WebtritApiClient>(
          create: (context) => WebtritApiClient(Uri.parse(EnvironmentConfig.CORE_URL)),
        ),
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
          ),
        ),
      ],
      child: BlocProvider<AppBloc>(
        create: (context) {
          return AppBloc();
        },
        child: App(
          webRegistrationInitialUrl: await SecureStorage().readWebRegistrationInitialUrl(),
          isRegistered: await SecureStorage().readToken() != null,
        ),
      ),
    ),
  );

  runApp(app);
}

class App extends StatelessWidget {
  const App({
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

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      restorationScopeId: 'App',
      title: EnvironmentConfig.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: _initialRoute(webRegistrationInitialUrl, isRegistered),
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
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/login':
            page = const LoginPage();
            break;
          case '/web-registration':
            page = WebRegistrationPage(
              initialUrl: settings.arguments != null ? settings.arguments as String : webRegistrationInitialUrl!,
            );
            break;
          case '/main':
            page = MultiBlocProvider(
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
                      appBloc: context.read<AppBloc>(),
                    )..add(const CallAttached());
                  },
                ),
              ],
              child: BlocListener<CallBloc, CallState>(
                listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                listener: (context, state) {
                  if (state is CallActive) {
                    setCallOrientations().then((_) {
                      Navigator.pushNamed(context, '/main/call',
                          arguments: CallNavigationArguments(
                            callBloc: context.read<CallBloc>(),
                          ));
                    });
                  }
                  if (state is CallIdle && Navigator.canPop(context)) {
                    // TODO canPop must be removed by reorganise states
                    setDefaultOrientations().then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const MainPage(),
              ),
            );
            break;
          case '/main/call':
            final callNavigationArguments = settings.arguments as CallNavigationArguments;
            page = BlocProvider<CallBloc>.value(
              value: callNavigationArguments.callBloc,
              child: const CallPage(),
            );
            break;
          case '/main/settings':
            page = const SettingsPage();
            break;
          case '/main/log-records-console':
            page = const LogRecordsConsolePage();
            break;
          case '/main/contact':
            final contact = settings.arguments! as Contact;
            page = ContactPage(contact);
            break;
          case '/main/recent':
            final recent = settings.arguments! as Recent;
            page = RecentScreen(recent);
            break;
          default:
            return null;
        }

        if ('/'.allMatches(settings.name!).length <= 1) {
          // add listener only to top level page
          page = BlocListener<AppBloc, AppState>(
            listener: (context, state) async {
              if (state is AppUnregister) {
                final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
                final isRegistered = await SecureStorage().readToken() != null;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  _initialRoute(webRegistrationInitialUrl, isRegistered),
                  (route) => false,
                  arguments: webRegistrationInitialUrl,
                );
              }
            },
            child: page,
          );
        }

        switch (settings.name) {
          case '/main/call':
            return PageRouteBuilder(
              fullscreenDialog: true,
              settings: settings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return page;
              },
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                const builder = ZoomPageTransitionsBuilder();
                return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
              },
            );
          default:
            return MaterialPageRoute(
              fullscreenDialog: true,
              settings: settings,
              builder: (BuildContext context) => page,
            );
        }
      },
    );
  }
}

Future<void> setDefaultOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> setCallOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class CallNavigationArguments {
  final CallBloc callBloc;

  CallNavigationArguments({
    required this.callBloc,
  });
}

extension RemoteMessageX on RemoteMessage {
  String toS() {
    return '$RemoteMessage {\n'
        'senderId: $senderId\n'
        'category: $category\n'
        'collapseKey: $collapseKey\n'
        'contentAvailable: $contentAvailable\n'
        'data: $data\n'
        'from: $from\n'
        'messageId: $messageId\n'
        'messageType: $messageType\n'
        'mutableContent: $mutableContent\n'
        'notification: $notification\n'
        'sentTime: $sentTime\n'
        'threadId: $threadId\n'
        'ttl: $ttl\n'
        '}';
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger('main');

  await Firebase.initializeApp();

  logger.info('onBackgroundMessage: ${message.toS()}');
}
