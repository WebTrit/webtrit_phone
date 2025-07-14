import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

final _logger = Logger('AppLogger');

class AppLogger {
  static late AppLogger _instance;

  static Future<AppLogger> init({
    required RemoteConfigService remoteConfigService,
    required PackageInfo packageInfo,
    required DeviceInfo deviceInfo,
    required AppInfo appInfo,
    required SecureStorage secureStorage,
  }) async {
    hierarchicalLoggingEnabled = true;

    final localLogLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
    final logzioLogLevel = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.REMOTE_LOGZIO_LOG_LEVEL);

    Logger.root.clearListeners();
    Logger.root.level = localLogLevel;

    // Set up local logs printing with a color formatter
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

    // Add log listener for Callkeep integration
    WebtritCallkeepLogs().setLogsDelegate(CallkeepLogs());

    // Configure remote logging for Logz.io with an anonymizing formatter.
    // If additional logging services are added in the future, consider extracting these settings
    // into a dedicated logging configuration module to improve maintainability and separation of concerns.
    final remoteLoggingServices = _createRemoteLoggingServices(remoteConfigService, logzioLogLevel);

    for (var it in remoteLoggingServices) {
      it.initialize(await _prepareRemoteLabels(packageInfo, deviceInfo, appInfo, secureStorage));
    }

    _logger.info('Initializing AppLogger with local log level: $localLogLevel, remote log level: $logzioLogLevel');

    _instance = AppLogger._(remoteLoggingServices, packageInfo, deviceInfo, appInfo, secureStorage);
    return _instance;
  }

  static List<RemoteLoggingService> _createRemoteLoggingServices(RemoteConfigService configService, Level minLevel) {
    final isEnabled = configService.getBool('firebaseRemoteLogging') ?? false;

    const logzioUrl = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_URL;
    const logzioToken = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_TOKEN;
    final logzioBufferSize = EnvironmentConfig.REMOTE_LOGZIO_LOGGING_BUFFER_SIZE;

    if (logzioUrl != null && logzioToken != null && isEnabled) {
      return [
        LogzioLoggingService(
          url: logzioUrl,
          token: logzioToken,
          bufferSize: logzioBufferSize,
          minLevel: minLevel,
        )
      ];
    }

    return [];
  }

  static Future<Map<String, String>> _prepareRemoteLabels(
    PackageInfo packageInfo,
    DeviceInfo deviceInfo,
    AppInfo appInfo,
    SecureStorage secureStorage,
  ) async {
    final token = secureStorage.readToken();
    final coreUrl = secureStorage.readCoreUrl();
    final tenantId = secureStorage.readTenantId();

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
      'authorization': token != null ? 'authorized' : 'unauthorized',
      if (coreUrl != null) 'coreUrl': coreUrl,
      if (tenantId != null) 'tenantId': tenantId,
    };
  }

  factory AppLogger() {
    return _instance;
  }

  AppLogger._(this._remoteLoggingServices, this._packageInfo, this._deviceInfo, this._appInfo, this._secureStorage);

  final PackageInfo _packageInfo;
  final DeviceInfo _deviceInfo;
  final AppInfo _appInfo;
  final SecureStorage _secureStorage;

  final List<RemoteLoggingService> _remoteLoggingServices;

  /// Allows regenerating labels when coreUrl and tenantId are available.
  Future<void> regenerateRemoteLabels() async {
    final labels = await _prepareRemoteLabels(_packageInfo, _deviceInfo, _appInfo, _secureStorage);
    for (var it in _remoteLoggingServices) {
      it.initialize(labels);
    }
  }
}
