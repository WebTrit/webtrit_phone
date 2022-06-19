import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.appBloc,
    required this.accountRepository,
  }) : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted, transformer: restartable());
    on<SettingsErrorDismissed>(_onErrorDismissed, transformer: droppable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
  }

  final AppBloc appBloc;
  final AccountRepository accountRepository;

  void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    await emit.forEach(accountRepository.info(), onData: (AccountInfo info) => SettingsState(info: info));
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
}
