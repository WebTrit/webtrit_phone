#!/usr/bin/env bash

set -euo pipefail

# patrol is not a committed dependency (it links XCTest into the app, which Apple
# rejects). Provision it just for this test run.
grep -qE '^  patrol:' pubspec.yaml || flutter pub add 'dev:patrol:^4.6.1'

target_file="${1:-patrol_test/just_run_test.dart}"

dart run packages/pjsua_companion/bin/server.dart &
PJSUA_SERVER_PID=$!

cleanup() {
  kill "$PJSUA_SERVER_PID" 2>/dev/null || true
}
trap cleanup EXIT

sleep 1

patrol test \
  -t "$target_file" \
  --dart-define-from-file=dart_define.json \
  --dart-define-from-file=dart_define.integration_test.json \
  --flavor=deeplinkssmsReceiver \
  --verbose \
  --show-flutter-logs

# TODO: add default flavor resolution and remove this flag