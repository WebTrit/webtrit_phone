import 'dart:async';
import 'push_notifications.dart';

/// This class is used to handle remote notifications from global context
///
/// Routes the notifications to the apropriate streams and holds them in a stream controller buffer
/// until it will be consumed by the apropriate app components when they are ready
class RemoteNotificationsBroker {
  static final _msgOpenedNtfnController = StreamController<AppRemoteNotification>();
  static final _msgOpenedNtfnBroadcastStream = _msgOpenedNtfnController.stream.asBroadcastStream();

  static final _msgForegroundNtfnController = StreamController<AppRemoteNotification>();
  static final _msgForegroundNtfnBroadcastStream = _msgForegroundNtfnController.stream.asBroadcastStream();

  /// Stream of messaging remote notifications that opens app
  /// while the app was in terminated state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<AppRemoteNotification> get messagingOpenedNotifications => _msgOpenedNtfnBroadcastStream;

  /// Stream of messaging remote notifications that received
  /// while the app was in foreground state when the notification is tapped
  ///
  /// The stream is broadcasted so it can be listened by multiple components
  static Stream<AppRemoteNotification> get messagingForegroundNotifications => _msgForegroundNtfnBroadcastStream;

  /// Handles the remote notification that opens the app
  /// and routes it to the apropriate stream
  static void handleOpenedNotification(AppRemoteNotification notification) {
    if (notification is MessageNotification) _msgOpenedNtfnController.add(notification);
  }

  /// Handles the remote notification that received while the app was in foreground
  /// and routes it to the apropriate stream
  static void handleForegroundNotification(AppRemoteNotification notification) {
    if (notification is MessageNotification) _msgForegroundNtfnController.add(notification);
  }
}
