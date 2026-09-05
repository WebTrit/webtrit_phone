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
    this.duplicateSuppressionWindow = const Duration(seconds: 3),
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

  /// A scheduled run landing within this window after a listener's last
  /// success is skipped: it would re-download data another entry point (a
  /// manual refresh, a racing leading cycle) fetched moments ago.
  final Duration duplicateSuppressionWindow;
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
class PollingService with WidgetsBindingObserver implements Disposable {
  PollingService({
    required ConnectivityService connectivityService,
    List<PollingRegistration> registrations = const [],
    PollingOptions options = const PollingOptions(),
    Jitter? jitter,
    BackoffPolicy? backoff,
  }) : _connectivityService = connectivityService,
       _options = options,
       _jitter = jitter ?? RandomJitter(maxMs: options.jitterMaxMs),
       _backoff = backoff ?? const ExponentialBackoff(),
       _reachability = TtlCache<bool>(ttl: options.reachabilityTtl) {
    _connectivitySub = _connectivityService.connectionStream.listen(_handleConnectivityChange);

    for (final reg in registrations) {
      register(reg);
    }

    _initializePollingIfConnected();

    // The service observes app lifecycle itself (registered for its own
    // lifetime, released in [dispose]) so its owner does not have to forward
    // [didChangeAppLifecycleState] by hand.
    WidgetsBinding.instance.addObserver(this);
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

  // Connectivity state applied last, null until the first report. Every
  // piece of connectivity evidence - stream events and the boot probe - is
  // applied through [_handleConnectivityChange] in completion order, and only
  // an actual state change starts a leading cycle, so a late or repeated
  // report can neither double the cycle nor wedge the state.
  bool? _lastAppliedConnected;

  // Bumped on every applied connectivity change; a reachability probe that
  // resolves under an older epoch is stale and must not write its result
  // into [_reachability].
  int _connectivityEpoch = 0;

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
    final config = _pollingConfigs.putIfAbsent(listener, () => _PollingConfig(interval: newInterval));

    final intervalChanged = config.interval != newInterval;
    config.interval = newInterval;

    if (intervalChanged) {
      // Cancel previous schedule (even mid-tick); do not trigger immediate refresh here.
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
  @override
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
    WidgetsBinding.instance.removeObserver(this);
    _disposed = true;
    _stopAllTimers();
    _pollingConfigs.clear();
    await _connectivitySub.cancel();
  }

  bool get _shouldRunTimers => !_disposed && _isConnected && (!_options.pauseInBackground || _isForeground);

  Future<void> _initializePollingIfConnected() async {
    if (_disposed) return;
    _logger.info('PollingService: Initializing polling...');
    final connected = await _connectivityService.checkConnection();
    if (_disposed) return;
    // The boot probe is just one more piece of connectivity evidence: route
    // it through the same single-writer path as stream events.
    _handleConnectivityChange(connected);
  }

  void _handleConnectivityChange(bool connected) {
    if (_disposed) return;

    final changed = connected != _lastAppliedConnected;
    _lastAppliedConnected = connected;
    _isConnected = connected;
    if (!changed) return;

    _connectivityEpoch++;
    // The report that carried this state was itself produced by a liveness
    // probe, so seed the cache with it instead of probing again right away.
    _reachability.set(connected);

    if (_shouldRunTimers) {
      // On boot/(re)connect: group-leading sharing that fresh reachability result.
      unawaited(_runLeadingForAll(forceCheck: false));
    } else {
      _stopAllTimers();
    }
  }

  void _stopAllTimers() {
    for (final c in _pollingConfigs.values) {
      c.scheduler.cancel();
      // Do not clear isRefreshing here: a refresh may still be in flight and
      // its own finally clears the flag; forcing it false would let a resume
      // leading cycle start an overlapping refresh of the same listener.
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
    if (config == null || _disposed || config.scheduler.isActive) return;

    FutureOr<Duration> onTick() async {
      if (_disposed || !_shouldRunTimers || _pollingConfigs[listener] != config) {
        return _nextDelay(config);
      }

      final reachable = await _isReachable();
      if (_disposed) return _nextDelay(config);

      if (!listener.isActive) {
        unregister(listener);
        return _nextDelay(config);
      }

      if (reachable && !config.isRefreshing && !_justRefreshed(config)) {
        await _runListenerRefresh(listener, config, countFailureTowardsBackoff: true);
      }

      return _nextDelay(config); // backoff + jitter for the next tick
    }

    // First scheduled tick after leading uses _nextDelay(config), not Duration.zero.
    config.scheduler.start(_nextDelay(config), onTick);
  }

  /// Leading refresh for a listener that **does not** perform its own reachability check.
  /// It uses a known result [reachable] that was computed once for the entire leading cycle.
  void _triggerOnceWithKnownReachability(Refreshable listener, _PollingConfig config, bool reachable) {
    if (_disposed || config.isRefreshing) return;

    // Cancel any pending schedule to avoid firing with an outdated cadence.
    config.scheduler.cancel();

    scheduleMicrotask(() async {
      if (_disposed) return;
      try {
        if (_shouldRunTimers && reachable && !config.isRefreshing) {
          if (!listener.isActive) {
            unregister(listener);
            return;
          }
          if (!_justRefreshed(config)) {
            await _runListenerRefresh(listener, config, countFailureTowardsBackoff: true);
          }
        }
      } finally {
        // _startPolling itself refuses a dead service, a foreign config and
        // an already-active chain, so only the timers gate is checked here.
        if (_shouldRunTimers && _pollingConfigs[listener] == config) {
          _startPolling(listener); // schedules next run via FixedDelayScheduler
        }
      }
    });
  }

  /// Whether [config] finished a successful run so recently that another
  /// one now would be a duplicate download rather than fresh data.
  bool _justRefreshed(_PollingConfig config) {
    final lastSuccessAt = config.lastSuccessAt;
    return lastSuccessAt != null && clock.now().difference(lastSuccessAt) < _options.duplicateSuppressionWindow;
  }

  /// The one refresh-cycle body every entry point runs: latch, execute,
  /// record the outcome. Scheduled runs feed their failures into the backoff
  /// counter; a manual run does not ([countFailureTowardsBackoff]), so a
  /// user's retries cannot starve the automatic schedule, while its success
  /// still resets the counter - a completed fetch is proof of recovery.
  Future<void> _runListenerRefresh(
    Refreshable listener,
    _PollingConfig config, {
    required bool countFailureTowardsBackoff,
    bool rethrowError = false,
  }) async {
    config.isRefreshing = true;
    final run = listener.refresh();
    config.inFlight = run;
    try {
      await run;
      _logger.finest('PollingService: refresh() succeeded for $listener');
      config.consecutiveErrors = 0;
      config.lastSuccessAt = clock.now();
    } catch (e) {
      _logger.warning('PollingService: refresh() failed for $listener', e);
      if (countFailureTowardsBackoff) config.consecutiveErrors++;
      if (rethrowError) rethrow;
    } finally {
      config.isRefreshing = false;
      config.inFlight = null;
    }
  }

  /// Immediate, caller-driven refresh of a registered [listener].
  ///
  /// Runs outside the reachability gate - a user-driven refresh must attempt
  /// the network and surface its failure rather than silently skip - and
  /// reschedules the periodic loop from its completion, so the next tick
  /// lands a full interval away. A run already in flight is joined: the
  /// returned future completes when that cycle does and shares its error.
  /// Manual failures do not feed the scheduled loop's backoff.
  Future<void> refreshListener(Refreshable listener) async {
    if (_disposed) return;
    final config = _pollingConfigs[listener];
    if (config == null) {
      throw ArgumentError.value(listener, 'listener', 'is not registered with this PollingService');
    }

    final inFlight = config.inFlight;
    if (inFlight != null) return inFlight;

    if (!listener.isActive) {
      unregister(listener);
      return;
    }

    try {
      await _runListenerRefresh(listener, config, countFailureTowardsBackoff: false, rethrowError: true);
      // A completed fetch is the strongest liveness evidence there is; seed
      // the cache so the rescheduled tick does not probe again immediately.
      _reachability.set(true);
    } finally {
      // The schedule is touched only after the run: cancelling before it
      // would leave the listener without a loop if the run never completed.
      config.scheduler.cancel();
      if (_shouldRunTimers && _pollingConfigs[listener] == config) {
        _startPolling(listener);
      }
    }
  }

  /// Reachability check with TTL cache. When [force] is true, the cache is ignored.
  Future<bool> _isReachable({bool force = false}) async {
    if (!force && !_options.verifyReachabilityOnTick) return _isConnected;

    final cached = !force ? _reachability.value : null;
    if (cached != null) return cached;

    _logger.fine('PollingService: Checking reachability...');
    final epoch = _connectivityEpoch;
    final r = await _connectivityService.checkConnection();
    if (_connectivityEpoch == epoch) {
      _reachability.set(r);
    }
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

  /// The run currently in flight, so a concurrent caller can join it and
  /// complete (or fail) together with it instead of returning early.
  Future<void>? inFlight;

  // Backoff input and the duplicate-suppression anchor; failures are logged
  // rather than stored.
  int consecutiveErrors = 0;
  DateTime? lastSuccessAt;
}

/// A registration for a [Refreshable] listener with a specific polling [interval].
class PollingRegistration {
  const PollingRegistration({required this.listener, required this.interval});

  final Refreshable listener;
  final Duration interval;
}
