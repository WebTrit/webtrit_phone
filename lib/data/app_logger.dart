import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import 'app_metadata_provider.dart';
import 'feature_access.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static Future<AppLogger> init(LoggingConfig loggingConfig, AppMetadataProvider labelsProvider) async {
    hierarchicalLoggingEnabled = true;

    final logzioLogLevel = Level.LEVELS.firstWhere((l) => l.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);

    Logger.root.clearListeners();
    Logger.root.level = loggingConfig.logLevel;
    EquatableConfig.stringify = loggingConfig.logLevel <= Level.FINE || logzioLogLevel <= Level.FINE;

    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    final remoteLoggingServices = _buildRemoteLoggingServices(loggingConfig.remoteLoggingEnabled, logzioLogLevel);
    for (var it in remoteLoggingServices) {
      it.initialize(labelsProvider.logLabels);
    }

    _logger.info('AppLogger initialized: level=${loggingConfig.logLevel}, remoteLevel=$logzioLogLevel');

    return AppLogger._(remoteLoggingServices, labelsProvider);
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

  StreamSubscription<LoggingConfig>? _configSubscription;

  void watchFeatureAccess(Stream<FeatureAccess> featureAccessStream) {
    _configSubscription?.cancel();
    _configSubscription = featureAccessStream
        .map((access) => access.loggingConfig)
        .distinct()
        .listen(_onLoggingConfigChanged);
  }

  void _onLoggingConfigChanged(LoggingConfig config) {
    final logzioLogLevel = Level.LEVELS.firstWhere((l) => l.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);
    Logger.root.level = config.logLevel;
    EquatableConfig.stringify = config.logLevel <= Level.FINE || logzioLogLevel <= Level.FINE;
    _logger.info('AppLogger log level updated: ${config.logLevel}');
  }

  /// Allows regenerating labels when coreUrl and tenantId are available.
  void regenerateRemoteLabels() {
    final labels = _labelsProvider.logLabels;
    for (var it in _remoteLoggingServices) {
      it.initialize(labels);
    }
  }

  void dispose() {
    _configSubscription?.cancel();
  }
}
