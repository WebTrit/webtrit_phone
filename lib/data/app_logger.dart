import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init(RemoteConfigService remoteConfigService) async {
    hierarchicalLoggingEnabled = true;

    Logger.root.clearListeners();
    Logger.root.level = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);

    // Set up local logs printing with a color formatter
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    // Add log listener for Callkeep integration
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    // Configure remote logging for Logz.io with an anonymizing formatter.
    // If additional logging services are added in the future, consider extracting these settings
    // into a dedicated logging configuration module to improve maintainability and separation of concerns.
    final remoteLoggingServices = <RemoteLoggingService>[];

    const logzioUrl = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const logzioToken = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;
    final logzioBufferSize = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE;

    if (logzioUrl != null && logzioToken != null) {
      remoteLoggingServices.add(LogzioLoggingService(url: logzioUrl, token: logzioToken, bufferSize: logzioBufferSize));
    }

    final isRemoteLoggingEnabled = remoteConfigService.getBool('firebaseRemoteLogging') ?? false;

    if (isRemoteLoggingEnabled) {
      for (var it in remoteLoggingServices) {
        it.initialize(await _prepareRemoteLabels());
      }
    }

    _instance = AppLogger._();
    return _instance;
  }

  static Future<Map<String, String>> _prepareRemoteLabels() async {
    final packageInfo = PackageInfo();
    final deviceInfo = DeviceInfo();
    final appInfo = AppInfo();

    return <String, String>{
      'app': packageInfo.appName,
      'appVersion': appInfo.version,
      'appSessionIdentifier': appInfo.identifier,
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
