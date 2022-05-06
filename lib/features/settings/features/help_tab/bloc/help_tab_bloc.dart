import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/account_info/account_info_repository.dart';

part 'help_tab_event.dart';
part 'help_tab_state.dart';

class HelpTabBloc extends Bloc<HelpTabEvent, HelpTabState> {
  HelpTabBloc({
    required this.accountInfoRepository,
  }) : super(const HelpTabState()) {
    on<HelpTabStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(HelpTabStarted event, Emitter<HelpTabState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => HelpTabState(info: info));
  }
}
