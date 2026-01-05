import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class CallLogsRepository with CallLogsDriftMapper {
  CallLogsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<CallLogEntry>> watchHistoryByNumber(String number) {
    return _appDatabase.callLogsDao
        .watchLastCallLogsByNumber(number)
        .map((data) => data.map(callLogEntryFromDrift).toList());
  }

  Future<void> add(NewCall call) {
    return _appDatabase.callLogsDao.insertCallLog(
      CallLogDataCompanion(
        direction: Value(CallLogDirectionEnum.values.byName(call.direction.name)),
        number: Value(call.number),
        video: Value(call.video),
        username: Value(call.username),
        createdAt: Value(call.createdTime),
        acceptedAt: Value(call.acceptedTime),
        hungUpAt: Value(call.hungUpTime),
      ),
    );
  }

  Future<void> deleteById(int id) async {
    await _appDatabase.callLogsDao.deleteCallLog(id);
  }

  /// Retrieves all call log entries from the database without any filtering.
  ///
  /// This method is primarily used for testing verification (e.g., checking total row counts)
  /// or scenarios where a complete history dump is required.
  Future<List<CallLogEntry>> getAll() async {
    final data = await _appDatabase.callLogsDao.getAllCallLogs();
    return data.map(callLogEntryFromDrift).toList();
  }
}

typedef NewCall = ({
  CallDirection direction,
  String number,
  bool video,
  String? username,
  DateTime createdTime,
  DateTime? acceptedTime,
  DateTime? hungUpTime,
});
