import 'crashlytics_utils.dart';

/// The single seam for writing app-context custom keys into the crash
/// reporting backend. Every component that owns crash-context keys (blocs,
/// cubits, CrashlyticsAppContext) takes this interface instead of calling
/// the static utils, so key writing is uniform and swappable in tests.
abstract interface class CrashKeysWriter {
  void setKey(String key, Object value);

  /// Writes a batch of keys; null values are skipped, so for optional
  /// entries a missing key means "not set".
  void setKeys(Map<String, Object?> keys);
}

/// Default writer backed by Crashlytics through the platform-split sink:
/// no-op on web, best-effort on native (a failed write never propagates).
class CrashlyticsKeysWriter implements CrashKeysWriter {
  const CrashlyticsKeysWriter();

  @override
  void setKey(String key, Object value) => CrashlyticsUtils.setKey(key, value);

  @override
  void setKeys(Map<String, Object?> keys) => CrashlyticsUtils.logAppSettings(keys);
}
