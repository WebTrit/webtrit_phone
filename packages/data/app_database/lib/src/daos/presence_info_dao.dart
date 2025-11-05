import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'presence_info_dao.g.dart';

@DriftAccessor(tables: [PresenceInfoTable])
class PresenceInfoDao extends DatabaseAccessor<AppDatabase> with _$PresenceInfoDaoMixin {
  PresenceInfoDao(super.db);

  Future<List<PresenceInfoData>> getPresenceInfoByNumber(String number) {
    final query = select(presenceInfoTable)..where((tbl) => tbl.number.equals(number));
    return query.get();
  }

  Stream<List<PresenceInfoData>> watchPresenceInfoByNumber(String number) {
    final query = select(presenceInfoTable)..where((tbl) => tbl.number.equals(number));
    return query.watch();
  }

  Future<void> upsertPresenceInfo(List<PresenceInfoData> info) {
    return batch((batch) => batch.insertAllOnConflictUpdate(presenceInfoTable, info));
  }

  Future<int> deletePresenceInfoByIds(List<String> ids) {
    final query = delete(presenceInfoTable)..where((tbl) => tbl.idKey.isIn(ids));
    return query.go();
  }
}
