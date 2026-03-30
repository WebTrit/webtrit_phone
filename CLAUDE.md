# WebTrit Phone — Claude Code

@AGENTS.md
@docs/call_architecture.md

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
@packages/webtrit_signaling_service/webtrit_signaling_service/AGENTS.md
@packages/webtrit_signaling_service/webtrit_signaling_service_platform_interface/AGENTS.md
@packages/webtrit_signaling_service/webtrit_signaling_service_android/AGENTS.md
@packages/webtrit_signaling_service/webtrit_signaling_service_ios/AGENTS.md

## Gotchas

- **l10n keys**: `<Bloc>_<Widget><Fields>[_<variant>]` — e.g. `lobby_AppBarTitle`, `login_Button_getPasswordBySMS`.
- **initState / dispose**: `super.initState()` first; `super.dispose()` last; dispose in reverse creation order.
- **withValues**: `withValues(alpha: 0.x)` — not deprecated `withOpacity()`.
- **Card not Container**: elevation/shadow → `Card`, not `Container + BoxShadow`.
- **Schema migration**: `dart run bin/create_new_schema_dump_and_test_migration.dart` after any Drift table change.
- **Theming steps**: DTO → codegen → JSON assets → bridge → extension (all 5 steps when adding a theme property).
- **Flavor combinator**: `--flavor deeplinkssmsReceiver` = deeplinks + sms receiver (see AGENTS.md for full matrix).
