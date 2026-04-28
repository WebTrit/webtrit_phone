import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';

import 'isolate_database.dart';

/// Provides scoped access to the [AppDatabase].
///
/// Manages the lifecycle of a database connection:
/// opens the database before running the action and closes it afterward,
/// regardless of success or failure.
abstract final class AppDatabaseScope {
  /// Opens a new database connection, runs [action], and closes the connection.
  ///
  /// Any exception thrown during initialization or inside [action] is rethrown.
  static Future<T> use<T>({
    required String directoryPath,
    required Future<T> Function(AppDatabase db) action,
    String dbName = 'db.sqlite',
    Duration timeout = const Duration(seconds: 10),
  }) async {
    Logger.root.info('AppDatabaseScope.use - opening database connection');
    final db = await IsolateDatabase.connectOrCreate(directoryPath: directoryPath, dbName: dbName);
    T? result;
    Object? error;
    try {
      Logger.root.info('AppDatabaseScope.use - running action (time: ${DateTime.now().toIso8601String()})');

      /// Run the action with a timeout to prevent hanging indefinitely if the database is locked or unresponsive.
      result = await action(db).timeout(timeout);
      Logger.root.info('AppDatabaseScope.use - action completed (time: ${DateTime.now().toIso8601String()})');
    } catch (e, s) {
      Logger.root.severe('AppDatabaseScope.use - error during action execution: $e', e, s);
      error = e;
    }
    Logger.root.info('AppDatabaseScope.use - closing database connection (time: ${DateTime.now().toIso8601String()})');

    /// Ensure the database connection is closed even if the action throws an error.
    /// Before last change 17.04.2026, with finaly block, the connection was not closed if action threw an error, which could lead to resource leaks and locked database files.
    await db.close();
    return result ?? (throw error ?? Exception('Unknown error in AppDatabaseScope.use'));
  }

  /// Runs [action] within a database scope.
  ///
  /// On error, notifies [onError] (if provided) and returns `null`.
  /// Useful when failures should yield an absent value instead of an exception.
  static Future<T?> useOrNull<T>({
    required String directoryPath,
    required Future<T> Function(AppDatabase db) action,
    String dbName = 'db.sqlite',
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await use(directoryPath: directoryPath, dbName: dbName, action: action);
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);
      return null;
    }
  }
}
