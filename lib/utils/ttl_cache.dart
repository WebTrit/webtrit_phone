import 'package:clock/clock.dart';

/// A simple in-memory cache with time-to-live (TTL).
///
/// Stores a single value of type [T] with an associated timestamp.
/// - If the cached value is older than [ttl], it is considered expired and
///   `value` returns `null`.
/// - Use [set] to put a new value (resets the TTL).
/// - Use [clear] to remove the cached value immediately.
///
/// Example:
/// ```dart
/// final cache = TtlCache<String>(ttl: Duration(seconds: 10));
///
/// cache.set('hello');
/// print(cache.value); // 'hello'
///
/// await Future.delayed(Duration(seconds: 11));
/// print(cache.value); // null (expired)
/// ```
class TtlCache<T> {
  TtlCache({required this.ttl});

  final Duration ttl;

  T? _value;
  DateTime? _ts;

  /// Returns the cached value if it has not expired, otherwise `null`.
  T? get value {
    final now = clock.now();
    if (_value != null && _ts != null && now.difference(_ts!) <= ttl) {
      return _value;
    }
    return null;
  }

  /// Stores a new value and resets the TTL timer.
  void set(T v) {
    _value = v;
    _ts = clock.now();
  }

  /// Clears the cached value immediately.
  void clear() {
    _value = null;
    _ts = null;
  }
}
