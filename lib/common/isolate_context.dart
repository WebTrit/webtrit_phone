import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import 'app_id_provider.dart';
import 'db/db.dart';
import 'logging/logging.dart';

/// Runs [factory] and returns its result, or `null` if it throws.
/// Logs a warning with the full stack trace so failures are visible in the isolate log.
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
/// top-level nullable variable - isolates do not share memory.
///
/// Non-critical fields are nullable - init failures are caught individually so
/// the main flow continues with partial data rather than aborting entirely.
class IsolateContext {
  IsolateContext({
    required this.secureStorage,
    this.remoteConfigService,
    this.appInfo,
    this.deviceInfo,
    this.packageInfo,
    this.appLabelsProvider,
    this.nativeLogForwarder,
    this.appPath,
  });

  /// Required - credentials for signaling auth. Throws on failure.
  final SecureStorage secureStorage;

  /// Nullable - best-effort. Null when remote config is unavailable.
  final RemoteConfigService? remoteConfigService;
  final AppInfo? appInfo;
  final DeviceInfo? deviceInfo;
  final PackageInfo? packageInfo;
  final AppMetadataProvider? appLabelsProvider;

  /// Nullable - best-effort. Null when [appPath] is unavailable.
  final NativeLogForwarder? nativeLogForwarder;

  /// Nullable - best-effort. Null when filesystem path is unavailable.
  final AppPath? appPath;

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

    final appPath = await _tryInit(AppPath.init, 'AppPath');
    final nativeLogForwarder = appPath != null
        ? (NativeLogForwarder(nativeLogFilePath: appPath.nativeLogFilePath, logger: Logger('callkeep'))..start())
        : null;

    return IsolateContext(
      secureStorage: secureStorage,
      remoteConfigService: remoteConfigService,
      appInfo: appInfo,
      deviceInfo: deviceInfo,
      packageInfo: packageInfo,
      appLabelsProvider: appLabelsProvider,
      nativeLogForwarder: nativeLogForwarder,
      appPath: appPath,
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
/// required - failures there abort the push flow. All other push-specific
/// fields are nullable with best-effort init.
class PushIsolateContext extends IsolateContext {
  PushIsolateContext({
    required super.secureStorage,
    required this.incomingCallTypeRepository,
    required this.appCertificates,
    required this.localPushRepository,
    required this.locale,
    super.nativeLogForwarder,
    super.appPath,
    super.remoteConfigService,
    super.appInfo,
    super.deviceInfo,
    super.packageInfo,
    super.appLabelsProvider,
    this.appDatabase,
    this.callLogsRepository,
  });

  /// Required - mode check (persistent vs pushBound). Throws on failure.
  final IncomingCallTypeRepository incomingCallTypeRepository;

  /// Required - TLS certificates for WebSocket. Throws on failure.
  final AppCertificates appCertificates;

  /// Nullable - best-effort. Null when [appPath] or DB open fails.
  final AppDatabase? appDatabase;

  /// Always initialised - uses FlutterLocalNotificationsPlugin, no DB dependency.
  final LocalPushRepository localPushRepository;

  /// Nullable - best-effort. Null when [appDatabase] is unavailable.
  final CallLogsRepository? callLogsRepository;

  /// User's selected locale, used to resolve localised strings in the isolate.
  final Locale locale;

  static Future<PushIsolateContext> init() async {
    // Phase 1 - critical: abort if these fail.
    final base = await IsolateContext.init();
    final appPreferences = await AppPreferencesImpl.init();
    final appCertificates = await AppCertificates.init();

    // Phase 2 - best-effort: failures are isolated, flow continues with nulls.
    AppDatabase? appDatabase;
    if (base.appPath != null) {
      Logger.root.info('IsolateDatabase.connectOrCreate call from PushIsolateContext.init');
      appDatabase = await _tryInit(
        () => IsolateDatabase.connectOrCreate(directoryPath: base.appPath!.applicationDocumentsPath),
        'AppDatabase',
      );
    } else {
      Logger.root.warning('PushIsolateContext: AppPath unavailable - skipping DB init');
    }

    final localPushRepository = LocalPushRepositoryFLNImpl();
    final callLogsRepository = appDatabase != null ? CallLogsRepository(appDatabase: appDatabase) : null;
    final locale = LocaleRepositoryPrefsImpl(appPreferences).getLocale();

    return PushIsolateContext(
      secureStorage: base.secureStorage,
      remoteConfigService: base.remoteConfigService,
      appInfo: base.appInfo,
      deviceInfo: base.deviceInfo,
      packageInfo: base.packageInfo,
      appLabelsProvider: base.appLabelsProvider,
      nativeLogForwarder: base.nativeLogForwarder,
      incomingCallTypeRepository: IncomingCallTypeRepositoryPrefsImpl(appPreferences),
      appCertificates: appCertificates,
      appPath: base.appPath,
      appDatabase: appDatabase,
      localPushRepository: localPushRepository,
      callLogsRepository: callLogsRepository,
      locale: locale,
    );
  }

  Future<void> dispose() async {
    await nativeLogForwarder?.dispose();
    await appDatabase?.close();
  }
}
