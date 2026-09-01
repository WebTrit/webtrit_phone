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

A discriminated union is a **sealed base with an ordinary class per variant**, not a freezed
union (`PageBackground`, `SupportedFeature`, `BottomMenuTabScheme`). The base holds the
redirecting factories, a `fromJson` that switches on `type`, and the getters common to every
variant; each variant declares its own `type` with its value as the default, and a
`static const jsonSchema = _$<Variant>JsonSchema;` (the generated constant is private to its
library, so nothing outside the file can reach it otherwise). The reason for the shape is the
schema: a freezed union's variants are classes freezed writes, so there is no source class
declaring the fields a variant holds. Adding one is two adjacent things in the same file - see
[Recipes](#recipes).

Custom JSON converters in `lib/converters/`:

- `UriConverter` — `Uri` to and from its string form

Do not add another - it is one of the [rules](#rules-for-extending-the-contract), and the tests
enforce it. A converter makes a field's Dart type differ from what the JSON carries, and the
schema describes the Dart type, so a converted field is published as something no document
contains. That is why `IconDataConfig.codePoint` is a `String` and `embeddedResourceId` is a
`String`.

## Adding a New DTO Property

1. Add field to the class in `lib/models/`.
2. Re-run `build_runner` → regenerates `*.g.dart` / `*.freezed.dart`.
3. Update JSON fixtures in `test/helpers/fixtures.dart` (or `assets/themes/*.json` in parent).
4. Update bridge mapping in `lib/theme/` of the parent project.
5. Consume via `Theme.of(context).extension<T>()` in widgets.

A brand-new **root** type takes two more lines - see [Recipes](#recipes).

Nothing above needs you to remember what the schema can and cannot describe: the shapes that
break it are listed under [Rules for extending the contract](#rules-for-extending-the-contract),
and `dart test` names the rule you broke and what to write instead. Worked examples are in
[Recipes](#recipes).

## Constraints

- **No `flutter/material.dart`** — package must stay platform-independent.
- Never edit `*.g.dart` or `*.freezed.dart` — regenerate via `build_runner`.
- All fields nullable with defaults; never break JSON deserialization on schema evolution.
- `explicitToJson: true` required on nested freezed classes.

## JSON Schema

Every root type publishes the JSON Schema (draft 2020-12) of its JSON. It is not a by-product:
it is what a configurator generates a form from, and what validates a theme document before the
app is asked to parse it. Two guarantees hold and are tested:

- **complete** - every JSON key the generated `toJson` writes appears in the schema (610 keys
  across 132 types);
- **true of the app's own documents** - `test/theme/shipped_theme_validates_test.dart` in the
  parent project runs a real JSON Schema validator over every file in `assets/themes/`, and they
  pass with no errors.

### Getting one out

```bash
dart run bin/print_json_schema.dart                         # inside the package
dart run webtrit_appearance_theme:print_json_schema          # from a dependent package
dart run webtrit_appearance_theme:print_json_schema --list    # available roots
dart run webtrit_appearance_theme:print_json_schema AppConfig --out app_config.schema.json
```

Roots are `ThemeSettings`, `AppConfig` and `EmbeddedResource`. A nested type is not a root: it
already appears in a root's `$defs` and is addressable as `#/$defs/<Type>` - which is how the
theme fragments in `assets/themes/` are validated. `pubspec.yaml` also maps the CLI as the
`webtrit_theme_schema` executable for `dart pub global activate`. Write exports to a gitignored
directory; `*.schema.json` is ignored repo-wide.

In Dart:

```dart
print(const JsonEncoder.withIndent('  ').convert(ThemeSettings.jsonSchema));
```

### How it is put together

| Path | What it is |
|---|---|
| `lib/models/**` | the DTOs. The schema is derived from these and nothing else |
| `lib/builder.dart` | build-time only. Writes the three tables below, and holds `contractViolations` |
| `lib/schema/enum_properties.g.dart` | generated: which properties are enum-typed, the words each accepts, its default |
| `lib/schema/union_variants.g.dart` | generated: which classes each union is made of |
| `lib/schema/nullable_properties.g.dart` | generated: which properties accept `null` |
| `lib/schema/union_assembly.dart` | the three `assemble*` functions that use those tables |
| `bin/print_json_schema.dart` | the CLI, with `_roots` |
| `build.yaml` | declares and applies the builder. It does **not** enable the schema option |

json_serializable writes a `_$<Type>JsonSchema` constant for a class whose annotation carries
`createJsonSchema: true` - the three roots and the 16 union variants, the only ones whose
constant anything reads. Asked for in `build.yaml` instead, it writes one for all 135 annotated
classes, of which 116 are private to their library and read by nothing.

That constant is **private to its library**, so a `jsonSchema` member in the class is the only
way anything outside the file can reach it. A root's wraps the constant in the three assemblies,
which is why it is `static final` rather than `static const`.

What the assemblies add, because the generator will not:

| Gap | What the generator publishes | What the assembly does |
|---|---|---|
| a sealed base declares no fields | an empty object, no variant reached | `oneOf` over the variant classes, their `$defs` lifted in |
| no branch for an enum exists | a bare `{"type": "object"}` | the words it accepts and its default |
| a discriminator is a plain `string` | a document matches several `oneOf` branches at once | pins it with `const`, taken from the `default` already there |
| nullability is dropped | `{"type": "string"}` rejects an explicit `null` | widens to `["string", "null"]`, or an `anyOf` for a `$ref` |

The third one is not theoretical: every `bottomMenu` tab of the shipped `app.config.json` matched
six of the seven variants, so `oneOf` rejected all of them.

The builder reads the source **syntactically** - parsed, not resolved. Resolving a model library
needs its `part` files, which do not exist until freezed and json_serializable have run, and those
in turn need these tables to resolve the roots that import them: a cycle no build phase ordering
escapes. Parsing has none, and the AST moves far less between analyzer majors than the element
model does. The price is that a type counts as an enum, or as a variant, only where this package
declares it - which is where the contract lives.

`build.yaml` names a builder by `package:` URI, so `lib/builder.dart` has to sit under `lib/`
rather than in a generator package of its own. It therefore imports dev dependencies, which
`depend_on_referenced_packages` objects to - silenced at the top of that file, the alternative
being a pure-Dart contract package declaring an analyzer and a formatter as runtime dependencies
of the app. Nothing imports `builder.dart`; `build.yaml` is the only thing that names it, and it
must stay that way.

### Rules for extending the contract

The generator reads **fields off the source class** and knows nothing about a union, an enum or a
converter. Five ordinary-looking things you could write in a DTO make it describe the contract
wrongly, or stop describing it at all - and the first takes `fromJson` and `toJson` down with it,
so the damage is not limited to the schema.

Keep none of this in your head. `test/contract_rules_test.dart` reads this package's own source
and fails with the rule, the type or field, and what to write instead.

| Rule | Write this instead | Why |
|---|---|---|
| **no non-empty collection default** | an empty collection, with the default resolved when read | a non-empty one crashes generation for the whole library, `fromJson`/`toJson` included |
| **no new `JsonConverter`** | a field whose type is the type the JSON carries | the schema describes the Dart type, so a converted field is published as something no document contains. `UriConverter` is the exception - a `Uri` is a string on the wire and is described as one |
| **no freezed union** | a sealed base with an ordinary class per variant | a freezed union's variants are classes freezed writes, and declare no fields the generator can read |
| **state on the class, not a generated impl** | a constructor plus `final` fields, not `const factory X(...) = _X` | a class with no fields of its own is published as an empty object, and the types nested inside it get no `$def` at all |
| **a schema asked for is a schema exposed** | `createJsonSchema: true` together with a `jsonSchema` member, plus an entry in `bin/print_json_schema.dart` for a root | the generated constant is private to its library |

Three things deliberately have **no** rule, because they are read off the source and assembled in:
naming an enum property, listing a union's variants, and marking a field nullable. Add the field
and run `build_runner`.

### Recipes

**A property on an existing type.** Add the field, run `build_runner`. Nothing else - an enum type
or a nullable type is picked up on its own.

```dart
@override
final BoxFitConfig? fit;      // enum + nullable, both handled
```

**A variant of an existing union.** Two adjacent things in the one file, then `build_runner`:

```dart
// on the sealed base
const factory BottomMenuTabScheme.dialer({...}) = DialerTabScheme;

factory BottomMenuTabScheme.fromJson(Map<String, Object?> json) => switch (json['type']) {
  'dialer' => DialerTabScheme.fromJson(json),
  ...
};
```

The variant class itself needs `@JsonSerializable(explicitToJson: true, createJsonSchema: true)`,
a `type` field defaulting to its own word, and
`static const Map<String, Object?> jsonSchema = _$DialerTabSchemeJsonSchema;`. `union_variants.g.dart`
picks it up because it extends the base.

**A new union.** A sealed base with the redirecting factories, a `fromJson` that switches on
`type`, the getters common to every variant, and one class per variant as above. Nothing to
register: the builder finds the base by `sealed` and the variants by `extends`.

**A new root.** Two lines, then `build_runner`:

```dart
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class NewRoot with _$NewRoot {
  // ...
  static final Map<String, Object?> jsonSchema = assembleNullability(
    assembleEnums(assembleUnions(_$NewRootJsonSchema, unionVariants), 'NewRoot', enumProperties),
    'NewRoot',
    nullableProperties,
  );
}
```

and an entry in `_roots` of `bin/print_json_schema.dart`. The three wrappers are independent and
each skips what the root does not reach, so take all three whether or not there is a union or an
enum below it.

### What stays imprecise

`JsonConverter` annotations are ignored, so a converted field is described by its Dart type rather
than by what the JSON carries. That is the reason for the rule against adding one.

### Verifying

```bash
dart run build_runner build     # regenerates the three tables and the schema constants
dart test                        # the contract rules and the published schema
```

| Test | What it catches |
|---|---|
| `test/contract_rules_test.dart` | a DTO written in a shape the schema cannot describe |
| `test/enum_property_test.dart` | a property the schema still describes as a bare object |
| `test/union_schema_test.dart` | a word a decoder takes that the schema does not offer as a variant, and the reverse |
| `test/schema_tables_builder_test.dart` | what the builder reads out of a source file |
| `test/theme/shipped_theme_validates_test.dart` (parent) | a shipped theme document the schema rejects |

Only the first reads the source; the rest read the published schema, so a table that is generated
wrongly fails there rather than passing quietly.

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
