import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:webtrit_phone/utils/utils.dart';

abstract class LogRecordsRepository {
  Future<void> attachToLogger(Logger logger);

  Future<void> clear();

  Future<void> log(LogRecord record);

  Future<void> dispose();

  Future<void> cancelSubscriptions();

  Future<List<String>> getLogRecords();
}

class LogRecordsMemoryRepositoryImpl implements LogRecordsRepository {
  LogRecordsMemoryRepositoryImpl([this.capacity = 1000]) : _logRecords = ListQueue<LogRecord>(capacity);

  final int capacity;

  final _subscriptions = <StreamSubscription<dynamic>>[];

  final ListQueue<LogRecord> _logRecords;

  @override
  Future<List<String>> getLogRecords() async =>
      UnmodifiableListView(_logRecords.map((it) => DefaultLogRecordFormatter().format(it)));

  @override
  Future<void> attachToLogger(Logger logger) async {
    _subscriptions.add(logger.onRecord.listen(log));
  }

  @override
  Future<void> clear() async {
    _logRecords.clear();
  }

  @override
  Future<void> log(LogRecord record) async {
    if (_logRecords.length >= capacity) {
      _logRecords.removeLast();
    }
    _logRecords.addFirst(record);
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await cancelSubscriptions();
  }

  @override
  Future<void> cancelSubscriptions() async {
    final futures = _subscriptions.map((sub) => sub.cancel()).toList(growable: false);
    _subscriptions.clear();
    await Future.wait<dynamic>(futures);
  }
}

class LogRecordsFileRepositoryImpl implements LogRecordsRepository {
  LogRecordsFileRepositoryImpl(this.appender);

  final ReadableRotatingFileAppender appender;

  @override
  Future<List<String>> getLogRecords() async => appender.readAllLogs();

  @override
  Future<void> attachToLogger(Logger logger) async => appender.attachToLogger(logger);

  @override
  Future<void> clear() async {
    final appDocDir = await getApplicationDocumentsPath();
    final String baseLogDirectoryPath = '$appDocDir/logs';

    final logRecordsFile = File('$baseLogDirectoryPath/app_logs.log');

    if (await logRecordsFile.exists()) await logRecordsFile.delete();
  }

  @override
  Future<void> log(LogRecord record) async {}

  @override
  @mustCallSuper
  Future<void> dispose() async => cancelSubscriptions();

  @override
  Future<void> cancelSubscriptions() async {}
}

class ReadableRotatingFileAppender extends RotatingFileAppender {
  ReadableRotatingFileAppender({
    super.formatter,
    required super.baseFilePath,
    super.keepRotateCount,
    super.rotateAtSizeBytes,
    super.rotateCheckInterval,
    super.clock,
  });

  Future<List<String>> readAllLogs() async {
    final records = <String>[];

    final files = getAllLogFiles();

    for (var i = files.length - 1; i >= 0; i--) {
      final file = files[i];
      if (!file.existsSync()) {
        continue;
      }

      try {
        final lines = await file.readAsLines();

        for (final line in lines) {
          if (line.trim().isEmpty) continue;
          try {
            records.add(line);
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing line: $line');
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error when working with log file');
        }
      }
    }

    return records;
  }
}
