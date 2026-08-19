# Who owns the app's dependencies

Which objects the startup path creates, which the widget tree creates, and who is
allowed to shut each of them down.
Last reviewed: 2026-08-19.

## The rule

Every dependency belongs to one of two lifetimes.

**Process-long.** Created by `bootstrap()` (`lib/bootstrap.dart`) and released
only there. The tree just reads it: a provider never passes `dispose:` for
something it did not create, and never performs a process-wide teardown -
`DriftIsolate.shutdownAll()`, `IsolateNameServer.removePortNameMapping`, or
closing a `StreamController` that someone outside the tree still listens to.

**Subtree-long.** Created by a provider (`create:`) and released by the same
provider (`dispose:`). `lib/app/router/main_shell_services.dart` is the
reference shape: `PollingService` and `CdrsSyncWorker` are built and torn down
in one place.

Two consequences worth spelling out:

- An embedded host must run the startup teardown itself. The theme
  configurator's live preview boots the whole app inside its own process and
  restarts it on every configuration edit, so anything startup opened stays open
  until the browser tab is reloaded. A standalone run needs no teardown - the
  process ends.
- The shape of the provider list must not depend on parameter values. A
  conditional entry changes the widget type at its position, and everything
  below it is unmounted and rebuilt - which is exactly when a process-long
  object would be handed out already closed.

## What startup creates

| Object | Resource to release | Who else holds it | Released by |
|---|---|---|---|
| `DriftIsolate` (native only) | database server isolate + the `IsolateNameServer` mapping background isolates use to find it | `AppDatabaseLifecycleHolder` in the tree | the tree, through the holder |
| `ConnectivityService` | plugin subscription, two broadcast controllers, the checker | `PollingService`, `ConnectivityLifecycleService` | the tree |
| `SystemInfoRepository` | broadcast controller | `FeatureAccessStreamFactory` (startup level), `PollingService` | the tree |
| `LogRecordsRepository` | subscription to the root logger; the file-backed one also owns a rotating appender | - | the tree |
| `NativeLogForwarder` | file-watch subscription (Android only) | - | the tree |
| `CachedRemoteConfigService` | remote-config subscription + broadcast controller (it does have a `dispose`) | `FeatureAccessStreamFactory` | nobody |
| `SessionCleanupWorker` | connectivity subscription taken in its constructor; it has no `dispose` at all | `SessionRepository` | nobody |
| `AppLogger` | the remote logging service behind it | - | nobody |
| `AppLifecycle` | registers itself as a `WidgetsBindingObserver` | - | nobody |
| `Callkeep`, `CallkeepConnections` | native singletons; the shell installs and removes its own listeners | `MainShell` | the shell, for its own listeners |
| `FeatureAccessStreamFactory` | none itself; each `create()` call opens a stream over system info and remote config | `RootApp` | the `StreamProvider` cancels the subscription |
| storages, device and package info, themes, certificates, permissions, metadata, api client factory, auth and session repositories | none - plain data or thin wrappers | many | nothing to release |

## What the tree creates

| Object | Where | Released by |
|---|---|---|
| the preference-backed repositories | `RootApp.build` | nothing to release |
| `AppCompatibilityResolver`, `SignalingServiceFactory` | `RootApp.build`, both const | nothing to release |
| `FirebaseMessaging` | `RootApp.build`, plugin singleton | nothing to release |
| `AppDatabaseLifecycleHolder` and `AppDatabase` | `RootApp.build` | itself - it owns the connection and its lifecycle observer |
| `PollingService`, `CdrsSyncWorker`, session services | `main_shell_services.dart` | the same provider |
| `PrivateGatewayRepository` | `main_shell_repositories.dart` | the same provider |
| `SessionGuard` | `main_shell.dart` | the shell |

## Known gaps (in progress)

The code does not follow the rule yet. What is open, as of the review date:

- Five providers in `RootApp.build` release objects startup created:
  `ConnectivityService`, `LogRecordsRepository`, `NativeLogForwarder`,
  `SystemInfoRepository`, and - partly - `AppDatabaseLifecycleHolder`, which
  correctly closes its own connection but also shuts down the startup-owned
  database isolate and drops the global name mapping.
- Four objects are released by nobody: `SessionCleanupWorker` (no `dispose`
  exists, and its connectivity subscription keeps retrying stored sessions),
  `CachedRemoteConfigService` (a `dispose` exists but is never called),
  `AppLogger` with its remote logging service, and `AppLifecycle`.
- Cross-ownership: closing `SystemInfoRepository` closes the stream
  `FeatureAccessStreamFactory` feeds the app's feature configuration from, so
  unmounting the tree breaks a startup-level collaborator - no remount needed.
- There is no startup teardown to call, which is why the embedded preview
  accumulates a set of these objects per restart.
- The theme-mode provider in `RootApp.build` is conditional and sits above every
  other provider, so a host that passes it conditionally would remount the whole
  graph below it.
