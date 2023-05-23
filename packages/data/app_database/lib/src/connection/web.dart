import 'package:drift/drift.dart';
import 'package:drift/web.dart';

DatabaseConnection createAppDatabaseConnection(String? path, String name, {bool logStatements = false}) {
  assert(path == null || path.isEmpty, 'path is not supported on web');
  return DatabaseConnection(
    WebDatabase(
      name,
      logStatements: logStatements,
    ),
  );
}
