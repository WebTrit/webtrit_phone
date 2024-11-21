import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class CallLogsRepository {
  CallLogsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<CallLogEntry>> watchHistoryByNumber(String number) {
    return _appDatabase.callLogsDao.watchLastCallLogsByNumber(number).map((data) => data.map(_toCallLogEntry).toList());
  }

  Future<void> add(NewCall call) {
    return _appDatabase.callLogsDao.insertCallLog(CallLogDataCompanion(
      direction: Value(CallLogDirectionEnum.values.byName(call.direction.name)),
      number: Value(call.number),
      video: Value(call.video),
      createdAt: Value(call.createdTime),
      acceptedAt: Value(call.acceptedTime),
      hungUpAt: Value(call.hungUpTime),
    ));
  }

  Future<void> deleteById(int id) async {
    await _appDatabase.callLogsDao.deleteCallLog(id);
  }

  CallLogEntry _toCallLogEntry(CallLogData callLogData) {
    return CallLogEntry(
      direction: CallDirection.values.byName(callLogData.direction.name),
      number: callLogData.number,
      video: callLogData.video,
      createdTime: callLogData.createdAt,
      acceptedTime: callLogData.acceptedAt,
      hungUpTime: callLogData.hungUpAt,
      id: callLogData.id,
    );
  }
}

typedef NewCall = ({
  CallDirection direction,
  String number,
  bool video,
  DateTime createdTime,
  DateTime? acceptedTime,
  DateTime? hungUpTime,
});
