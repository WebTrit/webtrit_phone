import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init() async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();
    Logger.root.level = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);

    // Set up local logs printing with a color formatter
    PrintAppender(
      formatter: const ColorFormatter(),
    ).attachToLogger(Logger.root);

    // Set up remote logs with an anonymizing formatter if remote logging is enabled
    const remoteLoggingUrl = EnvironmentConfig.REMOTE_LOGGING_URL;
    const remoteLoggingToken = EnvironmentConfig.REMOTE_LOGGING_TOKEN;

    if (remoteLoggingUrl != null && remoteLoggingToken != null) {
      final remoteFormatter = AnonymizingFormatter(
        anonymizationTypes: AnonymizationType.full,
        wrappedFormatter: const RemoteFormatter(),
      );

      LogzIoApiAppender(
        formatter: remoteFormatter,
        url: remoteLoggingUrl,
        apiToken: remoteLoggingToken,
        bufferSize: EnvironmentConfig.REMOTE_LOGGING_BUFFER_SIZE,
        labels: _prepareRemoteLabels(),
      ).attachToLogger(Logger.root);
    }

    // Add log listener for Callkeep integration
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    _instance = AppLogger._();
    return _instance;
  }

  static Map<String, String> _prepareRemoteLabels() {
    final packageInfo = PackageInfo();
    final deviceInfo = DeviceInfo();
    final appInfo = AppInfo();

    return <String, String>{
      'app': packageInfo.appName,
      'appVersion': appInfo.version,
      'storeVersion': packageInfo.version,
      'packageName': packageInfo.packageName,
      'buildNumber': packageInfo.buildNumber,
      'manufacturer': deviceInfo.manufacturer,
      'model': deviceInfo.model,
      'os': deviceInfo.systemName,
      'osVersion': deviceInfo.systemVersion,
    };
  }

  factory AppLogger() {
    return _instance;
  }

  AppLogger._();
}
