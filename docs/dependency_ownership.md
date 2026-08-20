# Who owns the app's dependencies

Which objects the startup path creates, which the widget tree creates, and who is
allowed to shut each of them down.
Last reviewed: 2026-08-20.

## The rule

Every dependency belongs to one of two lifetimes.

**Process-long.** Created by `bootstrap()` (`lib/bootstrap.dart`), registered in
the `InstanceRegistry`, and released by that registry alone - `dispose()` walks
its entries in reverse registration order and releases every `Disposable` among
them. A provider never passes `dispose:` for something it did not create, and
never performs a process-wide teardown - `DriftIsolate.shutdownAll()`,
`IsolateNameServer.removePortNameMapping`, or closing a `StreamController` that
someone outside the tree still listens to.

Because the registry releases in reverse, registration order is part of the
contract: register a dependency after whatever it was built from.

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
| `DatabaseServer` (native only) | database server isolate + the `IsolateNameServer` mapping background isolates use to find it | widgets take client connections from it | the registry |
| `ConnectivityService` | plugin subscription, two broadcast controllers, the checker | `PollingService`, `ConnectivityLifecycleService` | the registry |
| `SystemInfoRepository` | broadcast controller | `FeatureAccessStreamFactory` (startup level), `PollingService` | the registry |
| `LogRecordsRepository` | subscription to the root logger; the file-backed one also owns a rotating appender | - | the registry |
| `NativeLogForwarder` | file-watch subscription (Android only) | - | the registry |
| `CachedRemoteConfigService` | remote-config subscription + broadcast controller | `FeatureAccessStreamFactory` | the registry |
| `SessionCleanupWorker` | connectivity subscription taken in its constructor | `SessionRepository` | the registry |
| `AppLogger` | the remote logging service behind it | - | the registry |
| `AppLifecycle` | registers itself as a `WidgetsBindingObserver` | - | the registry |
| `Callkeep`, `CallkeepConnections` | native singletons; the shell installs and removes its own listeners | `MainShell` | the shell, for its own listeners |
| `FeatureAccessStreamFactory` | none itself; each `create()` call opens a stream over system info and remote config | `RootApp` | the `StreamProvider` cancels the subscription |
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

- `test/common/instance_registry_test.dart` covers the release: reverse order,
  one run even under a concurrent second call, a failing release not stopping
  the rest, and a released registry refusing to hand instances out.
- `test/app/host_theme_mode_provider_test.dart` covers the shape rule for the
  optional theme-mode entry, which sits above every other provider: giving or
  taking away the host mode must not remount what is below it.
