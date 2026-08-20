import 'dart:async';

import 'startup_trace.dart';

/// Initializes the two independent push-platform branches.
///
/// Firebase Messaging depends on Firebase core, while local notifications do
/// not. Both branches are observed immediately and allowed to settle before an
/// error is reported. A Firebase-branch failure keeps priority over a local
/// notification failure, preserving deterministic startup error attribution.
Future<void> initializePushPlatform({
  required StartupTrace startupTrace,
  required Future<void> Function() initializeFirebase,
  required Future<void> Function() initializeFirebaseMessaging,
  required Future<void> Function() initializeLocalNotifications,
}) async {
  Object? firebaseError;
  StackTrace? firebaseStackTrace;
  Object? localNotificationsError;
  StackTrace? localNotificationsStackTrace;

  final firebaseBranch = () async {
    try {
      await startupTrace.measure('firebase-core', initializeFirebase);
      await startupTrace.measure('firebase-messaging', initializeFirebaseMessaging);
    } catch (error, stackTrace) {
      firebaseError = error;
      firebaseStackTrace = stackTrace;
    }
  }();
  final localNotificationsBranch = () async {
    try {
      await startupTrace.measure('local-notifications', initializeLocalNotifications);
    } catch (error, stackTrace) {
      localNotificationsError = error;
      localNotificationsStackTrace = stackTrace;
    }
  }();

  await Future.wait<void>([firebaseBranch, localNotificationsBranch]);

  if (firebaseError case final error?) {
    Error.throwWithStackTrace(error, firebaseStackTrace!);
  }
  if (localNotificationsError case final error?) {
    Error.throwWithStackTrace(error, localNotificationsStackTrace!);
  }
}
