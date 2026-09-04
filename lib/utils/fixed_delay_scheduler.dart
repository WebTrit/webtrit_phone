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

  // Generation of the chain started by the last [start] call. A tick may
  // still be awaiting its [onTick] after [cancel] (no timer is pending, so
  // [isScheduled] is already false), and a subsequent [start] must not let
  // that stale tick reschedule itself alongside the new chain - each tick
  // only reschedules while its own generation is still the current one.
  int _generation = 0;
  bool _active = false;

  /// Whether a timer is currently scheduled.
  bool get isScheduled => _timer != null;

  /// Whether a chain is active: a timer is pending or a tick is in flight.
  /// While this is `true`, [start] is a no-op; use this (not [isScheduled],
  /// which is `false` for the whole duration of a running tick) to decide
  /// whether the loop needs a restart.
  bool get isActive => _active;

  /// Start scheduling ticks.
  ///
  /// - [initialDelay] — delay before the first tick.
  /// - [onTick] — callback executed on each tick. It should return
  ///   the [Duration] until the next tick.
  ///
  /// If [start] is called while a chain [isActive], it does nothing. A tick
  /// that throws ends its chain and releases the scheduler, so a later
  /// [start] can arm it again.
  void start(Duration initialDelay, NextDelay onTick) {
    if (_active) return; // a chain is already scheduled or mid-tick
    _active = true;
    final generation = ++_generation;

    void schedule(Duration delay) {
      _timer = Timer(delay, () async {
        _timer = null; // this tick is firing now
        var rescheduled = false;
        try {
          final next = await onTick();
          if (_generation == generation) {
            // Schedule next tick after onTick completes.
            schedule(next);
            rescheduled = true;
          }
        } finally {
          if (_generation == generation && !rescheduled) {
            // The chain ended without a next tick (onTick threw): release
            // ownership so a future [start] can arm the scheduler again.
            _active = false;
          }
        }
      });
    }

    schedule(initialDelay);
  }

  /// Cancel any scheduled ticks and prevent further rescheduling.
  void cancel() {
    _generation++; // invalidate the continuation of any in-flight tick
    _active = false;
    _timer?.cancel();
    _timer = null;
  }
}
