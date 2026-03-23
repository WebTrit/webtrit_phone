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
    RemoteLoggingService? remoteLoggingService,
    AppMetadataProvider labelsProvider,
  ) async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();

    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    remoteLoggingService?.initialize(labelsProvider.logLabels);

    final instance = AppLogger._(remoteLoggingService, labelsProvider);
    instance.applyConfig(logLevel);

    return instance;
  }

  AppLogger._(this._remoteLoggingService, this._labelsProvider);

  final RemoteLoggingService? _remoteLoggingService;
  final AppMetadataProvider _labelsProvider;

  void applyConfig(Level logLevel) {
    Logger.root.level = logLevel;
    EquatableConfig.stringify = logLevel <= Level.FINE || (_remoteLoggingService?.minLevel ?? Level.OFF) <= Level.FINE;
    _logger.info('AppLogger log level applied: $logLevel');
  }

  /// Allows regenerating labels when coreUrl and tenantId are available.
  void regenerateRemoteLabels() {
    _remoteLoggingService?.initialize(_labelsProvider.logLabels);
  }
}
