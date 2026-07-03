#!/usr/bin/env bash
# Push a SINGLE localization key to Localizely for every configured locale, overwriting
# only that key.
#
# Why this exists: `melos run l10n:push` uploads with overwrite:false (see localizely.yml),
# so it can NOT change the text of a key that already exists in Localizely - and an arb file
# edited only in the repo gets silently reverted by the next `melos run l10n:fetch`. The
# Localizely upload API only touches keys PRESENT in the uploaded file, so uploading a
# one-key arb with overwrite=true updates exactly that key: other keys, other locales'
# pending edits and reviewer state are untouched, and nothing is deleted.
#
# Usage (from the repo root, on the branch that contains the NEW text in the arb files):
#   ./tool/scripts/localizely_push_key.sh <key_name> [--dry-run]
#
# Reads:
#   - localizely.yml  (project_id, branch, arb file <-> locale map)
#   - .env            (LOCALIZELY_TOKEN)
#   - lib/l10n/arb/*.arb from the current working tree
#
# --dry-run prints the per-locale payloads and target URLs without sending anything.

set -euo pipefail

KEY="${1:?usage: tool/scripts/localizely_push_key.sh <key_name> [--dry-run]}"
DRY_RUN="${2:-}"

CFG="localizely.yml"
ENV_FILE=".env"
[ -f "$CFG" ] || { echo "error: $CFG not found (run from the repo root)" >&2; exit 1; }
[ -f "$ENV_FILE" ] || { echo "error: $ENV_FILE not found (LOCALIZELY_TOKEN)" >&2; exit 1; }

TOKEN=$(grep -E '^(export[[:space:]]+)?LOCALIZELY_TOKEN=' "$ENV_FILE" | head -1 | cut -d '=' -f2)
[ -n "$TOKEN" ] || { echo "error: LOCALIZELY_TOKEN not found in $ENV_FILE" >&2; exit 1; }

PROJECT_ID=$(awk '/^project_id:/ {print $2}' "$CFG")
BRANCH=$(awk '/^branch:/ {print $2}' "$CFG")
[ -n "$PROJECT_ID" ] || { echo "error: project_id not found in $CFG" >&2; exit 1; }

# Parse the "- file: <path>" / "locale_code: <code>" pairs; the upload and download
# sections list the same pairs, so dedupe.
PAIRS=$(awk '
  /file:/        { file=$NF }
  /locale_code:/ { print file "|" $NF }
' "$CFG" | sort -u)

WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT

FAILED=0
while IFS='|' read -r ARB LOCALE; do
    [ -f "$ARB" ] || { echo "skip $LOCALE: $ARB not found" >&2; continue; }

    ONE_KEY_FILE="$WORKDIR/$LOCALE.arb"
    KEY="$KEY" python3 - "$ARB" > "$ONE_KEY_FILE" << 'PYEOF'
import json, os, sys
key = os.environ["KEY"]
data = json.load(open(sys.argv[1], encoding="utf-8"))
if key not in data:
    sys.exit(f"key '{key}' not found in {sys.argv[1]}")
print(json.dumps({key: data[key]}, ensure_ascii=False, indent=2))
PYEOF

    URL="https://api.localizely.com/v1/projects/$PROJECT_ID/files/upload?lang_code=$LOCALE&branch=$BRANCH&overwrite=true&reviewed=false"

    if [ "$DRY_RUN" = "--dry-run" ]; then
        echo "== DRY RUN [$LOCALE] -> $URL"
        cat "$ONE_KEY_FILE"
        echo
    else
        echo "== push [$LOCALE] $KEY"
        HTTP_CODE=$(curl -s -o "$WORKDIR/resp_$LOCALE" -w '%{http_code}' -X POST "$URL" \
            -H "X-Api-Token: $TOKEN" \
            -F "file=@$ONE_KEY_FILE;filename=app_$LOCALE.arb")
        if [ "$HTTP_CODE" != "200" ]; then
            echo "   FAILED ($HTTP_CODE): $(cat "$WORKDIR/resp_$LOCALE")" >&2
            FAILED=1
        else
            echo "   ok"
        fi
    fi
done <<< "$PAIRS"

exit $FAILED
