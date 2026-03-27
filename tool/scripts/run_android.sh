#!/usr/bin/env bash

set -euo pipefail

target_file="${1:-patrol_test/just_run_test.dart}"

patrol test \
  -t patrol_test/call_and_recent_test.dart \
  --dart-define-from-file=dart_define.json \
  --dart-define-from-file=dart_define.integration_test.json \
  --flavor=deeplinkssmsReceiver
