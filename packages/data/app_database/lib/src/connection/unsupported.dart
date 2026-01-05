import 'package:drift/drift.dart';

DatabaseConnection createAppDatabaseConnection(
  String? path,
  String name, {
  bool logStatements = false,
  bool? isWalEnabled = true,
  int? busyTimeoutMs = 5000,
}) {
  throw UnsupportedError('No suitable database connection implementation was found on this platform.');
}
