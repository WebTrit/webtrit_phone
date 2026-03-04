#!/bin/bash
set -euo pipefail

BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🔍 Current branch: $BRANCH"

if ! [[ "$BRANCH" =~ ^(feat|feature|refactor|fix|chore|build|style|docs|release)/.+$ ]]; then
  echo "❌ Invalid branch name: '$BRANCH'"
  echo "💡 Use: feature/name, feat/name, fix/bug-name, release/1.0.0, etc."
  exit 1
fi

echo "✅ Branch name OK."
