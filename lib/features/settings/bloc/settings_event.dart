part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsRefreshed extends SettingsEvent {
  const SettingsRefreshed();
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
