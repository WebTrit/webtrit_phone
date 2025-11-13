import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'media_settings_state.dart';

class MediaSettingsCubit extends Cubit<MediaSettingsState> {
  MediaSettingsCubit(
    this._prefs,
    this._defaultPeerConnectionSettings,
    this._audioProcessingSettingsRepository,
    this._encodingPresetRepository,
    this._iceSettingsRepository,
    this._peerConnectionSettingsRepository,
    this._videoCapturingSettingsRepository,
    this._encodingSettingsRepository,
  ) : super(
        MediaSettingsState.fromPrefs(
          _prefs,
          _defaultPeerConnectionSettings,
          _audioProcessingSettingsRepository,
          _encodingPresetRepository,
          _iceSettingsRepository,
          _peerConnectionSettingsRepository,
          _videoCapturingSettingsRepository,
          _encodingSettingsRepository,
        ),
      );

  final AppPreferences _prefs;
  final PeerConnectionSettings _defaultPeerConnectionSettings;
  final AudioProcessingSettingsRepository _audioProcessingSettingsRepository;
  final EncodingPresetRepository _encodingPresetRepository;
  final IceSettingsRepository _iceSettingsRepository;
  final PeerConnectionSettingsRepository _peerConnectionSettingsRepository;
  final VideoCapturingSettingsRepository _videoCapturingSettingsRepository;
  final EncodingSettingsRepository _encodingSettingsRepository;

  void setEncodingSettings(EncodingSettings settings) {
    emit(state.copyWithEncodingSettings(settings));
    _encodingSettingsRepository.setEncodingSettings(settings);
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
    _videoCapturingSettingsRepository.setVideoCapturingSettings(settings);
  }

  void setIceSettings(IceSettings settings) {
    emit(state.copyWithIceSettings(settings));
    _iceSettingsRepository.setIceSettings(settings);
  }

  void setPeerConnectionSettings(PeerConnectionSettings settings) {
    emit(state.copyWithPeerConnectionSettings(settings));
    _peerConnectionSettingsRepository.setPearConnectionSettings(settings);
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
    _encodingSettingsRepository.setEncodingSettings(EncodingSettings.blank());
    _audioProcessingSettingsRepository.setAudioProcessingSettings(AudioProcessingSettings.blank());
    _videoCapturingSettingsRepository.setVideoCapturingSettings(VideoCapturingSettings.blank());
    _iceSettingsRepository.setIceSettings(IceSettings.blank());
    _peerConnectionSettingsRepository.setPearConnectionSettings(_defaultPeerConnectionSettings);
  }
}
