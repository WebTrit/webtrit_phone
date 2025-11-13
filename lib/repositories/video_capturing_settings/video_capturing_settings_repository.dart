import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/mappers/json/video_capturing_settings_mapper.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

abstract interface class VideoCapturingSettingsRepository {
  VideoCapturingSettings getVideoCapturingSettings();

  Future<void> setVideoCapturingSettings(VideoCapturingSettings settings);

  Future<void> clear();
}

class VideoCapturingSettingsRepositoryPrefsImpl
    with VideoCapturingSettingsJsonMapper
    implements VideoCapturingSettingsRepository {
  VideoCapturingSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'video-capturing-settings';

  @override
  VideoCapturingSettings getVideoCapturingSettings() {
    final videoCapturingSettingsString = _appPreferences.getString(_prefsKey);
    if (videoCapturingSettingsString != null) {
      return videoCapturingSettingsFromJson(videoCapturingSettingsString);
    } else {
      return VideoCapturingSettings.blank();
    }
  }

  @override
  Future<void> setVideoCapturingSettings(VideoCapturingSettings settings) {
    return _appPreferences.setString(_prefsKey, videoCapturingSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
