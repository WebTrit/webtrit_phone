import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logging/logging.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/features/system_notifications/services/services.dart';

import 'package:webtrit_phone/features/call/call.dart'
    show onPushNotificationSyncCallback, onSignalingBackgroundCallEvent;

import 'app/app_dependencies.dart';
import 'app/firebase_integration.dart';
import 'app/initial_notification_resolver.dart';
import 'app/session/session.dart';
import 'app/startup_trace.dart';
import 'firebase_options.dart';
import 'services/services.dart';

// Lazily initialised once per Firebase background isolate lifetime.
// Dart isolates do not share memory -- each background isolate gets its own instance.
IsolateContext? _isolateContext;

Future<AppDependencies> bootstrap({
  FirebaseIntegration firebase = const FirebaseIntegrationEnabled(),
  AppPresentationConfigBuilder? configurePresentation,
  StartupTrace? startupTrace,
}) async {
  // Everything long-lived is handed to the builder where it is created: `share`
  // for what the screens read, `keep` for what only has to keep running. See
  // AppDependenciesBuilder and `docs/dependency_ownership.md`.
  final deps = AppDependenciesBuilder();
  final trace = startupTrace ?? StartupTrace.disabled();

  // External SDKs (side effects only, don't need registration). The [firebase]
  // strategy decides whether these run: standalone wires Firebase, while an
  // embedder that owns the default Firebase app (e.g. the theme configurator's
  // realtime preview) passes a disabled strategy so the app runs Firebase-free.
  await trace.measure('platform', () => firebase.initPlatform(trace));

  // Initialize Components

  // App Info & Device Data

  final packageInfo = deps.share(await trace.measure('package-info', PackageInfoFactory.init));
  final appInfo = deps.share(await trace.measure('app-info', () => AppInfo.init(firebase.appIdProvider)));
  final deviceInfo = deps.share(await trace.measure('device-info', DeviceInfoFactory.init));

  // Storages
  final secureStorage = deps.share(await trace.measure('secure-storage', SecureStorageImpl.init));
  // final token = secureStorage.readToken();
  // print('bootstrap: secureStorage token: ${token != null ? '***' : 'null'}');
  final appPreferences = deps.share(await trace.measure('app-preferences', AppPreferencesImpl.init));
  deps.share<UserLocalDatasource>(UserLocalDatasourcePrefsImpl(appPreferences));

  // Network clients
  final appCertificates = deps.share(await trace.measure('app-certificates', AppCertificates.init));

  // Built here rather than taken from AppMetadataProvider, which needs
  // featureAccess and is therefore created later; the format is shared.

  // TODO(Vlad): Split AppMetadataProvider into AppMetadataProvider (userAgent,
  // appInfo, deviceInfo, exportFilenamePrefix - needs only package/app/device
  // info) and LogLabelsProvider (logLabels - the only member needing
  // secureStorage and featureAccess). Then the metadata provider can be built
  // here, before the API client factory, and this static call goes away.
  final userAgent = DefaultAppMetadataProvider.buildUserAgent(packageInfo, appInfo, deviceInfo);
  final apiClientFactory = deps.share(
    WebtritApiClientFactory(
      trustedCertificates: appCertificates.trustedCertificates,
      userAgent: userAgent,
      getTenantId: () => secureStorage.readTenantId() ?? '',
      getCoreUrl: () =>
          Uri.parse(secureStorage.readCoreUrl() ?? EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL),
    ),
  );

  // Background workers (assuming SessionCleanupWorker is still a side-effect init)
  final sessionCleanupWorker = SessionCleanupWorker.init(apiClientFactory);

  // Core infrastructure
  final appThemes = deps.keep(await trace.measure('app-themes', AppThemes.init));

  // Repositories
  final contactsAgreementStatusRepository = deps.share<ContactsAgreementStatusRepository>(
    ContactsAgreementStatusRepositoryPrefsImpl(appPreferences),
  );
  final systemInfoLocalDatasource = SystemInfoLocalRepositoryPrefsImpl(secureStorage);
  final systemInfoRemoteDatasource = SystemInfoRemoteDatasource(apiClientFactory);
  final systemInfoRepository = deps.share<SystemInfoRepository>(
    SystemInfoRepositoryImpl(localDatasource: systemInfoLocalDatasource, remoteDatasource: systemInfoRemoteDatasource),
  );

  deps.share<AuthRepository>(
    AuthRepositoryImpl(
      apiClientFactory: apiClientFactory,
      systemInfoRemoteDatasource: systemInfoRemoteDatasource,
      appIdentifier: appInfo.identifier,
      appBundleId: EnvironmentConfig.resolveBundleId(packageInfo.packageName),
    ),
  );

  deps.share<SessionRepository>(
    SessionRepositoryImpl(
      secureStorage: secureStorage,
      sessionCleanupWorker: sessionCleanupWorker,
      apiClientFactory: apiClientFactory,
    ),
  );

  // Remote configuration. The Firebase-backed service needs the Firebase app, so
  // the strategy resolves it (with a local-cache fallback); a disabled strategy
  // just uses the local cache (DefaultRemoteCacheConfigService also implements
  // RemoteConfigService).
  final remoteCacheConfigService = await trace.measure('remote-config-cache', DefaultRemoteCacheConfigService.init);
  final cachedRemoteConfigService = await trace.measure(
    'remote-config',
    () => firebase.remoteConfig(remoteCacheConfigService),
  );

  final featureAccessStreamFactory = deps.keep(
    FeatureAccessStreamFactory(
      appThemes: appThemes,
      systemInfoRepository: systemInfoRepository,
      remoteConfigService: cachedRemoteConfigService,
    ),
  );
  // Initialize the immutable feature configuration snapshot.
  // This instance serves as the `initialData` for the `StreamProvider`, ensuring the UI
  // has valid feature flags immediately during the first frame.
  final featureAccess = await trace.measure('feature-access', featureAccessStreamFactory.getInitialSnapshot);

  // Utilities - Capturing instances that were previously just `await Class.init()`
  deps.share(await trace.measure('push-environment', PushEnvironment.init));
  final appPath = deps.share(await trace.measure('app-path', AppPath.init));

  // Spawn the shared DriftIsolate database server. All isolates (FCM background,
  // WorkManager) connect to this single server via IsolateNameServer, eliminating
  // write-write SQLite contention.
  if (kIsWeb) {
    // TODO(web): dart:isolate is unsupported on web, so there is no DriftIsolate
    // server. The drift WasmDatabase is opened lazily on first access in main.dart
    // (see AppDatabaseLifecycleHolder); nothing to register here.
    Logger('bootstrap').warning('DriftIsolate server skipped on web; using lazy WasmDatabase connection');
  } else {
    final driftIsolate = await trace.measure(
      'database-isolate',
      () => IsolateDatabase.spawnServer(directoryPath: appPath.applicationDocumentsPath),
    );
    // The server isolate and its name-server mapping are process-wide - the
    // background isolates find the database through that mapping - so the
    // registry owns them and widgets only take client connections.
    deps.share(DatabaseServer(driftIsolate));
  }

  deps.share(
    await trace.measure(
      'app-permissions',
      () => _createAppPermissions(featureAccess, contactsAgreementStatusRepository),
    ),
  );
  deps.share(await trace.measure('app-time', AppTime.init));
  final metadataProvider = deps.share<AppMetadataProvider>(
    await trace.measure(
      'app-metadata',
      () => DefaultAppMetadataProvider.init(packageInfo, deviceInfo, appInfo, secureStorage, featureAccess),
    ),
  );

  // Logger
  deps.share(
    await trace.measure(
      'app-logger',
      () => AppLogger.init(
        featureAccess.loggingConfig,
        LogzioLoggingService.fromEnvironment(featureAccess.loggingConfig.remoteLoggingEnabled),
        () => metadataProvider.logLabels,
      ),
    ),
  );
  // File-based log storage uses dart:io and is unavailable on web; fall back to
  // the in-memory log repository there. TODO(web): persistent web logging.
  deps.share(
    LogRecordsRepository.create(useFileStorage: !kIsWeb, logFilePath: appPath.logFilePath)..attachToLogger(Logger.root),
  );

  if (kIsWeb && EnvironmentConfig.WEB_BUNDLE_ID == null) {
    Logger('bootstrap').warning(
      'Web build has no WEBTRIT_APP_WEB_BUNDLE_ID dart-define; falling back to '
      'packageInfo.packageName ("${packageInfo.packageName}") as bundle_id, which the '
      'server will likely reject with unconfigured_bundle_id (login/autoprovision fail).',
    );
  }
  final nativeLogForwarder = deps.share(
    NativeLogForwarder(nativeLogFilePath: appPath.nativeLogFilePath, logger: Logger('callkeep')),
  );
  // FileSystemEntity.watch is not supported on iOS: the Dart SDK only implements
  // it for Android/Linux (inotify), Windows, and macOS (FSEvents). Calling it on
  // iOS throws FileSystemException("File system watching is not supported on this
  // platform"). The Callkeep native log file also only exists on Android.
  if (kIsWeb) {
    // TODO(web): the native callkeep log file does not exist on web; nothing to forward.
    Logger('bootstrap').info('NativeLogForwarder not started on web');
  } else if (Platform.isAndroid) {
    nativeLogForwarder.start();
  }

  // In master mode the instance adds itself as a WidgetsBindingObserver; it is
  // registered below so the registry takes it back off when it is released.
  // Background isolates build their own via initSlave.
  deps.keep(await trace.measure('app-lifecycle', AppLifecycle.initMaster));

  // ConnectivityService - owns the `Connectivity()` plugin subscription used by
  // the call subsystem (other features still keep their own direct subscriptions).
  // Built here (not in RootApp) so the deduplication cache can be seeded via an
  // awaited `checkConnectivity()` read before any consumer subscribes. This
  // prevents the listener's first replayed event from being misinterpreted as a
  // real interface change downstream.
  deps.share<ConnectivityService>(
    await trace.measure(
      'connectivity',
      () => ConnectivityServiceImpl.create(connectivityChecker: _createConnectivityChecker(apiClientFactory)),
    ),
  );

  // Call-integration handles of the authenticated shell, shared here so widgets
  // receive them from the composition root instead of constructing them inline
  // (widget tests substitute them by providing their own above the shell). Both
  // are process-wide singletons behind their factory constructors.
  deps.share(Callkeep());
  deps.share(CallkeepConnections());
  deps.share(firebase.analytics);

  // Final side-effect initializations that rely on the components above
  await trace.measure('callkeep', () => _initCallkeep(featureAccess));
  await trace.measure('work-manager', _initWorkManager);

  final defaultPresentationConfig = (
    featureAccess: (initial: featureAccess, updates: featureAccessStreamFactory.create),
    themeSettings: (initial: appThemes.values.first.settings, updates: () => const Stream<ThemeSettings>.empty()),
  );
  // A host may replace only the sources rendered by the tree. Bootstrap has
  // already used its own FeatureAccess snapshot for permissions, metadata,
  // logging and call integration, so preview sources cannot reconfigure those
  // services.
  final presentationConfig = resolvePresentationConfig(defaultPresentationConfig, configurePresentation);

  return deps.build(
    featureAccess: presentationConfig.featureAccess,
    themeSettings: presentationConfig.themeSettings,
    systemInfo: systemInfoRepository,
  );
}

/// Standalone integration: real Firebase platform init, the Firebase id provider,
/// Firebase Remote Config (with a local-cache fallback) and Firebase Analytics.
/// This is the default [bootstrap] strategy. Lives here so it can reuse the
/// private Firebase init functions below.
class FirebaseIntegrationEnabled implements FirebaseIntegration {
  const FirebaseIntegrationEnabled();

  @override
  Future<void> initPlatform(StartupTrace startupTrace) async {
    await startupTrace.measure('firebase-core', _initFirebaseApp);
    await startupTrace.measure('firebase-messaging', _initFirebaseMessaging);
    await startupTrace.measure('local-notifications', _initLocalPushs);
  }

  @override
  AppIdProvider get appIdProvider => FirebaseAppIdProvider();

  @override
  Future<RemoteConfigService> remoteConfig(DefaultRemoteCacheConfigService cache) async {
    try {
      return await CachedRemoteConfigService.init(cache);
    } catch (e, s) {
      Logger('bootstrap').warning('Firebase Remote Config init failed; using local cache fallback', e, s);
      return cache;
    }
  }

  @override
  AppAnalyticsRepository get analytics => FirebaseAppAnalyticsRepository();
}

/// Creates the platform [ConnectivityChecker] used by [ConnectivityService]
/// for HTTP liveness probes. Picks the custom-URL implementation if a
/// dedicated check endpoint is provided via [EnvironmentConfig], otherwise
/// falls back to the default API-client-based check.
ConnectivityChecker _createConnectivityChecker(WebtritApiClientFactory apiClientFactory) {
  final customUrl = EnvironmentConfig.CONNECTIVITY_CHECK_URL;
  return switch (customUrl) {
    String url => CustomConnectivityChecker(
      connectivityCheckUrl: url,
      createHttpRequestExecutor: apiClientFactory.createHttpRequestExecutor(),
    ),
    null => DefaultConnectivityChecker(createApiClient: apiClientFactory.createWebtritApiClient),
  };
}

/// Initializes [AppPermissions] with an exclusion callback.
///
/// This function creates a callback that combines permissions to be excluded based on feature access
/// and the user's agreement status for contacts. This allows for dynamically determining which
/// permissions should be excluded, for example, if a feature is disabled or the user has not consented
/// to contact access.
Future<AppPermissions> _createAppPermissions(
  FeatureAccess featureAccess,
  ContactsAgreementStatusRepository repository,
) async {
  return AppPermissions.init(
    // Pass the callback directly. It captures the 'featureAccess' and 'repository'
    // variables and evaluates them only when the callback is triggered.
    () => [...featureAccess.excludedPermissions, ...repository.getContactsAgreementStatus().excludedPermissions],
  );
}

/// Registers all background callbacks required by the CallKeep and signaling subsystems.
///
/// Must be called once at app startup before any background isolates are spawned.
/// Each registration is awaited so that handles are persisted to SharedPreferences
/// before the service starts and reads them in the background isolate.
Future<void> _initCallkeep(FeatureAccess featureAccess) async {
  final logger = Logger('bootstrap');

  // Registers the factory used by the signaling service to create a [SignalingModule]
  // instance. Must be a top-level function annotated @pragma('vm:entry-point').
  // iOS: stored in memory, called directly in start(). Android: also persisted to
  // SharedPreferences for deserialization in the background isolate.
  // Required on every platform - web/iOS run the signaling in the main isolate
  // (WebtritSignalingServiceDirect) and start() throws without a registered factory.
  try {
    await WebtritSignalingService.setModuleFactory(createSignalingModule);
  } catch (e, s) {
    logger.severe('signaling module factory registration failed -- signaling may not work', e, s);
  }

  // The remaining callkeep services (Android background push isolate,
  // persistent-mode call-event handler, SMS triggers) are Android-only; web has
  // no background isolates and iOS does not use them. kIsWeb short-circuits before
  // the dart:io Platform check (which is unavailable on web).
  if (kIsWeb || !Platform.isAndroid) return;

  // Registers the top-level callback that the native Android side invokes when a push
  // notification arrives in the background. Bootstraps the push isolate and delegates
  // to [onPushNotificationSyncCallback]. Must be annotated @pragma('vm:entry-point').
  try {
    await AndroidCallkeepServices.backgroundPushNotificationBootstrapService.initializeCallback(
      onPushNotificationSyncCallback,
    );
  } catch (e, s) {
    logger.severe('initializeCallback failed -- push notifications may not work in background', e, s);
  }

  // Registers the top-level callback invoked by the signaling background isolate when a
  // call-relevant event (IncomingCallEvent, HangupEvent) arrives in persistent mode
  // (app closed or backgrounded). Must be annotated @pragma('vm:entry-point').
  try {
    await WebtritSignalingService.setCallEventHandler(onSignalingBackgroundCallEvent);
  } catch (e, s) {
    logger.severe('setCallEventHandler failed -- call events in persistent mode may not work', e, s);
  }

  // Configures Android CallKeep to process incoming SMS messages as call triggers
  // when the SMS fallback mechanism is enabled in the feature access config.
  if (featureAccess.callConfig.triggerConfig.smsFallback.enabled) {
    try {
      await AndroidCallkeepUtils.smsReceptionConfig.configureReceivedSms(
        prefix: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS_PREFIX,
        regexPattern: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN,
      );
    } catch (e, s) {
      logger.severe('configureReceivedSms failed -- SMS call trigger may not work', e, s);
    }
  }
}

/// Initializes Firebase for background services. This initialization must be called in an isolate
/// when Firebase components are used. For more details, refer to the Firebase documentation:
/// https://firebase.google.com/docs/cloud-messaging/flutter/receive
Future<void> _initFirebaseApp() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    Logger('Firebase').severe('Error in _initFirebase', e);
  }
}

Future<void> _initFirebaseMessaging() async {
  final logger = Logger('FirebaseMessaging');

  if (kIsWeb) {
    // TODO(web): wire FCM web (service worker + onMessage) when push support on
    // web is in scope. Skipped for now - several APIs below are mobile-only.
    logger.info('Firebase messaging init skipped on web');
    return;
  }

  FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.info('onMessage: ${message.toMap()}');
    final appPush = AppRemotePush.fromFCM(message);
    RemotePushBroker.handleForegroundPush(appPush);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.info('onMessageOpenedApp: ${message.toMap()}');
    final appPush = AppRemotePush.fromFCM(message);
    RemotePushBroker.handleOpenedPush(appPush);
  });
  unawaited(
    resolveInitialNotification<RemoteMessage>(
      load: FirebaseMessaging.instance.getInitialMessage,
      deliver: (initialMessage) {
        logger.info('initialMessage: ${initialMessage.toMap()}');
        final appPush = AppRemotePush.fromFCM(initialMessage);
        RemotePushBroker.handleOpenedPush(appPush);
      },
      onSlow: (elapsed) => logger.warning('getInitialMessage still pending after ${elapsed.inSeconds}s'),
      onError: (error, stackTrace) => logger.warning('getInitialMessage failed', error, stackTrace),
    ),
  );

  // actual FirebaseMessaging permission request executed in [PermissionsCubit]
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger('_firebaseMessagingBackgroundHandler');

  // Ensure Firebase services are initialized before configuring Crashlytics.
  await _initFirebaseApp();

  await runZonedGuarded(
    () => _handleBackgroundMessage(message, logger),
    (error, stack) => _recordBackgroundError(error, stack, logger),
  );
}

/// Records background isolate errors to both the local logger and Firebase Crashlytics.
Future<void> _recordBackgroundError(Object error, StackTrace stack, Logger logger) async {
  logger.severe('Unhandled background error', error, stack);

  await FirebaseCrashlytics.instance.recordFlutterFatalError(
    FlutterErrorDetails(
      exception: error,
      stack: stack,
      context: ErrorDescription('Firebase background handler logic failure'),
    ),
  );
}

/// Core logic for processing background messages.
Future<void> _handleBackgroundMessage(RemoteMessage message, Logger logger) async {
  // Initialise shared isolate dependencies once per isolate lifetime.
  _isolateContext ??= await IsolateContext.init();

  final appPush = AppRemotePush.fromFCM(message);

  logger.info('onBackgroundMessage: ${message.toMap()}');

  if (!kIsWeb && appPush is PendingCallPush && Platform.isAndroid) {
    // Known issue: [SqliteException] with code 5 (database is locked) may occur
    // due to concurrent database access from multiple isolates.
    final displayName = await _resolveContactDisplayNameWithFallback(appPush, logger);

    await AndroidCallkeepServices.backgroundPushNotificationBootstrapService
        .reportNewIncomingCall(
          appPush.call.id,
          CallkeepHandle.number(appPush.call.handle),
          displayName: displayName,
          hasVideo: appPush.call.hasVideo,
        )
        .timeout(const Duration(seconds: 10), onTimeout: () => _onReportIncomingCallTimeout(logger));
  }

  if (appPush is MessagePush) {
    final activeMessagePush = ActiveMessagePush(
      notificationId: appPush.id,
      messageId: appPush.messageId,
      conversationId: appPush.conversationId,
      title: appPush.title ?? '',
      body: appPush.body ?? '',
      time: DateTime.now(),
    );

    final appPath = _isolateContext!.appPath;
    if (appPath != null) {
      await DatabaseScope(appPath.applicationDocumentsPath)
          .onError((e, _) => logger.warning('MessagePush DB write failed: $e'))
          .execute((db) async => ActiveMessagePushsRepositoryDriftImpl(appDatabase: db).set(activeMessagePush))
          .run();
    }
  }
}

/// Attempts to resolve the contact name from the database, falling back to push data on error.
///
/// This process is susceptible to [SqliteException] with code 5 (database is locked)
/// when multiple isolates (e.g., background FCM and main app) access the database
/// concurrently. If any error occurs, the display name from the push payload is returned.
Future<String> _resolveContactDisplayNameWithFallback(PendingCallPush appPush, Logger logger) async {
  final appPath = _isolateContext!.appPath;
  if (appPath == null) return appPush.call.displayName;

  String? contactName;
  await DatabaseScope(appPath.applicationDocumentsPath)
      .onError(
        (e, s) => logger.severe(
          'Failed to resolve contact name for handle: ${appPush.call.handle}. Fallback to push display name.',
          e,
          s,
        ),
      )
      .execute((db) async {
        final contact = await ContactsRepository(
          appDatabase: db,
          contactsRemoteDataSource: null,
          contactsLocalDataSource: null,
        ).getContactByPhoneNumber(appPush.call.handle);
        contactName = contact?.maybeName;
      })
      .run();
  return contactName ?? appPush.call.displayName;
}

CallkeepIncomingCallError? _onReportIncomingCallTimeout(Logger logger) {
  logger.warning('reportNewIncomingCall timed out — Telecom may be overloaded');
  return null;
}

Future _initLocalPushs() async {
  if (kIsWeb) {
    // TODO(web): flutter_local_notifications has no web platform; local push
    // channels are skipped on web.
    Logger('bootstrap').info('Local notifications init skipped on web');
    return;
  }
  await FlutterLocalNotificationsPlugin().initialize(
    settings: const InitializationSettings(
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: LocalPushsBroker.handleActionReceived,
    onDidReceiveBackgroundNotificationResponse: LocalPushsBroker.handleActionReceived,
  );

  await _initAndroidNotificationChannel();

  final logger = Logger('LocalNotifications');
  unawaited(
    resolveInitialNotification<NotificationAppLaunchDetails>(
      load: FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails,
      deliver: (launchDetails) async {
        final response = launchDetails.notificationResponse;
        if (response != null) await LocalPushsBroker.handleActionReceived(response);
      },
      onSlow: (elapsed) => logger.warning('getNotificationAppLaunchDetails still pending after ${elapsed.inSeconds}s'),
      onError: (error, stackTrace) => logger.warning('getNotificationAppLaunchDetails failed', error, stackTrace),
    ),
  );
}

/// Creates the high-importance local push channel referenced by FCM's
/// `default_notification_channel_id` and drops the legacy default-importance
/// channel so heads-up banners and screen wake work for local pushes.
Future<void> _initAndroidNotificationChannel() async {
  final androidPlugin = FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  if (androidPlugin == null) return;

  // ignore: deprecated_member_use_from_same_package
  await androidPlugin.deleteNotificationChannel(channelId: kLegacyLocalPushChannelId);
  await androidPlugin.createNotificationChannel(
    const AndroidNotificationChannel(kLocalPushChannelId, kLocalPushChannelName, importance: Importance.high),
  );
}

Future<void> _initWorkManager() async {
  if (kIsWeb) {
    // TODO(web): workmanager has no web platform; background system-notification
    // polling is not available on web.
    Logger('bootstrap').info('WorkManager init skipped on web');
    return;
  }
  Workmanager().initialize(workManagerDispatcher);
}

@pragma('vm:entry-point')
void workManagerDispatcher() {
  final logger = Logger('WorkManagerDispatcher');

  Workmanager().executeTask((task, _) async {
    logger.info('Task execution started: $task');

    if (task != kSystemNotificationsTask && task != kSystemNotificationsTaskId) {
      return true;
    }

    // Skip execution if the app is in the foreground
    final appLifecycle = await AppLifecycle.initSlave();
    if (appLifecycle.getLifecycleState() == AppLifecycleState.resumed) return true;

    try {
      // Init api and remote repository
      final storage = await SecureStorageImpl.init();
      final coreUrl = storage.readCoreUrl();
      final tenantId = storage.readTenantId();
      final token = storage.readToken();
      if (coreUrl == null || tenantId == null || token == null) return true;

      final api = WebtritApiClient(Uri.parse(coreUrl), tenantId);
      final remoteRepo = SystemNotificationsRemoteRepositoryApiImpl(api, token, const EmptySessionGuard());

      final appPath = await AppPath.init();
      final localPushRepo = LocalPushRepositoryFLNImpl();

      var taskSucceeded = false;
      await DatabaseScope(
        appPath.applicationDocumentsPath,
      ).onError((e, s) => logger.severe('System notifications task failed', e, s)).execute((db) async {
        final localRepo = SystemNotificationsLocalRepositoryDriftImpl(db);
        final worker = SystemNotificationBackgroundWorker(localRepo, remoteRepo, localPushRepo);
        taskSucceeded = await worker.execute();
      }).run();

      logger.info('Task result: $taskSucceeded');
      return taskSucceeded; // false - WorkManager retries
    } catch (e, st) {
      logger.severe('Unhandled WorkManager task error', e, st);
      // Return `false` so WorkManager can retry according to its backoff policy.
      // Returning `true` would mark the run as successful and may prevent retries.
      return false;
    }
  });
}
