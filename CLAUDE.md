# WebTrit Phone — Claude Code Guide

## Common Commands

Melos scripts are defined in `melos.yaml`. Run `melos run` to list all available scripts.
Formatting and linting rules are in `analysis_options.yaml`.

```bash
# Integration tests (Patrol)
patrol develop --dart-define-from-file=../dart_define.json \
  --dart-define-from-file=dart_define.integration_test.json \
  --flavor=deeplinkssmsReceiver

# DB schema (after adding/modifying a table)
dart run bin/create_new_schema_dump_and_test_migration.dart
```

## Project Structure

```
lib/
├── main.dart               # entry point
├── bootstrap.dart          # service initialization
├── environment_config.dart # dart-define env vars
├── app/
│   ├── router/             # AutoRoute (app_router.dart → app_router.gr.dart)
│   ├── view/               # root widget (RootApp)
│   └── session/            # auth guards
├── features/               # feature modules (BLoC + UI)
├── theme/                  # DTO → ThemeData/ThemeExtension bridge
├── repositories/           # data access layer
├── models/                 # domain models
├── mappers/drift/          # Drift ↔ domain model mappers
├── blocs/                  # app-level BLoCs
└── l10n/                   # generated localization
packages/
├── webtrit_appearance_theme/  # theming DTOs (no Flutter deps)
├── data/app_database/         # Drift DB + DAOs
├── webtrit_api/               # REST API client
├── webtrit_signaling/         # signaling protocol
└── webtrit_callkeep/          # call management
```

## Flavors

Android flavors are composed from two flags in `dart_define.json`:

| Variable                             | Value     | Flavor segment        |
|--------------------------------------|-----------|-----------------------|
| `WEBTRIT_APP_LINK_DOMAIN`            | non-empty | `deeplinks`           |
|                                      | empty     | `deeplinksDisabled`   |
| `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` | `"true"`  | `smsReceiver`         |
|                                      | `"false"` | `smsReceiverDisabled` |

Combined example: `--flavor deeplinkssmsReceiver`

## Git Hooks (Lefthook)

See `lefthook.yml` for hook definitions.

---

# Project Rules

## Critical Constraints

- **No Cyrillic** anywhere: source files, comments, strings, logs, identifiers, JSON/YAML keys.
- **No comments** to describe logic, UI structure, or as visual separators. DartDoc only for public
  APIs.
- **No DI frameworks**: no `get_it`, `injectable`, or any Service Locator pattern.

## Code Style

- Required named parameters declared **before** optional named parameters.
- Avoid unnecessary `.0` literals on doubles unless required by the type context.
- Callbacks must be **single-expression only**. Extract multi-statement logic into a private method.

## Import Order

Groups separated by exactly one blank line, each group sorted alphabetically. No section comments.

1. Dart SDK
2. Flutter SDK
3. External dependencies
4. Internal package dependencies (e.g. `webtrit_callkeep`)
5. Project package imports (`package:webtrit_phone/...`)
6. Relative imports

## Flutter & Widget Rules

- Always use `StatelessWidget` classes instead of methods returning widgets (except simple widget
  lists).
- Widgets in `features/<feature>/view/widgets` are **dumb**: no `BlocBuilder` or `context.read`
  inside. All data and callbacks come via constructor.
- `initState`: call `super.initState()` **first**.
- `dispose`: call `super.dispose()` **last**; dispose resources in reverse creation order.
- Use `withValues(alpha: 0.x)` instead of deprecated `withOpacity()`.
- Use `Card` for surfaces needing elevation/shadow. Never use `Container` + `BoxShadow` unless
  `Card` is fundamentally incompatible.

## Architecture

### Monorepo Boundaries

- Local packages live in `packages/`. They must **not** import from `lib/`.
- Features and BLoCs live in `lib/features/`.
- `webtrit_callkeep` is an **external repository** (path configured in `pubspec.yaml`), not part
  of this monorepo. See its `README.md` for full API docs.

### webtrit_callkeep

Provides native call UI integration. Source: <https://github.com/WebTrit/webtrit_callkeep>.
Full docs in its `README.md` (path resolved from `pubspec.yaml`).

- **Interface**: singleton `Callkeep()`, events via `CallkeepDelegate` (`setDelegate`)
- **iOS**: CallKit UI when app is in background/terminated; Flutter UI when in foreground
- **Android**: always Flutter UI + push notification interface (no native ConnectionService UI)
- **Background calls**: iOS via PushKit (`setPushRegistryDelegate`); Android via FCM or persistent
  signaling service (`BackgroundSignalingService`)

### State Management (BLoC/Cubit)

- **Events**: use native Dart `sealed class` + `Equatable`. Do **not** use `freezed` for events.

  ```dart
  sealed class CallEvent extends Equatable { ... }
  ```

- **State**: use `@freezed` for state classes and complex data models.
- **Transformers**: always declare `bloc_concurrency` transformers (`sequential()`, `droppable()`,
  etc.) explicitly when registering event handlers.
- Provide dependencies via `Provider` / `RepositoryProvider` / `MultiProvider`. Pass them through
  constructors.
- Read via `context.read<T>()` for callbacks, `context.watch<T>()` for rebuilds. Never pass
  `BuildContext` into BLoCs or Services.

### Call Architecture

`CallBloc` (`lib/features/call/bloc/call_bloc.dart`) is the central component of the entire app.
It implements both `Bloc<CallEvent, CallState>` and `CallkeepDelegate`, making it the single point
that bridges signaling, native call UI, WebRTC media, and the Flutter UI layer.

#### Responsibilities

- Manages all active calls (`List<ActiveCall>` in state)
- Owns the `WebtritSignalingClient` lifecycle (connect → handshake → events → disconnect)
- Implements `CallkeepDelegate` — native platform calls directly into the BLoC
- Creates and disposes `RTCPeerConnection` per call via `PeerConnectionManager`
- Persists finished calls to `CallLogsRepository`
- Keeps `LinesStateRepository` in sync for the UI

#### Event Categories

| Category | Prefix | Source |
|---|---|---|
| Lifecycle | `CallStarted`, `CallConfigEvent` | App bootstrap |
| Signaling client | `_SignalingClientEvent` | Internal |
| Signaling protocol | `_CallSignalingEvent`, `_HandshakeSignalingEventState` | `WebtritSignalingClient` callbacks |
| Push | `_CallPushEventIncoming` | iOS PushKit / Android FCM isolate |
| User actions | `CallControlEvent` | UI widgets |
| Native perform | `_CallPerformEvent` | `CallkeepDelegate` callbacks |
| WebRTC | `_PeerConnectionEvent` | `RTCPeerConnection` observer |
| UI screen | `CallScreenEvent` | Call screen widget |

#### State Structure

```dart
// CallState (immutable, @freezed)
CallServiceState callServiceState   // signaling + registration + network status
List<ActiveCall> activeCalls        // all current calls
int linesCount                      // SIP lines from handshake
bool? minimized                     // overlay vs full-screen
CallAudioDevice? audioDevice
List<CallAudioDevice> availableAudioDevices
```

#### ActiveCall Processing Status (state machine)

```
incomingFromPush          push arrived, no signaling offer yet
incomingFromOffer         offer received from signaling
incomingPerformingStarted native answer started
incomingInitializingMedia getting mic/camera
incomingAnswering         AcceptRequest sent, waiting for confirmation
─────────────────────────────────────────────────────────────
outgoingCreated           startCall reported to Callkeep
outgoingConnectingToSignaling waiting for signaling session
outgoingInitializingMedia getting mic/camera
outgoingOfferPreparing    creating RTCPeerConnection + offer
outgoingOfferSent         OutgoingCallRequest sent
─────────────────────────────────────────────────────────────
connected                 media flowing (both directions)
disconnecting             hangup sent, cleanup in progress
```

#### Incoming Call Flow

```
Signaling: IncomingCallEvent (JSEP offer)
  → BLoC: reportNewIncomingCall → Callkeep → system UI / Flutter screen
  → User taps Answer
  → CallControlEvent.answered → _CallPerformEvent.answered
  → get user media → RTCPeerConnection → setRemoteDescription(offer)
  → createAnswer → AcceptRequest to signaling
  → Signaling: AcceptedEvent → setRemoteDescription(answer) → connected
```

iOS push path (app backgrounded/killed):

```
PushKit push → didPushIncomingCall → _CallPushEventIncoming
  → ActiveCall(status: incomingFromPush)   ← placeholder until offer arrives
  → signaling connects → IncomingCallEvent enriches the existing ActiveCall
```

#### Outgoing Call Flow

```
UI: CallController.createCall(number, video)
  → CallControlEvent.started
  → callkeep.startCall → performStartCall callback
  → _CallPerformEvent.started
  → wait signaling ready → get user media → RTCPeerConnection
  → createOffer → OutgoingCallRequest to signaling
  → Signaling: AcceptedEvent (remote answer) → setRemoteDescription → connected
```

#### Isolates

Two background isolate managers handle calls when the app is not in the foreground.
Both implement `CallkeepBackgroundServiceDelegate` and must be annotated
`@pragma('vm:entry-point')` to survive tree-shaking.

| Manager | Entry point | Trigger | Reconnect |
|---|---|---|---|
| `PushNotificationIsolateManager` | `onPushNotificationSyncCallback` | Android FCM push | No |
| `SignalingForegroundIsolateManager` | `onSignalingSyncCallback` | Android background service | Yes |

Each isolate initialises its own dependency graph (storage, DB, logger, repositories) because
Flutter isolates share no memory. The isolate receives `CallkeepServiceStatus` and
`CallkeepIncomingCallMetadata` from the native side.

#### Key Patterns

**Perform-event futures** — `CallkeepDelegate` callbacks (`performStartCall`,
`performAnswerCall`, `performEndCall`) are `async` and return `Future<bool>`. The BLoC completes
these futures only after the actual operation finishes, so the native side waits for the result.

**Push enrichment** — an incoming call can arrive via push before signaling is ready. The BLoC
creates a placeholder `ActiveCall(status: incomingFromPush)` and later merges the signaling
offer into it when `IncomingCallEvent` arrives, instead of creating a duplicate entry.

**Disposal barrier** — `PeerConnectionManager` tracks pending disposal futures. Creating a new
`RTCPeerConnection` for a call ID waits until the previous one is fully disposed, preventing
resource races on rapid call sequences.

**Connectivity-aware reconnection** — the BLoC monitors both `AppLifecycleState` and network
connectivity. Reconnection is suppressed when the app is backgrounded with no active calls.
Fast reconnect (0 s delay) is used on manual trigger; slow (6 s) on unexpected disconnect.

**iOS audio reset** — on the first and last call, the BLoC forces audio to earpiece via
`AppleNativeAudioManagement` to work around a platform bug where speaker stays active across
calls.

## Theming

### Architecture Layers

| Layer       | Location                            | Responsibility                                     |
|-------------|-------------------------------------|----------------------------------------------------|
| Contract    | `packages/webtrit_appearance_theme` | Pure Dart DTOs (`String` colors, `double` sizes)   |
| Data        | `assets/themes/*.json`              | Serialized DTOs                                    |
| Bridge      | `lib/theme/`                        | Maps DTOs → Flutter `ThemeData` / `ThemeExtension` |
| Consumption | Widgets                             | `Theme.of(context).extension<T>()`                 |

- `webtrit_appearance_theme` must stay platform-independent: no `flutter/material.dart` imports.
- Never use raw `Colors.xxx` or raw `TextStyle` directly in widgets.
- Use `colorScheme` / `textTheme` only for generic properties from `ColorSchemeConfig` /
  `TextThemeConfig`.

### Custom Styles Convention

- `XStyle`: concrete Flutter properties (e.g. `final ButtonStyle? hangup`).
- `XStyles`: extends `ThemeExtension<XStyles>`, wraps one or more `XStyle` objects.
- Register all new extensions inside `AppThemeData` factory.

### Adding a New Themeable Property

1. Add property to the DTO in `packages/webtrit_appearance_theme`.
2. Run code generation for that package.
3. Update JSON files in `assets/themes/`.
4. Update mapping in `lib/theme/` and the `ThemeExtension`.
5. Consume via extension in the widget.

## Database (Drift)

- Database is fully encapsulated in `packages/data/app_database`.
- Features and BLoCs must use DAOs from `packages/data/app_database/lib/src/daos/`. Never access
  `AppDatabase` directly.
- Use Drift's query builder. Prefer `insertReturning` with `onConflict: DoUpdate(...)` for upserts.
- Timestamps: include `insertedAt` / `updatedAt` where applicable. Do not update `updatedAt`
  manually — triggers handle it.
- Enums: use `intEnum<YourEnum>()`.
- Foreign keys: `customConstraint('NOT NULL REFERENCES table_name(id) ON DELETE CASCADE')`.
- Drift-generated classes must **not** leave the repository layer. Use domain models from
  `lib/models/` in BLoCs and UI. Map via `lib/mappers/drift/`.

### Schema Migration Workflow

1. Create migration file in `packages/data/app_database/lib/src/migrations/` (e.g.
   `migration_v19.dart`) extending `Migration`.
2. Register it in `migrations.dart`.
3. Run: `dart run bin/create_new_schema_dump_and_test_migration.dart`.
4. Write/update migration tests in `test/migrations_test.dart` using `SchemaVerifier`.

## Error Handling

- Never use empty `catch` blocks. Always handle or rethrow the error.
- Use typed exceptions where possible (`on SpecificException catch (e)`).
- Do not swallow errors silently in BLoCs — emit a failure state or rethrow.

## Generated Files

Never manually edit files ending in `.g.dart`, `.freezed.dart`, or `.gr.dart` — they are fully
regenerated by `build_runner`. Edit only the source file and re-run codegen.

## Localization (l10n)

Naming: `<bloc_Name>_<HostWidgetGeneralName><FieldNames>[_<variation>]`

Examples: `lobby_AppBarTitle`, `lobby_AppBarActionsTooltip_settings`,
`login_Button_getPasswordBySMS`

- Sub-features may reuse l10n keys from their parent feature.
- General terms (Yes, No, Ok, Cancel) go in the global namespace.
