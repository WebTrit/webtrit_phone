import 'dart:async';

import 'package:drift/drift.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class RecentsRepository {
  RecentsRepository({required this.appDatabase});

  final AppDatabase appDatabase;

  Stream<List<Recent>> recents() {
    return appDatabase.callLogsDao.watchLastCallLogs().map((callLogs) => callLogs
        .map((callLog) => Recent(
              direction: callLog.direction,
              number: callLog.number,
              createdTime: callLog.createdAt,
              acceptedTime: callLog.acceptedAt,
              hungUpTime: callLog.hungUpAt,
              id: callLog.id,
            ))
        .toList(growable: false));
  }

  Future<void> add(Recent recent) async {
    appDatabase.callLogsDao.insertCallLog(CallLogDataCompanion(
      direction: Value(recent.direction),
      number: Value(recent.number),
      createdAt: Value(recent.createdTime),
      acceptedAt: Value(recent.acceptedTime),
      hungUpAt: Value(recent.hungUpTime),
    ));
  }

  Future<void> delete(Recent recent) async {
    final id = recent.id;
    if (id != null) {
      appDatabase.callLogsDao.deleteCallLog(CallLogDataCompanion(
        id: Value(id),
      ));
    }
  }
}
