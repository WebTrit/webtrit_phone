import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

DatabaseConnection createAppDatabaseConnection(String name, {bool logStatements = false}) {
  return DatabaseConnection.delayed(Future.sync(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databasePath = path.join(documentsDirectory.path, name);

    final queryExecutor = NativeDatabase.createInBackground(
      File(databasePath),
      logStatements: logStatements,
    );

    return DatabaseConnection(queryExecutor);
  }));
}
