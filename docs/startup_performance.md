# Startup performance measurements

The application records its Dart startup path without changing initialization
order or behavior. The trace starts when Dart enters `main` and ends in the
first Flutter frame callback.

This is not the complete native process-start duration. Use Android startup
timings or platform performance tools alongside it when measuring launch from
the home screen.

## Recorded output

Every stage is written to the Dart timeline under the `startup` filter key and
to the platform log in this stable format:

```text
startup_stage name=remote-config duration_ms=842.315 succeeded=true
startup_complete total_ms=2310.774 stages=[firebase-core:120.301:ok,...]
```

The stages separate Firebase core, messaging and local notifications from the
local-data, theme, Remote Config, database, logging, connectivity and callkeep
parts of bootstrap. A failed stage is recorded before its original error is
re-thrown.

## Baseline procedure

Use a profile or release build; debug timings are not representative. Keep the
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
