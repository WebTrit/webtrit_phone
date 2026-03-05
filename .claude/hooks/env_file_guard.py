#!/usr/bin/env python3
"""
Claude Code PreToolUse hook: blocks reading/writing .env files.

Place in: .claude/hooks/env_file_guard.py
Make executable: chmod +x .claude/hooks/env_file_guard.py
"""
import json
import sys
import re

ENV_RE = re.compile(r'\.env($|\.)', re.IGNORECASE)

READ_COMMANDS_RE = re.compile(
    r'\b(cat|less|more|head|tail|bat|view|nano|vim?|code|open|type|'
    r'strings|xxd|hexdump|od|base64)\b'
)


def main():
    try:
        data = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    tool = data.get('tool', '')
    tool_input = data.get('tool_input', {})

    if tool in ('Bash', 'Run'):
        command = tool_input.get('command', '')
        if READ_COMMANDS_RE.search(command) and ENV_RE.search(command):
            print(
                '🚫 BLOCKED: This command reads a .env file. '
                'Environment files contain secrets and must not be read by the agent.',
                file=sys.stderr,
            )
            sys.exit(2)

        write_re = re.compile(r'\b(cp|mv|scp|rsync|tar|zip)\b')
        if write_re.search(command) and ENV_RE.search(command):
            print(
                '🚫 BLOCKED: This command copies/moves a .env file. '
                'Secrets must not be transferred by the agent.',
                file=sys.stderr,
            )
            sys.exit(2)

        if re.search(r'\b(find|grep|rg|ag|fd)\b', command) and ENV_RE.search(command):
            print(
                '🚫 BLOCKED: This command searches for .env files. '
                'Secret files must not be scanned by the agent.',
                file=sys.stderr,
            )
            sys.exit(2)

    if tool in ('Read', 'View', 'Edit', 'Write', 'MultiEdit'):
        file_path = tool_input.get('file_path', '') or tool_input.get('path', '')
        if ENV_RE.search(file_path):
            print(
                f'🚫 BLOCKED: Cannot access \'{file_path}\' — '
                '.env files contain secrets and must not be accessed by the agent.',
                file=sys.stderr,
            )
            sys.exit(2)

    sys.exit(0)


if __name__ == '__main__':
    main()
