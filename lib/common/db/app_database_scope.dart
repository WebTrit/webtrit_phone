import 'dart:async';

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
  }) async {
    final db = IsolateDatabase.create(directoryPath: directoryPath, dbName: dbName);
    try {
      return await action(db);
    } finally {
      await db.close();
    }
  }

  /// Runs [action] within a database scope.
  ///
  /// On error, notifies [onError] (if provided) and returns [fallback],
  /// preventing the exception from bubbling up the call stack.
  static Future<T> tryUse<T>({
    required String directoryPath,
    required Future<T> Function(AppDatabase db) action,
    required T fallback,
    String dbName = 'db.sqlite',
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      return await use(directoryPath: directoryPath, dbName: dbName, action: action);
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);
      return fallback;
    }
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
