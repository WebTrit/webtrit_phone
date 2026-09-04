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

  /// Delay applied to the next [checkConnection] call only (consumed once),
  /// modelling a slow probe that a stream event can outrun.
  Duration? nextCheckDelay;

  /// Forced result for the next [checkConnection] call only (consumed once),
  /// modelling a probe whose answer is wrong by the time it resolves.
  bool? nextCheckResult;

  @override
  Stream<bool> get connectionStream => _controller.stream;

  @override
  ConnectivityResult get currentConnectivityResult => _currentResult;

  @override
  Stream<ConnectivityResult> get connectivityResultStream => _resultController.stream;

  @override
  Future<bool> checkConnection() async {
    checkCalls++;
    final delay = nextCheckDelay;
    nextCheckDelay = null;
    final forced = nextCheckResult;
    nextCheckResult = null;
    if (delay != null) await Future<void>.delayed(delay);
    // Like the real probe, report the state as of completion - unless the
    // test forced a (possibly stale) result via [nextCheckResult].
    return forced ?? _connected;
  }

  /// Emit a connectivity event without changing the underlying state,
  /// modelling a transiently wrong producer probe (e.g. a transport handoff
  /// whose liveness check failed while the network is actually fine).
  void emitConnectivityEvent(bool connected) => _controller.add(connected);

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
  Future<void> dispose() async {
    _controller.close();
    _resultController.close();
  }
}
