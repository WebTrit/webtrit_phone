import 'dart:async';

import 'package:drift/drift.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class RecentsRepository {
  RecentsRepository({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Recent>> watchRecents() {
    return _appDatabase.callLogsDao
        .watchLastCallLogsExt()
        .map((callLogsExt) => callLogsExt.map(_toRecentExt).toList(growable: false));
  }

  Future<Recent> getRecent(RecentId recentId) {
    return _appDatabase.callLogsDao
        .getCallLogExt(CallLogDataCompanion(
          id: Value(recentId),
        ))
        .then(_toRecentExt);
  }

  Stream<List<Recent>> watchHistory(Recent recent) {
    return _appDatabase.callLogsDao
        .watchLastCallLogsByNumber(recent.number)
        .map((callLogs) => callLogs.map(_toRecent).toList(growable: false));
  }

  Future<void> add(Recent recent) async {
    await _appDatabase.callLogsDao.insertCallLog(CallLogDataCompanion(
      direction: Value(recent.direction),
      number: Value(recent.number),
      video: Value(recent.video),
      createdAt: Value(recent.createdTime),
      acceptedAt: Value(recent.acceptedTime),
      hungUpAt: Value(recent.hungUpTime),
    ));
  }

  Future<void> delete(Recent recent) async {
    final id = recent.id;
    if (id != null) {
      await _appDatabase.callLogsDao.deleteCallLog(CallLogDataCompanion(
        id: Value(id),
      ));
    }
  }

  Recent _toRecentExt(CallLogDataWithContactPhoneDataAndContactData callLogExt) {
    final callLog = callLogExt.callLog;
    final contactData = callLogExt.contactData;
    return Recent(
      direction: callLog.direction,
      number: callLog.number,
      video: callLog.video,
      createdTime: callLog.createdAt,
      acceptedTime: callLog.acceptedAt,
      hungUpTime: callLog.hungUpAt,
      id: callLog.id,
      displayName: contactData?.displayName,
      firstName: contactData?.firstName,
      lastName: contactData?.lastName,
    );
  }

  Recent _toRecent(CallLogData callLogData) {
    return Recent(
      direction: callLogData.direction,
      number: callLogData.number,
      video: callLogData.video,
      createdTime: callLogData.createdAt,
      acceptedTime: callLogData.acceptedAt,
      hungUpTime: callLogData.hungUpAt,
      id: callLogData.id,
    );
  }
}
