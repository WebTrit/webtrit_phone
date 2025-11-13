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
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'app_bloc.freezed.dart';

part 'app_event.dart';

part 'app_state.dart';

final _logger = Logger('AppBloc');

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.appPreferences,
    required this.userAgreementStatusRepository,
    required this.contactsAgreementStatusRepository,
    required this.sessionRepository,
    required this.appInfo,
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
    required AppThemes appThemes,
  }) : super(
         AppState(
           /// Important to manage routing and navigation in AppRouter
           session: sessionRepository.getCurrent() ?? const Session(),
           themeSettings: appThemes.values.first.settings,
           themeMode: appPreferences.getThemeMode(),
           locale: appPreferences.getLocale(),
           userAgreementStatus: userAgreementStatusRepository.getUserAgreementStatus(),
           contactsAgreementStatus: contactsAgreementStatusRepository.getContactsAgreementStatus(),
         ),
       ) {
    on<_SessionUpdated>(_onSessionUpdated, transformer: sequential());
    on<AppThemeSettingsChanged>(_onThemeSettingsChanged, transformer: droppable());
    on<AppThemeModeChanged>(_onThemeModeChanged, transformer: droppable());
    on<AppLocaleChanged>(_onLocaleChanged, transformer: droppable());
    on<AppAgreementAccepted>(_onUserAgreementAccepted, transformer: droppable());

    _subscribeSession();
  }

  final AppPreferences appPreferences;
  final UserAgreementStatusRepository userAgreementStatusRepository;
  final ContactsAgreementStatusRepository contactsAgreementStatusRepository;
  final WebtritApiClientFactory createWebtritApiClient;
  final SessionRepository sessionRepository;
  final AppInfo appInfo;

  late final StreamSubscription<Session?> _sessionSub;

  @override
  void onChange(Change<AppState> change) {
    /// Trigger when user transitions from logged out to logged in
    if (!change.currentState.session.isLoggedIn && change.nextState.session.isLoggedIn) {
      _onSessionLoggedIn(change.nextState.session);
    }

    /// Trigger when user transitions from logged in to logged out
    if (change.currentState.session.isLoggedIn && !change.nextState.session.isLoggedIn) {
      _onSessionLoggedOut(change.currentState.session);
    }
    super.onChange(change);
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

  void _subscribeSession() {
    _sessionSub = sessionRepository.watch().listen(
      (session) => add(_SessionUpdated(session)),
      onError: (e, st) => _logger.severe('authSessionRepository.watch', e, st),
    );
  }

  void _onSessionUpdated(_SessionUpdated event, Emitter<AppState> emit) async {
    emit(state.copyWith(session: event.session ?? const Session()));
  }

  void _onThemeSettingsChanged(AppThemeSettingsChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(themeSettings: event.value));
  }

  void _onThemeModeChanged(AppThemeModeChanged event, Emitter<AppState> emit) async {
    final themeMode = event.value;
    if (themeMode == ThemeMode.system) {
      await appPreferences.removeThemeMode();
    } else {
      await appPreferences.setThemeMode(themeMode);
    }
    emit(state.copyWith(themeMode: themeMode));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) async {
    final locale = event.value;
    if (locale == LocaleExtension.defaultNull) {
      await appPreferences.removeLocale();
    } else {
      await appPreferences.setLocale(locale);
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
          sessionRepository.logout();
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

  @override
  Future<void> close() async {
    await _sessionSub.cancel();
    return super.close();
  }
}
