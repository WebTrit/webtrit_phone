import 'package:drift/drift.dart';
import 'package:drift/web.dart';

DatabaseConnection createAppDatabaseConnection(String name, {bool logStatements = false}) {
  return DatabaseConnection(
    WebDatabase(
      name,
      logStatements: logStatements,
    ),
  );
}
