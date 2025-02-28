import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
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

  void reset() {
    emit(MediaSettingsState(
      encodingPreset: null,
      encodingSettings: EncodingSettings.blank(),
    ));

    _prefs.setEncodingPreset(null);
    _prefs.setEncodingSettings(EncodingSettings.blank());
  }
}

class MediaSettingsState with EquatableMixin {
  MediaSettingsState({required this.encodingSettings, required this.encodingPreset});

  final EncodingSettings encodingSettings;
  final EncodingPreset? encodingPreset;

  factory MediaSettingsState.fromPrefs(AppPreferences prefs) {
    return MediaSettingsState(
      encodingSettings: prefs.getEncodingSettings(),
      encodingPreset: prefs.getEncodingPreset(),
    );
  }

  MediaSettingsState copyWithEncodingPresets(EncodingPreset? preset) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: preset,
    );
  }

  MediaSettingsState copyWithEncodingSettings(EncodingSettings settings) {
    return MediaSettingsState(
      encodingSettings: settings,
      encodingPreset: encodingPreset,
    );
  }

  @override
  List<Object?> get props => [
        encodingSettings,
        encodingPreset,
      ];

  @override
  String toString() {
    return 'MediaSettingsState{encodingPreset: $encodingPreset, encodingSettings: $encodingSettings}';
  }
}
