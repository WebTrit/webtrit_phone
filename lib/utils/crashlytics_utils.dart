import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Small helper around Firebase Crashlytics for consistent context logging.
class CrashlyticsUtils {
  CrashlyticsUtils._();

  /// Returns a stable label for the current execution context.
  /// - Mobile/Desktop: `debugName` if set, otherwise `isolate-<hash>`
  /// - Web: always `web-main` (Flutter Web has no true isolates)
  static String currentIsolateLabel({String webLabel = 'web-main'}) {
    if (kIsWeb) return webLabel;
    final dbg = Isolate.current.debugName;
    return dbg?.isNotEmpty == true ? dbg! : 'isolate-${Isolate.current.hashCode}';
  }

  /// Writes useful isolate/platform context into Crashlytics custom keys.
  static Future<void> logIsolateInfo() async {
    final label = currentIsolateLabel();
    final dbg = kIsWeb ? null : Isolate.current.debugName;
    final hash = kIsWeb ? null : Isolate.current.hashCode;

    final crashlytics = FirebaseCrashlytics.instance;
    unawaited(crashlytics.setCustomKey('isolate_label', label));
    if (dbg != null) unawaited(crashlytics.setCustomKey('isolate_debugName', dbg));
    if (hash != null) unawaited(crashlytics.setCustomKey('isolate_hash', hash));
  }

  /// Sets Crashlytics user + common session keys.
  /// Call this right after successful login.
  static Future<void> logSession({
    required String userId,
    required String tenantId,
    required String coreUrl,
  }) async {
    final crashlytics = FirebaseCrashlytics.instance;
    unawaited(crashlytics.setUserIdentifier(userId));
    unawaited(crashlytics.setCustomKey('tenantId', tenantId));
    unawaited(crashlytics.setCustomKey('coreUrl', coreUrl));
    await logIsolateInfo();
  }

  /// Convenience wrappers
  static void setKey(String key, Object value) {
    unawaited(FirebaseCrashlytics.instance.setCustomKey(key, value));
  }

  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }
}
