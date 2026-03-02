#!/usr/bin/env python3
"""
Claude Code PostToolUse hook: runs prettier on .md files after Write or Edit.

Place in: .claude/hooks/md_formatter.py
Make executable: chmod +x .claude/hooks/md_formatter.py
"""
import json
import subprocess
import sys


def main():
    try:
        data = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    tool_input = data.get('tool_input', {})
    file_path = tool_input.get('file_path', '') or tool_input.get('path', '')

    if not file_path.endswith('.md'):
        sys.exit(0)

    subprocess.run(
        ['npx', '--yes', 'markdownlint-cli2', '--fix', file_path],
        capture_output=True,
    )

    sys.exit(0)


if __name__ == '__main__':
    main()
