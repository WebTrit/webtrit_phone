import 'dart:async';
import 'push_notifications.dart';

/// This class is used to handle remote push notifications from global context
///
/// Routes push to the apropriate streams and holds them in a stream controller buffer
/// until it will be consumed by the apropriate app components when they are ready
class RemotePushBroker {
  // Messaging remote push that open app
  static final _msgOpenedController = StreamController<MessagePush>();
  static final _msgOpenedBroadcastStream = _msgOpenedController.stream.asBroadcastStream();

  // Messaging remote push that received while the app was in foreground
  static final _msgForegroundController = StreamController<MessagePush>();
  static final _msgForegroundBroadcastStream = _msgForegroundController.stream.asBroadcastStream();

  // System remote push that open app
  static final _snOpenedController = StreamController<SystemNotificationPush>();
  static final _snOpenedBroadcastStream = _snOpenedController.stream.asBroadcastStream();

  // System remote push that received while the app was in foreground
  static final _snForegroundController = StreamController<SystemNotificationPush>();
  static final _snForegroundBroadcastStream = _snForegroundController.stream.asBroadcastStream();

  /// Stream of messaging remote push that opens app
  /// while the app was in terminated state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<MessagePush> get messagingOpenedPushs => _msgOpenedBroadcastStream;

  /// Stream of messaging remote push that received
  /// while the app was in foreground state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<MessagePush> get messagingForegroundPushs => _msgForegroundBroadcastStream;

  /// Stream of system remote push that opens app
  /// while the app was in terminated state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<SystemNotificationPush> get systemNotificationsOpenedPushs => _snOpenedBroadcastStream;

  /// Stream of system remote push that received
  /// while the app was in foreground state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<SystemNotificationPush> get systemNotificationsForegroundPushs => _snForegroundBroadcastStream;

  /// Handles the remote notification that opens the app
  /// and routes it to the apropriate stream
  static void handleOpenedPush(AppRemotePush notification) {
    if (notification is MessagePush) _msgOpenedController.add(notification);
    if (notification is SystemNotificationPush) _snOpenedController.add(notification);
  }

  /// Handles the remote notification that received while the app was in foreground
  /// and routes it to the apropriate stream
  static void handleForegroundPush(AppRemotePush notification) {
    if (notification is MessagePush) _msgForegroundController.add(notification);
    if (notification is SystemNotificationPush) _snForegroundController.add(notification);
  }
}
