import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'remote_log_filter.dart';

class FilteredLogzIoAppender extends LogzIoApiAppender {
  FilteredLogzIoAppender({
    required LogRecordFormatter super.formatter,
    required super.url,
    required super.apiToken,
    super.bufferSize,
    super.labels = const {},
  });

  @override
  void handle(LogRecord record) {
    if (RemoteLogFilter.shouldLog(record)) {
      super.handle(record);
    }
  }
}
