import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/account_info/account_info_repository.dart';

part 'language_tab_event.dart';
part 'language_tab_state.dart';

class LanguageTabBloc extends Bloc<LanguageTabEvent, LanguageTabState> {
  LanguageTabBloc({
    required this.accountInfoRepository,
  }) : super(const LanguageTabState()) {
    on<LanguageTabStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(LanguageTabStarted event, Emitter<LanguageTabState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => LanguageTabState(info: info));
  }
}
