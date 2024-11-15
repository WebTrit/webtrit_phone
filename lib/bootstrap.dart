import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/app_bloc_observer.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'background_call_handler.dart';
import 'environment_config.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  _initLogs();

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

Future<void> _initFirebaseMessaging() async {
  final logger = Logger('FirebaseMessaging');

  FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.info('onMessage: ${message.toMap()}');
    final appNotification = AppRemoteNotification.fromFCM(message);
    RemoteNotificationsBroker.handleForegroundNotification(appNotification);

    // Type of notification for testing purposes
    _dHandleInspectPushNotification(message.data, false);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.info('onMessageOpenedApp: ${message.toMap()}');
    final appNotification = AppRemoteNotification.fromFCM(message);
    RemoteNotificationsBroker.handleOpenedNotification(appNotification);
  });
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    logger.info('initialMessage: ${initialMessage.toMap()}');
    final appNotification = AppRemoteNotification.fromFCM(initialMessage);
    RemoteNotificationsBroker.handleOpenedNotification(appNotification);
  }

  // actual FirebaseMessaging permission request executed in [PermissionsCubit]
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  _initLogs();
  final appNotification = AppRemoteNotification.fromFCM(message);
  final logger = Logger('_firebaseMessagingBackgroundHandler')..info('RemoteNotification: $appNotification');

  // Type of notification for testing purposes
  _dHandleInspectPushNotification(message.data, true);

  if (appNotification is PendingCallNotification && Platform.isAndroid) {
    final call = appNotification.call;

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());
    final appDatabase = await IsolateDatabase.create();
    final repository = RecentsRepository(appDatabase: appDatabase);

    logger.info('Initial incoming call');

    BackgroundCallHandler(call, repository).init();
  }
  if (appNotification is MessageNotification) {
    final appDatabase = await IsolateDatabase.create();
    final repo = ActiveMessageNotificationsRepositoryDriftImpl(appDatabase: appDatabase);

    final activeMessageNotification = ActiveMessageNotification(
      notificationId: appNotification.id,
      messageId: appNotification.messageId,
      conversationId: appNotification.conversationId,
      title: appNotification.title ?? '',
      body: appNotification.body ?? '',
      time: DateTime.now(),
    );
    await repo.set(activeMessageNotification);
  }
}

Future _initLocalNotifications() async {
  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: LocalNotificationsBroker.handleActionReceived,
    onDidReceiveBackgroundNotificationResponse: LocalNotificationsBroker.handleActionReceived,
  );

  final launchDetails = await FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();
  final data = launchDetails?.notificationResponse;
  if (data != null) LocalNotificationsBroker.handleActionReceived(data);
}

// Debugging push notifications
void _dHandleInspectPushNotification(Map<String, dynamic> data, bool background) {
  if (data.containsKey('type') && data['type'] == 'inspect-push') {
    final title = data['title'] ?? 'Inspect Notification';
    final body =
        "${data['body'] ?? 'This is a local notification for testing notifications'} ${background ? 'Background' : 'Foreground'}";

    _dShowInspectLocalNotification(title: title, body: body);
  }
}

// Debugging push notifications
Future<void> _dShowInspectLocalNotification({
  required String title,
  required String body,
}) async {
  await FlutterLocalNotificationsPlugin().show(
    0,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'inspect_push_channel',
        'Inspect Push Notifications',
        channelDescription: 'Channel for debugging push notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}
