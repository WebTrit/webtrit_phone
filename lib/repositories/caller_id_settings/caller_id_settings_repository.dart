import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/mappers/json/caller_id_settings_mapper.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';

abstract interface class CallerIdSettingsRepository {
  CallerIdSettings getCallerIdSettings();

  Future<void> setCallerIdSettings(CallerIdSettings settings);

  Future<void> clear();
}

class CallerIdSettingsRepositoryPrefsImpl with CallerIdSettingsJsonMapper implements CallerIdSettingsRepository {
  CallerIdSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'caller-id-settings';

  @override
  CallerIdSettings getCallerIdSettings() {
    final callerIdSettingsString = _appPreferences.getString(_prefsKey);
    if (callerIdSettingsString == null) return const CallerIdSettings();
    return callerIdSettingsFromJson(callerIdSettingsString);
  }

  @override
  Future<void> setCallerIdSettings(CallerIdSettings settings) {
    return _appPreferences.setString(_prefsKey, callerIdSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
