import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

/// Helper for creating [AppDatabase] instances in different isolates.
///
/// This helper does **not** cache database instances. Each call opens a new SQLite connection
/// to the same database file.
abstract final class IsolateDatabase {
  /// Opens a new [AppDatabase] instance for [directoryPath]/[dbName].
  ///
  /// Note: This creates a new SQLite connection each time. Avoid calling it repeatedly in
  /// concurrent code paths; prefer [use] to ensure connections are closed deterministically.
  static AppDatabase create({required String directoryPath, String dbName = 'db.sqlite'}) {
    assert(directoryPath.isNotEmpty, 'directoryPath must not be empty');
    assert(dbName.isNotEmpty, 'dbName must not be empty');

    try {
      final executor = createAppDatabaseConnection(
        directoryPath,
        dbName,
        logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
      );
      return AppDatabase(executor);
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
