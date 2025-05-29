import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class RemotePushRepository {
  /// Stream of messaging notifications that were tapped and opened the app from a background or terminated state
  Stream<MessagePush> get messagingOpenedPushs;

  /// Stream of messaging notifications that were received while the app was in the foreground
  Stream<MessagePush> get messagingForegroundPushs;

  /// Stream of system notifications that were tapped and opened the app from a background or terminated state
  Stream<SystemNotificationPush> get systemNotificationsOpenedPushs;

  /// Stream of system notifications that were received while the app was in the foreground
  Stream<SystemNotificationPush> get systemNotificationsForegroundPushs;
}

/// This class is used to handle remote notifications from global context broker
class RemotePushRepositoryBrokerImpl implements RemotePushRepository {
  @override
  Stream<MessagePush> get messagingOpenedPushs => RemotePushBroker.messagingOpenedPushs;

  @override
  Stream<MessagePush> get messagingForegroundPushs => RemotePushBroker.messagingForegroundPushs;

  @override
  Stream<SystemNotificationPush> get systemNotificationsOpenedPushs => RemotePushBroker.systemNotificationsOpenedPushs;

  @override
  Stream<SystemNotificationPush> get systemNotificationsForegroundPushs =>
      RemotePushBroker.systemNotificationsForegroundPushs;
}
