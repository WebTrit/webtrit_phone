import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV23 extends Migration {
  const MigrationV23();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    // Drop the redundant UNIQUE constraint on cdrs.call_id. The column is the
    // single-column primary key, which already enforces uniqueness, so the
    // extra UNIQUE is a no-op. SQLite cannot drop a column constraint in place,
    // so recreate the table without it and copy the rows over.
    await db.customStatement('PRAGMA foreign_keys = OFF');

    await db.customStatement('''
      CREATE TABLE cdrs_new (
        call_id TEXT NOT NULL,
        direction TEXT NOT NULL,
        status TEXT NOT NULL,
        callee TEXT NOT NULL,
        callee_number TEXT NULL,
        caller TEXT NOT NULL,
        caller_number TEXT NULL,
        connect_time_usec INTEGER NOT NULL,
        disconnect_time_usec INTEGER NOT NULL,
        disconnect_reason TEXT NOT NULL,
        duration_seconds INTEGER NOT NULL,
        recording_id TEXT NULL,
        PRIMARY KEY(call_id)
      )
    ''');

    await db.customStatement('''
      INSERT INTO cdrs_new (
        call_id, direction, status, callee, callee_number, caller, caller_number,
        connect_time_usec, disconnect_time_usec, disconnect_reason, duration_seconds, recording_id
      )
      SELECT
        call_id, direction, status, callee, callee_number, caller, caller_number,
        connect_time_usec, disconnect_time_usec, disconnect_reason, duration_seconds, recording_id
      FROM cdrs
    ''');

    await db.customStatement('DROP TABLE cdrs');

    await db.customStatement('ALTER TABLE cdrs_new RENAME TO cdrs');

    await db.customStatement('PRAGMA foreign_keys = ON');
  }
}
