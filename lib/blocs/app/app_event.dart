part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

class _SessionUpdated extends AppEvent {
  const _SessionUpdated(this.session);

  final Session? session;
}

class AppThemeSettingsChanged extends AppEvent {
  const AppThemeSettingsChanged(this.value);

  final ThemeSettings value;
}

class AppThemeModeChanged extends AppEvent {
  const AppThemeModeChanged(this.value);

  final ThemeMode value;
}

class AppLocaleChanged extends AppEvent {
  const AppLocaleChanged(this.value);

  final Locale value;
}

@Freezed(copyWith: false)
class AppAgreementAccepted with _$AppAgreementAccepted implements AppEvent {
  const factory AppAgreementAccepted.updateUserAgreement(AgreementStatus status) = _UserAppAgreementUpdate;

  const factory AppAgreementAccepted.updateContactsAgreement(AgreementStatus status) = _ContactsAppAgreementUpdate;
}
