import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

extension LoggerPretty on Logger {
  /// Logs data with info level formatting.
  void infoPretty(Object? data, {String? tag}) => logPretty(data, tag: tag, level: Level.INFO);

  /// Logs data with fine level formatting.
  void finePretty(Object? data, {String? tag}) => logPretty(data, tag: tag, level: Level.FINE);

  /// Logs data with warning level formatting.
  void warningPretty(Object? data, {String? tag}) => logPretty(data, tag: tag, level: Level.WARNING);

  /// Logs formatted data safely by handling large payloads and environment constraints.
  void logPretty(
    Object? data, {
    Level level = Level.INFO,
    String? tag,
    int chunkSize = 800,
    int maxLogLength = 20000,
    int maxCollectionItems = 50,
  }) {
    if (!isLoggable(level) || kReleaseMode) {
      return;
    }

    final effectiveTag = tag ?? name;
    final baseHeader = '[$effectiveTag]';

    try {
      var formattedString = _formatDataSafe(data, maxCollectionItems);

      if (formattedString.length > maxLogLength) {
        formattedString = '${formattedString.substring(0, maxLogLength)}\n\n... [Log Truncated: Too Large]';
      }

      _processLogChunks(formattedString, baseHeader, level, chunkSize);
    } catch (e) {
      log(level, '$baseHeader [Log Error]: $e');
    }
  }

  String _formatDataSafe(Object? data, int maxItems) {
    if (data is String && data.startsWith('v=0')) {
      return data.length > 5000
          ? '${data.substring(0, 5000)}... (SDP truncated)'
          : data.replaceAll(RegExp(r'\r?\n'), '\n  ');
    }

    try {
      final safeObject = _jsonSafe(data, maxItems);
      return const JsonEncoder.withIndent('  ').convert(safeObject);
    } catch (_) {
      return data.toString();
    }
  }

  void _processLogChunks(String message, String header, Level level, int chunkSize) {
    final totalChunks = (message.length / chunkSize).ceil();

    for (var i = 0; i < totalChunks; i++) {
      final start = i * chunkSize;
      final end = math.min(start + chunkSize, message.length);
      final part = message.substring(start, end);
      final chunkHeader = totalChunks > 1 ? '$header (${i + 1}/$totalChunks): ' : '$header: ';

      log(level, '$chunkHeader$part');
    }
  }

  static Object? _jsonSafe(Object? v, int maxItems) {
    if (v == null || v is num || v is bool || v is String) {
      return v;
    }

    if (v is Iterable) {
      final list = v.toList();
      final truncated = list.take(maxItems).map((e) => _jsonSafe(e, maxItems)).toList();

      if (list.length > maxItems) {
        truncated.add('... (${list.length - maxItems} more items)');
      }
      return truncated;
    }

    if (v is Map) {
      final entries = v.entries.take(maxItems).map((e) => MapEntry(e.key.toString(), _jsonSafe(e.value, maxItems)));
      final result = Map.fromEntries(entries);

      if (v.length > maxItems) {
        result['...'] = '(${v.length - maxItems} more keys)';
      }
      return result;
    }

    return v.toString();
  }
}
