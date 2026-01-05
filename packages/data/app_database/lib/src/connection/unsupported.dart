import 'package:drift/drift.dart';

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,
  bool isWalEnabled = true,
  int? busyTimeoutMilliseconds = 5000,
}) {
  throw UnsupportedError('No suitable database connection implementation was found on this platform.');
}
