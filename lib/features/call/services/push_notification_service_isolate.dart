import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'push_notification_isolate_manager.dart';

BackgroundPushNotificationService? _callkeep;
PushNotificationIsolateManager? _pushNotificationIsolateManager;

RemoteConfigService? _remoteConfigService;

DeviceInfo? _deviceInfo;
PackageInfo? _packageInfo;
AppLogger? _appLogger;
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
  _appCertificates ??= await AppCertificates.init();

  // Always create a new instance to avoid caching issues
  _secureStorage = await SecureStorage.init();

  _callLogsRepository ??= CallLogsRepository(appDatabase: await IsolateDatabase.create());
  _callkeep ??= BackgroundPushNotificationService();

  _pushNotificationIsolateManager ??= PushNotificationIsolateManager(
    callLogsRepository: _callLogsRepository!,
    callkeep: _callkeep!,
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
}

final _logger = Logger('BackgroundCallIsolate');

@pragma('vm:entry-point')
Future<void> onPushNotificationCallback(CallkeepPushNotificationSyncStatus status) async {
  await _initializeDependencies();

  _logger.info('onPushNotificationCallback: $status');

  switch (status) {
    case CallkeepPushNotificationSyncStatus.synchronizeCallStatus:
      await _pushNotificationIsolateManager?.sync();
    case CallkeepPushNotificationSyncStatus.releaseResources:
      await _pushNotificationIsolateManager?.close();
  }
}
