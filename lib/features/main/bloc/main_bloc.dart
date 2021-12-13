import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required this.accountInfoRepository,
  }) : super(const MainState()) {
    on<MainStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(MainStarted event, Emitter<MainState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => MainState(info: info));
  }
}
