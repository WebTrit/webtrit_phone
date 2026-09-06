part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState({required this.progress});

  @override
  final bool progress;
}
