#!/bin/bash
set -euo pipefail

PASS=0
FAIL=0

run_test() {
  local name="$1"
  printf "  %-20s " "melos run $name"
  local tmp
  tmp=$(mktemp)
  if melos run "$name" > "$tmp" 2>&1; then
    echo "✓ PASS"
    ((PASS++))
  else
    local code=$?
    echo "✗ FAIL (exit $code)"
    sed 's/^/    /' "$tmp"
    ((FAIL++))
  fi
  rm -f "$tmp"
}

echo "=== Melos Smoke Tests ==="
echo ""

run_test "get"
run_test "fmt:check"
run_test "analyze"
run_test "outdated"
run_test "l10n:generate"
run_test "ide:sync"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
