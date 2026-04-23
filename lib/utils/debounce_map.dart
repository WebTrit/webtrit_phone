import 'dart:async';

/// Debounces repeated actions keyed by an identifier.
///
/// Calling [schedule] with the same key cancels any pending callback for that
/// key and starts a new [duration] countdown. Useful when the same logical
/// action may be triggered many times in quick succession and only the last
/// occurrence should execute.
class DebounceMap<K> {
  DebounceMap(this.duration);

  final Duration duration;
  final Map<K, Timer> _timers = {};

  void schedule(K key, void Function() callback) {
    _timers[key]?.cancel();
    _timers[key] = Timer(duration, () {
      _timers.remove(key);
      callback();
    });
  }

  void cancel(K key) {
    _timers.remove(key)?.cancel();
  }

  void dispose() {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
  }
}
