part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class _SessionUpdated extends AppEvent {
  const _SessionUpdated(this.session);

  final Session? session;

  @override
  List<Object> get props => [
        EquatablePropToString([session], listPropToString),
      ];
}

class AppThemeSettingsChanged extends AppEvent {
  const AppThemeSettingsChanged(this.value);

  final ThemeSettings value;

  @override
  List<Object> get props => [
        EquatablePropToString([value], listPropToString),
      ];
}

class AppThemeModeChanged extends AppEvent {
  const AppThemeModeChanged(this.value);

  final ThemeMode value;

  @override
  List<Object> get props => [
        EquatablePropToString([value], listPropToString),
      ];
}

class AppLocaleChanged extends AppEvent {
  const AppLocaleChanged(this.value);

  final Locale value;

  @override
  List<Object> get props => [
        EquatablePropToString([value], listPropToString),
      ];
}

sealed class AppAgreementAccepted extends AppEvent {
  const AppAgreementAccepted();

  const factory AppAgreementAccepted.updateUserAgreement(AgreementStatus status) = _UserAppAgreementUpdate;

  const factory AppAgreementAccepted.updateContactsAgreement(AgreementStatus status) = _ContactsAppAgreementUpdate;
}

class _UserAppAgreementUpdate extends AppAgreementAccepted {
  const _UserAppAgreementUpdate(this.status);

  final AgreementStatus status;

  @override
  List<Object> get props => [
        EquatablePropToString([status], listPropToString),
      ];
}

class _ContactsAppAgreementUpdate extends AppAgreementAccepted {
  const _ContactsAppAgreementUpdate(this.status);

  final AgreementStatus status;

  @override
  List<Object> get props => [
        EquatablePropToString([status], listPropToString),
      ];
}
