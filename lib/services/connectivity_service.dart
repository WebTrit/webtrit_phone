import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

abstract class ConnectivityService {
  Stream<bool> get connectionStream;

  Future<bool> checkConnection();

  void dispose();
}

class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl({required ConnectivityChecker connectivityChecker})
    : _connectivityChecker = connectivityChecker {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  final ConnectivityChecker _connectivityChecker;
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  Stream<bool> get connectionStream => _controller.stream;

  @override
  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    return _connectivityChecker.checkConnection();
  }

  Future<void> _handleConnectivityChange(List<ConnectivityResult> result) async {
    final connected = await checkConnection();
    _controller.add(connected);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _controller.close();
  }
}
