import 'dart:collection';

import 'package:logging/logging.dart';

import 'log_data_source.dart';

class LocalLogDataSource implements LogDataSource {
  LocalLogDataSource([this.capacity = 1000]) : _logRecords = ListQueue<LogRecord>(capacity);

  final int capacity;
  final ListQueue<LogRecord> _logRecords;

  @override
  Future<List<LogRecord>> getLogRecords() async => UnmodifiableListView(_logRecords);

  @override
  void addLogRecord(LogRecord record) {
    if (_logRecords.length >= capacity) {
      _logRecords.removeLast();
    }
    _logRecords.addFirst(record);
  }

  @override
  void clear() {
    _logRecords.clear();
  }

  @override
  Future<void> dispose() async {}
}
