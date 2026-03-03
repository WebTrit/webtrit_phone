# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

`webtrit_phone_number` is a pure Dart/Flutter utility package responsible for normalizing phone numbers. Its primary purpose is to convert visually similar Unicode digits (e.g., mathematical bold digits like `𝟗`) into their ASCII equivalents before the number is passed to SIP, CallKeep, or dialing logic.

## Commands

```bash
# Run all tests
flutter test

# Run a single test file
flutter test test/src/phone_parser_test.dart

# Analyze code
flutter analyze

# Format code (120-char line width per analysis_options.yaml)
dart format --line-length 120 .
```

## Architecture

The package has a minimal, flat structure:

- `lib/src/constants.dart` — `Constants` class with `allNormalizationMappings`: a large static `Map<String, String>` mapping thousands of Unicode characters (accented letters, styled digits, fullwidth variants, emoji enclosed letters, etc.) to their ASCII equivalents.
- `lib/src/phone_parser.dart` — `PhoneParser` abstract class with a single static method `normalize(String)`. Iterates via `.runes` (Unicode code points, not UTF-16 code units) to correctly handle surrogate-pair characters before looking them up in `allNormalizationMappings`.
- `lib/webtrit_phone_number.dart` — library barrel that exports only `phone_parser.dart` (not `constants.dart`).

## Key Design Decision

Normalization iterates with `.runes` rather than `.split('')`. This is critical: surrogate-pair characters (e.g., `𝟗` at U+1D7D7) would be broken into two orphaned code units by `split('')`, causing lookup misses. `constants.dart` must not be exported publicly — it is an internal implementation detail.

## Code Style

- Linter: `package:lints/recommended.yaml` + `prefer_single_quotes: true`
- Line width: 120 characters
- No external dependencies (only `flutter` SDK and `flutter_test` for dev)
