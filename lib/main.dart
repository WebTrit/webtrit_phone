import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/app.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

void main() {
  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  bootstrap(() async {
    final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);

    DriftIsolate isolate = await AppDatabase.spawn(AppPath().databasePath);

    return Provider<AppDatabase>(
      create: (context) => AppDatabase.fromIsolate(isolate),
      dispose: (context, value) => value.close(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: logRecordsRepository,
          ),
          RepositoryProvider<WebtritApiClient>(
            create: (context) => WebtritApiClient(Uri.parse(EnvironmentConfig.CORE_URL)),
          ),
          RepositoryProvider<CallRepository>(
            create: (context) => CallRepository(),
          ),
          RepositoryProvider<FavoritesRepository>(
            create: (context) => FavoritesRepository(
              appDatabase: context.read<AppDatabase>(),
            ),
          ),
          RepositoryProvider<RecentsRepository>(
            create: (context) => RecentsRepository(
              appDatabase: context.read<AppDatabase>(),
            ),
          ),
          RepositoryProvider<ContactsRepository>(
            create: (context) => ContactsRepository(
              appDatabase: context.read<AppDatabase>(),
            ),
          ),
          RepositoryProvider<LocalContactsRepository>(
            create: (context) => LocalContactsRepository(),
          ),
          RepositoryProvider<PushTokensRepository>(
            create: (context) => PushTokensRepository(
              webtritApiClient: context.read<WebtritApiClient>(),
              secureStorage: SecureStorage(),
            ),
          ),
          RepositoryProvider<ExternalContactsRepository>(
            create: (context) => ExternalContactsRepository(
              webtritApiClient: context.read<WebtritApiClient>(),
              periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
            ),
          ),
          RepositoryProvider<AccountInfoRepository>(
            create: (context) => AccountInfoRepository(
              webtritApiClient: context.read<WebtritApiClient>(),
              periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NotificationsBloc>(
              create: (context) => NotificationsBloc(),
            ),
            BlocProvider<AppBloc>(
              create: (context) => AppBloc(),
            ),
          ],
          child: App(
            webRegistrationInitialUrl: await SecureStorage().readWebRegistrationInitialUrl(),
            isRegistered: await SecureStorage().readToken() != null,
          ),
        ),
      ),
    );
  });
}
