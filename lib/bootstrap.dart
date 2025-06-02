import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:webtrit_phone/features/call/call.dart' show onPushNotificationSyncCallback, onSignalingSyncCallback;

import 'firebase_options.dart';

Future<void> bootstrap() async {
  await _initFirebase();
  await _initFirebaseMessaging();
  await _initLocalNotifications();

  // Remote configuration
  final remoteCacheConfigService = await DefaultRemoteCacheConfigService.init();
  final remoteFirebaseConfigService = await FirebaseRemoteConfigService.init(remoteCacheConfigService);

  // Initialization order is crucial for proper app setup

  final appThemes = await AppThemes.init();

  final appPreferences = await AppPreferencesFactory.init();
  final featureAccess = FeatureAccess.init(appThemes.appConfig, appPreferences);
  final appInfo = await AppInfo.init(FirebaseAppIdProvider());
  final deviceInfo = await DeviceInfoFactory.init();
  final packageInfo = await PackageInfoFactory.init();
  final secureStorage = await SecureStorage.init();

  await AppPath.init();
  await AppPermissions.init(featureAccess);
  await AppCertificates.init();
  await AppTime.init();
  await SessionCleanupWorker.init();
  await AppLogger.init(
    remoteConfigService: remoteFirebaseConfigService,
    packageInfo: packageInfo,
    deviceInfo: deviceInfo,
    appInfo: appInfo,
    secureStorage: secureStorage,
  );

  await _initCallkeep(appPreferences, featureAccess);
}

Future<void> _initCallkeep(AppPreferences appPreferences, FeatureAccess featureAccess) async {
  if (!Platform.isAndroid) return;

  AndroidCallkeepServices.backgroundSignalingBootstrapService.initializeCallback(onSignalingSyncCallback);
  AndroidCallkeepServices.backgroundPushNotificationBootstrapService.initializeCallback(onPushNotificationSyncCallback);

// If the fallback incoming call trigger via SMS is enabled in the feature access config
  if (featureAccess.callFeature.callTriggerConfig.smsFallback.enabled) {
    // Configure Android CallKeep to process incoming SMS messages
    // - prefix: filters SMS messages by required prefix
    // - regexPattern: extracts callId, handle, displayName, and hasVideo from the SMS body
    await AndroidCallkeepServices.smsReceptionConfig.configureReceivedSms(
      prefix: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS_PREFIX,
      regexPattern: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN,
    );
  }
}

/// Initializes Firebase for background services. This initialization must be called in an isolate
/// when Firebase components are used. For more details, refer to the Firebase documentation:
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive
Future<void> _initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    Logger('Firebase').severe('Error in _initFirebase', e);
  }
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
  final logger = Logger('_firebaseMessagingBackgroundHandler');

  // Cache remote configuration
  final remoteCacheConfigService = await DefaultRemoteCacheConfigService.init();

  // Initialize the logger for handling Firebase Cloud Messaging (FCM) in the background isolate.
  final appInfo = await AppInfo.init(const SharedPreferencesAppIdProvider());
  final deviceInfo = await DeviceInfoFactory.init();
  final packageInfo = await PackageInfoFactory.init();
  final secureStorage = await SecureStorage.init();

  await AppLogger.init(
    remoteConfigService: remoteCacheConfigService,
    packageInfo: packageInfo,
    deviceInfo: deviceInfo,
    appInfo: appInfo,
    secureStorage: secureStorage,
  );

  final appNotification = AppRemoteNotification.fromFCM(message);

  logger.info('onBackgroundMessage: ${message.toMap()}');

  // Type of notification for testing purposes
  _dHandleInspectPushNotification(message.data, true);

  if (appNotification is PendingCallNotification && Platform.isAndroid) {
    final appDatabase = await IsolateDatabase.create();
    final contactsRepository = ContactsRepository(appDatabase: appDatabase);

    final contact = await contactsRepository.getContactByPhoneNumber(appNotification.call.handle);
    final displayName = contact?.maybeName ?? appNotification.call.displayName;

    AndroidCallkeepServices.backgroundPushNotificationBootstrapService.reportNewIncomingCall(
      appNotification.call.id,
      CallkeepHandle.number(appNotification.call.handle),
      displayName: displayName,
      hasVideo: appNotification.call.hasVideo,
    );
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
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
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
