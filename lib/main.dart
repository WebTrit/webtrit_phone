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
import 'package:webtrit_phone/repositories/repositories.dart';

void main() {
  hierarchicalLoggingEnabled = true;
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  bootstrap(() async {
    final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);
    final appAnalyticsRepository = AppAnalyticsRepository(instance: FirebaseAnalytics.instance);

    return Provider<AppDatabase>(
      create: (context) => AppDatabase.createInBackground(
        AppPath().databasePath,
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      ),
      dispose: (context, value) => value.close(),
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
