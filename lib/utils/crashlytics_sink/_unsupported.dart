// Fallback Crashlytics sink for platforms with neither dart:io nor dart:js.
// Telemetry is best-effort, so every operation is a no-op (never throws).

Future<void> crashlyticsSetUserIdentifier(String identifier) => Future.value();

Future<void> crashlyticsSetCustomKey(String key, Object value) => Future.value();

void crashlyticsLog(String message) {}

Future<void> crashlyticsRecordError(
  Object? exception,
  StackTrace? stack, {
  Object? reason,
  Iterable<Object> information = const [],
  bool fatal = false,
  bool printDetails = false,
}) => Future.value();
