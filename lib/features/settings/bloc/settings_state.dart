part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    required bool progress,
    @Default(0) int unreadVoicemailCount,
  }) = _SettingsState;
}
