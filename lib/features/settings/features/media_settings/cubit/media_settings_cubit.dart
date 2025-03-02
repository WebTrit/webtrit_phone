import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

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

  void reset() {
    emit(MediaSettingsState(
      encodingPreset: null,
      encodingSettings: EncodingSettings.blank(),
      audioProcessingSettings: AudioProcessingSettings.blank(),
    ));

    _prefs.setEncodingPreset(null);
    _prefs.setEncodingSettings(EncodingSettings.blank());
  }
}

class MediaSettingsState with EquatableMixin {
  MediaSettingsState(
      {required this.encodingSettings, required this.encodingPreset, required this.audioProcessingSettings});

  final EncodingSettings encodingSettings;
  final EncodingPreset? encodingPreset;
  final AudioProcessingSettings audioProcessingSettings;

  factory MediaSettingsState.fromPrefs(AppPreferences prefs) {
    return MediaSettingsState(
      encodingSettings: prefs.getEncodingSettings(),
      encodingPreset: prefs.getEncodingPreset(),
      audioProcessingSettings: prefs.getAudioProcessingSettings(),
    );
  }

  MediaSettingsState copyWithEncodingPresets(EncodingPreset? preset) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: preset,
      audioProcessingSettings: audioProcessingSettings,
    );
  }

  MediaSettingsState copyWithEncodingSettings(EncodingSettings settings) {
    return MediaSettingsState(
      encodingSettings: settings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
    );
  }

  MediaSettingsState copyWithAudioProcessingSettings(AudioProcessingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: settings,
    );
  }

  @override
  List<Object?> get props => [
        encodingSettings,
        encodingPreset,
        audioProcessingSettings,
      ];

  @override
  String toString() {
    return 'MediaSettingsState{encodingPreset: $encodingPreset, encodingSettings: $encodingSettings} , audioProcessingSettings: $audioProcessingSettings}';
  }
}
