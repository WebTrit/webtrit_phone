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

Sealed unions use `@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)` with
discriminated JSON (e.g. `BottomMenuTabScheme`). The values they accept are a wire contract -
[Wire Contract](#wire-contract) below is the authority on them.

Custom JSON converters in `lib/converters/`:

- `HexCodePointConverter` — `0x####` hex strings to int codepoints
- `IntToStringConverter` / `IntToStringOptionalConverter` — legacy migration shims

## Wire Contract

The strings below are what a deployed release parses. The configurator's backend keeps an
inventory of every `Class.field` a release reads, and refuses a release that removes a path or
changes a type. Nothing in this section may be renamed, re-cased or deleted without a
hand-written bridge entry on the backend side.

### Sealed unions

All three discriminate on `type`. The values are the constructor names, and the authority is
the `switch (json['type'])` in the matching `*.freezed.dart` - not the annotation.

| Class | Values on the wire |
| --- | --- |
| `PageBackground` | `solid`, `gradient`, `image` |
| `SupportedFeature` | `themeMode`, `videoCall`, `loggingConfig`, `systemNotifications`, `hybridPresence`, `callPull` |
| `BottomMenuTabScheme` | `favorites`, `recents`, `contacts`, `keypad`, `messaging`, `voicemail`, `embedded` |

All three state `unionValueCase: FreezedUnionCase.none`, so a multi-word factory added to any
of them arrives camelCase. `PageBackground` carried `snake` from the commit that introduced it
(#814) until it was made explicit: the union has only ever had single-word factories, so that
rule never produced a snake_cased value, and dropping it left the generated files
byte-identical. It was historical, not a property of backgrounds - the package now has one
rule rather than a divergence to remember.

`test/wire_contract_test.dart` holds this table through `fromJson`/`toJson`. A renamed factory,
a changed `unionValueCase` and a dropped variant each fail it. Adding a variant does not - an
addition is what the registry accepts - so add the new value to both the test and the table.

### The `$ref` key

`ImageSource.ref` is written as `$ref` (`lib/models/resources/image_source.dart`) - the only
raw-string key in the package, and the JSON Schema keyword for a reference. As a child of
`properties` it is an ordinary property name, but a schema walker that resolves references
before it descends will follow it and lose every path underneath: the first flattener written
against this schema produced 23 paths instead of 610. Treat the children of `properties` as
names, never as keywords. The plain `type` property on `ShapeBorderConfig`,
`AppConfigSettingsItem`, `AppConfigLoginQrFormat` and `AppConfigModeSelectAction` has the same
exposure.

The key stays. It has been on the wire since 1.11.0, so a rename is a removal plus an addition
in the inventory's eyes, and a config still sending `$ref` would fall back to the `asset`
default without an error.

### Empty objects

`AppConfigContactList` (`contacts.list`) and `AppConfigSms` (`messaging.sms`) declare no fields
and serialize as `{}`. They hold their slot beside `contacts.details` and `messaging.chats`;
the stock `assets/themes/app.config.json` marks the first "Not implemented yet". They
contribute no path to the inventory, and removing them would take `contacts.list` and
`messaging.sms` out of it - a removal, refused at the gate, for nothing gained. Fill them or
leave them; do not delete them.

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
