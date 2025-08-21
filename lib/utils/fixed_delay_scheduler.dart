import 'dart:async';

/// Signature for a callback that is executed on each tick of the scheduler.
/// The callback must return the [Duration] until the next tick.
/// You can return it synchronously or asynchronously.
typedef NextDelay = FutureOr<Duration> Function();

/// A simple fixed-delay scheduler that repeatedly runs a task
/// with a pause between executions determined by the [NextDelay] callback.
///
/// Unlike [Timer.periodic], the delay until the next tick is scheduled
/// **after** the previous tick's task completes (even if it's async).
///
/// Useful when you want to avoid overlapping executions or when you need
/// dynamic delays with backoff or jitter.
///
/// Example:
/// ```dart
/// final scheduler = FixedDelayScheduler();
///
/// // Start with initial delay of 1 second.
/// scheduler.start(Duration(seconds: 1), () async {
///   print('Tick at ${DateTime.now()}');
///   // Simulate work
///   await Future.delayed(Duration(milliseconds: 500));
///   // Next tick after 2 seconds
///   return Duration(seconds: 2);
/// });
///
/// // Later, when you need to stop:
/// scheduler.cancel();
/// ```
class FixedDelayScheduler {
  Timer? _timer;
  bool _running = false;
  bool _stopped = false;

  /// Whether a timer is currently scheduled.
  bool get isScheduled => _timer != null;

  /// Whether the [onTick] callback is currently running.
  bool get isRunning => _running;

  /// Start scheduling ticks.
  ///
  /// - [initialDelay] — delay before the first tick.
  /// - [onTick] — callback executed on each tick. It should return
  ///   the [Duration] until the next tick.
  ///
  /// If [start] is called while already scheduled, it does nothing.
  void start(Duration initialDelay, NextDelay onTick) {
    if (_timer != null) return; // already scheduled
    _stopped = false;

    void schedule(Duration delay) {
      _timer = Timer(delay, () async {
        _timer = null; // this tick is firing now
        _running = true;
        try {
          final next = await onTick();
          if (!_stopped) {
            // Schedule next tick after onTick completes.
            schedule(next);
          }
        } finally {
          _running = false;
        }
      });
    }

    schedule(initialDelay);
  }

  /// Cancel any scheduled ticks and prevent further rescheduling.
  void cancel() {
    _stopped = true;
    _timer?.cancel();
    _timer = null;
    _running = false;
  }
}
