/// A utility class to manage concurrent asynchronous operations based on unique keys.
///
/// It ensures that only one operation for a specific key runs at a time.
/// Subsequent attempts to run an operation with the same key are ignored
/// until the ongoing operation completes.
class AsyncKeyLock {
  final _pendingKeys = <String>{};

  /// Executes the provided asynchronous [action] exclusively for the given [key].
  ///
  /// If an operation associated with [key] is already in progress, this method returns immediately
  /// without executing the [action].
  ///
  /// The lock for the [key] is automatically released when the [action] completes,
  /// regardless of whether it succeeded or failed.
  void runExclusive(String key, Future<void> Function() action) {
    if (_pendingKeys.contains(key)) return;

    _pendingKeys.add(key);

    action().whenComplete(() {
      _pendingKeys.remove(key);
    });
  }

  /// Returns `true` if an operation for the specified [key] is currently in progress.
  bool isLocked(String key) => _pendingKeys.contains(key);
}

/// A mixin that provides [AsyncKeyLock] capabilities to any class.
mixin AsyncKeyLockMixin {
  final _asyncKeyLock = AsyncKeyLock();

  /// Executes [action] only if there is no pending operation for [key].
  /// See [AsyncKeyLock.runExclusive] for details.
  void runExclusive(String key, Future<void> Function() action) {
    _asyncKeyLock.runExclusive(key, action);
  }

  /// Checks if [key] is currently locked.
  bool isLocked(String key) => _asyncKeyLock.isLocked(key);
}
