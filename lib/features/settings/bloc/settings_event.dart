part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsStarted extends SettingsEvent {
  const SettingsStarted();
}

class SettingsErrorDismissed extends SettingsEvent {
  const SettingsErrorDismissed();
}

class SettingsLogouted extends SettingsEvent {
  const SettingsLogouted();
}

class SettingsRegisterStatusChanged extends SettingsEvent {
  const SettingsRegisterStatusChanged(this.value);

  final bool value;
}
