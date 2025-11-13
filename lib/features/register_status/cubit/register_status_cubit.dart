import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('RegisterStatusCubit');

class RegisterStatusCubit extends Cubit<RegisterStatus> {
  RegisterStatusCubit(this.appRepository, this.registerStatusRepository, {this.handleError})
    : super(registerStatusRepository.getRegisterStatus()) {
    fetchStatus();
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
  }

  final AppRepository appRepository;
  final RegisterStatusRepository registerStatusRepository;
  final Function(Object error, StackTrace stackTrace)? handleError;

  late final StreamSubscription _connectivitySub;

  void _handleConnectivity(List<ConnectivityResult> results) {
    if (results.any((result) => result != ConnectivityResult.none)) fetchStatus();
  }

  Future<void> fetchStatus() async {
    try {
      final status = await appRepository.getRegisterStatus();
      registerStatusRepository.setRegisterStatus(status);
      emit(status);
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      handleError?.call(e, s);
    }
  }

  Future<void> setStatus(bool value) async {
    try {
      await appRepository.setRegisterStatus(value);
      await registerStatusRepository.setRegisterStatus(value);
      emit(value);
    } catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);
      handleError?.call(e, stackTrace);
    }
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}

typedef RegisterStatus = bool;
