import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/environment_config.dart';

import 'app_metadata_provider.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init(RemoteConfigService remoteConfigService, AppMetadataProvider labelsProvider) async {
    hierarchicalLoggingEnabled = true;

    final localLogLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
    final logzioLogLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);

    Logger.root.clearListeners();
    Logger.root.level = localLogLevel;

    EquatableConfig.stringify = localLogLevel <= Level.FINE || logzioLogLevel <= Level.FINE;

    // Set up local logs printing with a color formatter
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    // Add log listener for Callkeep integration
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    // Configure remote logging for Logz.io with an anonymizing formatter.
    // If additional logging services are added in the future, consider extracting these settings
    // into a dedicated logging configuration module to improve maintainability and separation of concerns.
    final remoteLoggingServices = _createRemoteLoggingServices(remoteConfigService, logzioLogLevel);

    for (var it in remoteLoggingServices) {
      it.initialize(labelsProvider.logLabels);
    }

    _logger.info('Initializing AppLogger with local log level: $localLogLevel, remote log level: $logzioLogLevel');

    _instance = AppLogger._(remoteLoggingServices, labelsProvider);
    return _instance;
  }

  static List<RemoteLoggingService> _createRemoteLoggingServices(RemoteConfigService configService, Level minLevel) {
    final isEnabled = configService.getBool('firebaseRemoteLogging') ?? false;

    const logzioUrl = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const logzioToken = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;
    final logzioBufferSize = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE;

    if (logzioUrl != null && logzioToken != null && isEnabled) {
      return [
        LogzioLoggingService(url: logzioUrl, token: logzioToken, bufferSize: logzioBufferSize, minLevel: minLevel),
      ];
    }

    return [];
  }

  factory AppLogger() {
    return _instance;
  }

  AppLogger._(this._remoteLoggingServices, this._labelsProvider);

  final List<RemoteLoggingService> _remoteLoggingServices;
  final AppMetadataProvider _labelsProvider;

  /// Allows regenerating labels when coreUrl and tenantId are available.
  void regenerateRemoteLabels() {
    final labels = _labelsProvider.logLabels;
    for (var it in _remoteLoggingServices) {
      it.initialize(labels);
    }
  }
}
