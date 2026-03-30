import 'dart:io';

import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import '../models/jsep_value.dart';
import 'isolate_manager.dart';

PushNotificationIsolateManager? _pushNotificationIsolateManager;

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
  final isolateOverrides = FeatureOverridesFactory.create(_remoteConfigService!.snapshot);
  final isolateLoggingConfig = LoggingMapper.mapFromOverridesOnly(isolateOverrides);
  _appLogger ??= await AppLogger.init(
    isolateLoggingConfig,
    LogzioLoggingService.fromEnvironment(isolateLoggingConfig.remoteLoggingEnabled),
    () => _appLabelsProvider!.logLabels,
  );
  _appCertificates ??= await AppCertificates.init();
  _localPushRepository ??= LocalPushRepositoryFLNImpl();

  _appDatabase ??= IsolateDatabase.create(directoryPath: _appPath!.applicationDocumentsPath);
  _callLogsRepository ??= CallLogsRepository(appDatabase: _appDatabase!);
}

Future<void> _disposeCommonDependencies() async {
  await _pushNotificationIsolateManager?.close();
  await _appDatabase?.close();

  _appDatabase = null;
  _pushNotificationIsolateManager = null;
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

/// Called by [SignalingForegroundIsolateManager] when an [IncomingCallEvent] arrives
/// in the foreground-service background isolate and the app is not running.
///
/// Registered via [WebtritSignalingService.setIncomingCallHandler] so the plugin can
/// invoke it from the background isolate. Uses the push-notification bootstrap path
/// to report the incoming call to callkeep, which in turn shows the system call UI.
///
/// Must be a top-level function annotated with [@pragma('vm:entry-point')] to survive
/// tree-shaking in release builds.
@pragma('vm:entry-point')
Future<void> onSignalingBackgroundIncomingCall(IncomingCallEvent event) async {
  if (!Platform.isAndroid) return;

  final caller = event.caller;
  final hasVideo = JsepValue.fromOptional(event.jsep)?.hasVideo ?? false;

  _logger.info('onSignalingBackgroundIncomingCall: callId=${event.callId} caller=$caller hasVideo=$hasVideo');

  await AndroidCallkeepServices.backgroundPushNotificationBootstrapService.reportNewIncomingCall(
    event.callId,
    CallkeepHandle.number(caller),
    displayName: event.callerDisplayName,
    hasVideo: hasVideo,
  );
}

// Called by the Flutter engine when an incoming push notification triggers a background call event.
@pragma('vm:entry-point')
Future<void> onPushNotificationSyncCallback(
  CallkeepPushNotificationSyncStatus status,
  CallkeepIncomingCallMetadata? metadata,
) async {
  await _initializeCommonDependencies();
  await _initializePushNotificationDependencies();

  _logger.info('onPushNotificationCallback: $status');

  switch (status) {
    case CallkeepPushNotificationSyncStatus.synchronizeCallStatus:
      await _pushNotificationIsolateManager?.launchSignaling(metadata);
    case CallkeepPushNotificationSyncStatus.releaseResources:
      await _disposeCommonDependencies();
  }
}
