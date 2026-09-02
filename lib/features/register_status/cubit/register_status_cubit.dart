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

  /// Returns whether the fetch succeeded, so an explicit user-triggered
  /// refresh can report a failure instead of silently keeping the stale value.
  ///
  /// [handleError] is called on every failure: it routes a 401 to the app
  /// logout flow and ignores everything else, so it stays silent for the
  /// automatic fetches (startup, connectivity regained).
  Future<bool> fetchStatus() async {
    try {
      final status = await appRepository.getRegisterStatus();
      await registerStatusRepository.setRegisterStatus(status);
      emit(RegisterStatus(value: status));
      return true;
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      handleError?.call(e, s);
      if (!_isTransientNetworkError(e)) {
        CrashlyticsUtils.recordError(e, stack: s, reason: 'RegisterStatusCubit.fetchStatus');
      }
      return false;
    }
  }

  bool _isTransientNetworkError(Object error) =>
      error is SocketException || error is TimeoutException || error is TlsException;

  /// Returns whether the change was accepted by the server. On failure the
  /// previous value is restored, so the caller must tell the user why the
  /// switch snapped back.
  Future<bool> setStatus(bool value) async {
    emit(RegisterStatus(value: value, isUpdating: true));
    try {
      await appRepository.setRegisterStatus(value);
      await registerStatusRepository.setRegisterStatus(value);
      emit(RegisterStatus(value: value, isUpdating: false));
      return true;
    } catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);
      emit(RegisterStatus(value: !value, isUpdating: false));
      handleError?.call(e, stackTrace);
      if (!_isTransientNetworkError(e)) {
        CrashlyticsUtils.recordError(e, stack: stackTrace, reason: 'RegisterStatusCubit.setStatus');
      }
      return false;
    }
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}
