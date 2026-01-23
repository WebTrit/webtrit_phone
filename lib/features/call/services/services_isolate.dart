import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'isolate_manager.dart';

PushNotificationIsolateManager? _pushNotificationIsolateManager;
SignalingForegroundIsolateManager? _signalingForegroundIsolateManager;

RemoteConfigService? _remoteConfigService;

AppPath? _appPath;
DeviceInfo? _deviceInfo;
PackageInfo? _packageInfo;
AppLogger? _appLogger;
SecureStorage? _secureStorage;
AppCertificates? _appCertificates;
AppInfo? _appInfo;
AppMetadataProvider? _appLabelsProvider;
AppDatabase? _appDatabase;
LocalPushRepository? _localPushRepository;

CallLogsRepository? _callLogsRepository;

Future<void> _initializeCommonDependencies() async {
  _remoteConfigService ??= await DefaultRemoteCacheConfigService.init();

  _appPath ??= await AppPath.init();
  _appInfo ??= await AppInfo.init(const SharedPreferencesAppIdProvider());
  _deviceInfo ??= await DeviceInfoFactory.init();
  _packageInfo ??= await PackageInfoFactory.init();
  _secureStorage = await SecureStorageImpl.init();
  _appLabelsProvider ??= await DefaultAppMetadataProvider.init(_packageInfo!, _deviceInfo!, _appInfo!, _secureStorage!);
  _appLogger ??= await AppLogger.init(_remoteConfigService!, _appLabelsProvider!);
  _appCertificates ??= await AppCertificates.init();
  _localPushRepository ??= LocalPushRepositoryFLNImpl();

  _appDatabase ??= IsolateDatabase.create(directoryPath: _appPath!.applicationDocumentsPath);
  _callLogsRepository ??= CallLogsRepository(appDatabase: _appDatabase!);
}

Future<void> _disposeCommonDependencies() async {
  await _pushNotificationIsolateManager?.close();
  await _signalingForegroundIsolateManager?.close();
  await _appDatabase?.close();

  _appDatabase = null;
  _pushNotificationIsolateManager = null;
  _signalingForegroundIsolateManager = null;
  _callLogsRepository = null;
  _localPushRepository = null;
  _remoteConfigService = null;
  _appPath = null;
  _deviceInfo = null;
  _packageInfo = null;
  _appLogger = null;
  _secureStorage = null;
  _appCertificates = null;
  _appInfo = null;
  _appLabelsProvider = null;
}

Future<void> _initializeSignalingDependencies() async {
  _signalingForegroundIsolateManager ??= SignalingForegroundIsolateManager(
    callLogsRepository: _callLogsRepository!,
    localPushRepository: _localPushRepository!,
    callkeep: BackgroundSignalingService(),
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
    logger: Logger('SignalingForegroundIsolateManager'),
  );
}

Future<void> _initializePushNotificationDependencies() async {
  _pushNotificationIsolateManager ??= PushNotificationIsolateManager(
    callLogsRepository: _callLogsRepository!,
    localPushRepository: _localPushRepository!,
    callkeep: BackgroundPushNotificationService(),
    storage: _secureStorage!,
    certificates: _appCertificates!.trustedCertificates,
    logger: Logger('PushNotificationIsolateManager'),
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
      await _pushNotificationIsolateManager?.launchSignaling();
    case CallkeepPushNotificationSyncStatus.releaseResources:
      await _disposeCommonDependencies();
  }
}

// Called by the Flutter engine when the signaling service is triggered.
@pragma('vm:entry-point')
Future<void> onSignalingSyncCallback(CallkeepServiceStatus status) async {
  await _initializeCommonDependencies();
  await _initializeSignalingDependencies();

  _logger.info('onSignalingSyncCallback: $status');

  await _signalingForegroundIsolateManager?.handleLifecycleStatus(status);
  // TODO: Implement a deterministic cleanup path for common dependencies (DB, storages, logger)
  // for the signaling isolate. Unlike the push-notification flow, this callback currently has
  // no explicit "releaseResources" event, so we need a reliable trigger (or idle-timeout) to
  // call `_disposeCommonDependencies()` without breaking subsequent sync calls.
  return;
}
