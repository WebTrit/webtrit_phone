import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

abstract class LogRecordsRepository {
  void attachToLogger(Logger logger);

  void clear();

  void log(LogRecord record);

  Future<void> dispose();

  Future<void> cancelSubscriptions();

  Future<List<LogRecord>> getLogRecords();
}

class LogRecordsMemoryRepositoryImpl implements LogRecordsRepository {
  LogRecordsMemoryRepositoryImpl([this.capacity = 1000]) : _logRecords = ListQueue<LogRecord>(capacity);

  final int capacity;

  final _subscriptions = <StreamSubscription<dynamic>>[];

  final ListQueue<LogRecord> _logRecords;

  @override
  Future<List<LogRecord>> getLogRecords() async => UnmodifiableListView(_logRecords);

  @override
  void attachToLogger(Logger logger) {
    _subscriptions.add(logger.onRecord.listen(log));
  }

  @override
  void clear() {
    _logRecords.clear();
  }

  @override
  void log(LogRecord record) {
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
  LogRecordsFileRepositoryImpl() : _logRecords = ListQueue<LogRecord>();

  final _subscriptions = <StreamSubscription<dynamic>>[];

  final ListQueue<LogRecord> _logRecords;

  @override
  Future<List<LogRecord>> getLogRecords() async => UnmodifiableListView(_logRecords);

  @override
  Future<void> attachToLogger(Logger logger) async => _subscriptions.add(logger.onRecord.listen(log));

  @override
  Future<void> clear() async {
    final appDocDir = await getApplicationDocumentsPath();
    final String baseLogDirectoryPath = '$appDocDir/logs';

    final logRecordsFile = File('$baseLogDirectoryPath/app_logs.log');

    await logRecordsFile.delete();
    _logRecords.clear();
  }

  @override
  Future<void> log(LogRecord record) async => _logRecords.addFirst(record);

  @override
  @mustCallSuper
  Future<void> dispose() async => await cancelSubscriptions();

  @override
  Future<void> cancelSubscriptions() async {
    final futures = _subscriptions.map((sub) => sub.cancel()).toList(growable: false);
    _subscriptions.clear();
    await Future.wait<dynamic>(futures);
  }
}
