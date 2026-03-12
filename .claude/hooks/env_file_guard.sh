#!/usr/bin/env bash
# PreToolUse hook: block any access to .env files.
INPUT=$(cat)
TOOL=$(jq -r '.tool // ""' <<< "$INPUT")
COMMAND=$(jq -r '.tool_input.command // ""' <<< "$INPUT")
FILE=$(jq -r '(.tool_input.file_path // .tool_input.path // "")' <<< "$INPUT")

if [[ "$TOOL" == "Bash" || "$TOOL" == "Run" ]]; then
  if echo "$COMMAND" | grep -qE '\b(cat|less|more|head|tail|bat|view|nano|vi|vim|code|open|type|strings|xxd|hexdump|od|base64)\b' \
  && echo "$COMMAND" | grep -qE '\.env($|\.)'; then
    echo "🚫 BLOCKED: reads a .env file — secrets must not be read by the agent." >&2
    exit 2
  fi
  if echo "$COMMAND" | grep -qE '\b(cp|mv|scp|rsync|tar|zip)\b' \
  && echo "$COMMAND" | grep -qE '\.env($|\.)'; then
    echo "🚫 BLOCKED: copies/moves a .env file — secrets must not be transferred." >&2
    exit 2
  fi
  if echo "$COMMAND" | grep -qE '\b(find|grep|rg|ag|fd)\b' \
  && echo "$COMMAND" | grep -qE '\.env($|\.)'; then
    echo "🚫 BLOCKED: searches for .env files — secret files must not be scanned." >&2
    exit 2
  fi
fi

if [[ "$TOOL" =~ ^(Read|View|Edit|Write|MultiEdit)$ ]]; then
  if echo "$FILE" | grep -qE '\.env($|\.)'; then
    echo "🚫 BLOCKED: Cannot access '$FILE' — .env files contain secrets." >&2
    exit 2
  fi
fi

exit 0
