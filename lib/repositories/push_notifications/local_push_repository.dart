import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class LocalPushRepository {
  /// Stream of messaging notification actions that were tapped or dismissed
  Stream<AppLocalPushAction> get messagingActions;

  /// Stream of system notification actions that were tapped or dismissed
  Stream<AppLocalPushAction> get systemNotificationsActions;

  /// Display a local push notification
  Future<void> displayPush(AppLocalPush notification);

  /// Dismiss a local push notification by its id (if it exists)
  Future<void> dissmissById(int id);

  /// Dismiss a local push notification by matching its title and body
  /// useful for dismissing notifications showen by other services like FCM or OneSignal etc.
  Future<void> dismissByContent(String title, String body);
}

/// This class is used to handle local notifications user Flutter Local Pushs plugin
class LocalPushRepositoryFLNImpl implements LocalPushRepository {
  @override
  Stream<AppLocalPushAction> get messagingActions {
    return LocalPushsBroker.messagingActions.map((action) {
      final payload = action.payload;
      return AppLocalPushAction(
        id: action.id ?? -1,
        payload: payload != null ? json.decode(payload) : {},
        type: LocalPushActionType.tap,
      );
    });
  }

  @override
  Stream<AppLocalPushAction> get systemNotificationsActions {
    return LocalPushsBroker.systemNotificationsActions.map((action) {
      final payload = action.payload;
      return AppLocalPushAction(
        id: action.id ?? -1,
        payload: payload != null ? json.decode(payload) : {},
        type: LocalPushActionType.tap,
      );
    });
  }

  @override
  Future<void> displayPush(AppLocalPush notification) async {
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
const kNotificationDetails = NotificationDetails(android: kAndroidNotificationDetails, iOS: kDarwinNotificationDetails);
