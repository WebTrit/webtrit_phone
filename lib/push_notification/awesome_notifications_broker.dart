import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';

/// This class is used to handle local notifications actions from global context
/// It holds them in a stream controller buffer to be consumed by the apropriate app components when they are ready
class AwesomeNotificationsBroker {
  static final StreamController<ReceivedAction> _chatActions = StreamController();

  /// Stream of chat local notifications actions, tap dismiss etc.
  static Stream<ReceivedAction> get chatActionsStream => _chatActions.stream;

  @pragma('vm:entry-point')
  static Future handleActionReceived(ReceivedAction action) async {
    if (action.channelKey == 'chats_channel') _chatActions.add(action);
  }
}
