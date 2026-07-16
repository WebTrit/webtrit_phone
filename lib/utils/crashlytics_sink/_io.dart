import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// Native Crashlytics sink: forwards to FirebaseCrashlytics.instance.

Future<void> crashlyticsSetUserIdentifier(String identifier) =>
    FirebaseCrashlytics.instance.setUserIdentifier(identifier);

Future<void> crashlyticsSetCustomKey(String key, Object value) => FirebaseCrashlytics.instance.setCustomKey(key, value);

void crashlyticsLog(String message) => FirebaseCrashlytics.instance.log(message);

Future<void> crashlyticsRecordError(
  Object? exception,
  StackTrace? stack, {
  Object? reason,
  Iterable<Object> information = const [],
  bool fatal = false,
  bool printDetails = false,
}) => FirebaseCrashlytics.instance.recordError(
  exception,
  stack,
  reason: reason,
  information: information,
  fatal: fatal,
  printDetails: printDetails,
);
