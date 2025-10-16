part of 'settings_bloc.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    required bool progress,
    @Default(0) int unreadVoicemailCount,
  }) = _SettingsState;
}
