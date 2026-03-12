#!/usr/bin/env bash
# PostToolUse hook: runs markdownlint-cli2 --fix on .md files after Write/Edit/MultiEdit.
INPUT=$(cat)
FILE=$(jq -r '(.tool_input.file_path // .tool_input.path // "")' <<< "$INPUT")

[[ -z "$FILE" || "$FILE" != *.md ]] && exit 0

ROOT=$(git rev-parse --show-toplevel 2>/dev/null) && cd "$ROOT"
npx --yes markdownlint-cli2 --fix "$FILE" >/dev/null 2>&1
exit 0
