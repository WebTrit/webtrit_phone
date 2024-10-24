import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'call_logs_dao.g.dart';

class CallLogDataWithContactPhoneDataAndContactData {
  CallLogDataWithContactPhoneDataAndContactData(this.callLog, this.contactPhoneData, this.contactData);

  final CallLogData callLog;
  final ContactPhoneData? contactPhoneData;
  final ContactData? contactData;
}

@DriftAccessor(tables: [
  CallLogsTable,
  ContactPhonesTable,
  ContactsTable,
])
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

  Stream<List<CallLogDataWithContactPhoneDataAndContactData>> watchLastCallLogsExt(
      [Duration period = const Duration(days: 14)]) {
    final q = _selectLastCallLogs(period).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    _groupByCallLogsTableId(q);
    return q.watch().map((rows) => rows.map(_toCallLogDataWithContactPhoneDataAndContactData).toList());
  }

  Future<CallLogDataWithContactPhoneDataAndContactData> getCallLogExt(Insertable<CallLogData> callLogData) {
    final q = (select(callLogsTable)..whereSamePrimaryKey(callLogData)).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    _groupByCallLogsTableId(q);
    return q.getSingle().then(_toCallLogDataWithContactPhoneDataAndContactData);
  }

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) {
    return into(callLogsTable).insert(callLogData);
  }

  Future<int> deleteCallLog(Insertable<CallLogData> callLogData) {
    return delete(callLogsTable).delete(callLogData);
  }

  // necessary to overcome the possibility that one particular number be assigned to more than one contact
  void _groupByCallLogsTableId(JoinedSelectStatement statement) {
    statement.groupBy([callLogsTable.id]);
  }

  CallLogDataWithContactPhoneDataAndContactData _toCallLogDataWithContactPhoneDataAndContactData(TypedResult row) {
    return CallLogDataWithContactPhoneDataAndContactData(
      row.readTable(callLogsTable),
      row.readTableOrNull(contactPhonesTable),
      row.readTableOrNull(contactsTable),
    );
  }
}
