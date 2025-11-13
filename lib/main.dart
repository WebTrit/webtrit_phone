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

      await bootstrap();

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
      runApp(const RootApp());
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
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppInfo>(
          create: (context) {
            return AppInfo();
          },
        ),
        Provider<AppThemes>(
          create: (context) {
            return AppThemes();
          },
        ),
        Provider<PlatformInfo>(
          create: (context) {
            return PlatformInfo();
          },
        ),
        Provider<PackageInfo>(
          create: (context) {
            return PackageInfoFactory.instance;
          },
        ),
        Provider<DeviceInfo>(
          create: (context) {
            return DeviceInfoFactory.instance;
          },
        ),
        Provider<AppPreferences>(
          create: (context) {
            return AppPreferencesFactory.instance;
          },
        ),
        Provider<AppPreferencesPure>(
          create: (context) {
            return AppPreferencesPure();
          },
        ),
        Provider<FeatureAccess>(
          create: (context) {
            return FeatureAccess();
          },
        ),
        Provider<SecureStorage>(
          create: (context) {
            return SecureStorage();
          },
        ),
        Provider<AppDatabase>(
          create: (context) {
            final appDatabase = _AppDatabaseWithAppLifecycleStateObserver(
              createAppDatabaseConnection(
                AppPath().applicationDocumentsPath,
                'db.sqlite',
                logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
              ),
            );
            WidgetsBinding.instance.addObserver(appDatabase);
            return appDatabase;
          },
          dispose: (context, value) {
            final appDatabase = value as _AppDatabaseWithAppLifecycleStateObserver;
            WidgetsBinding.instance.removeObserver(appDatabase);
            appDatabase.close();
          },
        ),
        Provider<AppPermissions>(
          create: (context) {
            return AppPermissions();
          },
        ),
        Provider<AppLogger>(
          create: (context) {
            return AppLogger();
          },
        ),
        Provider<AppTime>(
          create: (context) {
            return AppTime();
          },
        ),
        Provider<AppPath>(
          create: (context) {
            return AppPath();
          },
        ),
        // Services
        Provider<ConnectivityService>(
          create: (context) {
            return ConnectivityServiceImpl(
              connectivityChecker: const DefaultConnectivityChecker(
                connectivityCheckUrl: EnvironmentConfig.CONNECTIVITY_CHECK_URL,
              ),
            );
          },
          dispose: (context, value) => value.dispose(),
        ),
        Provider<AppLabelsProvider>(
          create: (context) {
            return DefaultAppLabelsProvider();
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final appPreferences = context.read<AppPreferences>();
          final appPreferencesPure = context.read<AppPreferencesPure>();
          final appDatabase = context.read<AppDatabase>();

          final registerStatusRepository = RegisterStatusRepositoryPrefsImpl(appPreferencesPure);
          final presenceSettingsRepository = PresenceSettingsRepositoryPrefsImpl(appPreferencesPure);
          final systemInfoLocalRepository = SystemInfoLocalRepositoryPrefsImpl(appPreferencesPure);
          final activeMainFlavorRepository = ActiveMainFlavorRepositoryPrefsImpl(appPreferencesPure);
          final callerIdSettingsRepository = CallerIdSettingsRepositoryPrefsImpl(appPreferencesPure);
          final userAgreementStatusRepository = UserAgreementStatusRepositoryPrefsImpl(appPreferencesPure);
          final activeRecentsVisibilityFilterRepository = ActiveRecentsVisibilityFilterRepositoryPrefsImpl(
            appPreferencesPure,
          );
          final activeContactSourceTypeRepository = ActiveContactSourceTypeRepositoryPrefsImpl(
            appPreferencesPure,
          );
          final audioProcessingSettingsRepository = AudioProcessingSettingsRepositoryPrefsImpl(appPreferencesPure);
          final contactsAgreementStatusRepository = ContactsAgreementStatusRepositoryPrefsImpl(appPreferencesPure);
          final encodingPresetRepository = EncodingPresetRepositoryPrefsImpl(appPreferencesPure);
          final iceSettingsRepository = IceSettingsRepositoryPrefsImpl(appPreferencesPure);

          final sessionRepository = SessionRepositoryImpl(
            secureStorage: context.read<SecureStorage>(),
            sessionCleanupWorker: SessionCleanupWorker(),
            onLogout: () async {
              await appDatabase.deleteEverything();
              await appPreferences.clear();
              await registerStatusRepository.clear();
              await presenceSettingsRepository.clear();
              await systemInfoLocalRepository.clear();
              await activeMainFlavorRepository.clear();
              await callerIdSettingsRepository.clear();
              await userAgreementStatusRepository.clear();
              await activeRecentsVisibilityFilterRepository.clear();
              await activeContactSourceTypeRepository.clear();
              await audioProcessingSettingsRepository.clear();
              await contactsAgreementStatusRepository.clear();
              await encodingPresetRepository.clear();
              await iceSettingsRepository.clear();
            },
          );

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: LogRecordsRepository()..attachToLogger(Logger.root)),
              RepositoryProvider.value(value: AppAnalyticsRepository(instance: FirebaseAnalytics.instance)),
              RepositoryProvider<RegisterStatusRepository>.value(value: registerStatusRepository),
              RepositoryProvider<PresenceSettingsRepository>.value(value: presenceSettingsRepository),
              RepositoryProvider<SystemInfoLocalRepository>.value(value: systemInfoLocalRepository),
              RepositoryProvider<ActiveMainFlavorRepository>.value(value: activeMainFlavorRepository),
              RepositoryProvider<SessionRepository>.value(value: sessionRepository),
              RepositoryProvider<CallerIdSettingsRepository>.value(value: callerIdSettingsRepository),
              RepositoryProvider<UserAgreementStatusRepository>.value(value: userAgreementStatusRepository),
              RepositoryProvider<ActiveRecentsVisibilityFilterRepository>.value(
                value: activeRecentsVisibilityFilterRepository,
              ),
              RepositoryProvider<ActiveContactSourceTypeRepository>.value(
                value: activeContactSourceTypeRepository,
              ),
              RepositoryProvider<AudioProcessingSettingsRepository>.value(
                value: audioProcessingSettingsRepository,
              ),
              RepositoryProvider<ContactsAgreementStatusRepository>.value(
                value: contactsAgreementStatusRepository,
              ),
              RepositoryProvider<EncodingPresetRepository>.value(
                value: encodingPresetRepository,
              ),
              RepositoryProvider<IceSettingsRepository>.value(
                value: iceSettingsRepository,
              ),
            ],
            child: const App(),
          );
        },
      ),
    );
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
