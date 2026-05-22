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
  Future<void> displayPush(AppLocalPush notification) {
    return FlutterLocalNotificationsPlugin().show(
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

/// Notification channel id for app-displayed local pushes (messages, missed
/// calls, system notifications).
///
/// Deliberately differs from [kLegacyLocalPushChannelId]: Android caches a
/// channel's importance at creation time, so raising importance on an existing
/// channel has no effect for users who already have it. A new id forces the
/// high-importance channel to be created.
///
/// Keep this value in sync with `default_notification_channel_id` in
/// android/app/src/main/AndroidManifest.xml.
const kLocalPushChannelId = 'app_notifications_channel';

/// Human-readable name shown for [kLocalPushChannelId] in the system settings.
const kLocalPushChannelName = 'Notifications';

/// Legacy channel id created with default importance. Deleted on startup so it
/// no longer lingers in the system notification settings.
@Deprecated(
  'Retained only to delete the old default-importance channel on startup. '
  'Remove this constant together with the deleteNotificationChannel cleanup '
  'once existing installs have migrated to kLocalPushChannelId.',
)
const kLegacyLocalPushChannelId = 'local_channel';

const kAndroidNotificationDetails = AndroidNotificationDetails(
  kLocalPushChannelId,
  kLocalPushChannelName,
  importance: Importance.high,
  priority: Priority.high,
);
const kDarwinNotificationDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
  interruptionLevel: InterruptionLevel.active,
);
const kNotificationDetails = NotificationDetails(android: kAndroidNotificationDetails, iOS: kDarwinNotificationDetails);
