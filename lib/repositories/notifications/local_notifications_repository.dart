import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class LocalNotificationRepository {
  /// Stream of messaging notification actions that were tapped or dismissed
  Stream<AppLocalNotificationAction> get messagingActions;

  /// Display a local push notification
  Future<void> displayNotification(AppLocalNotification notification);

  /// Dismiss a local push notification by its id (if it exists)
  Future<void> dissmissById(int id);

  /// Dismiss a local push notification by matching its title and body
  /// useful for dismissing notifications showen by other services like FCM or OneSignal etc.
  Future<void> dismissByContent(String title, String body);
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
    FlutterLocalNotificationsPlugin().show(
      notification.id,
      notification.title,
      notification.body,
      kNotificationDetails,
      payload: jsonEncode(notification.payload ?? {}),
    );
  }

  @override
  Future<void> dissmissById(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
  }

  @override
  Future<void> dismissByContent(String title, String body) async {
    final active = await FlutterLocalNotificationsPlugin().getActiveNotifications();
    final matched = active.where((n) => n.title == title && n.body == body).toList();
    for (final n in matched) {
      await FlutterLocalNotificationsPlugin().cancel(n.id ?? 0, tag: n.tag);
    }
  }
}

const kAndroidNotificationDetails = AndroidNotificationDetails(
  'local_channel',
  'local channel',
  importance: Importance.defaultImportance,
  priority: Priority.defaultPriority,
);
const kDarwinNotificationDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
  interruptionLevel: InterruptionLevel.active,
);
const kNotificationDetails = NotificationDetails(
  android: kAndroidNotificationDetails,
  iOS: kDarwinNotificationDetails,
);
