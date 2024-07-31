import 'dart:async';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// This class is used to handle local notifications actions from global context
/// It holds them in a stream controller buffer to be consumed by the apropriate app components when they are ready
class LocalNotificationsBroker {
  static final StreamController<NotificationResponse> _chatActions = StreamController();

  /// Stream of chat local notifications actions, tap dismiss etc.
  static Stream<NotificationResponse> get chatActionsStream => _chatActions.stream;

  @pragma('vm:entry-point')
  static Future handleActionReceived(NotificationResponse response) async {
    final payload = response.payload;
    if (payload == null) return;
    final payloadData = json.decode(payload);
    if (payloadData['chatId'] != null) _chatActions.add(response);
  }
}
