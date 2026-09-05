import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';
import 'package:webtrit_phone/services/polling_task_handle.dart';
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

  /// Register a [listener] with a polling [interval] and return its stable handle.
  ///
  /// If the listener already exists and the interval changes, the schedule is
  /// restarted **without** an extra leading call. For a brand-new listener,
  /// a **group-leading** cycle runs (one reachability check shared by all listeners).
  /// Re-registering the same listener returns the same [PollingTaskHandle].
  PollingTaskHandle register(PollingRegistration registration) {
    if (_disposed) {
      throw StateError('Cannot register a polling task after PollingService.dispose().');
    }

    final listener = registration.listener;
    final newInterval = registration.interval;

    final existed = _pollingConfigs.containsKey(listener);
    final config = _pollingConfigs.putIfAbsent(listener, () {
      final config = _PollingConfig(interval: newInterval);
      config.handle = _PollingTaskHandle(
        runNow: () => _runNow(listener, config),
        unregister: () => unregister(listener),
      );
      return config;
    });

    final intervalChanged = config.interval != newInterval;
    config.interval = newInterval;

    if (intervalChanged) {
      // Cancel previous schedule (even mid-tick); do not trigger immediate refresh here.
      config.scheduleEpoch++;
      config.scheduler.cancel();
    }

    if (!_shouldRunTimers) return config.handle;

    if (!existed) {
      // New listener: run group-leading once for all listeners (single reachability check).
      // We don't force a fresh check if cache was just updated on boot/resume.
      unawaited(_runLeadingForAll(forceCheck: false));
    } else if (intervalChanged) {
      // Existing listener with new interval: just restart its loop without a leading refresh.
      _startPolling(listener); // schedules next run via FixedDelayScheduler
    }
    // If existed && !intervalChanged — nothing to do.

    return config.handle;
  }

  /// Unregister a [listener] and cancel its schedule.
  void unregister(Refreshable listener) {
    final config = _pollingConfigs.remove(listener);
    if (config == null) return;

    config.scheduleEpoch++;
    config.scheduler.cancel();
    unawaited(config.handle.stop());
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

    final configs = _pollingConfigs.values.toList(growable: false);
    _pollingConfigs.clear();
    await Future.wait([_connectivitySub.cancel(), ...configs.map((config) => config.handle.stop())]);
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
      c.scheduleEpoch++;
      c.scheduler.cancel();
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

    final scheduleEpoch = config.scheduleEpoch;

    FutureOr<Duration> onTick() async {
      if (!_isCurrentSchedule(listener, config, scheduleEpoch)) {
        return _nextDelay(config);
      }

      final reachable = await _isReachable();
      if (!_isCurrentSchedule(listener, config, scheduleEpoch)) {
        return _nextDelay(config);
      }

      if (!listener.isActive) {
        unregister(listener);
        return _nextDelay(config);
      }

      if (reachable && config.inFlight == null) {
        try {
          await _runRefreshCycle(listener, config, trigger: _PollingTrigger.scheduled);
        } catch (_) {
          // The cycle already published and logged the scheduled failure.
        }
      }

      return _nextDelay(config); // backoff + jitter for the next tick
    }

    // First scheduled tick after leading uses _nextDelay(config), not Duration.zero.
    config.scheduler.start(_nextDelay(config), onTick);
  }

  /// Leading refresh for a listener that **does not** perform its own reachability check.
  /// It uses a known result [reachable] that was computed once for the entire leading cycle.
  void _triggerOnceWithKnownReachability(Refreshable listener, _PollingConfig config, bool reachable) {
    if (_disposed || _pollingConfigs[listener] != config) return;

    // Cancel any pending schedule to avoid firing with an outdated cadence.
    config.scheduleEpoch++;
    config.scheduler.cancel();

    scheduleMicrotask(() async {
      try {
        if (_shouldRunTimers && reachable && _pollingConfigs[listener] == config) {
          if (!listener.isActive) {
            unregister(listener);
            return;
          }

          if (config.inFlight == null) {
            try {
              await _runRefreshCycle(listener, config, trigger: _PollingTrigger.leading);
            } catch (_) {
              // The cycle already published and logged the scheduled failure.
            }
          }
        }
      } finally {
        final shouldSchedule = !_disposed && _shouldRunTimers && _pollingConfigs[listener] == config;

        if (shouldSchedule && !config.scheduler.isActive) {
          _startPolling(listener); // schedules next run via FixedDelayScheduler
        }
      }
    });
  }

  /// Run immediately or join the listener's current refresh cycle, then place
  /// the next periodic tick one full computed delay after that cycle.
  Future<void> _runNow(Refreshable listener, _PollingConfig config) async {
    if (_disposed || _pollingConfigs[listener] != config || !config.handle.isRegistered) {
      throw StateError('This polling task is no longer registered.');
    }

    if (!listener.isActive) {
      unregister(listener);
      throw StateError('Cannot run an inactive polling task.');
    }

    final joiningInFlight = config.inFlight != null;
    config.scheduleEpoch++;

    // An in-flight scheduled tick already owns its scheduler chain. Canceling
    // here invalidates that continuation while preserving the refresh future
    // that this manual call is about to join.
    if (joiningInFlight) config.scheduler.cancel();

    try {
      await _runRefreshCycle(listener, config, trigger: _PollingTrigger.manual);
    } finally {
      if (!_disposed && _pollingConfigs[listener] == config) {
        config.scheduleEpoch++;
        config.scheduler.cancel();
        if (_shouldRunTimers) _startPolling(listener);
      }
    }
  }

  /// The only path that invokes [Refreshable.refresh]. It publishes state and
  /// gives all manual callers the same in-flight future.
  Future<void> _runRefreshCycle(Refreshable listener, _PollingConfig config, {required _PollingTrigger trigger}) {
    final inFlight = config.inFlight;
    if (inFlight != null) return inFlight;

    final completer = Completer<void>();
    config.inFlight = completer.future;

    final startedAt = clock.now();
    config.handle.emit(
      PollingTaskState(
        phase: PollingTaskPhase.running,
        lastStartedAt: startedAt,
        lastSuccessAt: config.lastSuccessAt,
        lastFailureAt: config.lastFailureAt,
      ),
    );

    unawaited(() async {
      try {
        await Future.sync(listener.refresh);

        final completedAt = clock.now();
        config.consecutiveErrors = 0;
        config.lastSuccessAt = completedAt;
        config.handle.emit(
          PollingTaskState(
            phase: PollingTaskPhase.succeeded,
            lastStartedAt: startedAt,
            lastSuccessAt: completedAt,
            lastFailureAt: config.lastFailureAt,
          ),
        );
        _logger.finest('PollingService: ${trigger.name} refresh succeeded for $listener');
        completer.complete();
      } catch (error, stackTrace) {
        if (trigger != _PollingTrigger.manual) config.consecutiveErrors++;

        final completedAt = clock.now();
        config.lastFailureAt = completedAt;
        config.handle.emit(
          PollingTaskState(
            phase: PollingTaskPhase.failed,
            lastStartedAt: startedAt,
            lastSuccessAt: config.lastSuccessAt,
            lastFailureAt: completedAt,
            error: error,
            stackTrace: stackTrace,
          ),
        );
        _logger.warning('PollingService: ${trigger.name} refresh failed for $listener', error, stackTrace);
        completer.completeError(error, stackTrace);
      } finally {
        if (identical(config.inFlight, completer.future)) {
          config.inFlight = null;
        }
      }
    }());

    return completer.future;
  }

  bool _isCurrentSchedule(Refreshable listener, _PollingConfig config, int scheduleEpoch) {
    return !_disposed &&
        _shouldRunTimers &&
        _pollingConfigs[listener] == config &&
        config.scheduleEpoch == scheduleEpoch;
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

enum _PollingTrigger { leading, scheduled, manual }

/// Internal per-listener state.
class _PollingConfig {
  _PollingConfig({required this.interval}) : scheduler = FixedDelayScheduler();

  /// Base polling interval for this listener.
  Duration interval;

  /// Fixed-delay scheduler that guarantees no overlapping runs.
  final FixedDelayScheduler scheduler;

  /// Stable public capability for this registration.
  late final _PollingTaskHandle handle;

  /// Shared future for the listener's current refresh cycle.
  Future<void>? inFlight;

  /// Invalidates ticks that crossed an async boundary under an older schedule.
  int scheduleEpoch = 0;

  // Observability / backoff
  int consecutiveErrors = 0;
  DateTime? lastSuccessAt;
  DateTime? lastFailureAt;
}

class _PollingTaskHandle implements PollingTaskHandle {
  _PollingTaskHandle({required Future<void> Function() runNow, required void Function() unregister})
    : _runNow = runNow,
      _unregister = unregister;

  final Future<void> Function() _runNow;
  final void Function() _unregister;
  final BehaviorSubject<PollingTaskState> _states = BehaviorSubject.seeded(
    const PollingTaskState(phase: PollingTaskPhase.idle),
  );

  bool _isRegistered = true;

  @override
  bool get isRegistered => _isRegistered;

  @override
  PollingTaskState get state => _states.value;

  @override
  Stream<PollingTaskState> get states => _states.stream;

  @override
  Future<void> runNow() {
    if (!_isRegistered) {
      return Future.error(StateError('This polling task is no longer registered.'));
    }
    return _runNow();
  }

  @override
  void unregister() {
    if (_isRegistered) _unregister();
  }

  void emit(PollingTaskState state) {
    if (_isRegistered) _states.add(state);
  }

  Future<void> stop() async {
    if (!_isRegistered) return;

    _isRegistered = false;
    final previous = state;
    _states.add(
      PollingTaskState(
        phase: PollingTaskPhase.stopped,
        lastStartedAt: previous.lastStartedAt,
        lastSuccessAt: previous.lastSuccessAt,
        lastFailureAt: previous.lastFailureAt,
        error: previous.error,
        stackTrace: previous.stackTrace,
      ),
    );
    await _states.close();
  }
}

/// A registration for a [Refreshable] listener with a specific polling [interval].
class PollingRegistration {
  const PollingRegistration({required this.listener, required this.interval});

  final Refreshable listener;
  final Duration interval;
}
