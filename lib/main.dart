import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/pre_bootstrap/pre_bootstrap.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  preBootstrap();

  bootstrap(() async {
    final rootLogger = Logger.root;
    final logRecordsRepository = LogRecordsRepository()..attachToLogger(rootLogger);
    final appAnalyticsRepository = AppAnalyticsRepository(instance: FirebaseAnalytics.instance);
    rootLogger.onRecord.listen((record) => FirebaseCrashlytics.instance.log(record.toString()));

    final applicationDocumentsPath = await getApplicationDocumentsPath();

    return MultiProvider(
      providers: [
        Provider<AppInfo>(
          create: (context) {
            return AppInfo();
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
                applicationDocumentsPath,
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
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: logRecordsRepository),
          RepositoryProvider.value(value: appAnalyticsRepository),
        ],
        child: Builder(
          builder: (context) {
            return App(
              appPreferences: context.read<AppPreferences>(),
              secureStorage: context.read<SecureStorage>(),
              appDatabase: context.read<AppDatabase>(),
              appPermissions: context.read<AppPermissions>(),
              appThemes: AppThemes(),
            );
          },
        ),
      ),
    );
  });
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
