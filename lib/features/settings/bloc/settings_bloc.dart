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
    required this.accountRepository,
    required this.appRepository,
    required this.appPreferences,
  }) : super(SettingsState(registerStatus: appPreferences.getRegisterStatus())) {
    on<SettingsRefreshed>(_onRefreshed, transformer: restartable());
    on<SettingsErrorDismissed>(_onErrorDismissed, transformer: droppable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsRegisterStatusChanged>(_onRegisterStatusChanged, transformer: sequential());
  }

  final AppBloc appBloc;
  final AccountRepository accountRepository;
  final AppRepository appRepository;
  final AppPreferences appPreferences;

  void _onRefreshed(SettingsRefreshed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      final infoFuture = accountRepository.getInfo();
      final registerStatusFuture = appRepository.getRegisterStatus();

      final r = await Future.wait([infoFuture, registerStatusFuture]);

      if (emit.isDone) return;

      final info = r[0] as User;
      final registerStatus = r[1] as bool;

      if (registerStatus != state.registerStatus) {
        await appPreferences.setRegisterStatus(registerStatus);
      }

      emit(state.copyWith(
        progress: false,
        info: info,
        registerStatus: registerStatus,
      ));
    } catch (e, stackTrace) {
      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        info: null,
        registerStatus: appPreferences.getRegisterStatus(),
        error: e,
      ));
      _logger.warning('_onRefreshed', e, stackTrace);
    }
  }

  void _onErrorDismissed(SettingsErrorDismissed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(error: null));
  }

  void _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await accountRepository.logout();
      appBloc.add(const AppLogouted());
      emit(state.copyWith(progress: false));
    } catch (e) {
      emit(state.copyWith(error: e, progress: false));
    }
  }

  void _onRegisterStatusChanged(SettingsRegisterStatusChanged event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    final previousRegisterStatus = state.registerStatus;

    emit(state.copyWith(progress: true, registerStatus: event.value));
    try {
      await appRepository.setRegisterStatus(event.value);
      await appPreferences.setRegisterStatus(event.value);
      emit(state.copyWith(progress: false));
    } catch (e) {
      emit(state.copyWith(error: e, progress: false, registerStatus: previousRegisterStatus));
    }
  }
}
