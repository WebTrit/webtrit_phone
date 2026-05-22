import 'dart:async';

/// Single-key debounce utility.
///
/// Calling [schedule] cancels any pending callback and starts a new [duration]
/// countdown. Only the last scheduled callback within the quiet window executes.
///
/// [duration] default Duration(milliseconds: 300)
class Debounce {
  Debounce([Duration? duration]) : duration = duration ?? const Duration(milliseconds: 300);

  final Duration duration;
  Timer? _timer;

  void schedule(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, () {
      _timer = null;
      callback();
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
