import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class PresenceInfoRepository {
  /// Sets the presence information for a specific number.
  void setNumberPresence(String number, List<PresenceInfo> presenceInfo);

  /// Gets the presence information for a specific number.
  Future<List<PresenceInfo>> getNumberPresence(String number);

  /// Watches the presence information for a specific number.
  Stream<List<PresenceInfo>> watchNumberPresence(String number);
}

class PresenceInfoRepositoryDriftImpl with PresenceInfoDriftMapper implements PresenceInfoRepository {
  PresenceInfoRepositoryDriftImpl(this._appDatabase);
  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.presenceInfoDao;

  @override
  void setNumberPresence(String number, List<PresenceInfo> presence) async {
    final existing = await _dao.getPresenceInfoByNumber(number);
    final deleteIds = existing.map((e) => e.idKey).toSet().difference(presence.map((e) => e.id).toSet());

    final data = presence.map((e) => presenceInfoToDrift(number, e)).toList();
    await _dao.deletePresenceInfoByIds(deleteIds.toList());
    await _dao.upsertPresenceInfo(data);
  }

  @override
  Future<List<PresenceInfo>> getNumberPresence(String number) async {
    final data = await _dao.getPresenceInfoByNumber(number);
    final presence = data.map(presenceInfoFromDrift).toList();
    return presence;
  }

  @override
  Stream<List<PresenceInfo>> watchNumberPresence(String number) {
    return _dao
        .watchPresenceInfoByNumber(number)
        .map((presenceData) => presenceData.map((data) => presenceInfoFromDrift(data)).toList());
  }
}
