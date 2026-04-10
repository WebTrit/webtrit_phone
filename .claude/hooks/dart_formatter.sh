#!/usr/bin/env bash
# PostToolUse hook: auto-format .dart files after Write/Edit/MultiEdit.
# Generated files (*.g.dart, *.freezed.dart, *.gr.dart) are skipped.
INPUT=$(cat)
FILE=$(jq -r '(.tool_input.file_path // .tool_input.path // "")' <<< "$INPUT")

[[ -z "$FILE" || ! -f "$FILE" ]] && exit 0
[[ "$FILE" != *.dart ]] && exit 0
[[ "$FILE" == *.g.dart || "$FILE" == *.freezed.dart || "$FILE" == *.gr.dart ]] && exit 0

ROOT=$(git rev-parse --show-toplevel 2>/dev/null) && cd "$ROOT"
dart format "$FILE"
