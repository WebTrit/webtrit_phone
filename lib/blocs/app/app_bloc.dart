import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'app_bloc.freezed.dart';

part 'app_event.dart';

part 'app_state.dart';

final _logger = Logger('AppBloc');

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.userAgreementStatusRepository,
    required this.contactsAgreementStatusRepository,
    required this.sessionRepository,
    required this.appInfo,
    required this.localeRepository,
    required this.themeModeRepository,
    required this.userSessionCleanupResolver,
    required this.systemInfoRepository,
    required AppThemes appThemes,
  }) : super(
         AppState(
           session: sessionRepository.getCurrent(),
           status: (sessionRepository.getCurrent().isLoggedIn)
               ? AppLifecycleStatus.authenticated
               : AppLifecycleStatus.unauthenticated,
           themeSettings: appThemes.values.first.settings,
           themeMode: themeModeRepository.getThemeMode(),
           locale: localeRepository.getLocale(),
           userAgreementStatus: userAgreementStatusRepository.getUserAgreementStatus(),
           contactsAgreementStatus: contactsAgreementStatusRepository.getContactsAgreementStatus(),
         ),
       ) {
    on<AppLoggedIn>(_onLoggedIn);
    on<AppThemeSettingsChanged>(_onThemeSettingsChanged, transformer: droppable());
    on<AppThemeModeChanged>(_onThemeModeChanged, transformer: droppable());
    on<AppLocaleChanged>(_onLocaleChanged, transformer: droppable());
    on<AppAgreementAccepted>(_onUserAgreementAccepted, transformer: droppable());
    on<AppLogoutRequested>(_onLogoutRequested, transformer: droppable());
    on<AppCleanupRequested>(_onCleanupRequested, transformer: droppable());
  }

  final UserAgreementStatusRepository userAgreementStatusRepository;
  final ContactsAgreementStatusRepository contactsAgreementStatusRepository;
  final SessionRepository sessionRepository;
  final AppInfo appInfo;
  final LocaleRepository localeRepository;
  final ThemeModeRepository themeModeRepository;
  final UserSessionCleanupResolver userSessionCleanupResolver;
  final SystemInfoRepository systemInfoRepository;

  @override
  void onChange(Change<AppState> change) {
    /// Trigger when user transitions from logged out to logged in
    if (change.currentState.status != AppLifecycleStatus.authenticated &&
        change.nextState.status == AppLifecycleStatus.authenticated) {
      _onSessionLoggedIn(change.nextState.session);
    }

    /// Trigger when user transitions from logged in to logged out (or teardown)
    if (change.currentState.status == AppLifecycleStatus.authenticated &&
        change.nextState.status != AppLifecycleStatus.authenticated) {
      _onSessionLoggedOut(change.currentState.session);
    }
    super.onChange(change);
  }

  Future<void> _onLoggedIn(AppLoggedIn event, Emitter<AppState> emit) async {
    final systemInfo = event.systemInfo;
    if (systemInfo != null) {
      systemInfoRepository.preload(systemInfo);
    }

    // Persist session to storage (syncs disk)
    await sessionRepository.save(event.session);

    // Explicitly update bloc state (syncs UI)
    emit(state.copyWith(status: AppLifecycleStatus.authenticated, session: event.session));
  }

  void _onSessionLoggedIn(Session session) {
    unawaited(
      CrashlyticsUtils.logSession(
        userId: session.userId,
        tenantId: session.tenantId,
        coreUrl: session.coreUrl!,
        sessionId: appInfo.identifier,
      ),
    );
  }

  void _onSessionLoggedOut(Session session) {
    _logger.info('User logged out: ${session.userId}');
  }

  Future<void> _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) async {
    _logger.info('Logout requested. Reason: ${event.reason}. Initiating safe teardown sequence.');
    emit(state.copyWith(status: AppLifecycleStatus.teardown, logoutReason: event.reason));
  }

  Future<void> _onCleanupRequested(AppCleanupRequested event, Emitter<AppState> emit) async {
    _logger.info('UI teardown complete. Initiating cleanup.');

    try {
      await userSessionCleanupResolver.resolve();
    } catch (e, st) {
      _logger.severe('Resource cleanup failed', e, st);
    }

    // Determine the logout reason (defaulting to userRequest if null)
    final reason = state.logoutReason ?? AppLogoutReason.userRequest;
    final currentSession = sessionRepository.getCurrent();

    // Determine if we should attempt to revoke the session on the server.
    // We skip this only for 'sessionMissed' because the socket error (4201)
    // guarantees the session is already terminated.
    final shouldRevokeRemote = reason == AppLogoutReason.userRequest || reason == AppLogoutReason.serverRejection;

    if (shouldRevokeRemote && currentSession.isLoggedIn) {
      _logger.info('Revoking remote session. Reason: $reason');
      unawaited(sessionRepository.revokeSession(currentSession));
    } else {
      _logger.info('Skipping remote revoke. Reason: $reason');
    }

    // Always perform local cleanup
    await sessionRepository.clean();

    emit(state.copyWith(status: AppLifecycleStatus.unauthenticated, session: const Session(), logoutReason: null));
  }

  void _onThemeSettingsChanged(AppThemeSettingsChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(themeSettings: event.value));
  }

  void _onThemeModeChanged(AppThemeModeChanged event, Emitter<AppState> emit) async {
    final themeMode = event.value;
    if (themeMode == ThemeMode.system) {
      await themeModeRepository.clear();
    } else {
      await themeModeRepository.setThemeMode(themeMode);
    }
    emit(state.copyWith(themeMode: themeMode));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) async {
    final locale = event.value;
    if (locale == LocaleExtension.defaultNull) {
      await localeRepository.clear();
    } else {
      await localeRepository.setLocale(locale);
    }
    emit(state.copyWith(locale: locale));
  }

  /// Handles unauthorized errors for the active session.
  /// Logs out only if the failing request used the current token,
  /// avoiding accidental logout from outdated tokens (e.g. after re-login).
  // TODO: Consider moving this logic to another place, like a middleware or interceptor.
  void maybeHandleError(Object error) {
    if (error is RequestFailure) {
      if (error.statusCode == HttpStatus.unauthorized) {
        if (state.session.isLoggedIn && state.session.token == error.token) {
          add(const AppLogoutRequested());
        }
      }
    }
  }

  Future<void> _onUserAgreementAccepted(AppAgreementAccepted event, Emitter<AppState> emit) {
    return switch (event) {
      _UserAppAgreementUpdate() => __onUpdateUserAgreementStatus(event, emit),
      _ContactsAppAgreementUpdate() => __onContactsUserAgreementStatus(event, emit),
    };
  }

  Future<void> __onUpdateUserAgreementStatus(_UserAppAgreementUpdate event, Emitter<AppState> emit) async {
    await userAgreementStatusRepository.setUserAgreementStatus(event.status);
    emit(state.copyWith(userAgreementStatus: event.status));
  }

  Future<void> __onContactsUserAgreementStatus(_ContactsAppAgreementUpdate event, Emitter<AppState> emit) async {
    await contactsAgreementStatusRepository.setContactsAgreementStatus(event.status);
    emit(state.copyWith(contactsAgreementStatus: event.status));
  }
}
