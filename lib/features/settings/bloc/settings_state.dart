part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState({required this.progress, this.unreadVoicemailCount = 0});

  @override
  final bool progress;

  @override
  final int unreadVoicemailCount;
}
