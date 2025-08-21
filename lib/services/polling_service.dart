import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';

final _logger = Logger('PollingService');

/// Periodically calls [Refreshable.refresh] for registered listeners,
/// but only when network is actually reachable.
///
/// Handles:
/// - Auto start/stop polling on connectivity changes
/// - Skip ticks without internet (double-checks reachability each tick)
/// - Prevents overlapping refresh() calls (per-listener in-flight guard)
/// - Triggers a leading refresh once when connection is restored
class PollingService implements Disposable {
  PollingService({
    required ConnectivityService connectivityService,
    List<PollingRegistration> registrations = const [],
  }) : _connectivityService = connectivityService {
    _connectivitySubscription = _connectivityService.connectionStream.listen(_handleConnectivityChange);

    // apply initial registrations
    for (final reg in registrations) {
      register(reg);
    }

    _initializePollingIfConnected();
  }

  final ConnectivityService _connectivityService;
  late final StreamSubscription<bool> _connectivitySubscription;
  bool _isConnected = false;

  final Map<Refreshable, _PollingConfig> _pollingConfigs = {};

  /// Registers a [Refreshable] with a custom polling [interval].
  /// Starts polling immediately if there is connectivity.
  void register(PollingRegistration registration) {
    final listener = registration.listener;
    final interval = registration.interval;

    final config = _pollingConfigs.putIfAbsent(
      listener,
      () => _PollingConfig(interval: interval),
    );
    config.interval = interval;

    if (_isConnected) {
      _triggerOnce(listener, config);
      _startPolling(listener);
    }
  }

  /// Unregisters a previously registered [Refreshable].
  void unregister(Refreshable listener) {
    final config = _pollingConfigs.remove(listener);
    config?.timer?.cancel();
  }

  Future<void> _initializePollingIfConnected() async {
    _isConnected = await _connectivityService.checkConnection();
    if (_isConnected) {
      for (final entry in _pollingConfigs.entries) {
        _triggerOnce(entry.key, entry.value); // leading edge on boot
        _startPolling(entry.key);
      }
    }
  }

  void _handleConnectivityChange(bool connected) {
    _isConnected = connected;

    if (connected) {
      // On restore: trigger immediate refresh and ensure timers are running
      for (final entry in _pollingConfigs.entries) {
        _triggerOnce(entry.key, entry.value);
        _startPolling(entry.key);
      }
    } else {
      // On loss: stop all timers and reset in-flight state
      for (final config in _pollingConfigs.values) {
        config.timer?.cancel();
        config.timer = null;
        config.isRefreshing = false;
      }
    }
  }

  void _startPolling(Refreshable listener) {
    final config = _pollingConfigs[listener];
    if (config == null || config.timer != null) return;

    config.timer = Timer.periodic(config.interval, (_) async {
      if (!_isConnected) return;

      // Double-check actual reachability in case the stream missed a change
      final reachable = await _connectivityService.checkConnection();
      if (!reachable) return;

      // Avoid overlapping refresh() calls for this listener
      if (config.isRefreshing) return;

      config.isRefreshing = true;
      try {
        unawaited(listener.refresh());
      } catch (e, stack) {
        _logger.warning('PollingService: Error during refresh for $listener', e, stack);
      } finally {
        config.isRefreshing = false;
      }
    });
  }

  void _triggerOnce(Refreshable listener, _PollingConfig config) {
    if (config.isRefreshing) return;
    config.isRefreshing = true;

    // Do not block caller; run shortly after current event loop turn
    scheduleMicrotask(() async {
      try {
        if (_isConnected && await _connectivityService.checkConnection()) {
          unawaited(listener.refresh());
        }
      } catch (e, stack) {
        _logger.warning('PollingService: Error during initial refresh for $listener', e, stack);
      } finally {
        config.isRefreshing = false;
      }
    });
  }

  @override
  Future<void> dispose() async {
    for (final config in _pollingConfigs.values) {
      config.timer?.cancel();
    }
    _pollingConfigs.clear();
    _connectivitySubscription.cancel();
  }
}

class _PollingConfig {
  _PollingConfig({required this.interval});

  Duration interval;
  Timer? timer;

  /// Guards against concurrent refresh() for this listener.
  bool isRefreshing = false;
}

/// Helper model to pass initial registrations to constructor
class PollingRegistration {
  const PollingRegistration({
    required this.listener,
    required this.interval,
  });

  final Refreshable listener;
  final Duration interval;
}
