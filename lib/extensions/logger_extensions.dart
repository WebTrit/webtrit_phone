import 'dart:convert';
import 'dart:math' as math;

import 'package:logging/logging.dart';

extension LoggerPrettyJson on Logger {
  /// Logs any object in a pretty JSON format without visual borders.
  void logPretty(String tag, Object? data, {Level level = Level.FINE, int chunkSize = 900}) {
    if (!isLoggable(level)) return;

    final sanitized = _jsonSafe(data);
    String prettyString;

    try {
      prettyString = const JsonEncoder.withIndent('  ').convert(sanitized);
    } catch (e) {
      prettyString = data.toString();
    }

    final fullLogMessage = '$tag: $prettyString';
    final length = fullLogMessage.length;

    for (var i = 0; i < length; i += chunkSize) {
      final end = math.min(i + chunkSize, length);
      log(level, fullLogMessage.substring(i, end));
    }
  }

  /// Safely converts objects to JSON-compatible types.
  static Object? _jsonSafe(Object? v) {
    if (v == null) return null;
    if (v is num || v is bool || v is String) return v;

    if (v is Map) {
      return v.map((k, value) => MapEntry(k.toString(), _jsonSafe(value)));
    }

    if (v is Iterable) {
      return v.map(_jsonSafe).toList();
    }

    return v.toString();
  }
}
