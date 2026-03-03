# AGENTS.md

WebTrit Phone — Flutter VoIP app, Melos monorepo.
Flutter 3.32.4 (stable), Android SDK 35.0.1.

## Build & Test

```bash
melos bootstrap                                               # install all deps
melos run analyze                                             # lint all packages
melos run test                                                # test all packages
flutter test                                                  # unit/widget (app root)
dart run build_runner build --delete-conflicting-outputs      # codegen
dart run bin/create_new_schema_dump_and_test_migration.dart   # after Drift table changes
```

## Code Standards

- No Cyrillic anywhere (source, comments, strings, logs, keys).
- No inline comments — DartDoc only for public APIs.
- No DI frameworks (`get_it`, `injectable`, Service Locator — forbidden).
- Single quotes; 120-char line width.
- Never edit `*.g.dart` / `*.freezed.dart` / `*.gr.dart` — regenerate via `build_runner`.
- Required named params before optional named params.
- Callbacks: single-expression only; extract multi-statement logic to a private method.
- Imports: 6 groups, one blank line between, alphabetical within:
  1. Dart SDK · 2. Flutter SDK · 3. External · 4. Internal packages
  2. `package:webtrit_phone/...` · 6. Relative

## Architecture

```
lib/        → app (features/, theme/, repositories/, models/, blocs/, l10n/)
packages/   → shared libs (must NOT import from lib/)
  webtrit_appearance_theme/  pure Dart theme DTOs
  data/app_database/         Drift DB + DAOs
  webtrit_api/               REST client
  webtrit_signaling/         WebSocket signaling
  webtrit_callkeep/          native call UI (external repo)
```

- State: `@freezed` for state; `sealed class + Equatable` for events (never `freezed` on events).
- BLoC deps via `Provider`/`RepositoryProvider`; never pass `BuildContext` into BLoC/Service.
- DB: DAOs only — never `AppDatabase` directly; Drift-generated classes stay in repo layer.
- Theme: never raw `Colors.xxx` or `TextStyle` in widgets; `Theme.of(context).extension<T>()`.
- Widgets: `StatelessWidget` always (not helper methods); dumb widgets in `features/*/view/widgets/`.
- Tests: `MockClient`/`mocktail` — no real network calls; DB migrations via `SchemaVerifier`.
