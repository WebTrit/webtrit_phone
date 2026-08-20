import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';

final _logger = Logger('StartupWave');

/// Waits for a set of already-started independent startup operations.
///
/// Results retain the declared [operations] order. If any operation fails, all
/// siblings are allowed to settle first, successful [Disposable] results are
/// released in reverse declared order, and the first declared error is rethrown
/// with its original stack trace.
Future<List<Object>> settleStartupWave(List<Future<Object>> operations) async {
  final outcomes = await Future.wait(operations.map(_settle), eagerError: false);
  final failed = outcomes.where((outcome) => outcome.error != null).firstOrNull;

  if (failed == null) {
    return [for (final outcome in outcomes) outcome.value!];
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

Future<_StartupOutcome> _settle(Future<Object> operation) async {
  try {
    return _StartupOutcome.value(await operation);
  } catch (error, stackTrace) {
    return _StartupOutcome.error(error, stackTrace);
  }
}

class _StartupOutcome {
  const _StartupOutcome.value(this.value) : error = null, stackTrace = null;

  const _StartupOutcome.error(this.error, this.stackTrace) : value = null;

  final Object? value;
  final Object? error;
  final StackTrace? stackTrace;
}
