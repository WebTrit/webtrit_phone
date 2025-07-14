import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/base_remote_appender.dart';
import 'package:logging_appenders/logging_appenders.dart';

final _logger = Logger('FilteredLogzIoAppender');

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

  @override
  Future<void> sendLogEventsWithDio(
    List<LogEntry> entries,
    Map<String, String> userProperties,
    CancelToken cancelToken,
  ) async {
    try {
      await super.sendLogEventsWithDio(entries, userProperties, cancelToken);
    } on DioException catch (e) {
      if (RemoteLogFilter._shouldIgnoreDioError(e)) {
        _logger.info('Ignoring LogzIO DioException: $e');
      } else {
        _logger.warning('LogzIO DioException (not ignored): $e');
      }
    }
  }

  @override
  void handle(LogRecord record) {
    if (RemoteLogFilter.shouldLog(record, minLevel: minLevel)) {
      super.handle(record);
    }
  }
}

class RemoteLogFilter {
  static const List<String> ignoredHosts = [
    'listener.logz.io',
  ];

  static bool shouldLog(LogRecord record, {Level? minLevel}) {
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
    return !_shouldIgnoreDioError(dioError);
  }

  static bool _shouldIgnoreDioError(DioException dioError) {
    // Skip adding spam logs to the buffer if there is no internet connection for the specified hosts
    return (dioError.type == DioExceptionType.connectionTimeout || dioError.type == DioExceptionType.connectionError) &&
        ignoredHosts.any((host) => dioError.toString().contains(host));
  }
}
