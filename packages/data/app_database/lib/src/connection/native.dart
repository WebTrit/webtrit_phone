import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' show join;

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,
  bool isWalEnabled = true,
  int? busyTimeoutMilliseconds = 5000,
}) {
  return DatabaseConnection.delayed(
    Future.sync(() async {
      final databasePath = join(path ?? '', name);

      final queryExecutor = NativeDatabase.createInBackground(
        File(databasePath),
        logStatements: logStatements,
        setup: (database) {
          // Enables Write-Ahead Logging (WAL) mode.
          // In default mode (DELETE journal), readers block writers and writers block readers.
          if (isWalEnabled) {
            database.execute('PRAGMA journal_mode=WAL;');
          }

          // Sets a timeout (in milliseconds) for waiting when the database is locked.
          if (busyTimeoutMilliseconds != null) {
            database.execute('PRAGMA busy_timeout=$busyTimeoutMilliseconds;');
          }
        },
      );

      return DatabaseConnection(queryExecutor);
    }),
  );
}
