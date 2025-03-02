import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

import 'media_settings_state.dart';

class MediaSettingsCubit extends Cubit<MediaSettingsState> {
  MediaSettingsCubit(this._prefs) : super(MediaSettingsState.fromPrefs(_prefs));

  final AppPreferences _prefs;

  void setEncodingSettings(EncodingSettings settings) {
    emit(state.copyWithEncodingSettings(settings));
    _prefs.setEncodingSettings(settings);
  }

  void setEncodingPreset(EncodingPreset? preset) {
    emit(state.copyWithEncodingPresets(preset));
    _prefs.setEncodingPreset(preset);
  }

  void setAudioProcessingSettings(AudioProcessingSettings settings) {
    emit(state.copyWithAudioProcessingSettings(settings));
    _prefs.setAudioProcessingSettings(settings);
  }

  void setVideoCapturingSettings(VideoCapturingSettings settings) {
    emit(state.copyWithVideoCapturingSettings(settings));
    _prefs.setVideoCapturingSettings(settings);
  }

  void reset() {
    emit(MediaSettingsState(
      encodingPreset: null,
      encodingSettings: EncodingSettings.blank(),
      audioProcessingSettings: AudioProcessingSettings.blank(),
      videoCapturingSettings: VideoCapturingSettings.blank(),
    ));

    _prefs.setEncodingPreset(null);
    _prefs.setEncodingSettings(EncodingSettings.blank());
    _prefs.setAudioProcessingSettings(AudioProcessingSettings.blank());
    _prefs.setVideoCapturingSettings(VideoCapturingSettings.blank());
  }
}
