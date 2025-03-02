import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

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

class MediaSettingsState with EquatableMixin {
  MediaSettingsState({
    required this.encodingSettings,
    required this.encodingPreset,
    required this.audioProcessingSettings,
    required this.videoCapturingSettings,
  });

  final EncodingSettings encodingSettings;
  final EncodingPreset? encodingPreset;
  final AudioProcessingSettings audioProcessingSettings;
  final VideoCapturingSettings videoCapturingSettings;

  factory MediaSettingsState.fromPrefs(AppPreferences prefs) {
    return MediaSettingsState(
      encodingSettings: prefs.getEncodingSettings(),
      encodingPreset: prefs.getEncodingPreset(),
      audioProcessingSettings: prefs.getAudioProcessingSettings(),
      videoCapturingSettings: prefs.getVideoCapturingSettings(),
    );
  }

  MediaSettingsState copyWithEncodingPresets(EncodingPreset? preset) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: preset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
    );
  }

  MediaSettingsState copyWithEncodingSettings(EncodingSettings settings) {
    return MediaSettingsState(
      encodingSettings: settings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
    );
  }

  MediaSettingsState copyWithAudioProcessingSettings(AudioProcessingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: settings,
      videoCapturingSettings: videoCapturingSettings,
    );
  }

  MediaSettingsState copyWithVideoCapturingSettings(VideoCapturingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: settings,
    );
  }

  @override
  List<Object?> get props => [
        encodingSettings,
        encodingPreset,
        audioProcessingSettings,
        videoCapturingSettings,
      ];

  @override
  String toString() {
    return 'MediaSettingsState{encodingPreset: $encodingPreset, encodingSettings: $encodingSettings} , audioProcessingSettings: $audioProcessingSettings, videoCapturingSettings: $videoCapturingSettings';
  }
}
