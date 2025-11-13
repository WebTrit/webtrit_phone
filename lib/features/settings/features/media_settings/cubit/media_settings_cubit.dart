import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/audio_processing_settings/audio_processing_settings_repository.dart';
import 'package:webtrit_phone/repositories/encoding_preset/encoding_preset_repository.dart';

import 'media_settings_state.dart';

class MediaSettingsCubit extends Cubit<MediaSettingsState> {
  MediaSettingsCubit(
    this._prefs,
    this._defaultPeerConnectionSettings,
    this._audioProcessingSettingsRepository,
    this._encodingPresetRepository,
  ) : super(
        MediaSettingsState.fromPrefs(
          _prefs,
          _defaultPeerConnectionSettings,
          _audioProcessingSettingsRepository,
          _encodingPresetRepository,
        ),
      );

  final AppPreferences _prefs;
  final PeerConnectionSettings _defaultPeerConnectionSettings;
  final AudioProcessingSettingsRepository _audioProcessingSettingsRepository;
  final EncodingPresetRepository _encodingPresetRepository;

  void setEncodingSettings(EncodingSettings settings) {
    emit(state.copyWithEncodingSettings(settings));
    _prefs.setEncodingSettings(settings);
  }

  void setEncodingPreset(EncodingPreset? preset) {
    emit(state.copyWithEncodingPresets(preset));
    _encodingPresetRepository.setEncodingPreset(preset);
  }

  void setAudioProcessingSettings(AudioProcessingSettings settings) {
    emit(state.copyWithAudioProcessingSettings(settings));
    _audioProcessingSettingsRepository.setAudioProcessingSettings(settings);
  }

  void setVideoCapturingSettings(VideoCapturingSettings settings) {
    emit(state.copyWithVideoCapturingSettings(settings));
    _prefs.setVideoCapturingSettings(settings);
  }

  void setIceSettings(IceSettings settings) {
    emit(state.copyWithIceSettings(settings));
    _prefs.setIceSettings(settings);
  }

  void setPeerConnectionSettings(PeerConnectionSettings settings) {
    emit(state.copyWithPeerConnectionSettings(settings));
    _prefs.setPearConnectionSettings(settings);
  }

  void reset() {
    emit(
      MediaSettingsState(
        encodingPreset: null,
        encodingSettings: EncodingSettings.blank(),
        audioProcessingSettings: AudioProcessingSettings.blank(),
        videoCapturingSettings: VideoCapturingSettings.blank(),
        iceSettings: IceSettings.blank(),
        pearConnectionSettings: _defaultPeerConnectionSettings,
      ),
    );

    _encodingPresetRepository.setEncodingPreset(null);
    _prefs.setEncodingSettings(EncodingSettings.blank());
    _audioProcessingSettingsRepository.setAudioProcessingSettings(AudioProcessingSettings.blank());
    _prefs.setVideoCapturingSettings(VideoCapturingSettings.blank());
    _prefs.setIceSettings(IceSettings.blank());
    _prefs.setPearConnectionSettings(_defaultPeerConnectionSettings);
  }
}
