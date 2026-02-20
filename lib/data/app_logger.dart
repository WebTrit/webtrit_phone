import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/environment_config.dart';

import 'app_metadata_provider.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static Future<AppLogger> init(Level logLevel, bool remoteLoggingEnabled, AppMetadataProvider labelsProvider) async {
    hierarchicalLoggingEnabled = true;

    final logzioLogLevel = Level.LEVELS.firstWhere((l) => l.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);

    Logger.root.clearListeners();

    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    final remoteLoggingServices = _buildRemoteLoggingServices(remoteLoggingEnabled, logzioLogLevel);
    for (var it in remoteLoggingServices) {
      it.initialize(labelsProvider.logLabels);
    }

    final instance = AppLogger._(remoteLoggingServices, labelsProvider);
    instance.applyConfig(logLevel);

    return instance;
  }

  static List<RemoteLoggingService> _buildRemoteLoggingServices(bool remoteLoggingEnabled, Level minLevel) {
    if (!remoteLoggingEnabled) return [];

    const logzioUrl = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const logzioToken = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;
    final logzioBufferSize = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE;

    if (logzioUrl != null && logzioToken != null) {
      return [
        LogzioLoggingService(url: logzioUrl, token: logzioToken, bufferSize: logzioBufferSize, minLevel: minLevel),
      ];
    }

    return [];
  }

  AppLogger._(this._remoteLoggingServices, this._labelsProvider);

  final List<RemoteLoggingService> _remoteLoggingServices;
  final AppMetadataProvider _labelsProvider;

  void applyConfig(Level logLevel) {
    final logzioLogLevel = Level.LEVELS.firstWhere((l) => l.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);
    Logger.root.level = logLevel;
    EquatableConfig.stringify = logLevel <= Level.FINE || logzioLogLevel <= Level.FINE;
    _logger.info('AppLogger log level applied: $logLevel');
  }

  /// Allows regenerating labels when coreUrl and tenantId are available.
  void regenerateRemoteLabels() {
    final labels = _labelsProvider.logLabels;
    for (var it in _remoteLoggingServices) {
      it.initialize(labels);
    }
  }
}
