part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

@Freezed(copyWith: false)
class SettingsRefreshed with _$SettingsRefreshed implements SettingsEvent {
  const factory SettingsRefreshed() = _SettingsRefreshed;
}

@Freezed(copyWith: false)
class SettingsLogouted with _$SettingsLogouted implements SettingsEvent {
  const factory SettingsLogouted({@Default(false) bool force}) = _SettingsLogouted;
}

@Freezed(copyWith: false)
class SettingsRegisterStatusChanged with _$SettingsRegisterStatusChanged implements SettingsEvent {
  const factory SettingsRegisterStatusChanged(bool value) = _SettingsRegisterStatusChanged;
}

@Freezed(copyWith: false)
class SettingsAccountDeleted with _$SettingsAccountDeleted implements SettingsEvent {
  const factory SettingsAccountDeleted() = _SettingsAccountDeleted;
}
