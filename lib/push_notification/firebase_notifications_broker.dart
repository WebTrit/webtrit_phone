import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

/// This class is used to handle remote notifications from global context
/// It holds them in a stream controller buffer to be consumed by the apropriate app components when they are ready
class FirebaseNotificationsBroker {
  static final StreamController<RemoteMessage> _chatOpenedMessages = StreamController();

  /// Stream of chat remote notifications that tapped by user and opened the app
  static Stream<RemoteMessage> get chatOpenedMessagesStream => _chatOpenedMessages.stream;

  static final StreamController<RemoteMessage> _chatForegroundMessages = StreamController();

  /// Stream of chat remote notifications that received while the app is in foreground
  static Stream<RemoteMessage> get chatForegroundMessagesStream => _chatForegroundMessages.stream;

  static void handleOpenedMessage(RemoteMessage message) {
    if (message.data['chat_id'] != null) {
      _chatOpenedMessages.add(message);
    }
  }

  static void handleForegroundMessage(RemoteMessage message) {
    if (message.data['chat_id'] != null) {
      _chatForegroundMessages.add(message);
    }
  }
}
