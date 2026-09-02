import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';

final _logger = Logger('StartupWave');

/// An already-started startup operation whose typed result becomes available
/// after [settleStartupWave] completes successfully.
class StartupOperation<T extends Object> {
  StartupOperation(Future<T> future) : _future = future;

  final Future<T> _future;

  late T _value;
  var _available = false;

  /// The operation result.
  ///
  /// Throws if the startup wave has not completed successfully.
  T get value {
    if (!_available) {
      throw StateError('Startup operation has not completed successfully');
    }
    return _value;
  }

  Future<_StartupOutcome> _settle() async {
    try {
      final value = await _future;
      _value = value;
      return _StartupOutcome.value(value);
    } catch (error, stackTrace) {
      return _StartupOutcome.error(error, stackTrace);
    }
  }

  void _completeWave() => _available = true;
}

/// Waits for a set of already-started independent startup operations.
///
/// On success, every operation exposes its typed result through
/// [StartupOperation.value]. If any operation fails, all siblings are allowed
/// to settle first, successful [Disposable] results are released in reverse
/// declared order, no results become available, and the first declared error is
/// rethrown with its original stack trace.
Future<void> settleStartupWave(List<StartupOperation<Object>> operations) async {
  final outcomes = await Future.wait(operations.map((operation) => operation._settle()), eagerError: false);
  final failed = outcomes.where((outcome) => outcome.error != null).firstOrNull;

  if (failed == null) {
    for (final operation in operations) {
      operation._completeWave();
    }
    return;
  }

  for (final outcome in outcomes.reversed) {
    final value = outcome.value;
    if (value is! Disposable) continue;

    try {
      await value.dispose();
    } catch (error, stackTrace) {
      _logger.warning('Failed to roll back ${value.runtimeType}', error, stackTrace);
    }
  }

  Error.throwWithStackTrace(failed.error!, failed.stackTrace!);
}

class _StartupOutcome {
  const _StartupOutcome.value(this.value) : error = null, stackTrace = null;

  const _StartupOutcome.error(this.error, this.stackTrace) : value = null;

  final Object? value;
  final Object? error;
  final StackTrace? stackTrace;
}
