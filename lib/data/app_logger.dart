import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static Future<AppLogger> init(
    Level logLevel,
    RemoteLoggingService? remoteLoggingService,
    Map<String, String> Function() getLabels,
  ) async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();

    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    final instance = AppLogger._(remoteLoggingService, getLabels);
    instance.updateRemoteLabels();
    instance.applyConfig(logLevel);

    return instance;
  }

  AppLogger._(this._remoteLoggingService, this._getLabels);

  final RemoteLoggingService? _remoteLoggingService;
  final Map<String, String> Function() _getLabels;

  void applyConfig(Level logLevel) {
    Logger.root.level = logLevel;
    EquatableConfig.stringify = logLevel <= Level.FINE || (_remoteLoggingService?.minLevel ?? Level.OFF) <= Level.FINE;
    _logger.info('AppLogger log level applied: $logLevel');
  }

  /// Updates remote logging labels and re-attaches the remote appender.
  ///
  /// Call this after authentication when coreUrl and tenantId become available.
  void updateRemoteLabels() {
    _remoteLoggingService?.dispose();
    _remoteLoggingService?.initialize(_getLabels());
  }
}
