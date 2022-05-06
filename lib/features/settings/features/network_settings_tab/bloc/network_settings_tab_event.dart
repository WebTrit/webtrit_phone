part of 'network_settings_tab_bloc.dart';

abstract class NetworkSettingsTabEvent extends Equatable {
  const NetworkSettingsTabEvent();
}

class NetworkSettingsTabStarted extends NetworkSettingsTabEvent {
  const NetworkSettingsTabStarted();

  @override
  List<Object?> get props => [];
}
