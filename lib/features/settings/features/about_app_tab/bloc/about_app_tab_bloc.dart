import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/account_info/account_info_repository.dart';

part 'about_app_tab_event.dart';
part 'about_app_tab_state.dart';

class AboutAppTabBloc extends Bloc<AboutAppTabEvent, AboutAppTabState> {
  AboutAppTabBloc({
    required this.accountInfoRepository,
  }) : super(const AboutAppTabState()) {
    on<AboutAppTabStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(AboutAppTabStarted event, Emitter<AboutAppTabState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => AboutAppTabState(info: info));
  }
}
