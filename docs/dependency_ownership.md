# Who owns the app's dependencies

Which objects the startup path creates, which the widget tree creates, and who is
allowed to shut each of them down.
Last reviewed: 2026-08-20.

## The rule

Every dependency belongs to one of two lifetimes.

**Process-long.** Created by `bootstrap()` (`lib/bootstrap.dart`) and handed to
the `AppDependenciesBuilder` on the spot: `share` for what the screens read, `keep`
for what only has to keep running. The application releases all of it and
nothing else does - `AppDependencies.dispose()` walks what it owns in reverse order
of creation and releases every `Disposable` among them. Because release runs in
reverse, sharing a dependency after whatever it was built from is all the
ordering that is needed, and construction gives that for free.

If startup fails before `build()` transfers ownership to `AppDependencies`,
`bootstrap()` calls `AppDependenciesBuilder.abort()`. It applies the same reverse,
best-effort release contract to the dependencies collected so far, preventing a
partially started application from leaking subscriptions, isolates or controllers.

Concurrent startup waves have an earlier ownership boundary: their results are
not handed to the builder until every sibling succeeds. If one sibling fails, the
wave waits for the others to settle and releases successful `Disposable` results
in reverse declared order. Only after a completely successful wave are its values
registered with the builder and covered by `abort()`.

A shared dependency reaches the tree by value, so no provider can close it. A
provider never passes `dispose:` for something it did not create, and never
performs a process-wide teardown - `DriftIsolate.shutdownAll()`,
`IsolateNameServer.removePortNameMapping`, or closing a `StreamController` that
someone outside the tree still listens to.

There is no lookup by type: a widget is given its dependencies through the
providers the application hands over, and anything needed outside the tree is a
named member of `AppDependencies`, so widening that access is a visible edit.

**Owned by its owner.** A collaborator that belongs to exactly one dependency is
released by that dependency, not by the application: `SessionRepository` closes
the cleanup worker it was built with, `FeatureAccessStreamFactory` closes the
remote configuration service. Anything held by several owners (the API client
factory, for one) stays with the application, or it would be closed twice.

**Subtree-long.** Created by a provider (`create:`) and released by the same
provider (`dispose:`). `lib/app/router/main_shell_services.dart` is the
reference shape: `PollingService` and `CdrsSyncWorker` are built and torn down
in one place.

Two consequences worth spelling out:

- The app releases itself. `RootApp` is one running application: when it leaves
  the tree it releases the registry it was given, so one bootstrap belongs to one
  `RootApp`. A standalone run never gets there, because the process ends first;
  a host that embeds the app - the theme configurator's live preview, which
  relaunches it on every configuration edit - gets the shutdown simply by taking
  the widget down, and has nothing to call.
- The shape of the provider list must not depend on parameter values. A
  conditional entry changes the widget type at its position, and everything
  below it is unmounted and rebuilt - which is exactly when a process-long
  object would be handed out already closed.

## What startup creates

| Object | Resource to release | Who else holds it | Released by |
|---|---|---|---|
| `DatabaseServer` (native only) | database server isolate + the `IsolateNameServer` mapping background isolates use to find it | widgets take client connections from it | the application |
| `ConnectivityService` | plugin subscription, two broadcast controllers, the checker | `PollingService`, `ConnectivityLifecycleService` | the application |
| `SystemInfoRepository` | broadcast controller | `FeatureAccessStreamFactory` (startup level), `PollingService` | the application |
| `LogRecordsRepository` | subscription to the root logger; the file-backed one also owns a rotating appender | - | the application |
| `NativeLogForwarder` | file-watch subscription (Android only) | - | the application |
| `CachedRemoteConfigService` | remote-config subscription + broadcast controller | `FeatureAccessStreamFactory` | its owner, the stream factory |
| `SessionCleanupWorker` | connectivity subscription taken in its constructor | `SessionRepository` | its owner, the session repository |
| `AppLogger` | the remote logging service behind it | - | the application |
| `AppLifecycle` | registers itself as a `WidgetsBindingObserver` | - | the application |
| `Callkeep`, `CallkeepConnections` | native singletons; the shell installs and removes its own listeners | `MainShell` | the shell, for its own listeners |
| `FeatureAccessStreamFactory` | none itself; each `create()` call opens a stream over system info and remote config | `RootApp` | the `StreamProvider` cancels the subscription |
| `AppInfo` | app-id change subscription; also releases a disposable app-id provider | metadata, auth and compatibility consumers | the application (or startup wave before registration) |
| storages, device and package info, themes, certificates, permissions, metadata, api client factory, auth and session repositories | none - plain data or thin wrappers | many | nothing to release |

## What the tree creates

| Object | Where | Released by |
|---|---|---|
| the preference-backed repositories | `RootApp.build` | nothing to release |
| `AppCompatibilityResolver`, `SignalingServiceFactory` | `RootApp.build`, both const | nothing to release |
| `FirebaseMessaging` | `RootApp.build`, plugin singleton | nothing to release |
| `AppDatabaseLifecycleHolder` and `AppDatabase` | `RootApp.build` | itself - it owns the client connection and its lifecycle observer |
| `PollingService`, `CdrsSyncWorker`, session services | `main_shell_services.dart` | the same provider |
| `PrivateGatewayRepository` | `main_shell_repositories.dart` | the same provider |
| `SessionGuard` | `main_shell.dart` | the shell |

## What keeps it honest

- `test/app/app_dependencies_test.dart` covers what the tree receives (shared yes,
  kept no), normal release and startup abort: reverse order of creation, one run
  even under a concurrent second call, and a failing release not stopping the rest.
- `test/app/startup_wave_test.dart` covers wait-all error selection, typed result
  availability and reverse rollback before dependencies reach the builder.
- `test/app/host_theme_mode_provider_test.dart` covers the shape rule for the
  optional theme-mode entry, which sits above every other provider: giving or
  taking away the host mode must not remount what is below it.
