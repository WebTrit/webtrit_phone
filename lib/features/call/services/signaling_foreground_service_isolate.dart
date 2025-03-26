import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'signaling_foreground_isolate_manager.dart';


BackgroundSignalingService? _callkeep;
CallkeepConnections? _callkeepConnections;
SignalingForegroundIsolateManager? _signalingForegroundIsolateManager;

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
  _deviceInfo ??= await DeviceInfoFactory.init();
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
  _callkeep ??= BackgroundSignalingService();
  _callkeepConnections ??= CallkeepConnections();

  _signalingForegroundIsolateManager ??= SignalingForegroundIsolateManager(
    callLogsRepository: _callLogsRepository!,
    appPreferences: _appPreferences!,
    callkeep: _callkeep!,
    callkeepConnections: _callkeepConnections!,
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
}

@pragma('vm:entry-point')
Future<void> onSync(CallkeepServiceStatus status) async {
  await _initializeDependencies();
  await _signalingForegroundIsolateManager?.sync(status);
  return;
}
