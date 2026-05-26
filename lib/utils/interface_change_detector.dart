import 'package:connectivity_plus/connectivity_plus.dart';

/// A primary connectivity transition between two live (non-none) interfaces.
class NetworkInterfaceChange {
  const NetworkInterfaceChange({required this.previous, required this.current});

  final ConnectivityResult previous;
  final ConnectivityResult current;

  @override
  String toString() => '$previous -> $current';
}

/// Stateful detector of network interface changes with cooldown debounce.
///
/// Feed every primary [ConnectivityResult] (the first non-none entry from
/// connectivity_plus) into [update]; the detector returns a
/// [NetworkInterfaceChange] only when the primary moves between two live
/// interfaces and the previous emission is older than [debounce] - null
/// otherwise. The previous primary is remembered across `none` results so a
/// drop+restore of the same interface is not reported as a change; an actual
/// switch (e.g. WiFi -> LTE) through a brief `none` is.
class InterfaceChangeDetector {
  InterfaceChangeDetector({
    Duration debounce = const Duration(seconds: 2),
    DateTime Function() now = DateTime.now,
  }) : _debounce = debounce,
       _now = now;

  final Duration _debounce;
  final DateTime Function() _now;

  ConnectivityResult? _lastPrimary;
  DateTime? _lastChangeAt;

  /// Records [primary] and returns a [NetworkInterfaceChange] when this update
  /// represents a real interface change (debounced). Returns null otherwise.
  ///
  /// Pass [ConnectivityResult.none] for offline events - the last primary is
  /// preserved so the next non-none result can be compared against the prior
  /// interface.
  NetworkInterfaceChange? update(ConnectivityResult primary) {
    if (primary == ConnectivityResult.none) return null;
    final previous = _lastPrimary;
    _lastPrimary = primary;
    if (previous == null || previous == primary) return null;
    final now = _now();
    final lastAt = _lastChangeAt;
    if (lastAt != null && now.difference(lastAt) <= _debounce) return null;
    _lastChangeAt = now;
    return NetworkInterfaceChange(previous: previous, current: primary);
  }
}
