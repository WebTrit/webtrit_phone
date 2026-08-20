import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

/// One completed operation on the application startup path.
class StartupMeasurement {
  const StartupMeasurement({required this.name, required this.elapsed, required this.succeeded});

  final String name;
  final Duration elapsed;
  final bool succeeded;
}

/// Records startup stages in the Dart timeline and emits machine-readable logs.
///
/// A trace starts when Dart enters the startup zone and ends after Flutter's
/// first frame callback. [measure] preserves the wrapped operation's result and
/// error semantics; instrumentation must never change startup behavior.
class StartupTrace {
  StartupTrace({String timelineName = 'app-startup', void Function(String message)? output})
    : _stopwatch = Stopwatch()..start(),
      _timeline = _startTimeline(timelineName),
      _output = output ?? _printToConsole;

  StartupTrace.disabled() : _stopwatch = null, _timeline = null, _output = null;

  /// Creates the trace selected for the current build mode.
  ///
  /// [releaseMode] is injectable so the release gate can be covered by tests.
  factory StartupTrace.forBuildMode({required bool releaseMode, void Function(String message)? output}) {
    return releaseMode ? StartupTrace.disabled() : StartupTrace(output: output);
  }

  /// Stable prefix for filtering startup measurements in console output.
  static const logTag = '[Startup]';

  final Stopwatch? _stopwatch;
  final developer.TimelineTask? _timeline;
  final void Function(String message)? _output;
  final _measurements = <StartupMeasurement>[];

  bool _finished = false;

  /// Whether the overall startup trace has ended.
  bool get isFinished => _finished;

  /// A snapshot of the stages completed so far, in completion order.
  List<StartupMeasurement> get measurements => List.unmodifiable(_measurements);

  /// Runs [operation] unchanged while measuring its elapsed time and outcome.
  Future<T> measure<T>(String name, FutureOr<T> Function() operation) async {
    final stopwatch = _stopwatch;
    if (stopwatch == null) return operation();

    final startedAt = stopwatch.elapsed;
    final timeline = _startTimeline(name);
    var succeeded = false;
    try {
      final result = await operation();
      succeeded = true;
      return result;
    } finally {
      final elapsed = stopwatch.elapsed - startedAt;
      _ignoreInstrumentationError(
        () => timeline?.finish(arguments: {'duration_ms': _milliseconds(elapsed), 'succeeded': succeeded}),
      );
      _measurements.add(StartupMeasurement(name: name, elapsed: elapsed, succeeded: succeeded));
      _emit('$logTag startup_stage name=$name duration_ms=${_milliseconds(elapsed)} succeeded=$succeeded');
    }
  }

  /// Ends this trace after Flutter finishes its first frame callback.
  void finishAfterFirstFrame() {
    if (_stopwatch == null || _finished) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => finish());
  }

  /// Ends the trace and emits the total plus the completed stage summary.
  void finish() {
    final stopwatch = _stopwatch;
    if (stopwatch == null || _finished) return;
    _finished = true;
    stopwatch.stop();
    _ignoreInstrumentationError(() => _timeline?.finish(arguments: {'total_ms': _milliseconds(stopwatch.elapsed)}));

    final stages = _measurements
        .map((it) => '${it.name}:${_milliseconds(it.elapsed)}:${it.succeeded ? 'ok' : 'error'}')
        .join(',');
    _emit('$logTag startup_complete total_ms=${_milliseconds(stopwatch.elapsed)} stages=[$stages]');
  }

  void _emit(String message) {
    final output = _output;
    if (output != null) _ignoreInstrumentationError(() => output(message));
  }

  static developer.TimelineTask? _startTimeline(String name) {
    try {
      return developer.TimelineTask(filterKey: 'startup')..start(name);
    } catch (_) {
      return null;
    }
  }

  static void _ignoreInstrumentationError(void Function() operation) {
    try {
      operation();
    } catch (_) {
      // Measurement must never alter application startup or mask its failure.
    }
  }

  static String _milliseconds(Duration duration) => (duration.inMicroseconds / 1000).toStringAsFixed(3);

  static void _printToConsole(String message) {
    // Startup measurements happen before the application logger is wired and
    // must remain visible in debug/profile console output.
    // ignore: avoid_print
    print(message);
  }
}
