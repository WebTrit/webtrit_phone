part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

/// Event dispatched to finalize the authentication process.
///
/// Updates the application state with the provided [session] and optionally
/// preloads [systemInfo] into the corresponding repository.
class AppLogined extends AppEvent {
  final Session session;
  final WebtritSystemInfo? systemInfo;

  const AppLogined({required this.session, this.systemInfo});
}

class _SessionUpdated extends AppEvent {
  const _SessionUpdated(this.session);

  final Session? session;

  @override
  List<Object?> get props => [session];
}

class AppThemeSettingsChanged extends AppEvent {
  const AppThemeSettingsChanged(this.value);

  final ThemeSettings value;

  @override
  List<Object?> get props => [value];
}

class AppThemeModeChanged extends AppEvent {
  const AppThemeModeChanged(this.value);

  final ThemeMode value;

  @override
  List<Object?> get props => [value];
}

class AppLocaleChanged extends AppEvent {
  const AppLocaleChanged(this.value);

  final Locale value;

  @override
  List<Object?> get props => [value];
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
  List<Object?> get props => [status];
}

class _ContactsAppAgreementUpdate extends AppAgreementAccepted {
  const _ContactsAppAgreementUpdate(this.status);

  final AgreementStatus status;

  @override
  List<Object?> get props => [status];
}

/// Triggered to initiate the user logout process by transitioning the app
/// into a teardown state to safely unmount the primary UI.
class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

/// Triggered after the UI has stabilized in teardown mode to perform
/// the actual clearing of local databases, repositories, and session data.
class AppCleanupRequested extends AppEvent {
  const AppCleanupRequested();
}
