import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/app_bloc_observer.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/path_provider/_native.dart';

import 'background_call_handler.dart';
import 'environment_config.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  final logger = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();
      await _initFirebaseMessaging();
      await _initLocalNotifications();

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
      await AppSound.init(outgoingCallRingAsset: Assets.ringtones.outgoingCall1);
      await AppCertificates.init();
      await AppTime.init();

      if (Platform.isAndroid) {
        WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());
      }

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

@pragma('vm:entry-point')
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
  final logger = Logger('FCM')..info('_firebaseMessagingBackgroundHandler: ${message.toMap()}');

  final fcmHandler = FCMHandler(message);
  final fcmType = fcmHandler.getMessageType();

  logger.info('Push notification type: $fcmType');

  if (fcmType == FCMType.call && Platform.isAndroid) {
    final call = fcmHandler.getPendingCall()!;
    final logger = Logger('_backgroundAndroidCall')..info('Initial call: $call');

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    final appDatabase = FCMIsolateDatabase.instance(
      createAppDatabaseConnection(
        await getApplicationDocumentsPath(),
        'db.sqlite',
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      ),
    );
    final repository = RecentsRepository(
      appDatabase: appDatabase,
    );

    logger.info('Initial incoming call');

    BackgroundCallHandler(call, repository).init();
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

  static instance(executor) {
    _instance ??= FCMIsolateDatabase(executor);

    return _instance!;
  }
}

Future _initLocalNotifications() async {
  await AwesomeNotifications().initialize(
    null,
    [
      // init basic channel
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white),
      // init chats channel
      NotificationChannel(
          channelGroupKey: 'chats_channel_group',
          channelKey: 'chats_channel',
          channelName: 'Chats notifications',
          channelDescription: 'Notification channel for chats',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white),
    ],
  );
}
