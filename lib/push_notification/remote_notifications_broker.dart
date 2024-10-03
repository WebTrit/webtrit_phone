import 'dart:async';
import 'push_notifications.dart';

/// This class is used to handle remote notifications from global context
/// It holds them in a stream controller buffer to be consumed by the apropriate app components when they are ready
class RemoteNotificationsBroker {
  static final _messagingOpenedNotifications = StreamController<AppRemoteNotification>();
  static final _messagingForegroundNotifications = StreamController<AppRemoteNotification>();
  static bool _isMessagingNotification(AppRemoteNotification notification) {
    if (notification is ChatsNotification || notification is SmsNotification) return true;
    return false;
  }

  /// Stream of chat remote notifications that tapped by user and opened the app
  static Stream<AppRemoteNotification> get messagingOpenedNotifications => _messagingOpenedNotifications.stream;

  /// Stream of chat remote notifications that received while the app is in foreground
  static Stream<AppRemoteNotification> get messagingForegroundNotifications => _messagingForegroundNotifications.stream;

  static void handleOpenedNotification(AppRemoteNotification notification) {
    if (_isMessagingNotification(notification)) _messagingOpenedNotifications.add(notification);
  }

  static void handleForegroundNotification(AppRemoteNotification notification) {
    if (_isMessagingNotification(notification)) _messagingForegroundNotifications.add(notification);
  }
}
