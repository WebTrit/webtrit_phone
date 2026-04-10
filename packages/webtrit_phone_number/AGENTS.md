# webtrit_phone_number

Pure Dart/Flutter utility package for normalizing phone numbers — converts visually similar
Unicode digits (e.g. mathematical bold `𝟗`) into ASCII equivalents before passing to SIP,
CallKeep, or dialing logic.

## Public API

`PhoneParser.normalize(String)` — single static method. Iterates via `.runes` (Unicode code
points, not UTF-16 code units) and maps each character via `allNormalizationMappings`.

## Architecture

- `lib/src/constants.dart` — `Constants.allNormalizationMappings`: large static `Map<String, String>`
  mapping thousands of Unicode characters (accented letters, styled digits, fullwidth, emoji enclosed
  letters, etc.) to ASCII equivalents. **Not exported publicly.**
- `lib/src/phone_parser.dart` — `PhoneParser` with `normalize(String)`.
- `lib/webtrit_phone_number.dart` — barrel: exports only `phone_parser.dart`.

## Key Design Decision

Must iterate with `.runes`, not `.split('')`. Surrogate-pair characters (e.g. `𝟗` at U+1D7D7)
are broken into two orphaned code units by `split('')`, causing lookup misses.

## Commands

```bash
flutter test
flutter test test/src/phone_parser_test.dart
flutter analyze
dart format --line-length 120 .
```

## Code Style

- `package:lints/recommended.yaml` + `prefer_single_quotes: true`; 120-char line width.
- No external dependencies (only `flutter` SDK and `flutter_test` for dev).
