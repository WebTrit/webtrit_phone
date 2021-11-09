import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class LogRecordsRepository {
  LogRecordsRepository([this.capacity = 1000]) : _logRecords = ListQueue<LogRecord>(capacity);

  final int capacity;

  final _subscriptions = <StreamSubscription<dynamic>>[];

  final ListQueue<LogRecord> _logRecords;

  Future<List<LogRecord>> getLogRecords() async => UnmodifiableListView(_logRecords);

  void attachToLogger(Logger logger) {
    _subscriptions.add(logger.onRecord.listen(_log));
  }

  void clear() {
    _logRecords.clear();
  }

  void _log(LogRecord record) {
    if (_logRecords.length >= capacity) {
      _logRecords.removeLast();
    }
    _logRecords.addFirst(record);
  }

  @mustCallSuper
  Future<void> dispose() async {
    await _cancelSubscriptions();
  }

  Future<void> _cancelSubscriptions() async {
    final futures = _subscriptions.map((sub) => sub.cancel()).toList(growable: false);
    _subscriptions.clear();
    await Future.wait<dynamic>(futures);
  }
}
