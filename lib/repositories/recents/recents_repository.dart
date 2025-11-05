import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class RecentsRepository with PresenceInfoDriftMapper, CallLogsDriftMapper, ContactsDriftMapper, RecentsDriftMapper {
  RecentsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Recent>> watchRecents() {
    return _appDatabase.recentsDao.watchLastRecents().map(
      (callLogsExt) => callLogsExt.map(recentFromDrift).toList(growable: false),
    );
  }

  Future<void> deleteByCallId(int id) async {
    await _appDatabase.recentsDao.deleteRecent(id);
  }

  Future<Recent> getRecentByCallId(int id) {
    return _appDatabase.recentsDao.getRecentByCallId(id).then(recentFromDrift);
  }
}
