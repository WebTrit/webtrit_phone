import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

class IsolateDatabase extends AppDatabase {
  IsolateDatabase(super.executor);

  static Future<IsolateDatabase> create({required String directoryPath, String dbName = 'db.sqlite'}) async {
    assert(directoryPath.isNotEmpty, 'directoryPath must not be empty');
    assert(dbName.isNotEmpty, 'dbName must not be empty');

    try {
      final executor = createAppDatabaseConnection(
        directoryPath,
        dbName,
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      );
      return IsolateDatabase(executor);
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
