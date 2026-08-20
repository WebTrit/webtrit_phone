import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

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

      // Android 15+ enforces edge-to-edge, but on older versions the engine leaves the
      // view inset above the navigation bar - the app then paints nothing there and the
      // Android window background (`?android:colorBackground`, a light color) shows
      // through the transparent bar. Requesting the mode explicitly keeps one behavior
      // on every version: the app's own surfaces paint behind the system bars.
      if (!kIsWeb) await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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

/// The host theme-mode override, provided as a nullable value so the app can
/// always read it - null when no host supplies one.
///
/// Deliberately one widget type whether a [source] is given or not. The entry
/// sits above every other provider, and a list entry that changes type is a new
/// widget at that position: everything below it would be unmounted and rebuilt,
/// taking the dependencies of a running app with it.
///
/// The [source] is read once, when the entry is first built - as with every
/// stream provider here. A host that swaps one source for another gets the
/// first one until it mounts a new app, which is the intended contract: the
/// config sources belong to the app instance, not to a frame.
SingleChildWidget hostThemeModeProvider(ConfigSource<ThemeMode>? source) {
  return StreamProvider<ThemeMode?>(
    initialData: source?.initial,
    create: (_) => source?.updates() ?? const Stream<ThemeMode?>.empty(),
    updateShouldNotify: (previous, next) => previous != next,
  );
}

class RootApp extends StatefulWidget {
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
  State<RootApp> createState() => _RootAppState();
}

/// One mounted [RootApp] is one running application: it is handed the
/// dependencies its bootstrap built, and it releases them when it goes away.
/// A standalone run never gets there - the process ends first - while a host
/// that embeds the app (the theme configurator's live preview, which relaunches
/// it on every configuration edit) gets the shutdown for free, by taking the
/// widget down. One bootstrap therefore belongs to one [RootApp].
class _RootAppState extends State<RootApp> {
  @override
  void dispose() {
    widget.instanceRegistry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Providers that only hand out an instance built by the composition root
    // never dispose it: those live as long as the process and are released by
    // the startup teardown. A provider disposes what its own `create` built -
    // see `docs/dependency_ownership.md`.
    return MultiProvider(
      providers: [
        Provider<AppInfo>(create: (_) => widget.instanceRegistry.get()),
        // The active theme, provided down the tree as an inherited value so the
        // app consumes it directly (see App.build) instead of holding it in
        // AppState. The source is supplied by the caller (see [themeSettings]).
        StreamProvider<ThemeSettings>(
          initialData: widget.themeSettings.initial,
          create: (_) => widget.themeSettings.updates(),
          updateShouldNotify: (previous, next) => previous != next,
        ),
        // Optional host theme-mode override (see [themeMode]); always provided as
        // a nullable value so App can read it, null in a standalone run.
        hostThemeModeProvider(widget.themeMode),
        Provider<PackageInfo>(create: (_) => widget.instanceRegistry.get()),
        // Stateless version-compatibility policy shared by the login gate and the
        // in-app force-update gate; const, so no bootstrap registration needed.
        Provider<AppCompatibilityResolver>(create: (_) => const DefaultAppCompatibilityResolver()),
        Provider<DeviceInfo>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppPreferences>(create: (_) => widget.instanceRegistry.get()),
        // Reactive [FeatureAccess]; the source is supplied by the caller (see
        // [featureAccess]). Standalone it is the bootstrap stream synchronized
        // with SystemInfoRepository and RemoteConfigService.
        StreamProvider<FeatureAccess>(
          initialData: widget.featureAccess.initial,
          create: (_) => widget.featureAccess.updates(),
          updateShouldNotify: (previous, next) => previous != next,
        ),
        Provider<SecureStorage>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppPermissions>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppLogger>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppTime>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppPath>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppCertificates>(create: (_) => widget.instanceRegistry.get()),
        Provider<AppMetadataProvider>(create: (_) => widget.instanceRegistry.get()),
        Provider<WebtritApiClientFactory>(create: (_) => widget.instanceRegistry.get()),
        Provider<PushEnvironment>(create: (_) => widget.instanceRegistry.get()),
        // Platform-backed collaborators of the main shell, so the shell reads
        // them like every other dependency instead of constructing them
        // inline. The substitution seam this opens is for widget tests that
        // pump the shell under their own providers; a host embedding RootApp
        // still gets the production set.
        Provider<Callkeep>(create: (_) => widget.instanceRegistry.get()),
        Provider<CallkeepConnections>(create: (_) => widget.instanceRegistry.get()),
        // Const and stateless, so no bootstrap registration needed (the
        // AppCompatibilityResolver precedent above).
        Provider<SignalingServiceFactory>(create: (_) => const SignalingServiceFactory()),
        // Not in the bootstrap registry: resolving the messaging singleton
        // requires the default Firebase app, so it stays lazy and resolves on
        // first read - the moment the direct call used to happen. Note the
        // provider caches a throwing create for its lifetime, so this relies
        // on both hosts initializing Firebase before the shell mounts (both
        // do today).
        Provider<FirebaseMessaging>(create: (_) => FirebaseMessaging.instance),
        // Provides a lifecycle-aware holder that attaches a WidgetsBindingObserver and owns the DB instance.
        // This provider may stay lazy; it will be created when `AppDatabase` is first requested.
        Provider<AppDatabaseLifecycleHolder>(
          create: _createAppDatabaseLifecycleHolder,
          dispose: _disposeAppDatabaseLifecycleHolder,
        ),
        // Provides `AppDatabase` by reading it from `AppDatabaseLifecycleHolder`.
        // When this provider is read, it triggers creation of the holder first (provider is lazy).
        Provider<AppDatabase>(create: (context) => context.read<AppDatabaseLifecycleHolder>().db),
        Provider<ConnectivityService>(create: (_) => widget.instanceRegistry.get()),
      ],
      child: Builder(
        builder: (context) {
          final prefs = context.read<AppPreferences>();
          final appMetadataProvider = context.read<AppMetadataProvider>();
          final presenceDeviceName = appMetadataProvider.userAgent;

          final registerStatusRepository = RegisterStatusRepositoryPrefsImpl(prefs);
          final presenceSettingsRepository = PresenceSettingsRepositoryPrefsImpl(prefs, presenceDeviceName);
          final queuedTerminationRequestsRepository = QueuedTerminationRequestsRepositoryPrefsImpl(prefs);
          final activeMainTabRepository = ActiveMainTabRepositoryPrefsImpl(prefs);
          final userAgreementStatusRepository = UserAgreementStatusRepositoryPrefsImpl(prefs);
          final activeRecentsVisibilityFilterRepository = ActiveRecentsVisibilityFilterRepositoryPrefsImpl(prefs);
          final activeContactSourceTypeRepository = ActiveContactSourceTypeRepositoryPrefsImpl(prefs);
          final audioProcessingSettingsRepository = AudioProcessingSettingsRepositoryPrefsImpl(prefs);
          final encodingPresetRepository = EncodingPresetRepositoryPrefsImpl(prefs);
          final iceSettingsRepository = IceSettingsRepositoryPrefsImpl(prefs);
          final incomingCallTypeRepository = IncomingCallTypeRepositoryPrefsImpl(prefs);
          final peerConnectionSettingsRepository = PeerConnectionSettingsRepositoryPrefsImpl(prefs);
          final specialPermissionsRepository = SpecialPermissionsRepositoryPrefsImpl(prefs);
          final videoCapturingSettingsRepository = VideoCapturingSettingsRepositoryPrefsImpl(prefs);
          final encodingSettingsRepository = EncodingSettingsRepositoryPrefsImpl(prefs);
          final localeRepository = LocaleRepositoryPrefsImpl(prefs);
          final themeModeRepository = ThemeModeRepositoryPrefsImpl(prefs);
          final autocompleteHistoryRepository = AutocompleteHistoryRepositoryPrefsImpl(
            prefs,
            presets: {'recent_core_urls': EnvironmentConfig.PREDEFINED_CORE_URLS},
          );

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<LogRecordsRepository>(create: (_) => widget.instanceRegistry.get()),
              RepositoryProvider<NativeLogForwarder>(create: (_) => widget.instanceRegistry.get()),
              // Built by bootstrap's Firebase integration strategy: the Firebase-backed
              // repository standalone, a no-op one when Firebase is disabled.
              RepositoryProvider<AppAnalyticsRepository>(create: (_) => widget.instanceRegistry.get()),
              RepositoryProvider<RegisterStatusRepository>.value(value: registerStatusRepository),
              RepositoryProvider<PresenceSettingsRepository>.value(value: presenceSettingsRepository),
              RepositoryProvider<QueuedTerminationRequestsRepository>.value(value: queuedTerminationRequestsRepository),
              RepositoryProvider<ActiveMainTabRepository>.value(value: activeMainTabRepository),
              RepositoryProvider<SessionRepository>.value(value: widget.instanceRegistry.get<SessionRepository>()),
              RepositoryProvider<UserAgreementStatusRepository>.value(value: userAgreementStatusRepository),
              RepositoryProvider<ActiveRecentsVisibilityFilterRepository>.value(
                value: activeRecentsVisibilityFilterRepository,
              ),
              RepositoryProvider<ActiveContactSourceTypeRepository>.value(value: activeContactSourceTypeRepository),
              RepositoryProvider<AudioProcessingSettingsRepository>.value(value: audioProcessingSettingsRepository),
              RepositoryProvider<ContactsAgreementStatusRepository>.value(value: widget.instanceRegistry.get()),
              RepositoryProvider<EncodingPresetRepository>.value(value: encodingPresetRepository),
              RepositoryProvider<IceSettingsRepository>.value(value: iceSettingsRepository),
              RepositoryProvider<IncomingCallTypeRepository>.value(value: incomingCallTypeRepository),
              RepositoryProvider<PeerConnectionSettingsRepository>.value(value: peerConnectionSettingsRepository),
              RepositoryProvider<SpecialPermissionsRepository>.value(value: specialPermissionsRepository),
              RepositoryProvider<VideoCapturingSettingsRepository>.value(value: videoCapturingSettingsRepository),
              RepositoryProvider<EncodingSettingsRepository>.value(value: encodingSettingsRepository),
              RepositoryProvider<LocaleRepository>.value(value: localeRepository),
              RepositoryProvider<ThemeModeRepository>.value(value: themeModeRepository),
              RepositoryProvider<AutocompleteHistoryRepository>.value(value: autocompleteHistoryRepository),
              RepositoryProvider<SystemInfoRepository>(create: (_) => widget.instanceRegistry.get()),
              RepositoryProvider<UserLocalDatasource>(create: (_) => widget.instanceRegistry.get()),
              RepositoryProvider<AuthRepository>(create: (_) => widget.instanceRegistry.get()),
            ],
            child: App(ownsBrowserHistory: widget.ownsBrowserHistory),
          );
        },
      ),
    );
  }

  AppDatabaseLifecycleHolder _createAppDatabaseLifecycleHolder(BuildContext context) {
    if (kIsWeb) {
      // TODO(web): no DriftIsolate server on web; open the WasmDatabase directly.
      final db = IsolateDatabase.openWeb();
      return AppDatabaseLifecycleHolder(db)..attach();
    }
    // Establish the connection; the IPC handshake to the server isolate starts when this Future is created.
    final db = AppDatabase(widget.instanceRegistry.get<DatabaseServer>().connect());
    return AppDatabaseLifecycleHolder(db)..attach();
  }

  Future<void> _disposeAppDatabaseLifecycleHolder(BuildContext _, AppDatabaseLifecycleHolder holder) async {
    await holder.dispose();
  }
}

/// Owns the connection this app instance opened to the database, and closes it
/// when the widget owning it goes away or the app is detached.
///
/// The database server itself (the drift isolate and its name-server mapping)
/// belongs to the startup path and is shut down by the startup teardown - a
/// widget going away must not take it down with it, because the background
/// isolates find the database through that same mapping.
class AppDatabaseLifecycleHolder with WidgetsBindingObserver {
  AppDatabaseLifecycleHolder(this.db);

  final AppDatabase db;

  void attach() => WidgetsBinding.instance.addObserver(this);

  void detach() => WidgetsBinding.instance.removeObserver(this);

  Future<void> dispose() async {
    detach();
    await db.close();
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
