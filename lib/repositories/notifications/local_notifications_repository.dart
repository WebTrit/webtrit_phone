import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class LocalNotificationRepository {
  /// Stream of messaging notification actions that were tapped or dismissed
  Stream<AppLocalNotificationAction> get messagingActions;
  Future<void> displayNotification(AppLocalNotification notification);
  Future<void> dissmissNotification(int id);
}

/// This class is used to handle local notifications user Flutter Local Notifications plugin
class LocalNotificationRepositoryFLNImpl implements LocalNotificationRepository {
  @override
  Stream<AppLocalNotificationAction> get messagingActions {
    return LocalNotificationsBroker.messagingActions.map((action) {
      final payload = action.payload;
      return AppLocalNotificationAction(
        id: action.id ?? -1,
        payload: payload != null ? json.decode(payload) : {},
        type: LocalNotificationActionType.tap,
      );
    });
  }

  @override
  Future<void> displayNotification(AppLocalNotification notification) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'local_channel',
      'local channel',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.active,
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    FlutterLocalNotificationsPlugin().show(
      notification.id,
      notification.title,
      notification.body,
      notificationDetails,
      payload: const JsonEncoder().convert(notification.payload ?? {}),
    );
  }

  @override
  Future<void> dissmissNotification(int id) async {
    FlutterLocalNotificationsPlugin().cancel(id);
  }
}
