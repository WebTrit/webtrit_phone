import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';

import 'isolate_database.dart';

/// Scoped access to [AppDatabase] - opens a connection, runs the action, then closes it.
///
/// Build the scope with [execute] and [onError], then trigger execution with [run].
///
/// Example:
/// ```dart
/// await DatabaseScope(appPath.applicationDocumentsPath)
///   .onError((e, s) => logger.warning('failed: $e'))
///   .execute((db) async => repo.set(item))
///   .run();
/// ```
class DatabaseScope {
  DatabaseScope(this._directoryPath);

  final String _directoryPath;
  void Function(Object, StackTrace)? _onError;
  Future<void> Function(AppDatabase db)? _action;
  Duration _timeout = const Duration(seconds: 10);

  DatabaseScope withTimeout(Duration timeout) {
    _timeout = timeout;
    return this;
  }

  DatabaseScope onError(void Function(Object, StackTrace) handler) {
    _onError = handler;
    return this;
  }

  DatabaseScope execute(Future<void> Function(AppDatabase db) action) {
    _action = action;
    return this;
  }

  Future<void> run() async {
    if (_action == null) throw StateError('DatabaseScope.run() called without execute()');
    AppDatabase? db;
    try {
      Logger.root.info('DatabaseScope - opening connection');
      db = await IsolateDatabase.connectOrCreate(directoryPath: _directoryPath);
      Logger.root.info('DatabaseScope - running (time: ${DateTime.now().toIso8601String()})');
      await _action!(db).timeout(_timeout);
      Logger.root.info('DatabaseScope - completed (time: ${DateTime.now().toIso8601String()})');
    } catch (e, s) {
      Logger.root.severe('DatabaseScope - error: $e', e, s);
      _onError?.call(e, s);
    } finally {
      Logger.root.info('DatabaseScope - closing connection');
      await db?.close();
    }
  }
}
