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
class AppLoggedIn extends AppEvent {
  final Session session;
  final WebtritSystemInfo? systemInfo;

  const AppLoggedIn({required this.session, this.systemInfo});
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

/// Initiates the application logout sequence.
///
/// Can be triggered manually by the user or automatically upon session invalidation
/// (e.g., via signaling socket errors or API unauthorized responses).
///
/// Triggers the transition to [AppLifecycleStatus.teardown], forcing the
/// [MainShell] to unmount before any data cleanup begins.
class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

/// Triggered exclusively by the teardown UI after the widget tree has stabilized.
///
/// This event executes the critical cleanup of local databases and repositories.
/// It must **only** be dispatched when the app is already in [AppLifecycleStatus.teardown]
/// and the main UI has been unmounted to prevent database locking errors.
///
/// **Sequence:**
/// 1. [AppLogoutRequested] transitions state to teardown.
/// 2. Router displays the teardown screen.
/// 3. Teardown screen dispatches this event to finalize cleanup.
class AppCleanupRequested extends AppEvent {
  const AppCleanupRequested();
}
