# AGENTS.md

WebTrit Phone — Flutter VoIP app, Melos monorepo.
Flutter 3.47.1 (stable), Android SDK 35.0.1.

## Toolchain

- Flutter version is pinned **only** in `.fvmrc` — single source of truth, read by `fvm` locally and by the `webtrit_phone_builder` CI. When you bump it, update the version mentioned above in the same commit. (Older release branches may still carry the legacy `.github/flutter_version.yaml`; the builder falls back to it there.)
- Use `fvm flutter ...` / `fvm dart ...` so the pinned SDK is used; a bare `flutter` from `PATH` may be a different version. The `.fvm/` SDK cache is gitignored — run `fvm install` once per machine.

## Build & Test

```bash
melos bootstrap                                               # install all deps
melos run analyze                                             # lint all packages
melos run test                                                # test all packages
flutter test                                                  # unit/widget (app root)
dart run build_runner build --delete-conflicting-outputs      # codegen
dart run bin/create_new_schema_dump_and_test_migration.dart   # after Drift table changes
```

Every build needs `--dart-define-from-file=dart_define.json` **and** `--no-tree-shake-icons`
(`String.toIconData()` builds `IconData` at runtime, which the icon tree-shaker rejects in release
mode — and every `flutter build` is release by default). The failure lands only after the full
Dart compile, so a missing flag costs a whole build cycle: measured 256 s to fail, 381 s for a
successful web build. The `melos run build:*` scripts already pass both flags; web has no script
yet, so type them:

```bash
flutter build web --dart-define-from-file=dart_define.json --no-tree-shake-icons
```

Android APK/AAB builds additionally need `--flavor` (two flavor dimensions in
`android/app/build.gradle`). Without it Gradle builds all four flavor combinations (measured
569 s) and the tool then reports the misleading "Gradle build failed to produce an .apk file" -
even though the APKs are in `build/app/outputs/flutter-apk/` under flavor-suffixed names; take
one from there instead of re-running. `melos run build:apk` / `build:appbundle` resolve the
flavor from `dart_define.json` (`tool/scripts/android_flavor.sh`); a hand-typed command must pass
it, e.g. `--flavor deeplinkssmsReceiverDisabled`. Selection rule and background:
[`docs/build_verification.md`](docs/build_verification.md).

Before any build, run the cheap checks — `dart format` → `analyze` → `test`. Which check for which
change, measured costs, and how to drive a long build without wasted retries:
[`docs/build_verification.md`](docs/build_verification.md).

## Code Standards

- No Cyrillic in source, comments, logs, strings, or keys, except translation values in localization ARB files (`lib/l10n/arb/*.arb`).
- Comments: no redundant *what* comments that restate the code; comments explain non-obvious *why* (rationale, gotchas, workarounds, links to issues). DartDoc for public APIs.
- No DI frameworks (`get_it`, `injectable`, Service Locator — forbidden).
- Single quotes; 120-char line width.
- Never edit `*.g.dart` / `*.freezed.dart` / `*.gr.dart` — regenerate via `build_runner`.
- Required named params before optional named params.
- Callbacks: single-expression only; extract multi-statement logic to a private method.
- Imports: 6 groups, one blank line between, alphabetical within:
  1. Dart SDK
  2. Flutter SDK
  3. External
  4. Internal packages
  5. `package:webtrit_phone/...`
  6. Relative

## Accessibility

Mandatory for any UI you add or touch - a control shipped without this is a defect.
Full guide, wrapper choice and the traps: [`docs/accessibility.md`](docs/accessibility.md).

- Every interactive control carries a name and, where automation must reach it, a stable
  identifier: wrap it in `SemanticAction` (`.button` for a bare `GestureDetector`/`InkWell`),
  or in `SemanticId` for a screen anchor or a text field. Never wrap a tap target in a plain
  `Semantics(identifier: ...)` - the id then lands on a node above the one carrying the action
  (a raw `Semantics` that declares name, id and action itself is fine, but only with
  `excludeSemantics: true`, or the tappable widgets below keep their own nameless nodes). In-call buttons go
  through `CallActionButton`; `context.showSnackBar` already anchors the snackbar itself.
- Identifiers come from `lib/app/keys.dart` as a `const String ...Id` (paired with a widget `Key`
  built from it when a widget test needs that anchor too); names come from l10n (`<bloc>_SemanticsLabel_<control>`, all four arb files), never a
  hardcoded string. Omit a name only when the framework already provides one (the Android back
  button does) - a second one is announced twice.
- Every screen with controls has a `*_semantics_test.dart`: `expectTapTargetSemantics` per
  control, activation via `tapViaSemantics` (never `tester.tap` - a pointer tap passes while the
  semantics path is broken), and `meetsGuideline(labeledTapTargetGuideline)` over the screen.
- A pre-push gate (`tool/scripts/semantics-gate.sh`) fails the push when a diff adds a raw
  `GestureDetector`/`InkWell`/`InkResponse`/`IconButton` in a file whose added lines wire no
  semantics at all. A control that genuinely needs none takes a trailing
  `// semantics-exempt: <reason>` - an opt-out is a review item, not a loophole.
- After renaming anything in `keys.dart`, grep `patrol_test/` and `integration_test/`:
  `patrol_test/**` is excluded from analysis, so `analyze` stays green and the E2E run breaks.

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
  Exception: localized strings needed inside a callback may close over `context.l10n`, but ONLY
  when the closure is evaluated lazily (after construction). Do NOT call `context.l10n` synchronously
  inside `BlocProvider.create` — it uses `dependOnInheritedWidgetOfExactType` which throws
  "Tried to listen to InheritedWidget in a life-cycle that will never be called again" there.
- Dependency lifetime: everything process-long is built by `bootstrap()` and handed to the
  `AppDependenciesBuilder` right there - `share` for what screens read, `keep` for what only has to keep
  running - and released only by `AppDependencies.dispose()`, which `RootApp` runs when it leaves the
  tree. There is no lookup by type; a provider disposes only what its own `create:` built
  (`main_shell_services.dart` is the reference) and never performs a process-wide teardown. See
  `docs/dependency_ownership.md`.
- DB: DAOs only — never `AppDatabase` directly; Drift-generated classes stay in repo layer.
- Theme: never raw `Colors.xxx` or `TextStyle` in widgets; `Theme.of(context).extension<T>()`.
- Widgets: `StatelessWidget` always (not helper methods); dumb widgets in `features/*/view/widgets/`.
- Tests: `MockClient`/`mocktail` — no real network calls; DB migrations via `SchemaVerifier`.
- Routing (`auto_route`): the `AppRouter.routes` tree must ALWAYS be complete — never gate route
  *declarations* on async/runtime values (server capability, login state, feature flags).
  `routeCollection` is `late final`, built once at router construction (before server `system-info`
  loads), so any `if (capability) AutoRoute(...)` is frozen with whatever the value was at startup;
  later navigation to a route omitted then throws `Failed to navigate to <Route>`. Register every
  variant unconditionally and decide which one to *show* at navigation/build time (e.g.
  `AutoTabsRouter.routes`, guards, initial-tab resolver). Sibling routes may share a `path`
  (`recents`) — `RouteCollection` only requires unique route *names*, and tab matching is name-based.

## Documentation

- `docs/features/features.md` indexes the feature docs; the `docs/` root holds cross-cutting / component and app-level docs.
- Per feature `<name>` (kebab-case): a small one is a single `docs/features/<name>.md`. Split a grown one into `<name>_ux.md` (product/UX: what the user does, screen states, key widgets, in-progress redesign) + `<name>_arch.md` (code/architecture: bloc, events, state machine, flows, isolates, key patterns), and drop the plain `<name>.md` — `features.md` is the index, keep no redundant per-feature index.
- Cross-cutting components shared by several features live at the `docs/` root (e.g. `signaling_architecture_target.md`), not under features/; feature docs link to them rather than repeat them. Scenario docs (flows + diagrams) keep a descriptive name and live by scope — cross-component ones at the root (e.g. `incoming_call_scenarios.md`).
- Each doc: start with a one-line summary + a `Last reviewed:` date; describe current behavior first and put unfinished work under a marked "Redesign / in progress" section; link code by relative path (`lib/features/<name>/...`) and sibling docs relatively; update the doc in the same PR that changes the feature. Plain ASCII (repo convention).
