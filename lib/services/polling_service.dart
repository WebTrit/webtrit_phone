import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('PollingService');

/// Configuration options for [PollingService].
///
/// - [pauseInBackground] — if `true`, timers stop while the app is in background
///   (handled via [didChangeAppLifecycleState]).
/// - [verifyReachabilityOnTick] — if `true`, each tick verifies connectivity
///   using [ConnectivityService.checkConnection] with a TTL cache.
/// - [reachabilityTtl] — TTL for the reachability cache.
/// - [leadingRefreshRequiresVerify] — if `true`, boot/resume/reconnect runs a
///   single fresh connectivity check (shared across all listeners for that cycle).
/// - [jitterMaxMs] — maximum jitter in milliseconds added to intervals/backoff
///   to stagger calls (set to 0 in tests for determinism).
/// - [maxBackoff] — maximum delay applied when exponential backoff is triggered
///   due to repeated errors (caps the backoff growth).
class PollingOptions {
  const PollingOptions({
    this.pauseInBackground = true,
    this.verifyReachabilityOnTick = true,
    this.reachabilityTtl = const Duration(seconds: 30),
    this.leadingRefreshRequiresVerify = true,
    this.jitterMaxMs = 400,
    this.maxBackoff = const Duration(minutes: 5),
  });

  /// Stop timers while app is backgrounded (via didChangeAppLifecycleState).
  final bool pauseInBackground;

  /// If true, call ConnectivityService.checkConnection() before each tick (with TTL cache).
  final bool verifyReachabilityOnTick;

  /// TTL for reachability cache.
  final Duration reachabilityTtl;

  /// If true, leading refresh (on boot/connect/resume) verifies reachability freshly.
  final bool leadingRefreshRequiresVerify;

  /// Max random jitter (ms).
  final int jitterMaxMs;

  /// Maximum backoff duration when errors accumulate.
  final Duration maxBackoff;
}

/// Periodic polling service that calls `refresh()` on registered [Refreshable] listeners,
/// accounting for:
/// - network reachability with TTL cache,
/// - app lifecycle (pause in background, resume in foreground),
/// - “leading” refresh on boot/resume/reconnect (single reachability check shared across all listeners),
/// - exponential backoff on consecutive errors,
/// - jitter to spread load.
///
/// Key properties:
/// - **No overlapping calls**: next tick is scheduled only after the previous one finishes
///   (via [FixedDelayScheduler]).
/// - **One reachability check per leading cycle** (boot/resume/reconnect).
/// - **Interval reconfiguration**: re-registering the same listener with a different interval
///   restarts its schedule without an extra leading call.
///
/// Typical use cases:
/// - polling a backend or repository on a base interval,
/// - immediate refresh when network is restored / app resumes,
/// - load control: backoff on errors + jitter.
class PollingService implements Disposable {
  PollingService({
    required ConnectivityService connectivityService,
    List<PollingRegistration> registrations = const [],
    PollingOptions options = const PollingOptions(),
    Jitter? jitter,
    BackoffPolicy? backoff,
  })  : _connectivityService = connectivityService,
        _options = options,
        _jitter = jitter ?? RandomJitter(maxMs: options.jitterMaxMs),
        _backoff = backoff ?? const ExponentialBackoff(),
        _reachability = TtlCache<bool>(ttl: options.reachabilityTtl) {
    _connectivitySub = _connectivityService.connectionStream.listen(_handleConnectivityChange);

    for (final reg in registrations) {
      register(reg);
    }

    _initializePollingIfConnected();
  }

  final ConnectivityService _connectivityService;
  final PollingOptions _options;
  final Jitter _jitter;
  final BackoffPolicy _backoff;
  final TtlCache<bool> _reachability;

  late final StreamSubscription<bool> _connectivitySub;

  bool _isForeground = true;
  bool _isConnected = false;
  bool _disposed = false;

  final Map<Refreshable, _PollingConfig> _pollingConfigs = {};

  /// Register a [listener] with a polling [interval].
  ///
  /// If the listener already exists and the interval changes, the schedule is
  /// restarted **without** an extra leading call. For a brand-new listener,
  /// a **group-leading** cycle runs (one reachability check shared by all listeners).
  void register(PollingRegistration registration) {
    final listener = registration.listener;
    final newInterval = registration.interval;

    final existed = _pollingConfigs.containsKey(listener);
    final config = _pollingConfigs.putIfAbsent(
      listener,
      () => _PollingConfig(interval: newInterval),
    );

    final intervalChanged = config.interval != newInterval;
    config.interval = newInterval;

    if (intervalChanged && config.scheduler.isScheduled) {
      // Cancel previous schedule; do not trigger immediate refresh here.
      config.scheduler.cancel();
    }

    if (!_shouldRunTimers) return;

    if (!existed) {
      // New listener: run group-leading once for all listeners (single reachability check).
      // We don't force a fresh check if cache was just updated on boot/resume.
      unawaited(_runLeadingForAll(forceCheck: false));
    } else if (intervalChanged) {
      // Existing listener with new interval: just restart its loop without a leading refresh.
      _startPolling(listener); // schedules next run via FixedDelayScheduler
    }
    // If existed && !intervalChanged — nothing to do.
  }

  /// Unregister a [listener] and cancel its schedule.
  void unregister(Refreshable listener) {
    final config = _pollingConfigs.remove(listener);
    config?.scheduler.cancel();
  }

  /// Handle app lifecycle transitions. By default:
  /// - background → stop all schedules,
  /// - foreground resume → run **group-leading** (a single fresh reachability check shared across listeners).
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_options.pauseInBackground) return;

    final wasInForeground = _isForeground;
    _isForeground = (state == AppLifecycleState.resumed);

    if (_disposed) return;

    if (_isForeground && !wasInForeground) {
      if (_isConnected) {
        // On resume: run group-leading (one reachability check for all listeners).
        unawaited(_runLeadingForAll(forceCheck: true));
      }
    } else if (!_isForeground && wasInForeground) {
      _stopAllTimers();
    }
  }

  @override
  Future<void> dispose() async {
    _disposed = true;
    _stopAllTimers();
    _pollingConfigs.clear();
    await _connectivitySub.cancel();
  }

  bool get _shouldRunTimers => !_disposed && _isConnected && (!_options.pauseInBackground || _isForeground);

  Future<void> _initializePollingIfConnected() async {
    if (_disposed) return;
    _logger.info('PollingService: Initializing polling...');
    _isConnected = await _connectivityService.checkConnection();
    _reachability.clear(); // start with empty cache; we'll fill it in group-leading

    if (_shouldRunTimers) {
      // On boot: group-leading (one reachability check, then trigger all).
      await _runLeadingForAll(forceCheck: true);
    }
  }

  void _handleConnectivityChange(bool connected) {
    if (_disposed) return;

    _isConnected = connected;
    _reachability.clear();

    if (_shouldRunTimers) {
      // On (re)connect: group-leading (one reachability check for all listeners).
      unawaited(_runLeadingForAll(forceCheck: true));
    } else {
      _stopAllTimers();
    }
  }

  void _stopAllTimers() {
    for (final c in _pollingConfigs.values) {
      c.scheduler.cancel();
      c.isRefreshing = false;
      // Do not reset backoff counters here; they reset on success.
    }
  }

  /// Run a single reachability check (optionally forced) and then trigger a leading refresh
  /// for every registered listener using that known reachability result.
  Future<void> _runLeadingForAll({required bool forceCheck}) async {
    if (_disposed || !_shouldRunTimers) return;

    final reachable = _options.leadingRefreshRequiresVerify ? await _isReachable(force: forceCheck) : true;

    if (_disposed || !_shouldRunTimers) return;

    for (final e in _pollingConfigs.entries) {
      _triggerOnceWithKnownReachability(e.key, e.value, reachable);
    }
  }

  /// Start the fixed-delay loop for a particular [listener].
  /// Each next tick is scheduled **after** the previous one finishes, with optional
  /// backoff (on errors) and jitter (to spread load).
  void _startPolling(Refreshable listener) {
    final config = _pollingConfigs[listener];
    if (config == null || _disposed || config.scheduler.isScheduled) return;

    FutureOr<Duration> onTick() async {
      if (_disposed || !_shouldRunTimers || _pollingConfigs[listener] != config) {
        return _nextDelay(config);
      }

      final reachable = await _isReachable();
      if (_disposed) return _nextDelay(config);

      if (reachable && !config.isRefreshing) {
        config.isRefreshing = true;
        try {
          await listener.refresh();
          _logger.finest('PollingService: refresh() succeeded for $listener');
          config.consecutiveErrors = 0;
          config.lastSuccessAt = clock.now();
        } catch (e, st) {
          config.consecutiveErrors++;
          config.lastError = e;
          config.lastErrorAt = clock.now();
          _logger.warning('PollingService: refresh() failed for $listener', e, st);
        } finally {
          config.isRefreshing = false;
        }
      }

      return _nextDelay(config); // backoff + jitter for the next tick
    }

    // First scheduled tick after leading uses _nextDelay(config), not Duration.zero.
    config.scheduler.start(_nextDelay(config), onTick);
  }

  /// Leading refresh for a listener that **does not** perform its own reachability check.
  /// It uses a known result [reachable] that was computed once for the entire leading cycle.
  void _triggerOnceWithKnownReachability(
    Refreshable listener,
    _PollingConfig config,
    bool reachable,
  ) {
    if (_disposed || config.isRefreshing) return;
    config.isRefreshing = true;

    // Cancel any pending schedule to avoid firing with an outdated cadence.
    config.scheduler.cancel();

    scheduleMicrotask(() async {
      if (_disposed) return;
      try {
        if (_shouldRunTimers && reachable) {
          await listener.refresh();
          _logger.finest('PollingService: leading refresh succeeded for $listener');
          config.consecutiveErrors = 0;
          config.lastSuccessAt = clock.now();
        }
      } catch (e, st) {
        config.consecutiveErrors++;
        config.lastError = e;
        config.lastErrorAt = clock.now();
        _logger.warning('PollingService: leading refresh failed for $listener', e, st);
      } finally {
        config.isRefreshing = false;

        final shouldSchedule = !_disposed && _shouldRunTimers && _pollingConfigs[listener] == config;

        if (shouldSchedule && !config.scheduler.isScheduled) {
          _startPolling(listener); // schedules next run via FixedDelayScheduler
        }
      }
    });
  }

  /// Reachability check with TTL cache. When [force] is true, the cache is ignored.
  Future<bool> _isReachable({bool force = false}) async {
    if (!force && !_options.verifyReachabilityOnTick) return _isConnected;

    final cached = !force ? _reachability.value : null;
    if (cached != null) return cached;

    _logger.fine('PollingService: Checking reachability...');
    final r = await _connectivityService.checkConnection();
    _reachability.set(r);
    return r;
  }

  /// Compute the next delay based on error backoff and jitter.
  Duration _nextDelay(_PollingConfig c) {
    final raw = _backoff.next(c.consecutiveErrors, c.interval, max: _options.maxBackoff);
    return _jitter.add(raw);
  }
}

/// Internal per-listener state.
class _PollingConfig {
  _PollingConfig({required this.interval}) : scheduler = FixedDelayScheduler();

  /// Base polling interval for this listener.
  Duration interval;

  /// Fixed-delay scheduler that guarantees no overlapping runs.
  final FixedDelayScheduler scheduler;

  /// Whether a refresh is currently running.
  bool isRefreshing = false;

  // Observability / backoff
  int consecutiveErrors = 0;
  DateTime? lastSuccessAt;
  DateTime? lastErrorAt;
  Object? lastError;
}

/// A registration for a [Refreshable] listener with a specific polling [interval].
class PollingRegistration {
  const PollingRegistration({
    required this.listener,
    required this.interval,
  });

  final Refreshable listener;
  final Duration interval;
}
