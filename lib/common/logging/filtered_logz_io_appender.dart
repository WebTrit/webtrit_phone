import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:logging_appenders/base_remote_appender.dart';
import 'package:logging_appenders/logging_appenders.dart';

// DO NOT USE Logger inside FilteredLogzIoAppender
// to avoid logging cycles. Use debugPrint instead.
class FilteredLogzIoAppender extends LogzIoApiAppender {
  FilteredLogzIoAppender({
    required LogRecordFormatter super.formatter,
    required super.url,
    required super.apiToken,
    required this.minLevel,
    super.bufferSize,
    super.labels = const {},
  });

  final Level minLevel;

  /// Tracks the connection state to avoid spamming "connection lost" messages.
  bool _isConnectionLost = false;

  @override
  Future<void> sendLogEventsWithHttp(
    List<LogEntry> entries,
    Map<String, String> userProperties,
    Future<void> cancelToken,
  ) async {
    try {
      await super.sendLogEventsWithHttp(entries, userProperties, cancelToken);

      if (_isConnectionLost) {
        _isConnectionLost = false;
        debugPrint('FilteredLogzIoAppender: Connection restored. Resuming remote logging.');
      }
    } on http.ClientException catch (e) {
      _markConnectionLostOnce('ClientException: $e');
    } on SocketException catch (e) {
      _markConnectionLostOnce('SocketException: $e');
    } on TimeoutException catch (e) {
      _markConnectionLostOnce('TimeoutException: $e');
    } catch (e, stackTrace) {
      debugPrint('FilteredLogzIoAppender: Unhandled Exception: $e\n$stackTrace');
    }
  }

  void _markConnectionLostOnce(String details) {
    if (_isConnectionLost) return;
    _isConnectionLost = true;
    debugPrint('FilteredLogzIoAppender: Connection lost. Pausing remote logging. Will retry silently. $details');
  }

  @override
  void handle(LogRecord record) {
    if (RemoteLogFilter.shouldLog(record, url, minLevel: minLevel)) {
      super.handle(record);
    }
  }
}

class RemoteLogFilter {
  static bool shouldLog(LogRecord record, String url, {Level? minLevel}) {
    if (minLevel != null && record.level < minLevel) {
      return false;
    }

    final error = record.error;
    if (error is http.ClientException) {
      return !_isErrorForLoggerHost(error, url);
    }
    return true;
  }

  /// Skip records whose error is a network failure to the logger's own host —
  /// avoids logging cycles when the logger itself is unreachable.
  static bool _isErrorForLoggerHost(http.ClientException error, String url) {
    final loggerHost = Uri.tryParse(url)?.host;
    if (loggerHost == null) {
      return false;
    }
    return error.uri?.host == loggerHost;
  }
}
