import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/services/services.dart';

/// Lightweight fake ConnectivityService with controllable streams and checkConnection().
class FakeConnectivityService implements ConnectivityService {
  FakeConnectivityService({bool initialConnected = false, ConnectivityResult initialResult = ConnectivityResult.none})
    : _connected = initialConnected,
      _currentResult = initialResult;

  final _controller = StreamController<bool>.broadcast();
  final _resultController = StreamController<ConnectivityResult>.broadcast();
  bool _connected;
  ConnectivityResult _currentResult;

  int checkCalls = 0;

  @override
  Stream<bool> get connectionStream => _controller.stream;

  @override
  ConnectivityResult get currentConnectivityResult => _currentResult;

  @override
  Stream<ConnectivityResult> get connectivityResultStream => _resultController.stream;

  @override
  Future<bool> checkConnection() async {
    checkCalls++;
    return _connected;
  }

  /// Set current connectivity and emit an event (alias: [push]).
  void setConnected(bool value) {
    _connected = value;
    _controller.add(value);
  }

  /// Alias for [setConnected] to keep backward compatibility.
  void push(bool connected) => setConnected(connected);

  /// Set current ConnectivityResult and emit on the deduped stream if different.
  void setConnectivityResult(ConnectivityResult result) {
    if (result != _currentResult) {
      _currentResult = result;
      _resultController.add(result);
    }
  }

  @override
  void dispose() {
    _controller.close();
    _resultController.close();
  }
}
