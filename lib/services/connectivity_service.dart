import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

abstract class ConnectivityService {
  Stream<bool> get connectionStream;

  Future<bool> checkConnection();

  void dispose();
}

class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl({
    HttpRequestExecutorFactory createHttpRequestExecutor = defaultCreateHttpRequestExecutor,
  }) : _createHttpRequestExecutor = createHttpRequestExecutor {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final HttpRequestExecutorFactory _createHttpRequestExecutor;

  @override
  Stream<bool> get connectionStream => _controller.stream;

  @override
  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      return false;
    }

    final executor = _createHttpRequestExecutor();
    try {
      await executor.execute(method: 'GET', url: 'https://www.google.com/generate_204');
      return true;
    } catch (_) {
      return false;
    } finally {
      executor.close();
    }
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
