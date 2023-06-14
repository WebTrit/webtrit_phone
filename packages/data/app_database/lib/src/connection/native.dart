import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' show join;

DatabaseConnection createAppDatabaseConnection(String? path, String name, {bool logStatements = false}) {
  return DatabaseConnection.delayed(Future.sync(() async {
    final databasePath = join(path ?? '', name);

    final queryExecutor = NativeDatabase.createInBackground(
      File(databasePath),
      logStatements: logStatements,
    );

    return DatabaseConnection(queryExecutor);
  }));
}
