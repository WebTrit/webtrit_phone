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
import 'package:webtrit_phone/pre_bootstrap.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

void main() {
  hierarchicalLoggingEnabled = true;
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  preBootstrap();

  bootstrap(() async {
    final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);
    final appAnalyticsRepository = AppAnalyticsRepository(instance: FirebaseAnalytics.instance);

    return Provider<AppDatabase>(
      create: (context) {
        final appDatabase = _AppDatabaseWithAppLifecycleStateObserver.connect(
          createAppDatabaseConnection(
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
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: logRecordsRepository),
          RepositoryProvider.value(value: appAnalyticsRepository),
        ],
        child: Builder(
          builder: (context) {
            return App(
              appDatabase: context.read<AppDatabase>(),
              appPermissions: AppPermissions(),
            );
          },
        ),
      ),
    );
  });
}

class _AppDatabaseWithAppLifecycleStateObserver extends AppDatabase with WidgetsBindingObserver {
  _AppDatabaseWithAppLifecycleStateObserver.connect(connection) : super.connect(connection);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      close();
    }
  }
}
