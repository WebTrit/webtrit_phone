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

  // Identity of the chain started by the last [start] call. A tick may still
  // be awaiting its [onTick] after [cancel] (no timer is pending, so
  // [isScheduled] is already false), and a subsequent [start] must not let
  // that stale tick reschedule itself alongside the new chain - each tick
  // only reschedules while its own chain is still the current one.
  Object? _chain;

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
  /// If [start] is called while already scheduled or while a tick of a
  /// non-cancelled chain is still running, it does nothing.
  void start(Duration initialDelay, NextDelay onTick) {
    if (_chain != null) return; // already active
    final chain = Object();
    _chain = chain;

    void schedule(Duration delay) {
      _timer = Timer(delay, () async {
        _timer = null; // this tick is firing now
        _running = true;
        try {
          final next = await onTick();
          if (_chain == chain) {
            // Schedule next tick after onTick completes.
            schedule(next);
          }
        } finally {
          if (_chain == chain) {
            _running = false;
          }
        }
      });
    }

    schedule(initialDelay);
  }

  /// Cancel any scheduled ticks and prevent further rescheduling.
  void cancel() {
    _chain = null;
    _timer?.cancel();
    _timer = null;
    _running = false;
  }
}
