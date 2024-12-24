import 'package:logging/logging.dart';

import 'anonymizing_formatter.dart';
import 'filtered_logz_io_appender.dart';
import 'remote_formatter.dart';
import 'remote_logging_service.dart';

class LogzioLoggingService implements RemoteLoggingService {
  LogzioLoggingService({
    required this.url,
    required this.token,
    required this.bufferSize,
  });

  final String url;
  final String token;
  final int bufferSize;

  FilteredLogzIoAppender? _filteredLogzIoAppender;

  @override
  void initialize(Map<String, String> labels) {
    final remoteFormatter = AnonymizingFormatter(
      anonymizationTypes: AnonymizationType.full,
      wrappedFormatter: const RemoteFormatter(),
    );

    _filteredLogzIoAppender = FilteredLogzIoAppender(
      formatter: remoteFormatter,
      url: url,
      apiToken: token,
      bufferSize: bufferSize,
      labels: labels,
    )..attachToLogger(Logger.root);
  }

  @override
  void dispose() {
    _filteredLogzIoAppender?.dispose();
    _filteredLogzIoAppender = null;
  }
}
