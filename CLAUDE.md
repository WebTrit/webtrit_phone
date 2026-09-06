# WebTrit Phone — Claude Code

@AGENTS.md
@docs/features/call_arch.md

## Package Docs

@packages/webtrit_api/AGENTS.md
@packages/webtrit_signaling/AGENTS.md
@packages/data/CLAUDE.md
@packages/webtrit_appearance_theme/AGENTS.md
@packages/_http_client/AGENTS.md
@packages/_web_socket_channel/AGENTS.md
@packages/ssl_certificates/CLAUDE.md
@packages/store_info_extractor/AGENTS.md
@packages/device_auto_rotate/AGENTS.md
@packages/webtrit_phone_number/AGENTS.md

## Gotchas

- **l10n keys**: `<Bloc>_<Widget><Fields>[_<variant>]` — e.g. `lobby_AppBarTitle`, `login_Button_getPasswordBySMS`.
- **l10n workflow**: translations live in git (no TMS). New/changed keys get uk/it/th translations in the SAME PR, then BOTH `melos run l10n:generate` AND `dart run build_runner build` (the l10n mapper is git-tracked; gen-l10n alone silently breaks `parseL10n`), then `melos run l10n:check`. See `docs/localization.md`.
- **initState / dispose**: `super.initState()` first; `super.dispose()` last; dispose in reverse creation order.
- **withValues**: `withValues(alpha: 0.x)` — not deprecated `withOpacity()`.
- **Card not Container**: elevation/shadow → `Card`, not `Container + BoxShadow`.
- **Schema migration**: `dart run bin/create_new_schema_dump_and_test_migration.dart` after any Drift table change.
- **Theming steps**: DTO → codegen → JSON assets → bridge → extension (all 5 steps when adding a theme property).
- **Theme schema root**: a new ROOT DTO in `webtrit_appearance_theme` also needs a `jsonSchema` static in the class plus an entry in `bin/print_json_schema.dart` — the generated constant is private to its library, so without the static the schema is unreachable. A root with a union or an enum below it wraps that constant in `assembleUnions`/`assembleEnums` and is `static final`; see the package AGENTS.md. Nested types need nothing (they land in the root's `$defs`).
- **Theme contract rules**: the schema is generated from fields on the source class, so five DTO shapes break it — a non-empty collection default (crashes generation for the whole library), a new `JsonConverter`, a freezed union, state on a freezed impl instead of the class, and `createJsonSchema` without a `jsonSchema` member. `packages/webtrit_appearance_theme/test/contract_rules_test.dart` fails by name with what to do instead; the rules table is in that package's AGENTS.md.
- **Optional Android features**: no build flavors - deep links and the SMS call trigger are manifest fragments switched by `dart_define.json` (see docs/optional_features.md).
