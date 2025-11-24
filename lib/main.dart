import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/app/app_bloc_observer.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
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
      }

      FlutterError.onError = (details) {
        logger.severe('FlutterError', details.exception, details.stack);
        if (!kIsWeb && !kDebugMode) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        }
      };

      Logger.root.onRecord.listen((record) => FirebaseCrashlytics.instance.log(record.toString()));

      Bloc.observer = AppBlocObserver();
      runApp(RootApp(instanceRegistry: instanceRegistry));
    },
    (error, stackTrace) {
      logger.severe('runZonedGuarded', error, stackTrace);
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      }
    },
  );
}

class RootApp extends StatelessWidget {
  const RootApp({super.key, required this.instanceRegistry});

  final InstanceRegistry instanceRegistry;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppInfo>(create: (_) => instanceRegistry.get()),
        Provider<AppThemes>(create: (_) => instanceRegistry.get()),
        Provider<PackageInfo>(create: (_) => instanceRegistry.get()),
        Provider<DeviceInfo>(create: (_) => instanceRegistry.get()),
        Provider<AppPreferences>(create: (_) => instanceRegistry.get()),
        Provider<FeatureAccess>(create: (_) => instanceRegistry.get()),
        Provider<SecureStorage>(create: (_) => instanceRegistry.get()),
        Provider<AppPermissions>(create: (_) => instanceRegistry.get()),
        Provider<AppLogger>(create: (_) => instanceRegistry.get()),
        Provider<AppTime>(create: (_) => instanceRegistry.get()),
        Provider<AppPath>(create: (_) => instanceRegistry.get()),
        Provider<AppCertificates>(create: (_) => instanceRegistry.get()),
        Provider<AppMetadataProvider>(create: (_) => instanceRegistry.get()),
        Provider<WebtritApiClientFactory>(create: (_) => instanceRegistry.get()),

        // Services
        Provider<AppDatabase>(create: _createAppDatabase, dispose: _disposeAppDatabase),
        Provider<ConnectivityService>(create: _createConnectivityService, dispose: _disposeConnectivityService),
      ],
      child: Builder(
        builder: (context) {
          final prefs = context.read<AppPreferences>();
          final database = context.read<AppDatabase>();
          final webtritApiClientFactory = context.read<WebtritApiClientFactory>();
          final appMetadataProvider = context.read<AppMetadataProvider>();
          final presenceDeviceName = appMetadataProvider.userAgent;

          final systemInfoRepository = instanceRegistry.get<SystemInfoRepository>();

          final registerStatusRepository = RegisterStatusRepositoryPrefsImpl(prefs);
          final presenceSettingsRepository = PresenceSettingsRepositoryPrefsImpl(prefs, presenceDeviceName);
          final activeMainFlavorRepository = ActiveMainFlavorRepositoryPrefsImpl(prefs);
          final callerIdSettingsRepository = CallerIdSettingsRepositoryPrefsImpl(prefs);
          final userAgreementStatusRepository = UserAgreementStatusRepositoryPrefsImpl(prefs);
          final activeRecentsVisibilityFilterRepository = ActiveRecentsVisibilityFilterRepositoryPrefsImpl(prefs);
          final activeContactSourceTypeRepository = ActiveContactSourceTypeRepositoryPrefsImpl(prefs);
          final audioProcessingSettingsRepository = AudioProcessingSettingsRepositoryPrefsImpl(prefs);
          final contactsAgreementStatusRepository = ContactsAgreementStatusRepositoryPrefsImpl(prefs);
          final encodingPresetRepository = EncodingPresetRepositoryPrefsImpl(prefs);
          final iceSettingsRepository = IceSettingsRepositoryPrefsImpl(prefs);
          final incomingCallTypeRepository = IncomingCallTypeRepositoryPrefsImpl(prefs);
          final peerConnectionSettingsRepository = PeerConnectionSettingsRepositoryPrefsImpl(prefs);
          final videoCapturingSettingsRepository = VideoCapturingSettingsRepositoryPrefsImpl(prefs);
          final encodingSettingsRepository = EncodingSettingsRepositoryPrefsImpl(prefs);
          final localeRepository = LocaleRepositoryPrefsImpl(prefs);
          final themeModeRepository = ThemeModeRepositoryPrefsImpl(prefs);
          final autocompleteHistoryRepository = AutocompleteHistoryRepositoryPrefsImpl(prefs);

          final sessionRepository = SessionRepositoryImpl(
            secureStorage: context.read<SecureStorage>(),
            sessionCleanupWorker: instanceRegistry.get<SessionCleanupWorker>(),
            apiClientFactory: webtritApiClientFactory,

            /// TODO(Vlad): maybe consider refactoring this code to use some kind of higher-level "LogoutController" instead of hooking repositories here
            onLogout: () async {
              await database.deleteEverything(); // TODO: clear using repos instead of direct access
              await systemInfoRepository.clear();
              await registerStatusRepository.clear();
              await presenceSettingsRepository.clear();
              await activeMainFlavorRepository.clear();
              await callerIdSettingsRepository.clear();
              await activeRecentsVisibilityFilterRepository.clear();
              await activeContactSourceTypeRepository.clear();
              await audioProcessingSettingsRepository.clear();
              await encodingPresetRepository.clear();
              await iceSettingsRepository.clear();
              await incomingCallTypeRepository.clear();
              await peerConnectionSettingsRepository.clear();
              await videoCapturingSettingsRepository.clear();
              await encodingSettingsRepository.clear();
              await localeRepository.clear();
              await themeModeRepository.clear();
            },
          );

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: LogRecordsRepository()..attachToLogger(Logger.root)),
              RepositoryProvider.value(value: AppAnalyticsRepository(instance: FirebaseAnalytics.instance)),
              RepositoryProvider<RegisterStatusRepository>.value(value: registerStatusRepository),
              RepositoryProvider<PresenceSettingsRepository>.value(value: presenceSettingsRepository),
              RepositoryProvider<ActiveMainFlavorRepository>.value(value: activeMainFlavorRepository),
              RepositoryProvider<SessionRepository>.value(value: sessionRepository),
              RepositoryProvider<CallerIdSettingsRepository>.value(value: callerIdSettingsRepository),
              RepositoryProvider<UserAgreementStatusRepository>.value(value: userAgreementStatusRepository),
              RepositoryProvider<ActiveRecentsVisibilityFilterRepository>.value(
                value: activeRecentsVisibilityFilterRepository,
              ),
              RepositoryProvider<ActiveContactSourceTypeRepository>.value(value: activeContactSourceTypeRepository),
              RepositoryProvider<AudioProcessingSettingsRepository>.value(value: audioProcessingSettingsRepository),
              RepositoryProvider<ContactsAgreementStatusRepository>.value(value: contactsAgreementStatusRepository),
              RepositoryProvider<EncodingPresetRepository>.value(value: encodingPresetRepository),
              RepositoryProvider<IceSettingsRepository>.value(value: iceSettingsRepository),
              RepositoryProvider<IncomingCallTypeRepository>.value(value: incomingCallTypeRepository),
              RepositoryProvider<PeerConnectionSettingsRepository>.value(value: peerConnectionSettingsRepository),
              RepositoryProvider<VideoCapturingSettingsRepository>.value(value: videoCapturingSettingsRepository),
              RepositoryProvider<EncodingSettingsRepository>.value(value: encodingSettingsRepository),
              RepositoryProvider<LocaleRepository>.value(value: localeRepository),
              RepositoryProvider<ThemeModeRepository>.value(value: themeModeRepository),
              RepositoryProvider<AutocompleteHistoryRepository>.value(value: autocompleteHistoryRepository),
              RepositoryProvider<SystemInfoRepository>(
                create: (_) => instanceRegistry.get(),
                dispose: disposeIfDisposable,
              ),
              RepositoryProvider<AuthRepository>(
                create: (_) => instanceRegistry.get(),
                dispose: disposeIfDisposable,
              ),
            ],
            child: const App(),
          );
        },
      ),
    );
  }

  AppDatabase _createAppDatabase(BuildContext _) {
    final appDatabase = _AppDatabaseWithAppLifecycleStateObserver(
      createAppDatabaseConnection(
        instanceRegistry.get<AppPath>().applicationDocumentsPath,
        'db.sqlite',
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      ),
    );
    WidgetsBinding.instance.addObserver(appDatabase);
    return appDatabase;
  }

  void _disposeAppDatabase(BuildContext _, AppDatabase value) {
    final appDatabase = value as _AppDatabaseWithAppLifecycleStateObserver;
    WidgetsBinding.instance.removeObserver(appDatabase);
    appDatabase.close();
  }

  ConnectivityService _createConnectivityService(BuildContext context) {
    final executor = context.read<WebtritApiClientFactory>().createHttpRequestExecutor();

    return ConnectivityServiceImpl(
      connectivityChecker: DefaultConnectivityChecker(
        connectivityCheckUrl: EnvironmentConfig.CONNECTIVITY_CHECK_URL,
        createHttpRequestExecutor: executor,
      ),
    );
  }

  void _disposeConnectivityService(BuildContext _, ConnectivityService value) {
    value.dispose();
  }
}

class _AppDatabaseWithAppLifecycleStateObserver extends AppDatabase with WidgetsBindingObserver {
  _AppDatabaseWithAppLifecycleStateObserver(super.e);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      close();
    }
  }
}
