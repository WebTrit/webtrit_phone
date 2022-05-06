import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/account_info/account_info_repository.dart';

part 'terms_conditions_event.dart';
part 'terms_conditions_state.dart';

class TermsConditionsTabBloc extends Bloc<TermsConditionsTabEvent, TermsConditionsTabState> {
  TermsConditionsTabBloc({
    required this.accountInfoRepository,
  }) : super(const TermsConditionsTabState()) {
    on<TermsConditionsTabStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(TermsConditionsTabStarted event, Emitter<TermsConditionsTabState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => TermsConditionsTabState(info: info));
  }
}
