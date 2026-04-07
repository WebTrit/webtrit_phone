import 'package:drift/drift.dart';

QueryExecutor createAppDatabaseNative(
  String directoryPath,
  String name, {
  bool logStatements = false,
  bool? isWalEnabled = true,
  int? busyTimeoutMs = 5000,
}) {
  throw UnsupportedError('No suitable database implementation was found on this platform.');
}

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,
  bool? isWalEnabled = true,
  int? busyTimeoutMs = 5000,
}) {
  throw UnsupportedError('No suitable database connection implementation was found on this platform.');
}
