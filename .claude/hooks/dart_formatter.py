#!/usr/bin/env python3
"""PostToolUse hook: auto-format .dart files after Write/Edit/MultiEdit."""

import json
import subprocess
import sys

GENERATED_SUFFIXES = ('.g.dart', '.freezed.dart', '.gr.dart')


def get_file_path(hook_input: dict) -> str | None:
    tool = hook_input.get('tool_name', '')
    params = hook_input.get('tool_input', {})
    if tool in ('Write', 'Edit', 'MultiEdit'):
        return params.get('file_path')
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
        ['dart', 'format', '--line-length', '120', file_path],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print(f'dart format failed: {result.stderr}', file=sys.stderr)
        sys.exit(result.returncode)


if __name__ == '__main__':
    main()