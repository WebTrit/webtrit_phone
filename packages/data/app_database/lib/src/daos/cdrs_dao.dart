import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'cdrs_dao.g.dart';

@DriftAccessor(tables: [CdrTable, CdrSyncCursorTable])
class CdrsDao extends DatabaseAccessor<AppDatabase> with _$CdrsDaoMixin {
  CdrsDao(super.db);

  Future<void> upsertCdrs(List<CdrRecordData> cdrs) {
    return batch((batch) => batch.insertAllOnConflictUpdate(cdrTable, cdrs));
  }

  Future<List<CdrRecordData>> getHistory({
    String? number,
    String? destination,
    DateTime? from,
    DateTime? to,
    int? limit,
    CdrStatusData? status,
    CallDirectionData? direction,
  }) {
    final query = select(cdrTable);
    query.orderBy([(t) => OrderingTerm.desc(t.connectTimeUsec)]);

    if (number != null) query.where((tbl) => tbl.callerNumber.equals(number) | tbl.calleeNumber.equals(number));
    if (destination != null) query.where((tbl) => tbl.caller.equals(destination) | tbl.callee.equals(destination));
    if (status != null) query.where((tbl) => tbl.status.equals(status.name));
    if (direction != null) query.where((tbl) => tbl.direction.equals(direction.name));
    if (from != null) query.where((tbl) => tbl.connectTimeUsec.isSmallerThanValue(from.microsecondsSinceEpoch));
    if (to != null) query.where((tbl) => tbl.connectTimeUsec.isBiggerThanValue(to.microsecondsSinceEpoch));
    if (limit != null) query.limit(limit);

    return query.get();
  }

  Future<DateTime?> getLastUpdate() async {
    final query = select(cdrTable)
      ..orderBy([(t) => OrderingTerm.desc(t.connectTimeUsec)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.connectTimeUsec != null ? DateTime.fromMicrosecondsSinceEpoch(result!.connectTimeUsec) : null;
  }

  Future<DateTime?> getFirstRecordTime() async {
    final query = select(cdrTable)
      ..orderBy([(t) => OrderingTerm.asc(t.connectTimeUsec)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.connectTimeUsec != null ? DateTime.fromMicrosecondsSinceEpoch(result!.connectTimeUsec) : null;
  }

  /// Time of the last successfully completed remote sync cycle, or null if the
  /// initial sync has never finished (distinguishes it from a synced-but-empty
  /// history, which keeps a cursor while having no records).
  Future<DateTime?> getSyncCursor() async {
    final result = await select(cdrSyncCursorTable).getSingleOrNull();
    return result != null ? DateTime.fromMicrosecondsSinceEpoch(result.timestampUsec) : null;
  }

  Future<void> setSyncCursor(DateTime time) {
    return into(
      cdrSyncCursorTable,
    ).insertOnConflictUpdate(CdrSyncCursorData(id: 0, timestampUsec: time.microsecondsSinceEpoch));
  }

  Future<void> wipeData() async {
    await transaction(() async {
      await delete(cdrTable).go();
      await delete(cdrSyncCursorTable).go();
    });
  }

  Future<int> recordsCount() async {
    final query = selectOnly(cdrTable)..addColumns([countAll()]);
    return query.map((row) => row.read(countAll()) ?? 0).getSingle();
  }
}
