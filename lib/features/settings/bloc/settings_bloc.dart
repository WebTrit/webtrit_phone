import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/self_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

final _logger = Logger('SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.notificationsBloc,
    required this.appBloc,
    required this.userRepository,
    required this.selfConfigRepository,
    required this.appRepository,
    required this.appPreferences,
  }) : super(SettingsState(registerStatus: appPreferences.getRegisterStatus())) {
    on<SettingsRefreshed>(_onRefreshed, transformer: restartable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsRegisterStatusChanged>(_onRegisterStatusChanged, transformer: sequential());
    on<SettingsAccountDeleted>(_onAccountDeleted, transformer: droppable());
  }

  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final UserRepository userRepository;
  final SelfConfigRepository selfConfigRepository;
  final AppRepository appRepository;
  final AppPreferences appPreferences;

  Future<void> fetchUserInfo(Emitter<SettingsState> emit) async {
    try {
      final info = await userRepository.getInfo();
      emit(state.copyWith(info: info));
    } catch (e, s) {
      _logger.warning('Failed to get user info', e, s);
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);
    }
  }

  Future<void> fetchRegisterStatus(Emitter<SettingsState> emit) async {
    try {
      final status = await appRepository.getRegisterStatus();
      appPreferences.setRegisterStatus(status);
      emit(state.copyWith(registerStatus: status));
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);
      emit(state.copyWith(registerStatus: appPreferences.getRegisterStatus()));
    }
  }

  Future<void> fetchSelfConfig(Emitter<SettingsState> emit) async {
    try {
      final selfConfig = await selfConfigRepository.getSelfConfig();
      emit(state.copyWith(selfConfig: selfConfig));
    } catch (e, s) {
      /// Optional feature, so no need to show error to user.
      _logger.info('Failed to get self config', e, s);
      appBloc.maybeHandleError(e);
    }
  }

  FutureOr<void> _onRefreshed(SettingsRefreshed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    _logger.info('Refreshing settings');
    await Future.wait([fetchUserInfo(emit), fetchSelfConfig(emit), fetchRegisterStatus(emit)]);
    emit(state.copyWith(progress: false));
    _logger.info('Settings refreshed');
  }

  FutureOr<void> _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    // No need to wait any results here to not stop user from logging out.
    // Errors will handled by [SessionCleanupWorker] inside to avoid connection issues on session cleanup.
    //
    // Also, its needed to avoid race conditions with Signaling client, that happens if we wait for the result here.
    userRepository.logout().ignore();
    appBloc.add(const AppLogouted());
  }

  FutureOr<void> _onRegisterStatusChanged(SettingsRegisterStatusChanged event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    final previousRegisterStatus = state.registerStatus;

    emit(state.copyWith(
      progress: true,
      registerStatus: event.value,
    ));
    try {
      await appRepository.setRegisterStatus(event.value);
      await appPreferences.setRegisterStatus(event.value);

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);

      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        registerStatus: previousRegisterStatus,
      ));
    }
  }

  FutureOr<void> _onAccountDeleted(SettingsAccountDeleted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.delete();

      appBloc.add(const AppLogouted());

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } catch (e, stackTrace) {
      _logger.warning('_onAccountDeleted', e, stackTrace);

      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
  }
}
