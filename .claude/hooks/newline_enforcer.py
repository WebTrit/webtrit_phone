#!/usr/bin/env python3
"""PostToolUse hook: ensure text files written or edited end with a newline.

Prevents the "no newline at end of file" warning in Git diffs and code review tools.
Only applies to explicitly allowlisted extensions — all other files are ignored.
"""

import json
import os
import sys
from typing import Optional

# Only these extensions will have a trailing newline enforced.
ALLOWED_EXTENSIONS = {
    '.dart',
    '.yaml', '.yml',
    '.json',
    '.md',
    '.py',
    '.sh',
    '.kt', '.kts',
    '.swift',
    '.gradle',
    '.xml',
    '.html',
    '.txt',
}

# Generated Dart files must never be modified outside of build_runner.
# os.path.splitext('foo.g.dart') returns ('.g', '.dart'), so extension-based
# allowlist alone is not enough — explicit suffix check is required.
GENERATED_DART_SUFFIXES = ('.g.dart', '.freezed.dart', '.gr.dart')


def get_file_path(hook_input: dict) -> Optional[str]:
    """Return the file_path from a Write/Edit/MultiEdit tool call, or None."""
    tool = hook_input.get('tool') or hook_input.get('tool_name', '')
    params = hook_input.get('tool_input', {})
    if tool in ('Write', 'Edit', 'MultiEdit'):
        return params.get('file_path') or params.get('path')
    return None


def should_apply(file_path: str) -> bool:
    if any(file_path.endswith(s) for s in GENERATED_DART_SUFFIXES):
        return False
    _, ext = os.path.splitext(file_path)
    return ext.lower() in ALLOWED_EXTENSIONS


def main() -> None:
    try:
        hook_input = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    file_path = get_file_path(hook_input)
    if not file_path or not os.path.isfile(file_path):
        sys.exit(0)
    if not should_apply(file_path):
        sys.exit(0)

    try:
        with open(file_path, 'rb') as f:
            content = f.read()
    except OSError:
        sys.exit(0)

    if content and not content.endswith(b'\n'):
        with open(file_path, 'ab') as f:
            f.write(b'\n')


if __name__ == '__main__':
    main()
