import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'call_logs_dao.g.dart';

@DriftAccessor(tables: [CallLogsTable])
class CallLogsDao extends DatabaseAccessor<AppDatabase> with _$CallLogsDaoMixin {
  CallLogsDao(super.db);

  SimpleSelectStatement<$CallLogsTableTable, CallLogData> _selectLastCallLogs(Duration period) {
    return select(callLogsTable)
      ..where((t) => t.createdAt.isBiggerOrEqualValue(clock.agoBy(period)))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
  }

  SimpleSelectStatement<$CallLogsTableTable, CallLogData> _selectLastCallLogsByNumber(String number, Duration period) {
    return _selectLastCallLogs(period)..where((t) => t.number.equals(number));
  }

  Future<List<CallLogData>> getLastCallLogsByNumber(String number, [Duration period = const Duration(days: 14)]) {
    return _selectLastCallLogsByNumber(number, period).get();
  }

  Stream<List<CallLogData>> watchLastCallLogsByNumber(String number, [Duration period = const Duration(days: 14)]) {
    return _selectLastCallLogsByNumber(number, period).watch();
  }

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) {
    return into(callLogsTable).insert(callLogData);
  }

  Future deleteCallLog(int id) {
    return (delete(callLogsTable)..where((t) => t.id.equals(id))).go();
  }
}
