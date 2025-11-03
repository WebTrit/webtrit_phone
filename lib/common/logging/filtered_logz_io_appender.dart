import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  Future<void> sendLogEventsWithDio(
    List<LogEntry> entries,
    Map<String, String> userProperties,
    CancelToken cancelToken,
  ) async {
    try {
      await super.sendLogEventsWithDio(entries, userProperties, cancelToken);

      if (_isConnectionLost) {
        _isConnectionLost = false;
        // Print the message *once* when the connection is back.
        debugPrint('FilteredLogzIoAppender: Connection restored. Resuming remote logging.');
      }
    } on DioException catch (e) {
      if (RemoteLogFilter._shouldIgnoreDioConnectionError(e, url)) {
        // Print the message if this is the *first time* we`ve seen it.
        if (!_isConnectionLost) {
          _isConnectionLost = true;
          debugPrint('FilteredLogzIoAppender: Connection lost. Pausing remote logging. Will retry silently.');
        }
      } else {
        debugPrint('FilteredLogzIoAppender: Unhandled DioException: $e');
      }
    } catch (e, stackTrace) {
      debugPrint('FilteredLogzIoAppender: Unhandled Exception: $e\n$stackTrace');
    }
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
    // Check minimum level
    if (minLevel != null && record.level < minLevel) {
      return false;
    }

    // Allow all non-Dio errors
    if (record.error == null || record.error is! DioException) {
      return true;
    }

    // Filter specific Dio errors
    final dioError = record.error as DioException;
    return !_shouldIgnoreDioConnectionError(dioError, url);
  }

  /// Decides whether a [DioException] should be ignored.
  /// We only ignore *connection* errors to the *logger's* own host,
  /// derived from the provided [url].
  static bool _shouldIgnoreDioConnectionError(DioException dioError, String url) {
    final Uri? loggerUri = Uri.tryParse(url);
    final String? loggerHost = loggerUri?.host;

    if (loggerHost == null) {
      return false;
    }

    final String requestHost = dioError.requestOptions.uri.host;

    if (requestHost == loggerHost) {
      return switch (dioError.type) {
        DioExceptionType.connectionError || DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout => true,
        _ => false,
      };
    }

    return false;
  }
}
