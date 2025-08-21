import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';

final _logger = Logger('ConnectivityLifecycleService');

/// Reacts to connectivity changes:
/// - when goes online -> calls `refresh()` on registered [Refreshable]s
/// - when goes offline -> calls `suspend()` on registered [Suspendable]s
class ConnectivityLifecycleService implements Disposable {
  ConnectivityLifecycleService({
    required ConnectivityService connectivity,
    Iterable<ConnectivityRecoveryRegistration> registrations = const [],
  }) : _connectivityService = connectivity {
    _subscription = _connectivityService.connectionStream.listen(_onConnectivityChanged);

    for (final registration in registrations) {
      register(registration);
    }
  }

  final ConnectivityService _connectivityService;
  late final StreamSubscription<bool> _subscription;

  final Set<Refreshable> _refreshables = <Refreshable>{};
  final Set<Suspendable> _suspendables = <Suspendable>{};

  bool _isDisposed = false;

  /// Registers a listener described by [registration].
  /// Returns a disposer you can call to unregister later.
  void register(ConnectivityRecoveryRegistration registration) {
    if (_isDisposed) return;

    if (registration.refreshable != null) {
      _refreshables.add(registration.refreshable!);
    }
    if (registration.suspendable != null) {
      _suspendables.add(registration.suspendable!);
    }
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

  Future<void> _onConnectivityChanged(bool connected) async {
    if (_isDisposed) return;

    if (connected) {
      await refreshAll();
    } else {
      await suspendAll();
    }
  }

  /// Manually trigger refresh on all [Refreshable] listeners.
  Future<void> refreshAll() async {
    if (_isDisposed || _refreshables.isEmpty) return;

    final snapshot = List<Refreshable>.unmodifiable(_refreshables);
    for (final listener in snapshot) {
      try {
        unawaited(listener.refresh());
      } catch (e, st) {
        _logger.warning('ConnectivityRecoveryService.refreshAll', e, st);
      }
    }
  }

  /// Manually trigger suspend on all [Suspendable] listeners.
  Future<void> suspendAll() async {
    if (_isDisposed || _suspendables.isEmpty) return;

    final snapshot = List<Suspendable>.unmodifiable(_suspendables);
    for (final listener in snapshot) {
      try {
        unawaited(listener.suspend());
      } catch (e, st) {
        _logger.warning('ConnectivityRecoveryService.suspendAll', e, st);
      }
    }
  }

  @override
  Future<void> dispose() async {
    if (!_isDisposed) {
      _isDisposed = true;
      _subscription.cancel();
      _refreshables.clear();
      _suspendables.clear();
    }
  }
}

/// Model that describes a listener to register for connectivity recovery.
class ConnectivityRecoveryRegistration {
  final Refreshable? refreshable;
  final Suspendable? suspendable;

  const ConnectivityRecoveryRegistration({
    this.refreshable,
    this.suspendable,
  }) : assert(
          refreshable != null || suspendable != null,
          'At least one listener must be provided',
        );

  /// Convenience factory for Refreshable-only registration.
  factory ConnectivityRecoveryRegistration.refreshable(Refreshable r) =>
      ConnectivityRecoveryRegistration(refreshable: r);

  /// Convenience factory for Suspendable-only registration.
  factory ConnectivityRecoveryRegistration.suspendable(Suspendable s) =>
      ConnectivityRecoveryRegistration(suspendable: s);
}
