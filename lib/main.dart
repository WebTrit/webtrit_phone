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
    final sessionCleanupWorker = SessionCleanupWorker();

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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: LogRecordsRepository()..attachToLogger(Logger.root)),
              RepositoryProvider.value(value: AppAnalyticsRepository(instance: FirebaseAnalytics.instance)),
              RepositoryProvider<SessionRepository>.value(
                value: SessionRepositoryImpl(
                  secureStorage: context.read<SecureStorage>(),
                  appPreferences: context.read<AppPreferences>(),
                  appDatabase: context.read<AppDatabase>(),
                  sessionCleanupWorker: sessionCleanupWorker,
                ),
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
