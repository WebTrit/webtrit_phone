import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class PresenceInfoRepository {
  /// Sets the initial presence information for multiple numbers.
  /// Note: it replaces all previous presence info for all numbers with the provided data
  Future<void> setInitialPresenceInfo(List<PresenceInfo> presenceInfos);

  /// Sets the presence information for a specific number.
  /// Note: it sets multiple presence info for the same number, replacing existing
  Future<void> setNumberPresence(String number, List<PresenceInfo> presenceInfo);

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
  Future<void> setInitialPresenceInfo(List<PresenceInfo> presenceInfos) async {
    await _dao.replaceData(presenceInfos.map((info) => presenceInfoToDrift(info)).toList());
  }

  @override
  Future<void> setNumberPresence(String number, List<PresenceInfo> presence) async {
    final existing = await _dao.getPresenceInfoByNumber(number);
    final toRemove = existing
        .map((e) => (e.idKey, e.source))
        .toSet()
        .difference(presence.map((e) => (e.id, e.source)).toSet())
        .map((e) => e.$1);

    final data = presence.map((e) => presenceInfoToDrift(e)).toList();
    await _dao.deletePresenceInfoByIds(toRemove.toList());
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
