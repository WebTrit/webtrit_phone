import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.accountInfoRepository,
  }) : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => SettingsState(info: info));
  }
}
