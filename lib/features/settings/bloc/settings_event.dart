part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsStarted extends SettingsEvent {
  const SettingsStarted();

  @override
  List<Object?> get props => [];
}
