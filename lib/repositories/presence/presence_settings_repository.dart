import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class PresenceSettingsRepository {
  /// The current device presence settings.
  PresenceSettings get presenceSettings;

  /// Updates the current device presence settings.
  void updatePresenceSettings(PresenceSettings settings);

  /// The last time the presence settings were synchronized.
  /// Can be null if never synchronized.
  DateTime? get lastSettingsSync;

  /// Updates the last time the presence settings were synchronized.
  /// Typically set after a successful sync operation.
  void updateLastSettingsSync(DateTime time);

  /// Resets the last settings sync time to null.
  void resetLastSettingsSync();

  /// Clears all presence settings.
  Future<void> clear();
}

class PresenceSettingsRepositoryPrefsImpl with PresenceSettingJsonMapperMixin implements PresenceSettingsRepository {
  PresenceSettingsRepositoryPrefsImpl(this.appPreferences);
  AppPreferencesPure appPreferences;

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
  Future<void> clear() async {
    _lastSettingsSync = null;
    await appPreferences.remove(presenceSettingsKey);
  }
}
