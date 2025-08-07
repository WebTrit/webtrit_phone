#!/bin/bash
set -euo pipefail

BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🔍 Current branch: $BRANCH"

if ! [[ "$BRANCH" =~ ^(feature|fix|chore|build|style|docs)/.+$ ]]; then
  echo "❌ Invalid branch name: '$BRANCH'"
  echo "💡 Use: feature/name, fix/bug-name, etc."
  exit 1
fi

echo "✅ Branch name OK."
