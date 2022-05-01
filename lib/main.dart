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
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  bootstrap(() async {
    final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);

    DriftIsolate isolate = await AppDatabase.spawn(AppPath().databasePath);

    return Provider<AppDatabase>(
      create: (context) => AppDatabase.fromIsolate(isolate),
      dispose: (context, value) => value.close(),
      child: RepositoryProvider.value(
        value: logRecordsRepository,
        child: App(
          webRegistrationInitialUrl: await SecureStorage().readWebRegistrationInitialUrl(),
          isRegistered: await SecureStorage().readToken() != null,
        ),
      ),
    );
  });
}
