import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

DatabaseConnection createAppDatabaseConnection(String? path, String name,
    {bool logStatements = false}) {
  assert(path == null || path.isEmpty, 'path is not supported on web');

  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: name,
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    return result.resolvedExecutor;
  }));
}
