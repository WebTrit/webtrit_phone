import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

/// Helper for creating [AppDatabase] instances in different isolates.
///
/// This helper does **not** cache database instances. Each call opens a new SQLite connection
/// to the same database file.
///
/// Concurrency notes:
/// - Opening multiple connections to the same SQLite file across isolates can increase the
///   likelihood of `SqliteException: database is locked` if operations overlap.
/// - Prefer short-lived access in background isolates (open > do work > close) using
///   [IsolateDatabase.use] (or a `try/finally` close pattern).
/// - For long-lived background services (e.g. CallKeep signaling isolates), keep a single
///   connection for the lifetime of the service and close it on release/teardown.
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

  /// Opens DB, runs [action], and always closes DB afterwards.
  ///
  /// Recommended for background isolates to reduce the chance of lock contention and to
  /// avoid leaving connections open.
  static Future<T> use<T>({
    required String directoryPath,
    String dbName = 'db.sqlite',
    required Future<T> Function(AppDatabase db) action,
    FutureOr<T> Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    final db = create(directoryPath: directoryPath, dbName: dbName);
    try {
      return await action(db);
    } catch (e, st) {
      if (onError != null) return await onError(e, st);
      rethrow;
    } finally {
      await db.close();
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
