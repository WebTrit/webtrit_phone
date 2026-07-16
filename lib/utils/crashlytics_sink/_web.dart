// Web Crashlytics sink: firebase_crashlytics has no web implementation, so
// every operation is a no-op. The web bundle never links firebase_crashlytics.

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
