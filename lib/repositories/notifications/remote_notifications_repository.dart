import 'package:webtrit_phone/push_notification/push_notifications.dart';

abstract class RemoteNotificationRepository {
  /// Stream of messaging notifications that were tapped and opened the app from a background or terminated state
  Stream<AppRemoteNotification> get messagingOpenedNotifications;

  /// Stream of messaging notifications that were received while the app was in the foreground
  Stream<AppRemoteNotification> get messagingForegroundNotifications;
}

/// This class is used to handle remote notifications from global context broker
class RemoteNotificationRepositoryBrokerImpl implements RemoteNotificationRepository {
  @override
  Stream<AppRemoteNotification> get messagingOpenedNotifications {
    return RemoteNotificationsBroker.messagingOpenedNotifications;
  }

  @override
  Stream<AppRemoteNotification> get messagingForegroundNotifications {
    return RemoteNotificationsBroker.messagingForegroundNotifications;
  }
}
