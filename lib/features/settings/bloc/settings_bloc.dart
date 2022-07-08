import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
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
  }) : super(const SettingsState(registerStatus: true)) {
    on<SettingsStarted>(_onStarted, transformer: restartable());
    on<SettingsErrorDismissed>(_onErrorDismissed, transformer: droppable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsRegisterStatusChanged>(_onRegisterStatusChanged, transformer: sequential());
  }

  final AppBloc appBloc;
  final AccountRepository accountRepository;
  final AppRepository appRepository;

  void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      final registerStatus = await appRepository.getRegisterStatus();
      emit(state.copyWith(progress: false, registerStatus: registerStatus));
    } catch (e, stackTrace) {
      emit(state.copyWith(error: e, progress: false));
      _logger.warning('_onStarted', e, stackTrace);
    }

    await emit.forEach(accountRepository.info(), onData: (AccountInfo info) => state.copyWith(info: info));
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
      emit(state.copyWith(progress: false));
    } catch (e) {
      emit(state.copyWith(error: e, progress: false, registerStatus: previousRegisterStatus));
    }
  }
}
