part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [
    EquatablePropToString([count], listPropToString),
  ];
}
