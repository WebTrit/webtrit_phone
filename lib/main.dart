import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/pre_bootstrap/pre_bootstrap.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  hierarchicalLoggingEnabled = true;
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  preBootstrap();

  bootstrap(() async {
    final logRecordsRepository = LogRecordsRepository([
      LocalLogDataSource(),
      RemoteLogDataSource(),
    ])
      ..attachToLogger(Logger.root);

    final appAnalyticsRepository = AppAnalyticsRepository(instance: FirebaseAnalytics.instance);

    final applicationDocumentsPath = await getApplicationDocumentsPath();

    return MultiProvider(
      providers: [
        Provider<AppPreferences>(
          create: (context) {
            return AppPreferences();
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
