# Startup performance measurements

The application records its Dart startup path without changing initialization
order or behavior. The trace starts when Dart enters `main` and ends in the
first Flutter frame callback.

This is not the complete native process-start duration. Use Android startup
timings or platform performance tools alongside it when measuring launch from
the home screen.

## Recorded output

Every stage is written to the Dart timeline under the `startup` filter key and
to the Flutter console with the stable `[Startup]` prefix:

```text
[Startup] startup_stage name=remote-config started_ms=415.320 duration_ms=842.315 succeeded=true
[Startup] startup_complete total_ms=2310.774 stages=[firebase-core:120.301:ok,...]
```

`started_ms` is the stage's offset from the beginning of the startup trace.
Use it together with `duration_ms` to identify overlap. Once startup operations
run concurrently, stage durations overlap and must not be added together to
derive the total; `startup_complete total_ms` remains the wall-clock metric.

Use `[Startup]` as the console filter. On Android the platform tag remains
`flutter`, so the equivalent command is:

```sh
adb logcat -s flutter:I | grep '\[Startup\]'
```

Startup measurements are enabled in debug and profile builds. Release builds
use a disabled trace: no stopwatch, timeline events, retained measurements or
console output are created.

The stages separate Firebase core, messaging and local notifications from the
local-data, theme, Remote Config, database, logging, connectivity and callkeep
parts of bootstrap. A failed stage is recorded before its original error is
re-thrown.

The Firebase and local-notification stages start initial launch-notification
resolution but do not wait for it. A request still pending after five seconds
emits a warning and continues in the background; a later result is routed
through the notification broker and buffered until its consumer is ready.

System UI setup and bootstrap are independent and start together. Both must
finish before `runApp`, so the first rendered frame retains the edge-to-edge
contract. If system UI setup fails after bootstrap built the application
dependencies, those dependencies are disposed before the startup error is
reported.

## Baseline procedure

Use a profile build; debug timings are not representative and release builds
intentionally contain no startup instrumentation. Keep the
application version, device, network conditions and account state fixed while
comparing runs.

Capture at least ten runs for each relevant case:

- cold process and warm process;
- normal network, offline and constrained network;
- ordinary launch, remote-notification tap and local-notification tap;
- Android and iOS.

For an interactive profile run:

```sh
flutter run --profile --dart-define-from-file=dart_define.json
```

Filter device logs by `startup_stage` and `startup_complete`. In DevTools,
record a Performance timeline during launch and filter timeline events by the
`startup` key.

For Android's native launch boundary, capture `ThisTime` and `TotalTime` as a
separate measurement:

```sh
adb shell am force-stop com.webtrit.phone
adb shell am start -W com.webtrit.phone/.MainActivity
```

Do not use `am force-stop` when testing incoming-call push delivery: Android's
stopped package state intentionally blocks FCM. It is appropriate only for an
ordinary cold-launch timing run.

Report median (p50), p95, minimum/maximum, timeout count and failures for both
the total and every stage. Compare the same matrix before and after each startup
optimization.
