import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

final _logger = Logger('SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.appBloc,
    required this.userRepository,
    required this.appRepository,
    required this.appPreferences,
    required this.onNotification,
  }) : super(SettingsState(registerStatus: appPreferences.getRegisterStatus())) {
    on<SettingsRefreshed>(_onRefreshed, transformer: restartable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsRegisterStatusChanged>(_onRegisterStatusChanged, transformer: sequential());
    on<SettingsAccountDeleted>(_onAccountDeleted, transformer: droppable());
  }

  final AppBloc appBloc;
  final UserRepository userRepository;
  final AppRepository appRepository;
  final AppPreferences appPreferences;
  final void Function(Notification notification) onNotification;

  FutureOr<void> _onRefreshed(SettingsRefreshed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      _logger.info('Refreshing settings');
      final infoFuture = userRepository.getInfo();
      final registerStatusFuture = appRepository.getRegisterStatus();

      final r = await Future.wait([infoFuture, registerStatusFuture]);

      final info = r[0] as UserInfo;
      final registerStatus = r[1] as bool;

      if (registerStatus != state.registerStatus) {
        await appPreferences.setRegisterStatus(registerStatus);
      }

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        info: info,
        registerStatus: registerStatus,
      ));
    } on Exception catch (e, stackTrace) {
      _logger.warning('_onRefreshed', e, stackTrace);
      _logger.info('isClosed: $isClosed');
      _logger.info('emit.isDone: ${emit.isDone}');
      if (isClosed) return;
      if (emit.isDone) return;

      onNotification(DefaultErrorNotification(e));
      appBloc.maybeHandleError(e);

      emit(state.copyWith(
        progress: false,
        info: null,
        registerStatus: appPreferences.getRegisterStatus(),
      ));
    }
  }

  FutureOr<void> _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.logout();

      appBloc.add(const AppLogouted());

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } on Exception catch (e, stackTrace) {
      _logger.warning('_onLogouted', e, stackTrace);

      if (event.force) {
        appBloc.add(const AppLogouted());
      } else {
        onNotification(DefaultErrorNotification(e));
        appBloc.maybeHandleError(e);
      }

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
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
    } on Exception catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);

      onNotification(DefaultErrorNotification(e));
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
    } on Exception catch (e, stackTrace) {
      _logger.warning('_onAccountDeleted', e, stackTrace);

      onNotification(DefaultErrorNotification(e));
      appBloc.maybeHandleError(e);

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
  }
}
