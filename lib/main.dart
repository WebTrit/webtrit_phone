import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/blocs/logging_bloc_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/environment_config.dart';

void main() async {
  final logger = Logger('main');

  FlutterError.onError = (details) {
    logger.severe('Flutter framework error', details.exception, details.stack);
  };

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

  DriftIsolate isolate = await AppDatabase.spawn(AppPath().databasePath);

  final app = Provider<AppDatabase>(
    create: (context) => AppDatabase.fromIsolate(isolate),
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationsBloc>(
            create: (BuildContext context) => NotificationsBloc(),
          ),
          BlocProvider<AppBloc>(
            create: (BuildContext context) => AppBloc(),
          ),
        ],
        child: App(
          webRegistrationInitialUrl: await SecureStorage().readWebRegistrationInitialUrl(),
          isRegistered: await SecureStorage().readToken() != null,
        ),
      ),
    ),
  );

  await runZonedGuarded(
    () async => BlocOverrides.runZoned(
      () => runApp(app),
      blocObserver: LoggingBlocObserver(),
    ),
    (error, stackTrace) => logger.severe('Top zone error', error, stackTrace),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger('main');

  await Firebase.initializeApp();

  logger.info('onBackgroundMessage: ${message.toS()}');
}
