import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('RegisterStatusCubit');

class RegisterStatus {
  const RegisterStatus({required this.value, this.isUpdating = false});

  final bool value;
  final bool isUpdating;

  RegisterStatus copyWith({bool? value, bool? isUpdating}) =>
      RegisterStatus(value: value ?? this.value, isUpdating: isUpdating ?? this.isUpdating);
}

class RegisterStatusCubit extends Cubit<RegisterStatus> {
  RegisterStatusCubit(this.appRepository, this.registerStatusRepository, {this.handleError})
    : super(RegisterStatus(value: registerStatusRepository.getRegisterStatus())) {
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
      emit(RegisterStatus(value: status));
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      handleError?.call(e, s);
    }
  }

  Future<void> setStatus(bool value) async {
    emit(RegisterStatus(value: value, isUpdating: true));
    try {
      await appRepository.setRegisterStatus(value);
      await registerStatusRepository.setRegisterStatus(value);
      emit(RegisterStatus(value: value, isUpdating: false));
    } catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);
      emit(RegisterStatus(value: !value, isUpdating: false));
      handleError?.call(e, stackTrace);
    }
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}
