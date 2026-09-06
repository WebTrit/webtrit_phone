/// The current phase of a task registered with [PollingService].
enum PollingTaskPhase {
  /// The task is registered but has not run yet.
  idle,

  /// Automatic work is waiting for network reachability.
  waitingForConnectivity,

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

/// Read-only state of one polling task.
abstract interface class PollingTaskStateSource {
  /// The latest state. It is available synchronously from registration time.
  PollingTaskState get state;

  /// A replaying state stream. A new listener immediately receives [state].
  Stream<PollingTaskState> get states;
}

/// Permission to trigger one polling task without controlling its lifecycle.
abstract interface class PollingTaskRunner {
  /// Runs the task now, or joins its in-flight refresh cycle.
  ///
  /// A manual failure is reported to the caller but does not increase the
  /// scheduled retry backoff. A failure from a scheduled cycle still does,
  /// including when this call joined that scheduled cycle.
  Future<void> runNow();
}

/// Full ownership handle for one task registered with [PollingService].
///
/// Owners keep this handle for invalidation and teardown. Consumers should be
/// given only [PollingTaskStateSource] or [PollingTaskRunner], according to the
/// operation they need.
abstract interface class PollingTaskHandle implements PollingTaskStateSource, PollingTaskRunner {
  /// Whether this handle still represents a registered task.
  bool get isRegistered;

  /// Marks the task's data as stale and requests an automatic refresh no
  /// earlier than [after].
  ///
  /// Repeated calls use trailing-edge debounce: the latest call replaces the
  /// previous deadline. If a refresh that started before the deadline is still
  /// running, one trailing refresh remains pending. Connectivity, application
  /// lifecycle, and single-flight rules apply. A failure from the resulting
  /// automatic refresh participates in scheduled backoff.
  ///
  /// This method returns immediately. Observe [states] for the eventual result.
  /// Throws [ArgumentError] for a negative delay and [StateError] after the task
  /// has been unregistered.
  void invalidate({Duration after = Duration.zero});

  /// Removes this task from its owning [PollingService].
  void unregister();
}
