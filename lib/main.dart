import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  final logger = Logger('run_app');

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final instanceRegistry = await bootstrap();

      if (!kIsWeb && kDebugMode) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        await FirebaseCrashlytics.instance.deleteUnsentReports();
      } else if (!kIsWeb) {
        // setCrashlyticsCollectionEnabled(false) PERSISTS for the install: a
        // release build over an install that ever ran a debug build would
        // silently report nothing. Re-enable explicitly outside debug.
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      }

      FlutterError.onError = (details) {
        logger.severe('FlutterError', details.exception, details.stack);
        if (!kIsWeb && !kDebugMode) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        }
      };

      Logger.root.onRecord.listen(_onRootLogRecord);

      runApp(RootApp.standalone(instanceRegistry));
    },
    (error, stackTrace) {
      logger.severe('runZonedGuarded', error, stackTrace);
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      }
    },
  );
}

void _onRootLogRecord(LogRecord record) {
  // firebase_crashlytics has no web implementation; calling it throws
  // MissingPluginException on every record (and the rethrow re-logs -> loop).
  if (!kIsWeb) FirebaseCrashlytics.instance.log(record.toString());
  if (!kIsWeb && !kDebugMode && record.level >= Level.SEVERE && record.loggerName == 'callkeep') {
    FirebaseCrashlytics.instance.recordError(record.message, record.stackTrace, reason: 'native callkeep error');
  }
}

/// A reactive config input: the [initial] value for the first frame plus an
/// [updates] factory that creates the stream replacing it as it changes.
///
/// [updates] is a factory (not a ready stream) so every provider subscription
/// gets a fresh stream - the bootstrap FeatureAccess stream is single-subscription
/// and reactive (it follows runtime system-info / remote-config changes), so a
/// re-created provider must be able to listen again without throwing or going stale.
typedef ConfigSource<T> = ({T initial, Stream<T> Function() updates});

class RootApp extends StatelessWidget {
  const RootApp({
    super.key,
    required this.instanceRegistry,
    required this.featureAccess,
    required this.themeSettings,
    this.themeMode,
    this.ownsBrowserHistory = true,
  });

  /// Standalone composition: resolves the config sources from the bootstrap
  /// [instanceRegistry] (the reactive FeatureAccess stream and the first
  /// bootstrap-built theme, which is static). A host that embeds the app uses
  /// the default constructor and supplies its own sources instead.
  factory RootApp.standalone(InstanceRegistry instanceRegistry) => RootApp(
    instanceRegistry: instanceRegistry,
    featureAccess: (
      initial: instanceRegistry.get<FeatureAccess>(),
      updates: () => instanceRegistry.get<FeatureAccessStreamFactory>().create(),
    ),
    themeSettings: (
      initial: instanceRegistry.get<AppThemes>().values.first.settings,
      updates: () => const Stream.empty(),
    ),
  );

  final InstanceRegistry instanceRegistry;

  /// Reactive config the app renders, provided down the tree as inherited values.
  /// The composition root decides the source: standalone (`main`) resolves it
  /// from the bootstrap registry; a host that embeds this app (the configurator's
  /// realtime preview) passes its own streams so the preview reflects live edits.
  /// RootApp itself stays agnostic - it only wires whatever source it is given.
  final ConfigSource<FeatureAccess> featureAccess;
  final ConfigSource<ThemeSettings> themeSettings;

  /// Optional read-only override for the displayed theme mode (the configurator's
  /// light/dark preview toggle). Null in a standalone run, where the mode comes
  /// from FeatureAccess / AppState; when set it wins, and nothing is persisted.
  final ConfigSource<ThemeMode>? themeMode;

  /// Whether this app instance owns the browser history (the URL / `window.history`).
  ///
  /// On the web only one router may sync the URL. When the app is embedded in a
  /// host that already owns it (the configurator's realtime preview), pass `false`:
  /// the app then runs a delegate-only router that navigates internally without
  /// touching the URL, so it can't clobber the host's routing. Default `true` for
  /// a standalone run, where the app is the sole owner of the URL.
  final bool ownsBrowserHistory;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppInfo>(create: (_) => instanceRegistry.get()),
        // The active theme, provided down the tree as an inherited value so the
        // app consumes it directly (see App.build) instead of holding it in
        // AppState. The source is supplied by the caller (see [themeSettings]).
        StreamProvider<ThemeSettings>(
          initialData: themeSettings.initial,
          create: (_) => themeSettings.updates(),
          updateShouldNotify: (previous, next) => previous != next,
        ),
        // Optional host theme-mode override (see [themeMode]); always provided as
        // a nullable value so App can read it, null in a standalone run.
        if (themeMode case final source?)
          StreamProvider<ThemeMode?>(
            initialData: source.initial,
            create: (_) => source.updates(),
            updateShouldNotify: (previous, next) => previous != next,
          )
        else
          Provider<ThemeMode?>.value(value: null),
        Provider<PackageInfo>(create: (_) => instanceRegistry.get()),
        // Stateless version-compatibility policy shared by the login gate and the
        // in-app force-update gate; const, so no bootstrap registration needed.
        Provider<AppCompatibilityResolver>(create: (_) => const DefaultAppCompatibilityResolver()),
        Provider<DeviceInfo>(create: (_) => instanceRegistry.get()),
        Provider<AppPreferences>(create: (_) => instanceRegistry.get()),
        // Reactive [FeatureAccess]; the source is supplied by the caller (see
        // [featureAccess]). Standalone it is the bootstrap stream synchronized
        // with SystemInfoRepository and RemoteConfigService.
        StreamProvider<FeatureAccess>(
          initialData: featureAccess.initial,
          create: (_) => featureAccess.updates(),
          updateShouldNotify: (previous, next) => previous != next,
        ),
        Provider<SecureStorage>(create: (_) => instanceRegistry.get()),
        Provider<AppPermissions>(create: (_) => instanceRegistry.get()),
        Provider<AppLogger>(create: (_) => instanceRegistry.get()),
        Provider<AppTime>(create: (_) => instanceRegistry.get()),
        Provider<AppPath>(create: (_) => instanceRegistry.get()),
        Provider<AppCertificates>(create: (_) => instanceRegistry.get()),
        Provider<AppMetadataProvider>(create: (_) => instanceRegistry.get()),
        Provider<WebtritApiClientFactory>(create: (_) => instanceRegistry.get()),
        Provider<PushEnvironment>(create: (_) => instanceRegistry.get()),
        // Provides a lifecycle-aware holder that attaches a WidgetsBindingObserver and owns the DB instance.
        // This provider may stay lazy; it will be created when `AppDatabase` is first requested.
        Provider<AppDatabaseLifecycleHolder>(
          create: _createAppDatabaseLifecycleHolder,
          dispose: _disposeAppDatabaseLifecycleHolder,
        ),
        // Provides `AppDatabase` by reading it from `AppDatabaseLifecycleHolder`.
        // When this provider is read, it triggers creation of the holder first (provider is lazy).
        Provider<AppDatabase>(create: (context) => context.read<AppDatabaseLifecycleHolder>().db),
        Provider<ConnectivityService>(create: (_) => instanceRegistry.get(), dispose: _disposeConnectivityService),
      ],
      child: Builder(
        builder: (context) {
          final prefs = context.read<AppPreferences>();
          final appMetadataProvider = context.read<AppMetadataProvider>();
          final presenceDeviceName = appMetadataProvider.userAgent;

          final registerStatusRepository = RegisterStatusRepositoryPrefsImpl(prefs);
          final presenceSettingsRepository = PresenceSettingsRepositoryPrefsImpl(prefs, presenceDeviceName);
          final queuedTerminationRequestsRepository = QueuedTerminationRequestsRepositoryPrefsImpl(prefs);
          final activeMainFlavorRepository = ActiveMainFlavorRepositoryPrefsImpl(prefs);
          final userAgreementStatusRepository = UserAgreementStatusRepositoryPrefsImpl(prefs);
          final activeRecentsVisibilityFilterRepository = ActiveRecentsVisibilityFilterRepositoryPrefsImpl(prefs);
          final activeContactSourceTypeRepository = ActiveContactSourceTypeRepositoryPrefsImpl(prefs);
          final audioProcessingSettingsRepository = AudioProcessingSettingsRepositoryPrefsImpl(prefs);
          final encodingPresetRepository = EncodingPresetRepositoryPrefsImpl(prefs);
          final iceSettingsRepository = IceSettingsRepositoryPrefsImpl(prefs);
          final incomingCallTypeRepository = IncomingCallTypeRepositoryPrefsImpl(prefs);
          final peerConnectionSettingsRepository = PeerConnectionSettingsRepositoryPrefsImpl(prefs);
          final videoCapturingSettingsRepository = VideoCapturingSettingsRepositoryPrefsImpl(prefs);
          final encodingSettingsRepository = EncodingSettingsRepositoryPrefsImpl(prefs);
          final localeRepository = LocaleRepositoryPrefsImpl(prefs);
          final themeModeRepository = ThemeModeRepositoryPrefsImpl(prefs);
          final transcriptionModelRepository = TranscriptionModelRepositoryPrefsImpl(prefs);
          final autocompleteHistoryRepository = AutocompleteHistoryRepositoryPrefsImpl(
            prefs,
            presets: {'recent_core_urls': EnvironmentConfig.PREDEFINED_CORE_URLS},
          );

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<LogRecordsRepository>(
                create: (_) => instanceRegistry.get(),
                dispose: disposeIfDisposable,
              ),
              RepositoryProvider<NativeLogForwarder>(
                create: (_) => instanceRegistry.get(),
                dispose: disposeIfDisposable,
              ),
              // Built by bootstrap's Firebase integration strategy: the Firebase-backed
              // repository standalone, a no-op one when Firebase is disabled.
              RepositoryProvider<AppAnalyticsRepository>(create: (_) => instanceRegistry.get()),
              RepositoryProvider<RegisterStatusRepository>.value(value: registerStatusRepository),
              RepositoryProvider<PresenceSettingsRepository>.value(value: presenceSettingsRepository),
              RepositoryProvider<QueuedTerminationRequestsRepository>.value(value: queuedTerminationRequestsRepository),
              RepositoryProvider<ActiveMainFlavorRepository>.value(value: activeMainFlavorRepository),
              RepositoryProvider<SessionRepository>.value(value: instanceRegistry.get<SessionRepository>()),
              RepositoryProvider<UserAgreementStatusRepository>.value(value: userAgreementStatusRepository),
              RepositoryProvider<ActiveRecentsVisibilityFilterRepository>.value(
                value: activeRecentsVisibilityFilterRepository,
              ),
              RepositoryProvider<ActiveContactSourceTypeRepository>.value(value: activeContactSourceTypeRepository),
              RepositoryProvider<AudioProcessingSettingsRepository>.value(value: audioProcessingSettingsRepository),
              RepositoryProvider<ContactsAgreementStatusRepository>.value(value: instanceRegistry.get()),
              RepositoryProvider<EncodingPresetRepository>.value(value: encodingPresetRepository),
              RepositoryProvider<IceSettingsRepository>.value(value: iceSettingsRepository),
              RepositoryProvider<IncomingCallTypeRepository>.value(value: incomingCallTypeRepository),
              RepositoryProvider<PeerConnectionSettingsRepository>.value(value: peerConnectionSettingsRepository),
              RepositoryProvider<VideoCapturingSettingsRepository>.value(value: videoCapturingSettingsRepository),
              RepositoryProvider<EncodingSettingsRepository>.value(value: encodingSettingsRepository),
              RepositoryProvider<LocaleRepository>.value(value: localeRepository),
              RepositoryProvider<ThemeModeRepository>.value(value: themeModeRepository),
              RepositoryProvider<TranscriptionModelRepository>.value(value: transcriptionModelRepository),
              RepositoryProvider<AutocompleteHistoryRepository>.value(value: autocompleteHistoryRepository),
              RepositoryProvider<SystemInfoRepository>(
                create: (_) => instanceRegistry.get(),
                dispose: disposeIfDisposable,
              ),
              RepositoryProvider<UserLocalDatasource>(create: (_) => instanceRegistry.get()),
              RepositoryProvider<AuthRepository>(create: (_) => instanceRegistry.get()),
            ],
            child: App(ownsBrowserHistory: ownsBrowserHistory),
          );
        },
      ),
    );
  }

  AppDatabaseLifecycleHolder _createAppDatabaseLifecycleHolder(BuildContext context) {
    if (kIsWeb) {
      // TODO(web): no DriftIsolate server on web; open the WasmDatabase directly.
      final db = IsolateDatabase.openWeb();
      return AppDatabaseLifecycleHolder(db, null)..attach();
    }
    final driftIsolate = instanceRegistry.get<DriftIsolate>();
    // Establish the connection; the IPC handshake to the server isolate starts when this Future is created.
    final db = AppDatabase(DatabaseConnection.delayed(driftIsolate.connect()));
    return AppDatabaseLifecycleHolder(db, driftIsolate)..attach();
  }

  Future<void> _disposeAppDatabaseLifecycleHolder(BuildContext _, AppDatabaseLifecycleHolder holder) async {
    await holder.dispose();
  }

  void _disposeConnectivityService(BuildContext _, ConnectivityService value) {
    value.dispose();
  }
}

class AppDatabaseLifecycleHolder with WidgetsBindingObserver {
  AppDatabaseLifecycleHolder(this.db, this._driftIsolate);

  final AppDatabase db;
  // Null on web - there is no DriftIsolate server (dart:isolate spawning is unsupported).
  final DriftIsolate? _driftIsolate;

  void attach() => WidgetsBinding.instance.addObserver(this);

  void detach() => WidgetsBinding.instance.removeObserver(this);

  Future<void> dispose() async {
    detach();
    await db.close();
    if (!kIsWeb) {
      // dart:ui IsolateNameServer and DriftIsolate are native-only.
      IsolateNameServer.removePortNameMapping(IsolateDatabase.kDbPortName);
      _driftIsolate?.shutdownAll();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // Close the main-isolate client connection. The server isolate stays alive
      // until dispose() is called or all clients disconnect.
      unawaited(db.close());
    }
  }
}
