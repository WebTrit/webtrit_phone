import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' show join;

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,
  bool? isWalEnabled = true,
  int? busyTimeoutMs = 5000,
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
          if (isWalEnabled == true) {
            database.execute('PRAGMA journal_mode=WAL;');
          }

          // Sets a timeout (in milliseconds) for waiting when the database is locked.
          if (busyTimeoutMs != null && busyTimeoutMs >= 0) {
            database.execute('PRAGMA busy_timeout=$busyTimeoutMs;');
          }
        },
      );

      return DatabaseConnection(queryExecutor);
    }),
  );
}
