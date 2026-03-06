#!/usr/bin/env python3
"""PostToolUse hook: auto-format .dart files after Write/Edit/MultiEdit.

Runs `dart format` on every .dart file that Claude writes or edits.
Line width is intentionally omitted — dart format reads `formatter.page_width`
from analysis_options.yaml automatically (Dart 3.7+), so the project setting
is always respected without duplication.

Generated files (*.g.dart, *.freezed.dart, *.gr.dart) are skipped because
they must never be hand-edited or reformatted outside of build_runner.
"""

import json
import subprocess
import sys
from typing import Optional

# Suffixes that identify auto-generated Dart files — never reformat these.
GENERATED_SUFFIXES = ('.g.dart', '.freezed.dart', '.gr.dart')


def get_file_path(hook_input: dict) -> Optional[str]:
    """Return the file_path from a Write/Edit/MultiEdit tool call, or None."""
    tool = hook_input.get('tool') or hook_input.get('tool_name', '')
    params = hook_input.get('tool_input', {})
    if tool in ('Write', 'Edit', 'MultiEdit'):
        return params.get('file_path') or params.get('path')
    return None


def main() -> None:
    try:
        hook_input = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    file_path = get_file_path(hook_input)

    if not file_path:
        sys.exit(0)
    if not file_path.endswith('.dart'):
        sys.exit(0)
    if any(file_path.endswith(s) for s in GENERATED_SUFFIXES):
        sys.exit(0)

    result = subprocess.run(
        ['dart', 'format', file_path],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print(
            f'dart format failed for {file_path} with exit code {result.returncode}\n'
            f'stdout:\n{result.stdout}\n'
            f'stderr:\n{result.stderr}',
            file=sys.stderr,
        )


if __name__ == '__main__':
    main()
