import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'dialog_info_dao.g.dart';

@DriftAccessor(tables: [DialogInfoTable])
class DialogInfoDao extends DatabaseAccessor<AppDatabase> with _$DialogInfoDaoMixin {
  DialogInfoDao(super.db);

  Future<List<DialogInfoData>> getDialogInfoByNumber(String number) {
    final query = select(dialogInfoTable)..where((tbl) => tbl.entityNumber.equals(number));
    return query.get();
  }

  Stream<List<DialogInfoData>> watchDialogInfoByNumber(String number) {
    final query = select(dialogInfoTable)..where((tbl) => tbl.entityNumber.equals(number));
    return query.watch();
  }

  Future<void> upsertDialogInfo(List<DialogInfoData> info) {
    return batch((batch) => batch.insertAllOnConflictUpdate(dialogInfoTable, info));
  }

  Future<void> replaceData(List<DialogInfoData> info) {
    return batch((batch) {
      batch.deleteAll(dialogInfoTable);
      batch.insertAll(dialogInfoTable, info);
    });
  }

  Future<int> deleteDialogInfoByIdsAndNumber(List<String> ids, String number) {
    final query = delete(dialogInfoTable)
      ..where((tbl) => tbl.entityNumber.equals(number) & tbl.idKey.isIn(ids));
    return query.go();
  }
}