import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AppDatabase.web');

/// Not supported on Web — [DriftIsolate] server spawning is a native-only feature.
QueryExecutor createAppDatabaseNative(
  String directoryPath,
  String name, {
  bool logStatements = false,
  bool? isWalEnabled = true,
  int? busyTimeoutMs = 5000,
}) {
  throw UnsupportedError('createAppDatabaseNative is not supported on Web.');
}

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,

  /// Ignored on Web; provided for API compatibility with native platforms.
  bool? isWalEnabled = true,

  /// Ignored on Web; provided for API compatibility with native platforms.
  int? busyTimeoutMs = 5000,
}) {
  assert(path == null || path.isEmpty, 'path is not supported on web');

  return DatabaseConnection.delayed(
    Future(() async {
      final result = await WasmDatabase.open(
        databaseName: name,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );

      // drift transparently downgrades the storage tier (OPFS -> IndexedDB ->
      // in-memory). The in-memory fallback (e.g. private/incognito mode or a
      // browser without OPFS/IndexedDB) is NOT persistent: all local data is
      // lost on reload. Surface it instead of failing silently.
      if (result.chosenImplementation == WasmStorageImplementation.inMemory) {
        _logger.warning(
          'Web database has no persistent storage (in-memory fallback) - local data '
          'will be lost on reload. missingFeatures: ${result.missingFeatures}',
        );
      } else {
        _logger.info(
          'Web database storage: ${result.chosenImplementation}'
          '${result.missingFeatures.isEmpty ? '' : ' (missing: ${result.missingFeatures})'}',
        );
      }

      return result.resolvedExecutor;
    }),
  );
}
