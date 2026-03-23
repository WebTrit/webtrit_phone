import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static Future<AppLogger> init(
    LoggingConfig config,
    RemoteLoggingService? remoteLoggingService,
    Map<String, String> Function() getLabels,
  ) async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();

    // Anonymization is intentionally applied only to remote logs (Logzio).
    // Console output is not anonymized to preserve full detail for local debugging.
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    final instance = AppLogger._(remoteLoggingService, getLabels);
    instance.updateRemoteLabels();
    instance.applyConfig(config);

    return instance;
  }

  AppLogger._(this._remoteLoggingService, this._getLabels);

  final RemoteLoggingService? _remoteLoggingService;
  final Map<String, String> Function() _getLabels;

  void applyConfig(LoggingConfig config) {
    Logger.root.level = config.logLevel;
    _remoteLoggingService?.setAnonymizationEnabled(config.anonymizationEnabled);
    EquatableConfig.stringify =
        config.logLevel <= Level.FINE || (_remoteLoggingService?.minLevel ?? Level.OFF) <= Level.FINE;
    _logger.info('AppLogger log level applied: ${config.logLevel}');
  }

  /// Updates remote logging labels and re-attaches the remote appender.
  ///
  /// Call this after authentication when coreUrl and tenantId become available.
  void updateRemoteLabels() {
    _remoteLoggingService?.dispose();
    _remoteLoggingService?.initialize(_getLabels());
  }
}
