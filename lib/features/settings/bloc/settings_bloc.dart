import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.accountRepository,
  }) : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted, transformer: restartable());
  }

  final AccountRepository accountRepository;

  void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    await emit.forEach(accountRepository.info(), onData: (AccountInfo info) => SettingsState(info: info));
  }
}
