import 'dart:async';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// This class is used to handle local notifications actions from global context
///
/// Routes the actions to the apropriate streams and holds them in a stream controller buffer
/// until it will be consumed by the apropriate app components when they are ready
class LocalNotificationsBroker {
  static final _msgActsController = StreamController<NotificationResponse>();
  static final _msgActsBroadcastStream = _msgActsController.stream.asBroadcastStream();

  /// Stream of messaging local notification actions
  /// e.g tap dismiss etc.
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<NotificationResponse> get messagingActions => _msgActsBroadcastStream;

  /// Handles the local notification action
  /// and routes it to the apropriate stream
  @pragma('vm:entry-point')
  static Future handleActionReceived(NotificationResponse response) async {
    if (_isMessagingAction(response)) _msgActsController.add(response);
  }

  static bool _isMessagingAction(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return false;
    final payloadData = json.decode(payload);
    return payloadData['chatId'] != null || payloadData['smsConversationId'] != null;
  }
}
