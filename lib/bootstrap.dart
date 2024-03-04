import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/app_bloc_observer.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/path_provider/_native.dart';

import 'environment_config.dart';
import 'fcm_handler.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  final logger = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();
      await _initFirebaseMessaging();

      if (!kIsWeb && kDebugMode) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        await FirebaseCrashlytics.instance.deleteUnsentReports();
      }
      FlutterError.onError = (details) {
        logger.severe('FlutterError', details.exception, details.stack);
        if (!kIsWeb) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        }
      };

      await AppInfo.init();
      await AppPermissions.init();
      await AppPreferences.init();
      await DeviceInfo.init();
      await PackageInfo.init();
      await SecureStorage.init();
      await AppThemes.init();

      Bloc.observer = AppBlocObserver();

      runApp(await builder());
    },
    (error, stackTrace) {
      logger.severe('runZonedGuarded', error, stackTrace);
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      }
    },
  );
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _initFirebaseMessaging() async {
  final logger = Logger('FirebaseMessaging');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.info('onMessage: ${message.toMap()}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.info('onMessageOpenedApp: ${message.toMap()}');
  });
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    logger.info('initialMessage: ${initialMessage.toMap()}');
  }

  // actual FirebaseMessaging permission request executed in [PermissionsCubit]
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger('main');

  final applicationDocumentsPath = await getApplicationDocumentsPath();

  // TODO: Handle creating the database class AppDatabase multiple times
  final appDatabase = FCMIsolateDatabase.instance(
    createAppDatabaseConnection(
      applicationDocumentsPath,
      'db.sqlite',
      logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
    ),
  );

  final repository = RecentsRepository(
    appDatabase: appDatabase,
  );

  final fcmHandler = FCMHandler(logger, repository);

  await fcmHandler.execute(message);

  logger.info('onBackgroundMessage: ${message.toMap()}');
}

class FCMIsolateDatabase extends AppDatabase {
  FCMIsolateDatabase(super.e);

  static FCMIsolateDatabase? _instance;

  static instance(executor) {
    _instance ??= FCMIsolateDatabase(executor);

    return _instance!;
  }
}
