import 'dart:async';

import 'package:webtrit_phone/services/services.dart';

/// Lightweight fake ConnectivityService with controllable stream and checkConnection().
class FakeConnectivityService implements ConnectivityService {
  FakeConnectivityService({bool initialConnected = false}) : _connected = initialConnected;

  final _controller = StreamController<bool>.broadcast();
  bool _connected;

  int checkCalls = 0;

  @override
  Stream<bool> get connectionStream => _controller.stream;

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

  @override
  void dispose() {
    _controller.close();
  }
}
