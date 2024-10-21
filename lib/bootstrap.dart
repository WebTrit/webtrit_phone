import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/app_bloc_observer.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/path_provider/_native.dart';

import 'services/background_call_handler.dart';
import 'environment_config.dart';
import 'firebase_options.dart';
import 'models/models.dart';
import 'services/background_call_isolate.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  _initLogs();

  final logger = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();

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

      // Initialization order is crucial for proper app setup
      await AppInfo.init();
      await AppThemes.init();
      await AppPreferences.init();
      await FeatureAccess.init();
      await AppPermissions.init();
      await DeviceInfo.init();
      await PackageInfo.init();
      await SecureStorage.init();
      await AppSound.init(outgoingCallRingAsset: Assets.ringtones.outgoingCall1);
      await AppCertificates.init();
      await AppTime.init();
      await SessionCleanupWorker.init();

      Bloc.observer = AppBlocObserver();

      await _initFirebaseMessaging();
      await _initCallkeepService();

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

_initLogs() {
  hierarchicalLoggingEnabled = true;
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));
}

@pragma('vm:entry-point')
Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _initCallkeepService() async {
  CallkeepBackgroundService.initialize(
    onStart: onStartForegroundService,
    onChangedLifecycle: onChangedLifecycle,
    startServiceOnInitialization: false,
    androidNotificationChannelName: 'Webtrit Inbound Calls Service',
    androidNotificationChannelDescription: 'This is required to receive calls while in background',
  );

  final socketIncomingCall = AppPreferences().getIncomingCallType() == IncomingCallType.socket;
  final authorized = SecureStorage().readCoreUrl() != null && SecureStorage().readToken() != '';

  if (socketIncomingCall && authorized) {
    Future.delayed(Duration.zero, () {
      CallkeepBackgroundService().wakeUpBackgroundHandler(autoRestart: true);
    });
  }

  if (Platform.isAndroid) {
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());
  }
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
  AppPreferences.init();

  if (AppPreferences().getIncomingCallType() == IncomingCallType.pushNotification) {
    CallkeepBackgroundService().wakeUpBackgroundHandler(autoRestart: false);
  }
}

class CallkeepLogs implements CallkeepLogsDelegate {
  final _logger = Logger('CallkeepLogs');

  @override
  void onLog(CallkeepLogType type, String tag, String message) {
    _logger.info('$tag $message');
  }
}

class FCMIsolateDatabase extends AppDatabase {
  FCMIsolateDatabase(super.e);

  static FCMIsolateDatabase? _instance;

  static Future<FCMIsolateDatabase> db() async {
    return FCMIsolateDatabase.instance(
      createAppDatabaseConnection(
        await getApplicationDocumentsPath(),
        'db.sqlite',
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      ),
    );
  }

  static instance(executor) {
    _instance ??= FCMIsolateDatabase(executor);

    return _instance!;
  }
}
