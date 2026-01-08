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
    required String sessionId,
  }) async {
    final crashlytics = FirebaseCrashlytics.instance;
    unawaited(crashlytics.setUserIdentifier(userId));
    unawaited(crashlytics.setCustomKey('tenantId', tenantId));
    unawaited(crashlytics.setCustomKey('coreUrl', coreUrl));
    unawaited(crashlytics.setCustomKey('sessionId', sessionId));
    await logIsolateInfo();
  }

  /// Convenience wrappers
  static void setKey(String key, Object value) {
    unawaited(FirebaseCrashlytics.instance.setCustomKey(key, value));
  }

  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  /// Used for reporting errors manually triggered by the user via the
  /// "report a problem" feature. This is not for silent/automatic error
  /// reporting. It synthesizes an exception and stack trace to ensure it
  /// gets grouped and reported correctly in Crashlytics.
  static Future<void> reportServiceError({
    required String errorDescription,
    required String userComment,
    required Map<String, dynamic> diagnostics,
    required Map<String, dynamic> metadata,
    required Map<String, dynamic> extras,
    String errorGroup = 'UserReport.submit',
    bool isFatal = true,
  }) async {
    final crashlytics = FirebaseCrashlytics.instance;

    if (userComment.isNotEmpty) {
      _setSafeCustomKey('user_report_comment', userComment);
      crashlytics.log('User Diagnostic Comment: $userComment');
    }

    if (diagnostics.isNotEmpty) {
      crashlytics.log('Diagnostics: $diagnostics');
    }

    final allKeys = {...metadata, ...extras, ...diagnostics};

    for (final entry in allKeys.entries) {
      _setSafeCustomKey(entry.key, entry.value);
    }

    final exception = UserDiagnosticReportException(errorDescription);
    final syntheticStackTrace = StackTrace.fromString('#0      $errorGroup (user_diagnostic_report:1:1)');

    await crashlytics.recordError(
      exception,
      syntheticStackTrace,
      reason: 'Manual User Report via Service',
      fatal: isFatal,
      printDetails: true,
      information: extras.entries.map((e) => '${e.key}: ${e.value}').toList(),
    );
  }

  static void _setSafeCustomKey(String key, dynamic value) {
    final safeValue = (value is String || value is num || value is bool) ? value : value.toString();
    unawaited(FirebaseCrashlytics.instance.setCustomKey(key, safeValue));
  }
}

class UserDiagnosticReportException implements Exception {
  final String message;

  UserDiagnosticReportException(this.message);

  @override
  String toString() => message;
}
