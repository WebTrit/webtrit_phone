import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/services/signaling_foreground_isolate_manager.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'push_notification_isolate_manager.dart';

// TODO (Serdun): Refactor PushNotificationIsolateManager and SignalingForegroundIsolateManager into a single manager to reduce code duplication.

PushNotificationIsolateManager? _pushNotificationIsolateManager;

SignalingForegroundIsolateManager? _signalingForegroundIsolateManager;

RemoteConfigService? _remoteConfigService;

DeviceInfo? _deviceInfo;
PackageInfo? _packageInfo;
AppLogger? _appLogger;
SecureStorage? _secureStorage;
AppCertificates? _appCertificates;
AppInfo? _appInfo;
AppMetadataProvider? _appLabelsProvider;

CallLogsRepository? _callLogsRepository;

Future<void> _initializeCommonDependencies() async {
  // Cache remote configuration
  _remoteConfigService ??= await DefaultRemoteCacheConfigService.init();

  // Data classes
  _appInfo ??= await AppInfo.init(const SharedPreferencesAppIdProvider());
  _deviceInfo ??= await DeviceInfoFactory.init();
  _packageInfo ??= await PackageInfoFactory.init();
  _secureStorage = await SecureStorageImpl.init();
  _appLabelsProvider ??= await DefaultAppMetadataProvider.init(_packageInfo!, _deviceInfo!, _appInfo!, _secureStorage!);
  _appLogger ??= await AppLogger.init(_remoteConfigService!, _appLabelsProvider!);
  _appCertificates ??= await AppCertificates.init();

  _callLogsRepository ??= CallLogsRepository(appDatabase: await IsolateDatabase.create());
}

Future<void> _initializeSignalingDependencies() async {
  _signalingForegroundIsolateManager ??= SignalingForegroundIsolateManager(
    callLogsRepository: _callLogsRepository!,
    callkeep: BackgroundSignalingService(),
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
}

Future<void> _initializePushNotificationDependencies() async {
  _pushNotificationIsolateManager ??= PushNotificationIsolateManager(
    callLogsRepository: _callLogsRepository!,
    callkeep: BackgroundPushNotificationService(),
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
  );
}

final _logger = Logger('BackgroundCallIsolate');

// Called by the Flutter engine when the signaling service is started.
@pragma('vm:entry-point')
Future<void> onPushNotificationSyncCallback(CallkeepPushNotificationSyncStatus status) async {
  await _initializeCommonDependencies();
  await _initializePushNotificationDependencies();

  _logger.info('onPushNotificationCallback: $status');

  switch (status) {
    case CallkeepPushNotificationSyncStatus.synchronizeCallStatus:
      await _pushNotificationIsolateManager?.sync();
    case CallkeepPushNotificationSyncStatus.releaseResources:
      await _pushNotificationIsolateManager?.close();
  }
}

// Called by the Flutter engine when the signaling service is triggered.
@pragma('vm:entry-point')
Future<void> onSignalingSyncCallback(CallkeepServiceStatus status) async {
  await _initializeCommonDependencies();
  await _initializeSignalingDependencies();

  _logger.info('onSignalingSyncCallback: $status');

  await _signalingForegroundIsolateManager?.sync(status);
  return;
}
