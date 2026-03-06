#!/usr/bin/env python3
"""PostToolUse hook: ensure every text file written or edited ends with a newline.

Prevents the "no newline at end of file" warning in Git diffs and code review tools.
Applies to all text-based file types; silently skips binary files and generated Dart files.

Generated Dart files (*.g.dart, *.freezed.dart, *.gr.dart) are skipped because
they are managed exclusively by build_runner.
"""

import json
import os
import sys
from typing import Optional

# Extensions treated as binary or otherwise not touched.
BINARY_EXTENSIONS = {
    '.png', '.jpg', '.jpeg', '.gif', '.ico', '.webp',
    '.ttf', '.otf', '.woff', '.woff2',
    '.pdf', '.zip', '.tar', '.gz',
    '.jks', '.keystore', '.p12', '.pem', '.key', '.p8',
}

# Generated Dart files must never be modified outside of build_runner.
GENERATED_DART_SUFFIXES = ('.g.dart', '.freezed.dart', '.gr.dart')


def get_file_path(hook_input: dict) -> Optional[str]:
    """Return the file_path from a Write/Edit/MultiEdit tool call, or None."""
    tool = hook_input.get('tool') or hook_input.get('tool_name', '')
    params = hook_input.get('tool_input', {})
    if tool in ('Write', 'Edit', 'MultiEdit'):
        return params.get('file_path') or params.get('path')
    return None


def should_skip(file_path: str) -> bool:
    _, ext = os.path.splitext(file_path)
    if ext.lower() in BINARY_EXTENSIONS:
        return True
    if any(file_path.endswith(s) for s in GENERATED_DART_SUFFIXES):
        return True
    return False


def main() -> None:
    try:
        hook_input = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    file_path = get_file_path(hook_input)
    if not file_path or not os.path.isfile(file_path):
        sys.exit(0)
    if should_skip(file_path):
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
