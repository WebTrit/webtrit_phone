import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/mappers/json/encoding_settings_mapper.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

abstract interface class EncodingSettingsRepository {
  EncodingSettings getEncodingSettings();

  Future<void> setEncodingSettings(EncodingSettings settings);

  Future<void> clear();
}

class EncodingSettingsRepositoryPrefsImpl with EncodingSettingsJsonMapper implements EncodingSettingsRepository {
  EncodingSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'encoding-settings';

  @override
  EncodingSettings getEncodingSettings() {
    final encodingSettingsString = _appPreferences.getString(_prefsKey);
    if (encodingSettingsString != null) {
      return encodingSettingsFromJson(encodingSettingsString);
    } else {
      return EncodingSettings.blank();
    }
  }

  @override
  Future<void> setEncodingSettings(EncodingSettings settings) {
    return _appPreferences.setString(_prefsKey, encodingSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
