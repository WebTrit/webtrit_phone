import 'dart:async';

import 'package:meta/meta.dart';

import 'package:webtrit_phone/common/common.dart';

import 'polling_service.dart';
import 'polling_task_handle.dart';

/// One finite, repeatable unit of feature synchronization.
///
/// A worker owns domain work only. Scheduling, connectivity, application
/// lifecycle, single-flight execution, and task state belong to
/// [PollingService]. Implementations must become inactive after [dispose] and
/// reject later [refresh] calls.
abstract interface class PollingWorker implements Refreshable, Disposable {}

/// Owns one [PollingWorker] and its registration with [PollingService].
///
/// The full [PollingTaskHandle] remains private to this owner. Feature
/// consumers receive this object through [PollingTaskStateSource] or
/// [PollingTaskRunner], while subclasses can add domain-specific triggers by
/// calling [invalidatePollingTask].
abstract base class PollingWorkerOwner<W extends PollingWorker>
    implements PollingTaskStateSource, PollingTaskRunner, Disposable {
  PollingWorkerOwner({required W worker, required PollingService pollingService, required Duration interval})
    : _worker = worker,
      _task = pollingService.register(PollingRegistration(listener: worker, interval: interval));

  final W _worker;
  final PollingTaskHandle _task;

  bool _disposed = false;

  @override
  PollingTaskState get state => _task.state;

  @override
  Stream<PollingTaskState> get states => _task.states;

  @override
  Future<void> runNow() => _task.runNow();

  /// Marks this owner's task as stale without exposing lifecycle control to
  /// feature consumers.
  ///
  /// A trigger racing with teardown is deliberately ignored. This keeps
  /// feature callbacks safe while their owner is leaving the widget tree.
  @protected
  void invalidatePollingTask({Duration after = Duration.zero}) {
    if (_disposed || !_task.isRegistered) {
      return;
    }

    _task.invalidate(after: after);
  }

  @override
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }

    _disposed = true;
    _task.unregister();
    await _worker.dispose();
  }
}
