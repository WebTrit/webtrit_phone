part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsLogouted extends SettingsEvent {
  const SettingsLogouted();
}

class SettingsAccountDeleted extends SettingsEvent {
  const SettingsAccountDeleted();
}
