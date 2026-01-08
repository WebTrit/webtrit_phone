/// A generic utility to cache a value for a specific duration [ttl].
class ExpiringCache<T> {
  final Duration ttl;

  final T Function() compute;

  T? _cachedValue;

  DateTime? _lastFetchTime;

  ExpiringCache({required this.ttl, required this.compute});

  /// Returns the cached value if valid, otherwise computes a new one.
  T get value {
    final now = DateTime.now();

    final isCacheEmpty = _cachedValue == null;
    final isExpired = _lastFetchTime == null || now.difference(_lastFetchTime!) > ttl;

    if (isCacheEmpty || isExpired) {
      _cachedValue = compute();
      _lastFetchTime = now;
    }

    return _cachedValue!;
  }

  /// Forces the cache to expire immediately.
  void invalidate() {
    _cachedValue = null;
    _lastFetchTime = null;
  }
}
