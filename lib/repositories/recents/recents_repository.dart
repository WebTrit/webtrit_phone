import 'dart:async';

import 'package:drift/drift.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

class RecentsRepository {
  RecentsRepository({required this.appDatabase});

  final AppDatabase appDatabase;

  Stream<List<Recent>> recents() {
    return appDatabase.callLogsDao.watchLastCallLogsExt().map((callLogsExt) => callLogsExt.map((callLogExt) {
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
        }).toList(growable: false));
  }

  Future<void> add(Recent recent) async {
    appDatabase.callLogsDao.insertCallLog(CallLogDataCompanion(
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
      appDatabase.callLogsDao.deleteCallLog(CallLogDataCompanion(
        id: Value(id),
      ));
    }
  }
}
