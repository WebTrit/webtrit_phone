#!/bin/bash

MSG=$(git log -1 --pretty=%B | head -n1)

if ! [[ "$MSG" =~ ^(feat|fix|chore|refactor|test|docs|style|ci|perf|build|revert)(\(.+\))?:\ .+ ]]; then
  echo "❌ Invalid commit message: '$MSG'"
  echo "💡 Use Conventional Commits (e.g., feat: add login form)"
  exit 1
fi

echo "✅ Commit message OK."
