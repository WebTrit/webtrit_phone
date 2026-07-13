import 'package:drift/drift.dart';

import '../app_database.dart';
import '../migration.dart';

class MigrationV25 extends Migration {
  const MigrationV25();

  @override
  Future<void> execute(AppDatabase db, Migrator m) async {
    await m.createTable(db.cdrSyncCursorTable);

    // Installs that already hold CDRs have evidently completed a sync before,
    // so backfill the cursor from the newest record to keep them in the
    // "synced" state. Never-synced (or genuinely empty) installs stay without
    // a cursor until their first successful sync cycle. HAVING (not WHERE)
    // guards the aggregate: without it an empty cdrs table would still yield
    // a single (0, NULL) row and violate the NOT NULL constraint.
    await db.customStatement('''
      INSERT INTO cdr_sync_cursors (id, timestamp_usec)
      SELECT 0, MAX(connect_time_usec) FROM cdrs
      HAVING COUNT(*) > 0
    ''');
  }
}
