import 'package:drift/drift.dart';

DatabaseConnection createAppDatabaseConnection(String _, {bool logStatements = false}) {
  throw UnsupportedError('No suitable database connection implementation was found on this platform.');
}
