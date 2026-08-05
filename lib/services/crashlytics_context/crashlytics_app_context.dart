import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/utils/utils.dart';

/// Base for the Crashlytics context writers. Light on purpose: it holds only
/// the key-writing port. A feature that owns crash-context keys derives its
/// own context with typed log methods, so the key names and value formats
/// live in one place per feature and consumers never touch raw keys.
abstract class CrashlyticsAppContext {
  const CrashlyticsAppContext({this.crashKeysWriter = const CrashlyticsKeysWriter()});

  final CrashKeysWriter crashKeysWriter;

  @protected
  void setKey(String key, Object value) => crashKeysWriter.setKey(key, value);

  @protected
  void setKeys(Map<String, Object?> keys) => crashKeysWriter.setKeys(keys);
}
