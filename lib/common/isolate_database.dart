import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

class IsolateDatabase extends AppDatabase {
  IsolateDatabase(super.executor);

  static IsolateDatabase? _instance;

  static Future<IsolateDatabase> create({required String directoryPath, String dbName = 'db.sqlite'}) async {
    if (_instance != null) return _instance!;

    try {
      return Future.sync(() async {
        if (_instance == null) {
          final executor = createAppDatabaseConnection(
            directoryPath,
            dbName,
            logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
          );
          _instance = IsolateDatabase(executor);
        }
        return _instance!;
      });
    } catch (e, stackTrace) {
      throw DatabaseInitializationException('Failed to initialize database: $e', stackTrace);
    }
  }
}

class DatabaseInitializationException implements Exception {
  final String message;
  final StackTrace stackTrace;

  DatabaseInitializationException(this.message, this.stackTrace);

  @override
  String toString() => 'DatabaseInitializationException: $message\n$stackTrace';
}
