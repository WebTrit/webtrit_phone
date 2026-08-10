#!/usr/bin/env bash
# Upload an app build (apk/aab/ipa) to BrowserStack App Live for manual testing
# on real devices.
#
# Usage:
#   tool/scripts/browserstack_upload.sh <path-to-app>    upload the given file
#   tool/scripts/browserstack_upload.sh                  upload the newest apk from build output
#   tool/scripts/browserstack_upload.sh --build [flavor] build a debug apk first, then upload
#                                                        (default flavor: deeplinksDisabledSmsReceiverDisabled)
#   tool/scripts/browserstack_upload.sh --list           list recent App Live uploads and exit
#
# Options:
#   --custom-id <id>   App Live custom_id (default: webtrit_phone);
#                      App Live auto-picks the latest build uploaded with this id
#   --release          with --build: build release instead of debug
#
# Credentials: BROWSERSTACK_USERNAME and BROWSERSTACK_ACCESS_KEY in the repo .env
# (see .env.example). Get them at https://www.browserstack.com/accounts/profile/details

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ENV_FILE="$REPO_ROOT/.env"
API="https://api-cloud.browserstack.com/app-live"
APK_DIR="$REPO_ROOT/build/app/outputs/flutter-apk"
CUSTOM_ID="webtrit_phone"
DEFAULT_FLAVOR="deeplinksDisabledSmsReceiverDisabled"

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

pretty() { python3 -m json.tool 2>/dev/null || cat; }

APP_FILE=""
DO_BUILD=0
FLAVOR="$DEFAULT_FLAVOR"
BUILD_MODE="--debug"

while [ $# -gt 0 ]; do
  case "$1" in
    --list)
      curl -su "$AUTH" "$API/recent_apps" | pretty
      exit 0
      ;;
    --build)
      DO_BUILD=1
      if [ $# -gt 1 ] && [[ "$2" != --* ]]; then FLAVOR="$2"; shift; fi
      ;;
    --release) BUILD_MODE="--release" ;;
    --custom-id)
      [ $# -gt 1 ] || die "--custom-id needs a value"
      CUSTOM_ID="$2"; shift
      ;;
    --help|-h) sed -n '2,19p' "$0"; exit 0 ;;
    -*) die "unknown option: $1" ;;
    *) APP_FILE="$1" ;;
  esac
  shift
done

if [ "$DO_BUILD" = 1 ]; then
  echo "building $BUILD_MODE apk, flavor $FLAVOR ..."
  (cd "$REPO_ROOT" && flutter build apk --dart-define-from-file=dart_define.json \
    --no-tree-shake-icons "$BUILD_MODE" --flavor "$FLAVOR")
fi

if [ -z "$APP_FILE" ]; then
  [ -d "$APK_DIR" ] || die "no build output at $APK_DIR (pass a file path or use --build)"
  APP_FILE="$(ls -t "$APK_DIR"/*.apk 2>/dev/null | head -1)"
  [ -n "$APP_FILE" ] || die "no apk found in $APK_DIR"
fi
[ -f "$APP_FILE" ] || die "file not found: $APP_FILE"

echo "uploading: $APP_FILE"
echo "custom_id: $CUSTOM_ID"
RESPONSE="$(curl -su "$AUTH" -X POST "$API/upload" \
  -F "file=@$APP_FILE" \
  -F "data={\"custom_id\": \"$CUSTOM_ID\"}")"
echo "$RESPONSE" | pretty

echo "$RESPONSE" | grep -q '"app_url"' \
  || die "upload failed (no app_url in response)"
echo
echo "done: open https://app-live.browserstack.com/ and pick the app '$CUSTOM_ID' (latest build)"
