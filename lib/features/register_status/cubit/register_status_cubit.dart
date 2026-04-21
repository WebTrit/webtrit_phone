import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/crashlytics_utils.dart';

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
    fetchStatus(silently: true);
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
  }

  final AppRepository appRepository;
  final RegisterStatusRepository registerStatusRepository;
  final Function(Object error, StackTrace stackTrace)? handleError;

  late final StreamSubscription _connectivitySub;

  void _handleConnectivity(List<ConnectivityResult> results) {
    if (results.any((result) => result != ConnectivityResult.none)) fetchStatus(silently: true);
  }

  Future<void> fetchStatus({bool silently = false}) async {
    try {
      final status = await appRepository.getRegisterStatus();
      registerStatusRepository.setRegisterStatus(status);
      emit(RegisterStatus(value: status));
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      handleError?.call(e, s);

      if (!_isTransientNetworkError(e)) {
        if (!silently) handleError?.call(e, s);
        CrashlyticsUtils.recordError(e, stack: s, reason: 'RegisterStatusCubit.fetchStatus');
      }
    }
  }

  bool _isTransientNetworkError(Object error) =>
      error is SocketException || error is TimeoutException || error is TlsException;

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
      if (!_isTransientNetworkError(e)) {
        CrashlyticsUtils.recordError(e, stack: stackTrace, reason: 'RegisterStatusCubit.setStatus');
      }
    }
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}
