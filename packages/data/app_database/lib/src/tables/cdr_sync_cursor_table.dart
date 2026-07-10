import 'package:drift/drift.dart';

/// Single-row table holding the CDRs remote-sync watermark: the time the last
/// successful sync cycle completed (even when it fetched zero records).
/// Its presence distinguishes "never synced yet" from "synced, genuinely empty".
@DataClassName('CdrSyncCursorData')
class CdrSyncCursorTable extends Table {
  @override
  String get tableName => 'cdr_sync_cursors';

  @override
  Set<Column> get primaryKey => {id};

  /// Always 0: the table stores a single global cursor row.
  IntColumn get id => integer()();

  IntColumn get timestampUsec => integer()();
}
