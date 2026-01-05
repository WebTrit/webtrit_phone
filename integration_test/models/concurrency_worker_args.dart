/// A generic Data Transfer Object (DTO) for configuring background isolate workers.
class ConcurrencyWorkerArgs {
  const ConcurrencyWorkerArgs({required this.dbPath, required this.dbName, required this.itemsToWrite});

  /// The absolute path to the application documents directory.
  final String dbPath;

  /// The filename of the SQLite database.
  final String dbName;

  /// The number of operations to perform in the background task.
  final int itemsToWrite;
}
