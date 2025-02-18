import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

class EncodingSettingsCubit extends Cubit<EncodingSettingState> {
  EncodingSettingsCubit(this._prefs) : super(EncodingSettingState.fromPrefs(_prefs));

  final AppPreferences _prefs;

  void setSettings(EncodingSettings settings) {
    emit(state.copyWithSettings(settings));
    _prefs.setEncodingSettings(settings);
  }

  void setPreset(EncodingPreset? preset) {
    emit(state.copyWithPresets(preset));
    _prefs.setEncodingPreset(preset);
  }

  void reset() {
    emit(EncodingSettingState(preset: null, settings: EncodingSettings.blank()));

    _prefs.setEncodingPreset(null);
    _prefs.setEncodingSettings(EncodingSettings.blank());
  }
}

class EncodingSettingState with EquatableMixin {
  EncodingSettingState({required this.settings, required this.preset});

  final EncodingSettings settings;
  final EncodingPreset? preset;

  factory EncodingSettingState.fromPrefs(AppPreferences prefs) {
    return EncodingSettingState(settings: prefs.getEncodingSettings(), preset: prefs.getEncodingPreset());
  }

  EncodingSettingState copyWithPresets(EncodingPreset? preset) {
    return EncodingSettingState(settings: settings, preset: preset);
  }

  EncodingSettingState copyWithSettings(EncodingSettings settings) {
    return EncodingSettingState(settings: settings, preset: preset);
  }

  @override
  List<Object?> get props => [settings, preset];

  @override
  String toString() {
    return 'EncodingSettingState{preset: $preset, settings: $settings}';
  }
}
