# Integration Test Commands

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
