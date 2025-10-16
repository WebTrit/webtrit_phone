part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

@Freezed(copyWith: false)
abstract class _SessionUpdated with _$SessionUpdated implements AppEvent {
  const factory _SessionUpdated(Session? session) = __SessionUpdated;
}

@Freezed(copyWith: false)
abstract class AppThemeSettingsChanged with _$AppThemeSettingsChanged implements AppEvent {
  const factory AppThemeSettingsChanged(ThemeSettings value) = _AppThemeSettingsChanged;
}

@Freezed(copyWith: false)
abstract class AppThemeModeChanged with _$AppThemeModeChanged implements AppEvent {
  const factory AppThemeModeChanged(ThemeMode value) = _AppThemeModeChanged;
}

@Freezed(copyWith: false)
abstract class AppLocaleChanged with _$AppLocaleChanged implements AppEvent {
  const factory AppLocaleChanged(Locale value) = _AppLocaleChanged;
}

@Freezed(copyWith: false)
abstract class AppAgreementAccepted with _$AppAgreementAccepted implements AppEvent {
  const factory AppAgreementAccepted.updateUserAgreement(AgreementStatus status) = _UserAppAgreementUpdate;

  const factory AppAgreementAccepted.updateContactsAgreement(AgreementStatus status) = _ContactsAppAgreementUpdate;
}
