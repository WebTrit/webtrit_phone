#!/usr/bin/env bash
# Pre-push gate for the Accessibility rule (AGENTS.md, docs/accessibility.md):
# an interactive control added without semantics wiring is a defect, and the
# behavioural test suite stays green when one slips in - only this check and
# review stand in the way.
#
# Scope is deliberately narrow to stay quiet: only lines ADDED since the
# merge-base with origin/develop, only hand-written lib/ sources, and a file
# is flagged only when it adds a raw interactive widget and none of its added
# lines wires any semantics at all. A conscious opt-out is a trailing
# `// semantics-exempt: <reason>` on the flagged line.
set -euo pipefail

base=$(git merge-base origin/develop HEAD 2>/dev/null || true)
if [ -z "$base" ]; then
  echo "semantics-gate: no merge-base with origin/develop; skipping"
  exit 0
fi
if [ "$(git rev-parse HEAD)" = "$base" ]; then
  exit 0
fi

git diff --unified=0 "$base"..HEAD -- 'lib/*.dart' 'lib/**/*.dart' \
    ':(exclude)**/*.g.dart' ':(exclude)**/*.freezed.dart' ':(exclude)**/*.gr.dart' |
awk '
  /^\+\+\+ b\// { file = substr($0, 7); next }
  /^@@/ {
    split($3, parts, ",");
    line = substr(parts[1], 2) - 1;
    next
  }
  /^\+/ && !/^\+\+\+/ {
    line++;
    text = substr($0, 2);
    if (text ~ /SemanticAction|SemanticId|Semantics\(|CallActionButton|semanticLabel|tooltip:/) {
      wired[file] = 1
    }
    if (text ~ /(GestureDetector|InkWell|InkResponse|IconButton)[[:space:]]*\(/ && text !~ /semantics-exempt:/) {
      hits[++n] = file ":" line ": " text;
      hitfile[n] = file
    }
    next
  }
  END {
    bad = 0
    for (i = 1; i <= n; i++) {
      if (!(hitfile[i] in wired)) {
        if (!bad) {
          print "semantics-gate: added interactive controls with no semantics wiring in the same file:"
        }
        print "  " hits[i];
        bad = 1
      }
    }
    if (bad) {
      print ""
      print "Wrap the control in SemanticAction (or SemanticId) - see docs/accessibility.md."
      print "A control that genuinely needs none takes a trailing:  // semantics-exempt: <reason>"
      exit 1
    }
  }
'
