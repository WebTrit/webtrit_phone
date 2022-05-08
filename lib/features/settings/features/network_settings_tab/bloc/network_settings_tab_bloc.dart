import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_api/webtrit_api.dart';

import '../../../../../repositories/account_info/account_info_repository.dart';

part 'network_settings_tab_event.dart';
part 'network_settings_tab_state.dart';

class NetworkSettingsTabBloc extends Bloc<NetworkSettingsTabEvent, NetworkSettingsTabState> {
  NetworkSettingsTabBloc({
    required this.accountInfoRepository,
  }) : super(const NetworkSettingsTabState()) {
    on<NetworkSettingsTabStarted>(_onStarted, transformer: restartable());
  }

  final AccountInfoRepository accountInfoRepository;

  void _onStarted(NetworkSettingsTabStarted event, Emitter<NetworkSettingsTabState> emit) async {
    await emit.forEach(accountInfoRepository.info(), onData: (AccountInfo info) => NetworkSettingsTabState(info: info));
  }
}
