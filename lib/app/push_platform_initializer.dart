import 'dart:async';

import 'startup_trace.dart';

/// Initializes the two independent push-platform branches.
///
/// Firebase Messaging depends on Firebase core, while local notifications do
/// not. Both branches are observed immediately. A Firebase-branch failure is
/// reported without waiting for local notifications, while the local branch
/// remains observed so a later failure cannot escape into the startup zone.
Future<void> initializePushPlatform({
  required StartupTrace startupTrace,
  required Future<void> Function() initializeFirebase,
  required Future<void> Function() initializeFirebaseMessaging,
  required Future<void> Function() initializeLocalNotifications,
}) async {
  Object? localNotificationsError;
  StackTrace? localNotificationsStackTrace;

  final firebaseBranch = () async {
    await startupTrace.measure('firebase-core', initializeFirebase);
    await startupTrace.measure('firebase-messaging', initializeFirebaseMessaging);
  }();
  final localNotificationsBranch = () async {
    try {
      await startupTrace.measure('local-notifications', initializeLocalNotifications);
    } catch (error, stackTrace) {
      localNotificationsError = error;
      localNotificationsStackTrace = stackTrace;
    }
  }();

  await firebaseBranch;
  await localNotificationsBranch;
  if (localNotificationsError case final error?) {
    Error.throwWithStackTrace(error, localNotificationsStackTrace!);
  }
}
