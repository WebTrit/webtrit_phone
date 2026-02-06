part of 'app_bloc.dart';

enum AppLogoutReason {
  /// The user manually initiated the logout process through the UI.
  /// Requires both remote session revocation and local data cleanup.
  userRequest,

  /// The signaling was lost due to an expired or invalid session (e.g., Error 4201).
  /// Requires only local data cleanup as the server has already terminated the session.
  sessionMissed,

  /// The server explicitly rejected a request due to authentication.
  /// Requires both remote session revocation and local data cleanup.
  serverRejection,
}

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

/// Event dispatched to finalize the authentication process.
///
/// Updates the application state with the provided [session] and optionally
/// preloads [systemInfo] into the corresponding repository.
class AppLoggedIn extends AppEvent {
  final Session session;
  final WebtritSystemInfo? systemInfo;

  const AppLoggedIn({required this.session, this.systemInfo});

  @override
  List<Object?> get props => [session, systemInfo];
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

/// Initiates the application logout sequence.
///
/// Accepts an [AppLogoutReason] to define the context of the logout (e.g., manual user request
/// or system invalidation), which determines the subsequent cleanup strategy.
///
/// Transitions the application state to [AppLifecycleStatus.teardown], forcing the
/// [MainShell] to unmount before resource disposal begins.
class AppLogoutRequested extends AppEvent {
  final AppLogoutReason reason;

  const AppLogoutRequested({this.reason = AppLogoutReason.userRequest});

  @override
  List<Object?> get props => [reason];
}

/// Finalizes the logout process by releasing resources and clearing session data.
///
/// Dispatched exclusively by the teardown UI after the widget tree has stabilized
/// to prevent database lock contention.
///
/// This handler conditionally attempts remote session revocation based on the
/// [AppLogoutReason] stored in the state:
/// * **userRequest / serverRejection**: Revokes the remote session before local cleanup.
/// * **sessionMissed**: Skips remote revocation since the session is already terminated.
class AppCleanupRequested extends AppEvent {
  const AppCleanupRequested();
}
