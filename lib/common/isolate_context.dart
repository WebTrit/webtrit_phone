import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import 'app_id_provider.dart';
import 'db/db.dart';
import 'logging/logging.dart';

/// Shared lazily-initialised dependencies for background isolates.
///
/// Used by both the Firebase background message handler and the CallKeep
/// push-notification isolate. Each isolate maintains its own instance via a
/// top-level nullable variable -- isolates do not share memory.
class IsolateContext {
  IsolateContext({
    required this.remoteConfigService,
    required this.appInfo,
    required this.deviceInfo,
    required this.packageInfo,
    required this.secureStorage,
    required this.appLabelsProvider,
  });

  final RemoteConfigService remoteConfigService;
  final AppInfo appInfo;
  final DeviceInfo deviceInfo;
  final PackageInfo packageInfo;
  final SecureStorage secureStorage;
  final AppMetadataProvider appLabelsProvider;

  static Future<IsolateContext> init() async {
    final remoteConfigService = await DefaultRemoteCacheConfigService.init();
    final appInfo = await AppInfo.init(const SharedPreferencesAppIdProvider());
    final deviceInfo = await DeviceInfoFactory.init();
    final packageInfo = await PackageInfoFactory.init();
    final secureStorage = await SecureStorageImpl.init();
    final appLabelsProvider = await DefaultAppMetadataProvider.init(packageInfo, deviceInfo, appInfo, secureStorage);

    final overrides = FeatureOverridesFactory.create(remoteConfigService.snapshot);
    final loggingConfig = LoggingMapper.mapFromOverridesOnly(overrides);
    await AppLogger.init(
      loggingConfig,
      LogzioLoggingService.fromEnvironment(loggingConfig.remoteLoggingEnabled),
      () => appLabelsProvider.logLabels,
    );

    return IsolateContext(
      remoteConfigService: remoteConfigService,
      appInfo: appInfo,
      deviceInfo: deviceInfo,
      packageInfo: packageInfo,
      secureStorage: secureStorage,
      appLabelsProvider: appLabelsProvider,
    );
  }
}

/// Extended isolate context for the CallKeep push-notification isolate.
///
/// Extends [IsolateContext] with push-specific data-layer dependencies:
/// file-system paths, TLS certificates, the SQLite database, and the
/// repositories consumed by [PushNotificationIsolateManager].
///
/// Does NOT hold [PushNotificationIsolateManager] itself to keep this class
/// free of feature-layer imports.
class PushIsolateContext extends IsolateContext {
  PushIsolateContext({
    required super.remoteConfigService,
    required super.appInfo,
    required super.deviceInfo,
    required super.packageInfo,
    required super.secureStorage,
    required super.appLabelsProvider,
    required this.appPreferences,
    required this.appPath,
    required this.appCertificates,
    required this.appDatabase,
    required this.localPushRepository,
    required this.callLogsRepository,
  });

  final AppPreferences appPreferences;
  final AppPath appPath;
  final AppCertificates appCertificates;
  final AppDatabase appDatabase;
  final LocalPushRepository localPushRepository;
  final CallLogsRepository callLogsRepository;

  static Future<PushIsolateContext> init() async {
    final base = await IsolateContext.init();
    final appPreferences = await AppPreferencesImpl.init();
    final appPath = await AppPath.init();
    final appCertificates = await AppCertificates.init();

    Logger.root.info('IsolateDatabase.connectOrCreate call from PushIsolateContext.init');
    final appDatabase = await IsolateDatabase.connectOrCreate(directoryPath: appPath.applicationDocumentsPath);
    final localPushRepository = LocalPushRepositoryFLNImpl();
    final callLogsRepository = CallLogsRepository(appDatabase: appDatabase);

    return PushIsolateContext(
      remoteConfigService: base.remoteConfigService,
      appInfo: base.appInfo,
      deviceInfo: base.deviceInfo,
      packageInfo: base.packageInfo,
      secureStorage: base.secureStorage,
      appLabelsProvider: base.appLabelsProvider,
      appPreferences: appPreferences,
      appPath: appPath,
      appCertificates: appCertificates,
      appDatabase: appDatabase,
      localPushRepository: localPushRepository,
      callLogsRepository: callLogsRepository,
    );
  }

  Future<void> dispose() => appDatabase.close();
}
