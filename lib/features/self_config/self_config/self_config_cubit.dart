import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/self_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SelfConfigCubit');

/// A simple cubit that prefetches selfconfig and store data during the user's session.
class SelfConfigCubit extends Cubit<SelfConfigState> {
  SelfConfigCubit(this._customPrivateGatewayRepository, this._enabled) : super(SelfConfigState()) {
    if (!_enabled) return;
    fetchSelfConfig();
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
  }

  final CustomPrivateGatewayRepository _customPrivateGatewayRepository;
  final bool _enabled;
  StreamSubscription? _connectivitySub;

  void _handleConnectivity(List<ConnectivityResult> results) {
    if (results.any((result) => result != ConnectivityResult.none)) fetchSelfConfig();
  }

  Future<void> fetchSelfConfig() async {
    try {
      final selfConfig = await _customPrivateGatewayRepository.getSelfConfig();
      emit(SelfConfigState(selfConfig: selfConfig));
    } catch (e, s) {
      _logger.warning('Failed to get self config', e, s);
    }
  }

  @override
  Future<void> close() {
    _connectivitySub?.cancel();
    return super.close();
  }
}

class SelfConfigState with EquatableMixin {
  SelfConfigState({this.selfConfig});

  final SelfConfig? selfConfig;

  @override
  List<Object?> get props => [selfConfig];

  @override
  bool get stringify => true;
}
