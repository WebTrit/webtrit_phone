import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' show join;

DatabaseConnection createAppDatabaseConnection(String? path, String name, {bool logStatements = false}) {
  return DatabaseConnection.delayed(
    Future.sync(() async {
      final databasePath = join(path ?? '', name);

      final queryExecutor = NativeDatabase.createInBackground(
        File(databasePath),
        logStatements: logStatements,
        setup: (database) {
          // Enables Write-Ahead Logging (WAL) mode.
          // In default mode (DELETE journal), readers block writers and writers block readers.
          // WAL allows simultaneous readers and writers, which is crucial for
          // concurrent access from the UI isolate and Background isolate.
          database.execute('PRAGMA journal_mode=WAL;');

          // Sets a timeout (in milliseconds) for waiting when the database is locked.
          // By default, SQLite throws an error immediately if the DB is busy (SQLITE_BUSY).
          // Setting a timeout allows the driver to automatically retry the operation
          // for up to 5 seconds before failing, handling short-lived locks gracefully.
          database.execute('PRAGMA busy_timeout=5000;');
        },
      );

      return DatabaseConnection(queryExecutor);
    }),
  );
}
