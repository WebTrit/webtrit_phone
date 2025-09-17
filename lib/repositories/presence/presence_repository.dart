import 'dart:async';

import 'package:app_database/app_database.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
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

class PresenceRepositoryPrefsAndMemoryImpl with PresenceSettingJsonMapperMixin implements PresenceRepository {
  PresenceRepositoryPrefsAndMemoryImpl(this.appPreferences);
  AppPreferences appPreferences;

  static const presenceSettingsKey = 'presence_settings';
  final Map<String, List<PresenceInfo>> _numbersPresence = {};
  final _controller = StreamController<(String, List<PresenceInfo>)>.broadcast();
  DateTime? _lastSettingsSync;

  @override
  PresenceSettings get presenceSettings {
    final prefsResult = appPreferences.getString(presenceSettingsKey);
    if (prefsResult != null) {
      return presenceSettingsFromJson(prefsResult);
    } else {
      return PresenceSettings.blank();
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
  void setNumberPresence(String number, List<PresenceInfo> presence) {
    _numbersPresence[number] = presence;
    _controller.add((number, presence));
  }

  @override
  Future<List<PresenceInfo>> getNumberPresence(String number) => Future.value(_numbersPresence[number] ?? []);

  @override
  Stream<List<PresenceInfo>> watchNumberPresence(String number) async* {
    yield await getNumberPresence(number);
    yield* _controller.stream.where((e) => e.$1 == number).map((e) => e.$2);
  }

  @override
  Future<void> clearSettings() async {
    _lastSettingsSync = null;
    appPreferences.removeKey(presenceSettingsKey);
  }
}

class PresenceRepositoryPrefsAndDriftImpl
    with PresenceSettingJsonMapperMixin, PresenceInfoDriftMapper
    implements PresenceRepository {
  PresenceRepositoryPrefsAndDriftImpl(this.appPreferences, this._appDatabase);
  AppPreferences appPreferences;
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
      return PresenceSettings.blank();
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
    await appPreferences.removeKey(presenceSettingsKey);
  }
}
