import 'dart:async';

import 'package:webtrit_phone/common/disposable.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class PresenceRepository {
  /// The current device presence settings.
  PresenceSettings get presenceSettings;

  /// Updates the current device presence settings.
  void updatePresenceSettings(PresenceSettings settings);

  /// Sets the presence information for a specific number.
  void setNumberPresence(String number, List<PresenceInfo> presenceInfo);

  /// The last time the presence settings were synchronized.
  /// Can be null if never synchronized.
  DateTime? get lastSettingsSync;

  /// Updates the last time the presence settings were synchronized.
  /// Typically set after a successful sync operation.
  void updateLastSettingsSync(DateTime time);

  /// Resets the last settings sync time to null.
  void resetLastSettingsSync();

  /// Gets the presence information for a specific number.
  Future<List<PresenceInfo>> getNumberPresence(String number);

  /// Watches the presence information for a specific number.
  Stream<List<PresenceInfo>> watchNumberPresence(String number);

  /// Clears all presence settings.
  Future<void> clearSettings();
}

// TODO: split to PresenceInfoRepository and PresenceSettingsRepository
class PresenceRepositoryPrefsAndDriftImpl
    with PresenceSettingJsonMapperMixin, PresenceInfoDriftMapper
    implements PresenceRepository, Disposable {
  PresenceRepositoryPrefsAndDriftImpl(this.appPreferences, this._appDatabase);
  AppPreferencesPure appPreferences;
  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.presenceInfoDao;

  static const presenceSettingsKey = 'presence_settings';
  DateTime? _lastSettingsSync;

  @override
  PresenceSettings get presenceSettings {
    final prefsResult = appPreferences.getString(presenceSettingsKey);
    if (prefsResult != null) {
      return presenceSettingsFromJson(prefsResult);
    } else {
      final blank = PresenceSettings.blank();
      updatePresenceSettings(blank);
      return blank;
    }
  }

  @override
  void updatePresenceSettings(PresenceSettings settings) {
    appPreferences.setString(presenceSettingsKey, presenceSettingsToJson(settings));
  }

  @override
  DateTime? get lastSettingsSync => _lastSettingsSync;

  @override
  void updateLastSettingsSync(DateTime time) => _lastSettingsSync = time;

  @override
  void resetLastSettingsSync() => _lastSettingsSync = null;

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

  @override
  Future<void> clearSettings() async {
    _lastSettingsSync = null;
    await appPreferences.remove(presenceSettingsKey);
  }

  @override
  Future<void> dispose() async {
    clearSettings();
  }
}
