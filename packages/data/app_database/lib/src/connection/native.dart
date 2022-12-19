import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

DatabaseConnection createAppDatabaseConnection(String path, {bool logStatements = false}) {
  return DatabaseConnection(
    NativeDatabase.createInBackground(
      File(path),
      logStatements: logStatements,
    ),
  );
}
