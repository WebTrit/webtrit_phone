import 'package:logging/logging.dart';

import 'package:webtrit_phone/environment_config.dart';

import 'anonymizing_formatter.dart';
import 'filtered_logz_io_appender.dart';
import 'remote_formatter.dart';
import 'remote_logging_service.dart';

final _logger = Logger('LogzioLoggingService');

class LogzioLoggingService implements RemoteLoggingService {
  LogzioLoggingService({required this.url, required this.token, required this.bufferSize, required this.minLevel});

  static LogzioLoggingService? fromEnvironment(bool enabled, Level minLevel) {
    if (!enabled) return null;

    const url = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const token = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;
    if (url == null || token == null) return null;

    return LogzioLoggingService(
      url: url,
      token: token,
      bufferSize: EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE,
      minLevel: minLevel,
    );
  }

  final String url;
  final String token;
  final int bufferSize;
  final Level minLevel;

  FilteredLogzIoAppender? _filteredLogzIoAppender;

  @override
  void initialize(Map<String, String> labels) {
    _logger.finest('Initializing with url: $url, token: $token, bufferSize: $bufferSize labels: $labels');
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
      minLevel: minLevel,
    )..attachToLogger(Logger.root);
  }

  @override
  void dispose() {
    _filteredLogzIoAppender?.dispose();
    _filteredLogzIoAppender = null;
  }
}
