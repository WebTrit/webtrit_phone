import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import 'app_id_provider.dart';
import 'db/db.dart';
import 'logging/logging.dart';

Future<T?> _tryInit<T>(Future<T> Function() factory, String name) async {
  try {
    return await factory();
  } catch (e, st) {
    Logger.root.warning('$name init failed, continuing without it', e, st);
    return null;
  }
}

/// Shared lazily-initialised dependencies for background isolates.
///
/// Used by both the Firebase background message handler and the CallKeep
/// push-notification isolate. Each isolate maintains its own instance via a
/// top-level nullable variable -- isolates do not share memory.
///
/// Non-critical fields are nullable — init failures are caught individually so
/// the main flow continues with partial data rather than aborting entirely.
class IsolateContext {
  IsolateContext({
    required this.secureStorage,
    this.remoteConfigService,
    this.appInfo,
    this.deviceInfo,
    this.packageInfo,
    this.appLabelsProvider,
  });

  final SecureStorage secureStorage;
  final RemoteConfigService? remoteConfigService;
  final AppInfo? appInfo;
  final DeviceInfo? deviceInfo;
  final PackageInfo? packageInfo;
  final AppMetadataProvider? appLabelsProvider;

  static Future<IsolateContext> init() async {
    final secureStorage = await SecureStorageImpl.init();

    final remoteConfigService = await _tryInit(DefaultRemoteCacheConfigService.init, 'RemoteConfigService');
    final appInfo = await _tryInit(() => AppInfo.init(const SharedPreferencesAppIdProvider()), 'AppInfo');
    final deviceInfo = await _tryInit(DeviceInfoFactory.init, 'DeviceInfo');
    final packageInfo = await _tryInit(PackageInfoFactory.init, 'PackageInfo');
    final appLabelsProvider = packageInfo != null && deviceInfo != null && appInfo != null
        ? await _tryInit(
            () => DefaultAppMetadataProvider.init(packageInfo, deviceInfo, appInfo, secureStorage),
            'AppMetadataProvider',
          )
        : null;

    try {
      final loggingConfig = remoteConfigService != null
          ? LoggingMapper.mapFromOverridesOnly(FeatureOverridesFactory.create(remoteConfigService.snapshot))
          : const LoggingConfig(
              logLevel: Level.INFO,
              monitorCheckInterval: Duration(seconds: 15),
              remoteLoggingEnabled: false,
              anonymizationEnabled: true,
            );
      await AppLogger.init(
        loggingConfig,
        LogzioLoggingService.fromEnvironment(loggingConfig.remoteLoggingEnabled),
        () => appLabelsProvider?.logLabels ?? {},
      );
    } catch (e, st) {
      Logger.root.warning('IsolateContext: AppLogger init failed, continuing without remote logging', e, st);
    }

    return IsolateContext(
      secureStorage: secureStorage,
      remoteConfigService: remoteConfigService,
      appInfo: appInfo,
      deviceInfo: deviceInfo,
      packageInfo: packageInfo,
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
///
/// Critical fields ([incomingCallTypeRepository], [appCertificates]) are
/// required — failures there abort the push flow. All other push-specific
/// fields are nullable with best-effort init.
class PushIsolateContext extends IsolateContext {
  PushIsolateContext({
    required super.secureStorage,
    required this.incomingCallTypeRepository,
    required this.appCertificates,
    super.remoteConfigService,
    super.appInfo,
    super.deviceInfo,
    super.packageInfo,
    super.appLabelsProvider,
    required this.localPushRepository,
    this.appPath,
    this.appDatabase,
    this.callLogsRepository,
  });

  final IncomingCallTypeRepository incomingCallTypeRepository;
  final AppCertificates appCertificates;
  final AppPath? appPath;
  final AppDatabase? appDatabase;
  final LocalPushRepository localPushRepository;
  final CallLogsRepository? callLogsRepository;

  static Future<PushIsolateContext> init() async {
    // Phase 1 — critical: abort if these fail.
    final base = await IsolateContext.init();
    final appPreferences = await AppPreferencesImpl.init();
    final appCertificates = await AppCertificates.init();

    // Phase 2 — best-effort: failures are isolated, flow continues with nulls.
    final appPath = await _tryInit(AppPath.init, 'AppPath');

    AppDatabase? appDatabase;
    if (appPath != null) {
      Logger.root.info('IsolateDatabase.connectOrCreate call from PushIsolateContext.init');
      appDatabase = await _tryInit(
        () => IsolateDatabase.connectOrCreate(directoryPath: appPath.applicationDocumentsPath),
        'AppDatabase',
      );
    } else {
      Logger.root.warning('PushIsolateContext: AppPath unavailable — skipping DB init');
    }

    final localPushRepository = LocalPushRepositoryFLNImpl();
    final callLogsRepository = appDatabase != null ? CallLogsRepository(appDatabase: appDatabase) : null;

    return PushIsolateContext(
      secureStorage: base.secureStorage,
      remoteConfigService: base.remoteConfigService,
      appInfo: base.appInfo,
      deviceInfo: base.deviceInfo,
      packageInfo: base.packageInfo,
      appLabelsProvider: base.appLabelsProvider,
      incomingCallTypeRepository: IncomingCallTypeRepositoryPrefsImpl(appPreferences),
      appCertificates: appCertificates,
      appPath: appPath,
      appDatabase: appDatabase,
      localPushRepository: localPushRepository,
      callLogsRepository: callLogsRepository,
    );
  }

  Future<void> dispose() => appDatabase?.close() ?? Future.value();
}
