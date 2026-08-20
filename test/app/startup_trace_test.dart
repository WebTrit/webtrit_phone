import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/startup_trace.dart';

void main() {
  test('measure preserves a successful result and records the stage', () async {
    final output = <String>[];
    final trace = StartupTrace(output: output.add);

    final result = await trace.measure('stage', () => 42);

    expect(result, 42);
    expect(trace.measurements, hasLength(1));
    expect(trace.measurements.single.name, 'stage');
    expect(trace.measurements.single.succeeded, isTrue);
    expect(output.single, startsWith('[Startup] startup_stage name=stage duration_ms='));
  });

  test('measure preserves an error and records the failed stage', () async {
    final trace = StartupTrace();
    final error = StateError('failed');

    await expectLater(trace.measure<void>('stage', () => throw error), throwsA(same(error)));

    expect(trace.measurements, hasLength(1));
    expect(trace.measurements.single.name, 'stage');
    expect(trace.measurements.single.succeeded, isFalse);
  });

  test('disabled trace runs operations without retaining measurements', () async {
    final trace = StartupTrace.disabled();
    final completer = Completer<int>()..complete(42);

    expect(await trace.measure('stage', () => completer.future), 42);
    expect(trace.measurements, isEmpty);
  });

  test('finish writes a tagged total and stage summary', () async {
    final output = <String>[];
    final trace = StartupTrace(output: output.add);

    await trace.measure('stage', () async {});
    trace.finish();

    expect(output, hasLength(2));
    expect(output.last, startsWith('[Startup] startup_complete total_ms='));
    expect(output.last, contains('stages=[stage:'));
  });

  testWidgets('finishes after the first Flutter frame', (tester) async {
    final trace = StartupTrace();

    trace.finishAfterFirstFrame();
    expect(trace.isFinished, isFalse);

    await tester.pumpWidget(const SizedBox.shrink());

    expect(trace.isFinished, isTrue);
  });
}
