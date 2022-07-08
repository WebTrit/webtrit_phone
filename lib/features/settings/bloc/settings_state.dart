part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool progress,
    required bool registerStatus,
    AccountInfo? info,
    Object? error,
  }) = _SettingsState;
}
