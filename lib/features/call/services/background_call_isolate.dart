import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'background_call_event_service.dart';

CallkeepBackgroundService? _callkeep;
CallkeepConnections? _callkeepConnections;
BackgroundCallEventService? _backgroundCallEventManager;

RemoteConfigService? _remoteConfigService;

DeviceInfo? _deviceInfo;
PackageInfo? _packageInfo;
AppLogger? _appLogger;
AppPreferences? _appPreferences;
SecureStorage? _secureStorage;
AppCertificates? _appCertificates;
AppInfo? _appInfo;

CallLogsRepository? _callLogsRepository;

Future<void> _initializeDependencies() async {
  // Cache remote configuration
  _remoteConfigService ??= await DefaultRemoteCacheConfigService.init();

  // Data classes
  _appInfo ??= await AppInfo.init(const SharedPreferencesAppIdProvider());
  _deviceInfo ??= await DeviceInfo.init();
  _packageInfo ??= await PackageInfoFactory.init();
  _appLogger ??= await AppLogger.init(
    remoteConfigService: _remoteConfigService!,
    packageInfo: _packageInfo!,
    deviceInfo: _deviceInfo!,
    appInfo: _appInfo!,
  );
  _appPreferences ??= await AppPreferencesFactory.init();
  _appCertificates ??= await AppCertificates.init();

  // Always create a new instance to avoid caching issues
  _secureStorage = await SecureStorage.init();

  _callLogsRepository ??= CallLogsRepository(appDatabase: await IsolateDatabase.create());
  _callkeep ??= CallkeepBackgroundService();
  _callkeepConnections ??= CallkeepConnections();

  _backgroundCallEventManager ??= BackgroundCallEventService(
    callLogsRepository: _callLogsRepository!,
    appPreferences: _appPreferences!,
    callkeep: _callkeep!,
    callkeepConnections: _callkeepConnections!,
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
}

@pragma('vm:entry-point')
Future<void> onStart(CallkeepServiceStatus status) async {
  await _initializeDependencies();
  await _backgroundCallEventManager?.onStart(status);
}

@pragma('vm:entry-point')
Future<void> onChangedLifecycle(CallkeepServiceStatus status) async {
  await _backgroundCallEventManager?.onChangedLifecycle(status);
}
