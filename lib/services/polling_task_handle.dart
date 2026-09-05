/// The current phase of a task registered with [PollingService].
enum PollingTaskPhase {
  /// The task is registered but has not run yet.
  idle,

  /// A refresh cycle is in progress.
  running,

  /// The latest refresh cycle completed successfully.
  succeeded,

  /// The latest refresh cycle failed.
  failed,

  /// The task was unregistered or its owning service was disposed.
  stopped,
}

/// Observable state of a task registered with [PollingService].
///
/// Timestamps are retained across transitions so consumers can render the
/// latest outcome without keeping a separate state cache.
class PollingTaskState {
  const PollingTaskState({
    required this.phase,
    this.lastStartedAt,
    this.lastSuccessAt,
    this.lastFailureAt,
    this.error,
    this.stackTrace,
  });

  /// The task's current lifecycle phase.
  final PollingTaskPhase phase;

  /// When the latest refresh cycle started.
  final DateTime? lastStartedAt;

  /// When the latest successful refresh cycle completed.
  final DateTime? lastSuccessAt;

  /// When the latest failed refresh cycle completed.
  final DateTime? lastFailureAt;

  /// The error produced by the latest failed refresh cycle, if any.
  final Object? error;

  /// The stack trace associated with [error], if any.
  final StackTrace? stackTrace;
}

/// A stable capability for observing and manually running one polling task.
///
/// [runNow] joins an already-running refresh instead of starting an overlapping
/// one. Its returned future completes with that refresh cycle's result.
abstract interface class PollingTaskHandle {
  /// The latest state. It is available synchronously from registration time.
  PollingTaskState get state;

  /// A replaying state stream. A new listener immediately receives [state].
  Stream<PollingTaskState> get states;

  /// Whether this handle still represents a registered task.
  bool get isRegistered;

  /// Runs the task now, or joins its in-flight refresh cycle.
  ///
  /// A manual failure is reported to the caller but does not increase the
  /// scheduled retry backoff. A failure from a scheduled cycle still does,
  /// including when this call joined that scheduled cycle.
  Future<void> runNow();

  /// Removes this task from its owning [PollingService].
  void unregister();
}
