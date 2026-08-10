#!/usr/bin/env bash
# Run Patrol e2e tests on real devices in BrowserStack App Automate (Espresso).
#
# Usage:
#   tool/scripts/browserstack_e2e_android.sh --build [-t patrol_test/file.dart] [options]
#   tool/scripts/browserstack_e2e_android.sh [options]    reuse already built apks
#
# Options:
#   --build            run `patrol build android` first (provisions patrol dep)
#   -t <file>          with --build: build only this test target
#   --devices "A,B"    explicit device list, e.g. "Oppo Reno 3 Pro-10.0"
#   --preset <name>    coloros | miui | oem (default: coloros first device only)
#   --local            route device traffic through a running BrowserStackLocal tunnel
#   --no-wait          trigger the build and exit without polling
#
# Device names come from GET /app-automate/devices.json ("<device>-<os_version>").
# Credentials: BROWSERSTACK_USERNAME / BROWSERSTACK_ACCESS_KEY in the repo .env.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ENV_FILE="$REPO_ROOT/.env"
API="https://api-cloud.browserstack.com/app-automate/espresso/v2"
FLAVOR="deeplinkssmsReceiver"

PRESET_COLOROS="Oppo Reno 3 Pro-10.0,OnePlus 13R-15.0,OnePlus 12R-14.0"
PRESET_MIUI="Xiaomi Redmi Note 11-11.0,Xiaomi Redmi Note 9-10.0"

die() { echo "error: $*" >&2; exit 1; }

env_var() {
  grep -E "^(export[[:space:]]+)?$1=" "$ENV_FILE" | head -1 | cut -d '=' -f2- | tr -d '"'
}

[ -f "$ENV_FILE" ] || die ".env not found at $ENV_FILE (copy .env.example and fill in credentials)"
BS_USER="$(env_var BROWSERSTACK_USERNAME)"
BS_KEY="$(env_var BROWSERSTACK_ACCESS_KEY)"
[ -n "$BS_USER" ] && [ -n "$BS_KEY" ] \
  || die "BROWSERSTACK_USERNAME / BROWSERSTACK_ACCESS_KEY not set in $ENV_FILE"
AUTH="$BS_USER:$BS_KEY"

DO_BUILD=0
TARGET=""
DEVICES="Oppo Reno 3 Pro-10.0"
USE_LOCAL=false
WAIT=1

while [ $# -gt 0 ]; do
  case "$1" in
    --build) DO_BUILD=1 ;;
    -t)
      [ $# -gt 1 ] || die "-t needs a file"
      TARGET="$2"; shift
      ;;
    --devices)
      [ $# -gt 1 ] || die "--devices needs a value"
      DEVICES="$2"; shift
      ;;
    --preset)
      [ $# -gt 1 ] || die "--preset needs a value"
      case "$2" in
        coloros) DEVICES="$PRESET_COLOROS" ;;
        miui) DEVICES="$PRESET_MIUI" ;;
        oem) DEVICES="$PRESET_COLOROS,$PRESET_MIUI" ;;
        *) die "unknown preset: $2 (coloros|miui|oem)" ;;
      esac
      shift
      ;;
    --local) USE_LOCAL=true ;;
    --no-wait) WAIT=0 ;;
    --help|-h) sed -n '2,16p' "$0"; exit 0 ;;
    *) die "unknown option: $1" ;;
  esac
  shift
done

cd "$REPO_ROOT"

if [ "$DO_BUILD" = 1 ]; then
  # patrol is not a committed dependency (see patrol_e2e_run_local_android.sh)
  grep -qE '^  patrol:' pubspec.yaml || flutter pub add 'dev:patrol:^4.6.1'
  echo "building patrol apks (flavor $FLAVOR)${TARGET:+, target $TARGET} ..."
  patrol build android \
    ${TARGET:+-t "$TARGET"} \
    --dart-define-from-file=dart_define.json \
    --dart-define-from-file=dart_define.integration_test.json \
    --flavor="$FLAVOR"
fi

APP_APK="$(ls -t "build/app/outputs/apk/$FLAVOR/debug/"*-debug.apk 2>/dev/null | head -1)"
TEST_APK="$(ls -t "build/app/outputs/apk/androidTest/$FLAVOR/debug/"*-androidTest.apk 2>/dev/null | head -1)"
[ -n "$APP_APK" ] || die "app apk not found in build/app/outputs/apk/$FLAVOR/debug (run with --build)"
[ -n "$TEST_APK" ] || die "androidTest apk not found in build/app/outputs/apk/androidTest/$FLAVOR/debug (run with --build)"

echo "app apk:  $APP_APK"
echo "test apk: $TEST_APK"

json_field() {
  python3 -c '
import json, sys
field = sys.argv[1]
raw = sys.stdin.read()
try:
    value = json.loads(raw).get(field)
except ValueError:
    value = None
if not value:
    print(f"unexpected response (no {field}): {raw}", file=sys.stderr)
    sys.exit(1)
print(value)' "$1"
}

echo "uploading app apk ..."
APP_URL="$(curl -su "$AUTH" -X POST "$API/app" -F "file=@$APP_APK" | json_field app_url)"
echo "uploading test apk ..."
SUITE_URL="$(curl -su "$AUTH" -X POST "$API/test-suite" -F "file=@$TEST_APK" | json_field test_suite_url)"
echo "app_url: $APP_URL"
echo "test_suite_url: $SUITE_URL"

BODY="$(DEVICES="$DEVICES" APP_URL="$APP_URL" SUITE_URL="$SUITE_URL" USE_LOCAL="$USE_LOCAL" python3 -c '
import json, os
print(json.dumps({
    "app": os.environ["APP_URL"],
    "testSuite": os.environ["SUITE_URL"],
    "devices": [d.strip() for d in os.environ["DEVICES"].split(",") if d.strip()],
    "project": "webtrit_phone",
    "deviceLogs": True,
    "video": True,
    "networkLogs": True,
    "useOrchestrator": True,
    "clearPackageData": True,
    "local": os.environ["USE_LOCAL"] == "true",
}))')"

echo "starting build on: $DEVICES"
RESP="$(curl -su "$AUTH" -X POST "$API/build" -H "Content-Type: application/json" -d "$BODY")"
echo "$RESP"
BUILD_ID="$(echo "$RESP" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("build_id",""))')"
[ -n "$BUILD_ID" ] || die "build not started"
echo
echo "dashboard: https://app-automate.browserstack.com/builds/$BUILD_ID"

[ "$WAIT" = 1 ] || exit 0

echo "waiting for the run to finish (poll every 30s) ..."
while :; do
  sleep 30
  STATUS_JSON="$(curl -su "$AUTH" "$API/builds/$BUILD_ID")"
  STATUS="$(echo "$STATUS_JSON" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("status",""))')"
  echo "  status: $STATUS"
  case "$STATUS" in
    running|queued) ;;
    *) break ;;
  esac
done

echo
echo "$STATUS_JSON" | python3 -c '
import json, sys
b = json.load(sys.stdin)
print(f"build status: {b.get(\"status\")}")
for dev in b.get("devices", []):
    name = f"{dev.get(\"device\")}-{dev.get(\"os_version\")}"
    for s in dev.get("sessions", []):
        print(f"  {name}: {s.get(\"status\")} (session {s.get(\"id\")})")
'
echo "logs/video per session: dashboard above, or GET $API/builds/$BUILD_ID/sessions/<session_id>"
[ "$STATUS" = "passed" ] || [ "$STATUS" = "done" ] || exit 1
