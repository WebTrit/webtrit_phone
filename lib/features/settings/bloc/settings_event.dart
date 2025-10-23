part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class SettingsLogouted extends SettingsEvent {
  const SettingsLogouted();
}

class SettingsAccountDeleted extends SettingsEvent {
  const SettingsAccountDeleted();
}

class SettingsUnreadVoicemailCountChanged extends SettingsEvent {
  const SettingsUnreadVoicemailCountChanged(this.count);

  final int count;
}