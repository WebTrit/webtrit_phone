# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Purpose

`webtrit_appearance_theme` is a **pure Dart** package (no Flutter dependency) that defines the theme contract layer for WebTrit Phone. It contains only DTOs that serialize from/to JSON, used by the phone app, configurator tools, and builder pipelines. The Flutter bridge layer that maps these DTOs to `ThemeData`/`ThemeExtension` lives in `lib/theme/` of the parent project — it must not live here.

## Commands

```bash
# Install dependencies
dart pub get

# Run code generation (after adding/modifying freezed or json_serializable annotated classes)
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Run all tests
dart test

# Run a single test file
dart test test/app_config_main_parsing_test.dart
```

## Architecture

### Class Hierarchy

```
ThemeSettings                        ← root: light + dark variants of each below
  ├── ColorSchemeConfig              ← seed color + ColorSchemeOverride (30+ roles)
  ├── ThemeWidgetConfig              ← widget-level styling (buttons, bars, inputs, dialogs)
  └── ThemePageConfig                ← per-page overrides (call, keypad, login, settings, …)
```

`AppConfig` is a separate root (not inside `ThemeSettings`). It defines app behavior and feature flags (bottom menu tabs, login modes, call config, contacts, messaging).

### Key Patterns

**All major classes use `@freezed` + `@JsonSerializable`:**
```dart
@freezed
@JsonSerializable(explicitToJson: true)
class FooConfig with _$FooConfig {
  const FooConfig({this.someField});
  final String? someField;
  factory FooConfig.fromJson(Map<String, Object?> json) => _$FooConfigFromJson(json);
  Map<String, Object?> toJson() => _$FooConfigToJson(this);
}
```

**Sealed unions for polymorphic types** use `@Freezed(unionKey: 'type')` with discriminated JSON (e.g., `BottomMenuTabScheme` in `features_config/app_config.dart`).

**Custom JSON converters** live in `lib/converters/`:
- `HexCodePointConverter` — converts `0x####` hex strings to int codepoints (for icon data)
- `IntToStringConverter` / `IntToStringOptionalConverter` — legacy migration shims

### Adding a New DTO Property

1. Add the field to the relevant class in `lib/models/`.
2. Re-run `build_runner` to regenerate `*.g.dart` / `*.freezed.dart`.
3. Update corresponding JSON fixtures in `test/helpers/fixtures.dart` (or `assets/themes/*.json` in the parent project).
4. Update the bridge mapping in `lib/theme/` of the parent project.
5. Consume via `Theme.of(context).extension<T>()` in widgets.

### Constraints

- **No `flutter/material.dart` imports** — this package must stay platform-independent.
- Never manually edit `*.g.dart` or `*.freezed.dart` files — always regenerate via `build_runner`.
- All fields should be nullable with appropriate defaults; avoid breaking JSON deserialization when new fields are added to existing classes.
- `explicitToJson: true` is required on nested freezed classes for proper JSON round-tripping.

## Code Style

- Line width: 120 characters (set in `analysis_options.yaml`).
- Single quotes throughout (`prefer_single_quotes: true`).
- Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from analysis.
