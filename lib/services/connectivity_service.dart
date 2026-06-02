import 'dart:async';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

abstract class ConnectivityService {
  /// Last seen `ConnectivityResult` from any source (initial platform read or
  /// subsequent change event). Always non-null after the service is created.
  ConnectivityResult get currentConnectivityResult;

  /// Stream of raw `ConnectivityResult` values, deduplicated against the cached
  /// current value. Emits only when the OS reports a value different from the
  /// last accepted one. The first event after subscribe that mirrors the cached
  /// initial value is filtered out here - this is the bridge that the plugin's
  /// own `Stream.distinct()` does not cover (plugin compares within stream only;
  /// it does not know about `checkConnectivity()` snapshot reads).
  Stream<ConnectivityResult> get connectivityResultStream;

  /// Boolean online-state stream that combines OS connectivity with an HTTP
  /// liveness probe via [ConnectivityChecker]. Emits on every change event,
  /// after the probe completes.
  Stream<bool> get connectionStream;

  /// One-shot online check: OS state + HTTP probe.
  Future<bool> checkConnection();

  void dispose();
}

class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl._({
    required ConnectivityChecker connectivityChecker,
    required ConnectivityResult initialResult,
  }) : _connectivityChecker = connectivityChecker,
       _lastResult = initialResult {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  /// Creates a fully-initialised service. Reads the current OS connectivity
  /// state via `checkConnectivity()` to seed the cache before any consumer
  /// subscribes. Must be awaited so the listener's first replayed event is
  /// recognized as a duplicate and filtered.
  ///
  /// The awaited read is a cheap local platform-channel query of the OS
  /// transport state - it performs no network I/O (the HTTP liveness probe runs
  /// later, on change events), so its cost on the bootstrap/splash path is
  /// negligible next to heavier inits such as the DB isolate spawn. An empty
  /// platform result is treated as `ConnectivityResult.none` rather than
  /// throwing, so startup is never blocked by a missing entry.
  static Future<ConnectivityServiceImpl> create({required ConnectivityChecker connectivityChecker}) async {
    final initialResult = (await Connectivity().checkConnectivity()).firstOrNull ?? ConnectivityResult.none;
    return ConnectivityServiceImpl._(connectivityChecker: connectivityChecker, initialResult: initialResult);
  }

  final Connectivity _connectivity = Connectivity();
  final ConnectivityChecker _connectivityChecker;
  final StreamController<bool> _onlineController = StreamController<bool>.broadcast();
  final StreamController<ConnectivityResult> _resultController = StreamController<ConnectivityResult>.broadcast();
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityResult _lastResult;

  @override
  ConnectivityResult get currentConnectivityResult => _lastResult;

  @override
  Stream<ConnectivityResult> get connectivityResultStream => _resultController.stream;

  @override
  Stream<bool> get connectionStream => _onlineController.stream;

  @override
  Future<bool> checkConnection() => _checkConnection(_lastResult);

  Future<void> _handleConnectivityChange(List<ConnectivityResult> result) async {
    final next = result.firstOrNull ?? ConnectivityResult.none;
    if (next != _lastResult) {
      _lastResult = next;
      _resultController.add(next);
    }
    final connected = await _checkConnection(next);
    if (next == _lastResult) {
      _onlineController.add(connected);
    }
  }

  Future<bool> _checkConnection(ConnectivityResult current) async {
    if (current == ConnectivityResult.none) return false;
    return _connectivityChecker.checkConnection();
  }

  @override
  void dispose() {
    _connectivityChecker.dispose();
    _connectivitySubscription.cancel();
    _resultController.close();
    _onlineController.close();
  }
}
