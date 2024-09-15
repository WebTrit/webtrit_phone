import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

/// This class is used to handle remote notifications from global context
/// It holds them in a stream controller buffer to be consumed by the apropriate app components when they are ready
class FirebaseNotificationsBroker {
  static final _messagingOpenedNotifications = StreamController<RemoteMessage>();
  static final _messagingForegroundNotifications = StreamController<RemoteMessage>();
  static bool _isMessagingNotification(RemoteMessage message) {
    return message.data['chat_id'] != null || message.data['sms_conversation_id'] != null;
  }

  /// Stream of chat remote notifications that tapped by user and opened the app
  static Stream<RemoteMessage> get messagingOpenedNotifications => _messagingOpenedNotifications.stream;

  /// Stream of chat remote notifications that received while the app is in foreground
  static Stream<RemoteMessage> get messagingForegroundNotifications => _messagingForegroundNotifications.stream;

  static void handleOpenedNotification(RemoteMessage message) {
    if (_isMessagingNotification(message)) _messagingOpenedNotifications.add(message);
  }

  static void handleForegroundNotification(RemoteMessage message) {
    if (_isMessagingNotification(message)) _messagingForegroundNotifications.add(message);
  }
}
