#!/usr/bin/env bash
# PostToolUse hook: ensure text files end with a newline after Write/Edit/MultiEdit.
INPUT=$(cat)
FILE=$(jq -r '(.tool_input.file_path // .tool_input.path // "")' <<< "$INPUT")

[[ -z "$FILE" || ! -f "$FILE" ]] && exit 0
[[ "$FILE" == *.g.dart || "$FILE" == *.freezed.dart || "$FILE" == *.gr.dart ]] && exit 0

case "$FILE" in
  *.dart|*.yaml|*.yml|*.json|*.md|*.py|*.sh|*.kt|*.kts|*.swift|*.gradle|*.xml|*.html|*.txt) ;;
  *) exit 0 ;;
esac

[[ -n "$(tail -c 1 "$FILE")" ]] && printf '\n' >> "$FILE"
exit 0
