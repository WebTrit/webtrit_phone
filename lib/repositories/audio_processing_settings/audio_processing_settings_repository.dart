import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/mappers/json/audio_processing_settings_mapper.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';

abstract interface class AudioProcessingSettingsRepository {
  AudioProcessingSettings getAudioProcessingSettings();

  Future<void> setAudioProcessingSettings(AudioProcessingSettings settings);

  Future<void> clear();
}

class AudioProcessingSettingsRepositoryPrefsImpl
    with AudioProcessingSettingsJsonMapper
    implements AudioProcessingSettingsRepository {
  AudioProcessingSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'audio-processing-settings';

  @override
  AudioProcessingSettings getAudioProcessingSettings() {
    final audioProcessingSettingsString = _appPreferences.getString(_prefsKey);
    if (audioProcessingSettingsString != null) {
      return audioProcessingSettingsFromJson(audioProcessingSettingsString);
    } else {
      return AudioProcessingSettings.blank();
    }
  }

  @override
  Future<void> setAudioProcessingSettings(AudioProcessingSettings settings) {
    return _appPreferences.setString(_prefsKey, audioProcessingSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
