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

    // Configure remote logging for Logz.io with an anonymizing formatter.
    // If additional logging services are added in the future, consider extracting these settings
    // into a dedicated logging configuration module to improve maintainability and separation of concerns.
    const remoteLogzIOLoggingUrl = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const remoteLogzIOLoggingToken = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;

    if (remoteLogzIOLoggingUrl != null && remoteLogzIOLoggingToken != null) {
      final remoteFormatter = AnonymizingFormatter(
        anonymizationTypes: AnonymizationType.full,
        wrappedFormatter: const RemoteFormatter(),
      );

      LogzIoApiAppender(
        formatter: remoteFormatter,
        url: remoteLogzIOLoggingUrl,
        apiToken: remoteLogzIOLoggingToken,
        bufferSize: EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE,
        labels: await _prepareRemoteLabels(),
      ).attachToLogger(Logger.root);
    }

    // Add log listener for Callkeep integration
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    _instance = AppLogger._();
    return _instance;
  }

  static Future<Map<String, String>> _prepareRemoteLabels() async {
    final packageInfo = PackageInfo();
    final deviceInfo = DeviceInfo();

    // TODO(Serdun): Use getAppVersion directly to avoid initializing Firebase inside isolates,
    // as AppInfo depends on Firebase.
    final appVersion = await AppInfo.getAppVersion() ?? 'Undefine';

    return <String, String>{
      'app': packageInfo.appName,
      'appVersion': appVersion,
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
