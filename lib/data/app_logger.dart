import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';

import 'app_metadata_provider.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static Future<AppLogger> init(
    Level logLevel,
    Level logzioLogLevel,
    LogzioLoggingService? logzioService,
    AppMetadataProvider labelsProvider,
  ) async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();

    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    logzioService?.initialize(labelsProvider.logLabels);

    final instance = AppLogger._(logzioService, labelsProvider, logzioLogLevel);
    instance.applyConfig(logLevel);

    return instance;
  }

  AppLogger._(this._logzioService, this._labelsProvider, this._logzioLogLevel);

  final LogzioLoggingService? _logzioService;
  final AppMetadataProvider _labelsProvider;
  final Level _logzioLogLevel;

  void applyConfig(Level logLevel) {
    Logger.root.level = logLevel;
    EquatableConfig.stringify = logLevel <= Level.FINE || _logzioLogLevel <= Level.FINE;
    _logger.info('AppLogger log level applied: $logLevel');
  }

  /// Allows regenerating labels when coreUrl and tenantId are available.
  void regenerateRemoteLabels() {
    _logzioService?.initialize(_labelsProvider.logLabels);
  }
}
