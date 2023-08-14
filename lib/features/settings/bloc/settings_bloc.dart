import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

final _logger = Logger('$SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.appBloc,
    required this.userRepository,
    required this.appRepository,
    required this.appPreferences,
  }) : super(SettingsState(registerStatus: appPreferences.getRegisterStatus())) {
    on<SettingsRefreshed>(_onRefreshed, transformer: restartable());
    on<SettingsErrorDismissed>(_onErrorDismissed, transformer: droppable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsRegisterStatusChanged>(_onRegisterStatusChanged, transformer: sequential());
  }

  final AppBloc appBloc;
  final UserRepository userRepository;
  final AppRepository appRepository;
  final AppPreferences appPreferences;

  void _onRefreshed(SettingsRefreshed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    try {
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
    } catch (e, stackTrace) {
      _logger.warning('_onRefreshed', e, stackTrace);

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        info: null,
        registerStatus: appPreferences.getRegisterStatus(),
        error: e,
      ));
      appBloc.maybeHandleError(e);
    }
  }

  void _onErrorDismissed(SettingsErrorDismissed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(error: null));
  }

  void _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.logout();

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
      appBloc.add(const AppLogouted());
    } catch (e, stackTrace) {
      _logger.warning('_onLogouted', e, stackTrace);

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        error: e,
      ));
      appBloc.maybeHandleError(e);
    }
  }

  void _onRegisterStatusChanged(SettingsRegisterStatusChanged event, Emitter<SettingsState> emit) async {
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

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        registerStatus: previousRegisterStatus,
        error: e,
      ));
      appBloc.maybeHandleError(e);
    }
  }
}
