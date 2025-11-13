import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/mappers/json/ice_settings_mapper.dart';
import 'package:webtrit_phone/models/ice_settings.dart';

abstract interface class IceSettingsRepository {
  IceSettings getIceSettings();

  Future<void> setIceSettings(IceSettings settings);

  Future<void> clear();
}

class IceSettingsRepositoryPrefsImpl with IceSettingsJsonMapper implements IceSettingsRepository {
  IceSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'ice-settings';

  @override
  IceSettings getIceSettings() {
    final iceSettingsString = _appPreferences.getString(_prefsKey);
    if (iceSettingsString != null) {
      return iceSettingsFromJson(iceSettingsString);
    } else {
      return IceSettings.blank();
    }
  }

  @override
  Future<void> setIceSettings(IceSettings settings) {
    return _appPreferences.setString(_prefsKey, iceSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
