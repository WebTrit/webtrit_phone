import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'data_sources/log_data_source.dart';

class LogRecordsRepository {
  LogRecordsRepository(this.logDataSources);

  final List<LogDataSource> logDataSources;
  final _subscriptions = <StreamSubscription<dynamic>>[];

  Future<List<LogRecord>> getLogRecords() async {
    final allRecords = <LogRecord>[];
    for (final dataSource in logDataSources) {
      allRecords.addAll(await dataSource.getLogRecords());
    }
    return allRecords;
  }

  void attachToLogger(Logger logger) {
    for (final dataSource in logDataSources) {
      _subscriptions.add(logger.onRecord.listen(dataSource.addLogRecord));
    }
  }

  void clear() {
    for (final dataSource in logDataSources) {
      dataSource.clear();
    }
  }

  @mustCallSuper
  Future<void> dispose() async {
    await _cancelSubscriptions();
    for (final dataSource in logDataSources) {
      await dataSource.dispose();
    }
  }

  Future<void> _cancelSubscriptions() async {
    final futures = _subscriptions.map((sub) => sub.cancel()).toList(growable: false);
    _subscriptions.clear();
    await Future.wait<dynamic>(futures);
  }
}
