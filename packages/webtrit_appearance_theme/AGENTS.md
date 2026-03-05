# webtrit_appearance_theme

**Pure Dart** package (no Flutter dependency) — theme contract layer for WebTrit Phone.
Contains only DTOs that serialize from/to JSON. The Flutter bridge (`ThemeData`/`ThemeExtension`)
lives in `lib/theme/` of the parent project — it must not live here.

## Class Hierarchy

```
ThemeSettings                        ← root: light + dark variants
  ├── ColorSchemeConfig              ← seed color + ColorSchemeOverride (30+ roles)
  ├── ThemeWidgetConfig              ← widget-level styling (buttons, bars, inputs, dialogs)
  └── ThemePageConfig                ← per-page overrides (call, keypad, login, settings…)
```

`AppConfig` is a separate root (not inside `ThemeSettings`) — defines app behavior and feature flags.

## Key Patterns

All major classes use `@freezed` + `@JsonSerializable`:

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

Sealed unions use `@Freezed(unionKey: 'type')` with discriminated JSON (e.g. `BottomMenuTabScheme`).

Custom JSON converters in `lib/converters/`:

- `HexCodePointConverter` — `0x####` hex strings to int codepoints
- `IntToStringConverter` / `IntToStringOptionalConverter` — legacy migration shims

## Adding a New DTO Property

1. Add field to the class in `lib/models/`.
2. Re-run `build_runner` → regenerates `*.g.dart` / `*.freezed.dart`.
3. Update JSON fixtures in `test/helpers/fixtures.dart` (or `assets/themes/*.json` in parent).
4. Update bridge mapping in `lib/theme/` of the parent project.
5. Consume via `Theme.of(context).extension<T>()` in widgets.

## Constraints

- **No `flutter/material.dart`** — package must stay platform-independent.
- Never edit `*.g.dart` or `*.freezed.dart` — regenerate via `build_runner`.
- All fields nullable with defaults; never break JSON deserialization on schema evolution.
- `explicitToJson: true` required on nested freezed classes.

## Commands

```bash
dart pub get
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs
dart test
dart test test/app_config_main_parsing_test.dart
```

## Code Style

- Line width: 120 characters; single quotes; generated files excluded from analysis.
