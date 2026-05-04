import 'debounce.dart';

/// Debounces repeated actions keyed by an identifier.
///
/// Calling [schedule] with the same key cancels any pending callback for that
/// key and starts a new [duration] countdown. Useful when the same logical
/// action may be triggered many times in quick succession and only the last
/// occurrence should execute.
class DebounceMap<K> {
  DebounceMap(this.duration);

  final Duration duration;
  final Map<K, Debounce> _debouncers = {};

  void schedule(K key, void Function() callback) {
    (_debouncers[key] ??= Debounce(duration)).schedule(callback);
  }

  void cancel(K key) => _debouncers[key]?.cancel();

  void dispose() {
    for (final d in _debouncers.values) {
      d.dispose();
    }
    _debouncers.clear();
  }
}
