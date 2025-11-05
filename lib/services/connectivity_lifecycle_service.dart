import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';

/// Options that control how [ConnectivityLifecycleService] reacts to connectivity changes.
class ConnectivityLifecycleOptions {
  const ConnectivityLifecycleOptions({
    this.debounce = const Duration(milliseconds: 250),
    this.runOnStart = false,
    this.onlineStabilizationDelay = const Duration(milliseconds: 0),
    this.parallelism = Parallelism.sequential,
    this.perListenerTimeout,
    this.jitterMaxMs = 0,
  });

  /// Debounce window for successive connectivity events.
  /// Helps when the OS emits multiple quick "online/offline" flips.
  final Duration debounce;

  /// If `true`, perform the appropriate action (refresh/suspend) immediately
  /// based on the current connectivity state when the service starts.
  final bool runOnStart;

  /// Optional delay after going online before calling refreshers.
  /// Useful to let DNS/TLS/wifi settle before hammering backends.
  final Duration onlineStabilizationDelay;

  /// Whether listeners are executed sequentially (default) or concurrently.
  final Parallelism parallelism;

  /// Optional per-listener timeout. If set, a slow listener won't block the rest.
  final Duration? perListenerTimeout;

  /// Optional jitter (milliseconds) applied per listener to avoid thundering herds.
  /// Set to 0 for deterministic tests.
  final int jitterMaxMs;
}

enum Parallelism { sequential, concurrent }

final _logger = Logger('ConnectivityLifecycleService');

/// Reacts to connectivity changes:
/// - when goes **online** → calls `refresh()` on registered [Refreshable]s
/// - when goes **offline** → calls `suspend()` on registered [Suspendable]s
///
/// Improvements over a naive implementation:
/// - Debounces flapping network events
/// - Optional “stabilization delay” before refreshing after going online
/// - Optional per-listener timeout to prevent a single slow task from blocking others
/// - Optional listener jitter and concurrent execution to avoid stampedes
/// - Registration returns a disposer for easy unregistration
class ConnectivityLifecycleService implements Disposable {
  ConnectivityLifecycleService({
    required ConnectivityService connectivity,
    Iterable<ConnectivityRecoveryRegistration> registrations = const [],
    this.options = const ConnectivityLifecycleOptions(),
    Random? random, // for jitter; inject a seeded Random in tests if needed
  }) : _connectivityService = connectivity,
       _rand = random ?? Random() {
    _subscription = _connectivityService.connectionStream.listen(_onConnectivityChanged);

    for (final r in registrations) {
      register(r);
    }

    // Optionally run once on startup according to current state.
    if (options.runOnStart) {
      unawaited(_connectivityService.checkConnection().then(_onConnectivityChanged));
    }
  }

  final ConnectivityService _connectivityService;
  final ConnectivityLifecycleOptions options;
  final Random _rand;

  late final StreamSubscription<bool> _subscription;

  final Set<Refreshable> _refreshables = <Refreshable>{};
  final Set<Suspendable> _suspendables = <Suspendable>{};

  bool _isDisposed = false;

  // Debounce state
  Timer? _debounceTimer;
  bool? _lastEnqueued; // the last connectivity value we scheduled
  bool? _lastApplied; // the last connectivity value actually applied

  /// Registers a listener described by [registration].
  /// Returns a disposer you can call to unregister later.
  ///
  /// It is safe to register the same [Refreshable]/[Suspendable] multiple times;
  /// duplicates are ignored by the internal [Set]s.
  VoidCallback register(ConnectivityRecoveryRegistration registration) {
    if (_isDisposed) return () {};

    if (registration.refreshable != null) {
      _refreshables.add(registration.refreshable!);
    }
    if (registration.suspendable != null) {
      _suspendables.add(registration.suspendable!);
    }

    return () => unregister(registration);
  }

  /// Unregisters a previously registered listener.
  void unregister(ConnectivityRecoveryRegistration registration) {
    if (_isDisposed) return;

    if (registration.refreshable != null) {
      _refreshables.remove(registration.refreshable);
    }
    if (registration.suspendable != null) {
      _suspendables.remove(registration.suspendable);
    }
  }

  /// Internal: debounced handler for connectivity changes.
  Future<void> _onConnectivityChanged(bool connected) async {
    if (_isDisposed) return;

    if (_lastApplied == connected && _debounceTimer == null) return;

    _lastEnqueued = connected;
    _debounceTimer?.cancel();

    if (options.debounce == Duration.zero) {
      scheduleMicrotask(() async {
        if (_isDisposed) return;
        _debounceTimer = null;
        _lastApplied = _lastEnqueued;

        if (_lastApplied == true) {
          if (options.onlineStabilizationDelay > Duration.zero) {
            await Future<void>.delayed(options.onlineStabilizationDelay);
            if (_isDisposed) return;
          }
          await refreshAll();
        } else {
          await suspendAll();
        }
      });
      return;
    }

    _debounceTimer = Timer(options.debounce, () async {
      final target = _lastEnqueued;
      _debounceTimer = null;
      if (target == null) return;
      _lastApplied = target;

      if (target) {
        if (options.onlineStabilizationDelay > Duration.zero) {
          await Future<void>.delayed(options.onlineStabilizationDelay);
          if (_isDisposed) return;
        }
        await refreshAll();
      } else {
        await suspendAll();
      }
    });
  }

  /// Manually trigger refresh on all [Refreshable] listeners.
  /// Obeys [options.parallelism], [options.perListenerTimeout], and [options.jitterMaxMs].
  Future<void> refreshAll() async {
    if (_isDisposed || _refreshables.isEmpty) return;

    final snapshot = List<Refreshable>.unmodifiable(_refreshables);

    if (options.parallelism == Parallelism.concurrent) {
      await _runConcurrent<Refreshable>(snapshot, (r) => r.refresh());
    } else {
      await _runSequential<Refreshable>(snapshot, (r) => r.refresh());
    }
  }

  /// Manually trigger suspend on all [Suspendable] listeners.
  /// Obeys [options.parallelism], [options.perListenerTimeout], and [options.jitterMaxMs].
  Future<void> suspendAll() async {
    if (_isDisposed || _suspendables.isEmpty) return;

    final snapshot = List<Suspendable>.unmodifiable(_suspendables);

    if (options.parallelism == Parallelism.concurrent) {
      await _runConcurrent<Suspendable>(snapshot, (s) => s.suspend());
    } else {
      await _runSequential<Suspendable>(snapshot, (s) => s.suspend());
    }
  }

  // Execute tasks one by one, with optional jitter and per-listener timeout.
  Future<void> _runSequential<T>(List<T> items, Future<void> Function(T item) run) async {
    for (final item in items) {
      if (_isDisposed) return;

      // Optional jitter to avoid thundering herds
      if (options.jitterMaxMs > 0) {
        await Future<void>.delayed(Duration(milliseconds: _rand.nextInt(options.jitterMaxMs)));
        if (_isDisposed) return;
      }

      try {
        if (options.perListenerTimeout != null) {
          await _withTimeout(run(item), options.perListenerTimeout!);
        } else {
          await run(item);
        }
      } catch (e, st) {
        _logger.warning('ConnectivityLifecycleService: listener task failed', e, st);
      }
    }
  }

  // Execute tasks concurrently, each with optional jitter and per-listener timeout.
  Future<void> _runConcurrent<T>(List<T> items, Future<void> Function(T item) run) async {
    final futures = <Future<void>>[];
    for (final item in items) {
      futures.add(() async {
        if (_isDisposed) return;

        if (options.jitterMaxMs > 0) {
          await Future<void>.delayed(Duration(milliseconds: _rand.nextInt(options.jitterMaxMs)));
          if (_isDisposed) return;
        }

        try {
          if (options.perListenerTimeout != null) {
            await _withTimeout(run(item), options.perListenerTimeout!);
          } else {
            await run(item);
          }
        } catch (e, st) {
          _logger.warning('ConnectivityLifecycleService: listener task failed', e, st);
        }
      }());
    }
    await Future.wait(futures, eagerError: false);
  }

  Future<void> _withTimeout(Future<void> f, Duration timeout) {
    return f.timeout(
      timeout,
      onTimeout: () {
        throw TimeoutException('Listener task exceeded $timeout');
      },
    );
  }

  @override
  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;

    _debounceTimer?.cancel();
    await _subscription.cancel();
    _refreshables.clear();
    _suspendables.clear();
  }
}

/// Model that describes a listener to register for connectivity recovery.
class ConnectivityRecoveryRegistration {
  final Refreshable? refreshable;
  final Suspendable? suspendable;

  const ConnectivityRecoveryRegistration({this.refreshable, this.suspendable})
    : assert(refreshable != null || suspendable != null, 'At least one listener must be provided');

  /// Convenience factory for Refreshable-only registration.
  factory ConnectivityRecoveryRegistration.refreshable(Refreshable r) =>
      ConnectivityRecoveryRegistration(refreshable: r);

  /// Convenience factory for Suspendable-only registration.
  factory ConnectivityRecoveryRegistration.suspendable(Suspendable s) =>
      ConnectivityRecoveryRegistration(suspendable: s);
}
