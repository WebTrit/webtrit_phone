import 'dart:developer' as dev;

import 'package:equatable/equatable.dart';

// WARNING: This file contains utilities for performance profiling and debugging.
// They are not intended for use in production builds or as part of the
// core application logic.

/// A tool for measuring the execution time of code blocks, supporting laps
/// and integration with the Dart developer timeline.
class PerformanceTimer {
  /// A descriptive label for this timer, used in logs and timeline events.
  final String label;

  /// Configuration for this timer.
  final PerfConfig config;

  final Stopwatch _sw = Stopwatch();
  final List<Lap> _laps = <Lap>[];
  bool _started = false;

  /// Creates a new performance timer with the given [label].
  PerformanceTimer(this.label, {this.config = PerfConfig.defaults});

  /// Starts the timer.
  ///
  /// If [config.emitTimeline] is true, this also starts a developer timeline event.
  /// Does nothing if the timer is already started.
  void start() {
    if (_started) return;
    _started = true;
    if (config.emitTimeline) dev.Timeline.startSync(label);
    _sw.start();
  }

  /// Records a "lap" at the current time.
  ///
  /// A lap is a named timestamp relative to the timer's start.
  /// If the timer is not started, this will start it first.
  void lap([String name = 'lap']) {
    if (!_started) start();
    _laps.add(Lap(name, _sw.elapsed));
  }

  /// Stops the timer and returns a summary of the run.
  ///
  /// If [config.emitTimeline] is true, this also finishes the timeline event.
  /// Resets the timer state for a potential new run.
  /// Returns an empty summary if the timer was never started.
  PerformanceSummary stop() {
    if (!_started) {
      return PerformanceSummary(label, Duration.zero, const []);
    }
    _sw.stop();
    if (config.emitTimeline) dev.Timeline.finishSync();

    final summary = PerformanceSummary(label, _sw.elapsed, List<Lap>.from(_laps));

    _started = false;
    _sw.reset();
    _laps.clear();

    return summary;
  }

  /// Runs the provided [body] function, wrapping it with [start] and [stop].
  ///
  /// This is a convenience method to time a block of code.
  /// The timer instance is passed to the [body] so it can record laps.
  /// Returns the result of the [body] function.
  T run<T>(T Function(PerformanceTimer p) body) {
    start();
    try {
      return body(this);
    } finally {
      stop();
    }
  }
}

/// Represents a named timestamp (lap) within a [PerformanceTimer] run.
class Lap extends Equatable {
  /// The name of the lap.
  final String name;

  /// The timestamp when the lap was recorded, relative to the timer's start.
  final Duration at;

  /// Creates a new lap.
  const Lap(this.name, this.at);

  @override
  List<Object?> get props => [name, at];
}

/// A summary of a [PerformanceTimer] run, including total time and all laps.
class PerformanceSummary extends Equatable {
  /// The label of the timer that produced this summary.
  final String label;

  /// The total duration of the timer run.
  final Duration total;

  /// A list of all laps recorded during the run.
  final List<Lap> laps;

  /// Creates a new performance summary.
  const PerformanceSummary(this.label, this.total, this.laps);

  /// Returns a formatted string detailing the total time and all lap segments.
  String toPrettyString() {
    final b = StringBuffer('$label total: ${formatDuration(total)}');
    if (laps.isEmpty) return b.toString();
    b.writeln();
    var prev = Duration.zero;
    for (var i = 0; i < laps.length; i++) {
      final lap = laps[i];
      final seg = lap.at - prev;
      prev = lap.at;
      b.writeln('  #${i + 1} ${lap.name}: +${formatDuration(seg)} (at ${formatDuration(lap.at)})');
    }
    return b.toString();
  }

  @override
  List<Object?> get props => [label, total, laps];

  @override
  String toString() {
    return toPrettyString();
  }

  @override
  bool? get stringify => true;
}

/// Holds the statistical results of a benchmark (multiple runs of an operation).
class BenchmarkResult extends Equatable {
  /// A descriptive label for the benchmark.
  final String label;

  /// The number of times the operation was run.
  final int runs;

  /// The total time taken for all runs.
  final Duration total;

  /// The shortest (best) duration recorded.
  final Duration min;

  /// The longest (worst) duration recorded.
  final Duration max;

  /// The median duration (50th percentile).
  final Duration median;

  /// The mean (average) duration.
  final Duration mean;

  /// The 90th percentile duration.
  final Duration p90;

  /// The 95th percentile duration.
  final Duration p95;

  /// Creates a new benchmark result.
  const BenchmarkResult({
    required this.label,
    required this.runs,
    required this.total,
    required this.min,
    required this.max,
    required this.median,
    required this.mean,
    required this.p90,
    required this.p95,
  });

  /// Returns a compact, single-line string representation of the results.
  String toPrettyString() =>
      '$label n=$runs total=${formatDuration(total)} min=${formatDuration(min)} '
      'max=${formatDuration(max)} med=${formatDuration(median)} '
      'mean=${formatDuration(mean)} p90=${formatDuration(p90)} p95=${formatDuration(p95)}';

  @override
  List<Object?> get props => [label, runs, total, min, max, median, mean, p90, p95];

  @override
  String toString() => toPrettyString();

  @override
  bool? get stringify => true;
}

/// Formats a [Duration] into a human-readable string.
///
/// Uses milliseconds (ms) if >= 1ms, otherwise uses microseconds (us).
String formatDuration(Duration d) {
  final micros = d.inMicroseconds;
  if (micros >= 1000) {
    return '${(micros / 1000).toStringAsFixed(2)} ms';
  }
  return '$micros us';
}

/// Configuration for performance measurement tools.
class PerfConfig {
  /// Whether to emit events to the Dart developer timeline.
  final bool emitTimeline;

  /// Creates a performance configuration.
  const PerfConfig({this.emitTimeline = true});

  /// Default performance configuration (timeline events enabled).
  static const defaults = PerfConfig();
}

/// Holds the result of a timed operation along with the operation's return value.
class MeasureResult<T> {
  /// A descriptive label for the measurement.
  final String label;

  /// The time it took for the operation to complete.
  final Duration elapsed;

  /// The value returned by the timed operation.
  final T result;

  /// Creates a new measurement result.
  const MeasureResult(this.label, this.elapsed, this.result);

  /// Returns a human-readable string representation.
  String toPrettyString() => '$label took ${formatDuration(elapsed)}';

  @override
  String toString() => toPrettyString();
}
