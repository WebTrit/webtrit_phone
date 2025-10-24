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

@Freezed(copyWith: false)
class AppAgreementAccepted with _$AppAgreementAccepted implements AppEvent {
  const AppAgreementAccepted._();

  const factory AppAgreementAccepted.updateUserAgreement(AgreementStatus status) = _UserAppAgreementUpdate;

  const factory AppAgreementAccepted.updateContactsAgreement(AgreementStatus status) = _ContactsAppAgreementUpdate;

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
