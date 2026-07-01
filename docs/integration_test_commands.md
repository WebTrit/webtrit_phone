# Integration Test Commands

## Prerequisite: provision patrol

`patrol` is intentionally NOT a committed dependency. It weak-links `XCTest`, and
Flutter does not strip dev dependencies from iOS release builds
([flutter/flutter#163874](https://github.com/flutter/flutter/issues/163874)), so
shipping it makes the app reference `XCTest` and Apple rejects it (guideline 2.5.1).

Add it before running the commands below (the `tool/scripts/*` helpers do this
automatically):

```bash
flutter pub add 'dev:patrol:^4.6.1'
```

Do not commit the resulting `pubspec.yaml` / `pubspec.lock` change; restore them
when done (`git checkout pubspec.yaml pubspec.lock`).

## Run integration tests in dev mode

```bash
patrol develop --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json --flavor=deeplinkssmsReceiver
```

## Build integration tests

```bash
patrol build android/ios --dart-define-from-file=../dart_define.json --dart-define-from-file=dart_define.integration_test.json --flavor=deeplinkssmsReceiver
```

To specify a test file, use the `-t` option:

```bash
patrol build -t patrol_test/call_and_recent_test.dart ...
```

## Deploy to Firebase Test Lab

Run from the `tool/scripts` directory:

```bash
./testlab_assemble_android.sh <testfile(optional)>
./testlab_assemble_ios.sh <testfile(optional)>
```

## Run Android integration tests locally with call companion

Starts the [pjsua Companion](../packages/pjsua_companion/README.md) server automatically and runs the tests:

```bash
./tool/scripts/patrol_e2e_run_local_android.sh <testfile(optional)>
```
