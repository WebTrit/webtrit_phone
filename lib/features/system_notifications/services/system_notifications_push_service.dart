import 'dart:async';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/push_notification/app_local_push.dart';
import 'package:webtrit_phone/push_notification/app_local_push_action.dart';
import 'package:webtrit_phone/push_notification/app_remote_push.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// A service responsible for handling push notifications related to system notifications.
///
/// This class provides methods to manage the delivery, reception, and processing
/// of push notifications within the application.
///
/// Main usecases:
///   - Displaying local push notifications when a system notification is received. (For push-less clients)
///   - Handling user actions on push notifications, such as tapping to open the notifications screen.
///   - Dismissing push notifications when a system notification is marked as seen.
class SystemNotificationsPushService {
  SystemNotificationsPushService(
    this.remotePushRepository,
    this.localPushRepository,
    this.systemNotificationsLocalRepository, {
    required this.openNotifications,
    required this.producePush,
  });

  final RemotePushRepository remotePushRepository;
  final LocalPushRepository localPushRepository;
  final SystemNotificationsLocalRepository systemNotificationsLocalRepository;
  final Function() openNotifications;
  final bool producePush;

  final List<StreamSubscription> _subs = [];

  void init() async {
    _subs.add(systemNotificationsLocalRepository.eventBus.listen(_onLocalEvent));
    _subs.add(localPushRepository.systemNotificationsActions.listen(_onLocalPushAction));
    _subs.add(remotePushRepository.systemNotificationsOpenedPushs.listen(_onOpenPush));
    _subs.add(remotePushRepository.systemNotificationsForegroundPushs.listen(_onForegroundPush));
  }

  Future<void> _onLocalEvent(SystemNotificationEvent event) async {
    switch (event) {
      case SystemNotificationUpdate _:
        final notification = event.notification;
        if (notification.seen == true) {
          localPushRepository.dismissByContent(notification.title, notification.content);
        }
        if (event.initialData == false && notification.seen == false && producePush) {
          _displayPush(notification.id, notification.title, notification.content);
        }
      case SystemNotificationOutboxUpdate _:
        final entry = event.entry;
        if (entry.actionType == SnOutboxActionType.seen) {
          final notification = await systemNotificationsLocalRepository.getNotificationById(entry.notificationId);
          if (notification != null) localPushRepository.dismissByContent(notification.title, notification.content);
        }
      default:
        break;
    }
  }

  void _onLocalPushAction(AppLocalPushAction action) {
    if (action.type == LocalPushActionType.tap) openNotifications();
  }

  void _onOpenPush(SystemNotificationPush notification) {
    openNotifications();
  }

  void _onForegroundPush(SystemNotificationPush notification) {
    final (title, body) = (notification.title, notification.body);
    if (title == null || body == null) return;
    _displayPush(notification.notificationId, title, body);
  }

  void _displayPush(int id, String title, String body) {
    final push = AppLocalPush(id, title, body, payload: {'source': kLocalPushSourceSystemNotification});
    localPushRepository.displayPush(push);
  }

  void dispose() {
    for (final sub in _subs) {
      sub.cancel();
    }
    _subs.clear();
  }
}
