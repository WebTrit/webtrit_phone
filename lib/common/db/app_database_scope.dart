import 'dart:async';

import 'package:webtrit_phone/data/data.dart';

import 'isolate_database.dart';

/// Provides scoped access to the [AppDatabase].
///
/// This helper manages the lifecycle of the database connection, ensuring
/// it is opened before the action and closed immediately after, regardless of success or failure.
abstract final class AppDatabaseScope {
  /// Opens a new database connection, executes the provided [action], and closes the connection.
  ///
  /// Throws any exception that occurs during database initialization or within the [action].
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

  /// Attempts to execute the [action] within a database scope.
  ///
  /// If an exception occurs, [onError] is notified (if provided), and [fallback] is returned.
  /// This prevents exceptions from propagating up the stack.
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

  /// Attempts to execute the [action] within a database scope.
  ///
  /// If an exception occurs, [onError] is notified (if provided), and `null` is returned.
  /// Useful when a failure should simply result in a missing value.
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
