import 'package:logging/logging.dart';

abstract class LogDataSource {
  Future<List<LogRecord>> getLogRecords();

  void addLogRecord(LogRecord record);

  void clear();

  Future<void> dispose();
}
