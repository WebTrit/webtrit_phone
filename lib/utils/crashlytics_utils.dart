import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'crashlytics_sink/crashlytics_sink.dart';

/// Small helper around Firebase Crashlytics for consistent context logging.
///
/// The actual Crashlytics calls go through a platform-split sink
/// (`crashlytics_sink/`): native forwards to `FirebaseCrashlytics.instance`,
/// web/unsupported are no-ops. This keeps `firebase_crashlytics` (which has no
/// web implementation) out of the web bundle entirely, instead of guarding each
/// call at runtime.
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

    unawaited(crashlyticsSetCustomKey('isolate_label', label));
    if (dbg != null) unawaited(crashlyticsSetCustomKey('isolate_debugName', dbg));
    if (hash != null) unawaited(crashlyticsSetCustomKey('isolate_hash', hash));
  }

  /// Sets the Crashlytics user identifier + common session keys.
  /// Call this right after successful login. The tenant/core scope keys are
  /// owned by AppSessionCrashlyticsContext (they must be reset on logout),
  /// so they are deliberately not written here.
  static Future<void> logSession({required String userId, required String sessionId}) async {
    unawaited(crashlyticsSetUserIdentifier(userId));
    unawaited(crashlyticsSetCustomKey('sessionId', sessionId));
    await logIsolateInfo();
  }

  /// Writes application configuration/settings into Crashlytics custom keys
  /// so crash reports carry the context they happened in (versions, feature
  /// flags, user settings). Null values are skipped, so for optional entries
  /// (e.g. remote-config overrides) a missing key means "not set".
  static void logAppSettings(Map<String, Object?> settings) {
    for (final entry in settings.entries) {
      final value = entry.value;
      if (value == null) continue;
      _setSafeCustomKey(entry.key, value);
    }
  }

  /// Convenience wrappers
  static void setKey(String key, Object value) {
    _setSafeCustomKey(key, value);
  }

  static void log(String message) {
    crashlyticsLog(message);
  }

  /// Records an caught error that is needed to be reported, non fatal by default.
  ///
  /// [exception] can be any object that can be transformed into a string, but it's best to use an Exception for proper grouping in Crashlytics.
  /// [stack] is the stack trace associated with the error. If not available, you can use `StackTrace.current` to capture the current stack.
  ///
  /// [fatal] indicates whether this error should be treated as fatal in Crashlytics (affects how it's grouped and displayed in the dashboard).
  ///
  /// [reason] is an optional string providing additional context about the error.
  /// [information] is an optional iterable of objects that can provide extra details about the error, which will be included in report.
  static Future<void> recordError(
    dynamic exception, {
    StackTrace? stack,
    bool fatal = false,
    dynamic reason,
    Iterable<Object> information = const [],
    bool skipInDebug = true,
    bool skipNetwork = true,
  }) async {
    if (kDebugMode && skipInDebug) return;
    if (skipNetwork && _isTransientNetworkError(exception)) return;

    await crashlyticsRecordError(exception, stack, reason: reason, information: information, fatal: fatal);
  }

  static bool _isTransientNetworkError(Object error) =>
      error is SocketException || error is TimeoutException || error is TlsException;

  /// Used for reporting errors manually triggered by the user via the
  /// "report a problem" feature. This is not for silent/automatic error
  /// reporting. It synthesizes an exception and stack trace to ensure it
  /// gets grouped and reported correctly in Crashlytics.
  static Future<void> reportServiceError({
    required String errorDescription,
    required String comment,
    required Map<String, dynamic> diagnostics,
    required Map<String, dynamic> metadata,
    required Map<String, dynamic> extras,
    String errorGroup = 'UserReport.submit',
    bool isFatal = true,
  }) async {
    if (comment.isNotEmpty) {
      _setSafeCustomKey('report_comment', comment);
      crashlyticsLog('Diagnostic Comment: $comment');
    }

    if (diagnostics.isNotEmpty) {
      crashlyticsLog('Diagnostics: $diagnostics');
    }

    // Nulls are written as the literal 'null' (not skipped): a second report
    // in the same session must overwrite the keys of the first, otherwise a
    // field that became null would keep showing the earlier report's value.
    final allKeys = {...metadata, ...extras, ...diagnostics};
    logAppSettings(allKeys.map((key, value) => MapEntry(key, value ?? 'null')));

    final exception = UserDiagnosticReportException(errorDescription);
    final syntheticStackTrace = StackTrace.fromString('#0      $errorGroup (user_diagnostic_report:1:1)');

    await crashlyticsRecordError(
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
    // Context keys are best-effort: losing one must never take the app (or a
    // unit test without an initialized Firebase app) down. The try/catch
    // covers the synchronous throw (uninitialized Firebase), catchError the
    // asynchronous one (platform-channel failure).
    try {
      unawaited(crashlyticsSetCustomKey(key, safeValue).catchError((_) {}));
    } catch (_) {
      // Ignored, see above.
    }
  }
}

class UserDiagnosticReportException implements Exception {
  final String message;

  UserDiagnosticReportException(this.message);

  @override
  String toString() => message;
}
