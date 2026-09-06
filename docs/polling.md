# Background polling

`PollingService` coordinates periodic, lifecycle-triggered, and manual refreshes without overlapping work for the same registration.
Last reviewed: 2026-09-07.

## Scope and current status

This document describes the background polling contract implemented by:

- `lib/services/polling_service.dart`;
- `lib/services/polling_task_handle.dart`;
- `lib/services/polling_worker.dart`;
- `lib/services/connectivity_service.dart`;
- `lib/common/refreshable.dart`;
- `lib/utils/fixed_delay_scheduler.dart`;
- `lib/app/router/main_shell_services.dart`.

The service owns scheduling, connectivity checks, backoff, and task state. A
registered `Refreshable` owns one complete attempt and decides whether it is
still active. Feature orchestration that does not belong to one repository uses
the standard worker and owner structure in
[`polling_workers.md`](polling_workers.md). A consumer receives only the task
capability it needs instead of the ownership handle, another timer, or a
parallel call to the same work.

Most app registrations are still supplied through the `PollingService`
constructor because no consumer needs their handles. External Contacts and CDR
use the worker pattern: their `*Sync` owners retain private registrations and
expose only narrow capabilities or domain methods.

UI pull-to-refresh behavior is a separate concern. See
[`data_refresh.md`](data_refresh.md) for the screens and gestures that expose it.

## Components and ownership

| Component | Responsibility | Lifetime |
|---|---|---|
| `Refreshable` | Provides `refresh()` and the permanent `isActive` opt-out | Repository-defined |
| `PollingWorker` | Defines one finite, disposable feature sync cycle | Owned by its feature owner |
| `PollingWorkerOwner<W>` | Owns a worker registration and exposes narrow task capabilities | Feature subtree |
| `PollingRegistration` | Binds one `Refreshable` instance to a base interval | Stored by `PollingService` |
| `PollingService` | Owns connectivity, lifecycle, scheduling, single-flight, and backoff | Main shell subtree |
| `PollingTaskStateSource` | Exposes read-only, replaying state for one registration | Valid until unregister or service disposal |
| `PollingTaskRunner` | Exposes manual execution without lifecycle control | Valid until unregister or service disposal |
| `PollingTaskHandle` | Combines consumer capabilities with owner-only invalidation and teardown | Valid until unregister or service disposal |
| `FixedDelayScheduler` | Arms the next tick after the current tick completes | One per registration |

`MainShellServices` creates and disposes `PollingService` through the same
provider. Individual handles do not dispose the service. A component may call
`handle.unregister()` only when it owns that registration. Other components
should receive `PollingTaskStateSource` or `PollingTaskRunner`, so they cannot
remove or invalidate a task owned by the composition root. See
[`dependency_ownership.md`](dependency_ownership.md) for the wider application
lifetime rules and [`polling_workers.md`](polling_workers.md) for the standard
feature ownership boundary.

## Core invariants

The contract has seven invariants:

1. One `Refreshable` object identity maps to one registration and one stable
   handle inside a service.
2. At most one refresh started through that registration is in flight.
3. Periodic execution uses fixed delay: the next delay starts after the current
   tick completes, not at a fixed wall-clock rate.
4. Connectivity and app lifecycle control automatic work. `runNow()` is an
   explicit caller request and does not perform a reachability preflight.
5. Only the newest OS connectivity event may publish its liveness result. A
   probe started by an older event cannot overwrite newer evidence.
6. Unregister and service disposal are terminal for a handle. Late completion
   of an already-running refresh cannot move it out of `stopped`.
7. Deferred invalidation uses trailing-edge debounce and preserves one refresh
   after work that started before the latest deadline.

The single-flight guarantee only covers calls routed through the same
`PollingService` registration. A direct call to `repository.refresh()`, a second
service, or a second repository instance bypasses it.

## Execution model

All supported triggers converge on one refresh-cycle runner. Automatic work
passes through foreground and reachability gates; an explicit manual request
does not:

```text
boot / reconnect / resume --+
periodic timer -------------+--> automatic eligibility --+
invalidation deadline ------+    (foreground + network)   |
                                                           +--> one task single-flight
manual runNow() -------------------------------------------+        |
                                                                    v
                                                         Refreshable.refresh()
                                                                    |
                                                                    v
                                                   state result + next schedule
```

Only the cycle runner invokes `Refreshable.refresh()`. It publishes state,
records the result, and completes the future shared by manual callers.

### Trigger behavior

| Trigger | Reachability behavior | If a cycle is active | Failure behavior | Scheduling result |
|---|---|---|---|---|
| Boot or reconnect | Uses the connectivity result that caused the transition | Does not overlap it | Logged; increments automatic backoff | Arms the next periodic tick |
| Foreground resume | Performs one fresh check shared by all registrations | Does not overlap it | Logged; increments automatic backoff | Arms the next periodic tick |
| Periodic tick | Uses the TTL cache or performs a check | Skips the refresh | Logged; increments automatic backoff | Computes the next fixed delay |
| `runNow()` | No service-level preflight | Joins the same future | Returned to the caller | Re-arms one full computed delay after completion |
| `invalidate()` deadline | Uses the TTL cache or performs a check | Waits for an older cycle, then runs once | Logged; increments automatic backoff | Re-arms from the invalidated cycle |

A group-leading cycle is used for boot, reconnect, resume, and adding a new
registration while polling is active. It performs at most one reachability
check, then offers a leading refresh to every current registration. Adding one
task can therefore refresh the existing group as well; it is not a new-task-only
callback.

Automatic triggers never create an overlapping refresh. `runNow()` has stronger
semantics: when a cycle already exists, it joins that cycle and returns its
result. The trigger that originally created the cycle owns its backoff policy.
For example, a manual caller that joins a failing scheduled cycle receives the
error, and that scheduled failure still increments backoff.

## Registration and stable handles

Low-level infrastructure can register a `Refreshable` with its base interval:

```dart
final task = pollingService.register(
  PollingRegistration(
    listener: repository,
    interval: const Duration(minutes: 5),
  ),
);
```

Registering the same listener instance again returns the same handle.

- Same listener and same interval: no scheduling change.
- Same listener and a different interval: the old schedule is invalidated and
  restarted without an extra leading refresh.
- Different listener instance: a separate task, even if it accesses the same
  endpoint.
- Registration after `PollingService.dispose()`: throws `StateError`.

Do not make an unrelated screen re-register a listener only to discover its
handle. Low-level code that creates a registration must keep the full handle at
that ownership boundary and pass only `PollingTaskStateSource`,
`PollingTaskRunner`, or a narrower application-specific capability to
consumers.

Feature workers use `PollingWorkerOwner` instead of retaining the handle by
hand:

```dart
final contactsWorker = ExternalContactsSyncWorker(
  userRepository: userRepository,
  externalContactsRepository: externalContactsRepository,
  contactsRepository: contactsRepository,
);
final contactsSync = ExternalContactsSync(
  worker: contactsWorker,
  pollingService: pollingService,
  interval: const Duration(minutes: 1),
);

final PollingTaskStateSource stateSource = contactsSync;
final PollingTaskRunner runner = contactsSync;
```

The owner registers the worker once, keeps the handle private, and owns both
unregister and worker disposal.

Constructor registrations are convenient when no consumer needs a handle:

```dart
final pollingService = PollingService(
  connectivityService: connectivityService,
  registrations: [
    PollingRegistration(
      listener: userRepository,
      interval: const Duration(seconds: 10),
    ),
  ],
);
```

They follow the same execution rules, but their handles are not exposed by the
constructor. Migrate a task to an explicit owner at the composition boundary
when another component needs on-demand control or state.

## Manual refresh

Use `runNow()` for an on-demand refresh of a registered task:

```dart
final PollingTaskRunner contactsRunner = contactsSync;

try {
  await contactsRunner.runNow();
} catch (error, stackTrace) {
  // Map the repository error to the owning feature's UI or domain state.
}
```

`runNow()` means "run or join now", not "always start a new request".

- Concurrent callers receive the same cycle result.
- A success resets the automatic consecutive-error count.
- A cycle started manually does not increment automatic backoff when it fails.
- A manual call that joins an automatic cycle keeps that cycle's automatic
  backoff semantics.
- After the joined or newly started cycle completes, the periodic timer is
  placed one full computed delay into the future.
- An inactive or unregistered task fails with `StateError`.

Because manual execution skips the service reachability preflight, the
repository remains the source of truth for request errors. This keeps explicit
user actions observable instead of silently turning them into noops when the
cached connectivity state is wrong.

## Deferred invalidation

Low-level task owners use `invalidate(after:)` when a domain event means that
cached data is stale, but the backend may need a short publication delay.
Feature owners expose that through a domain method:

```dart
cdrsSync.requestPostCallRefresh();
```

Invalidation is automatic work, not a manual request. It respects connectivity
and foreground lifecycle checks, and its failure contributes to scheduled
backoff. The call returns immediately; consumers that need the result observe
the handle state.

Repeated invalidations replace the deadline, giving trailing-edge debounce. A
refresh that starts before the deadline does not consume the invalidation: the
service waits for that cycle to finish and then performs one trailing refresh.
If the deadline passes while offline or in the background, the request remains
pending until reconnect or resume. A reconnect or resume leading cycle may
satisfy it, but it cannot run twice.

## Observable state

`PollingTaskStateSource.state` is available synchronously. `states` is
replaying, so a new subscriber immediately receives the current value,
including a connectivity wait that began before that subscriber existed.

| Phase | Meaning |
|---|---|
| `idle` | Registered but no refresh cycle has started |
| `waitingForConnectivity` | Automatic work is paused because the latest connectivity or reachability evidence is offline |
| `running` | One refresh cycle is in flight |
| `succeeded` | The latest cycle completed successfully |
| `failed` | The latest cycle failed; `error` and `stackTrace` describe it |
| `stopped` | The task was unregistered or its service was disposed |

The state also retains:

- `lastStartedAt`;
- `lastSuccessAt`;
- `lastFailureAt`.

A typical sequence is:

```text
idle -> waitingForConnectivity -> running -> succeeded -> running -> failed
                 ^                                             |
                 +---------------------------------------------+
                                                               |
                                                               +--> stopped
```

`stopped` is terminal. It is emitted once and then the state stream closes.
`isRegistered` becomes `false` immediately. If a repository request was already
running, its future still completes for existing callers, but its late result is
not published to the stopped handle.

`waitingForConnectivity` is not a failed refresh and does not increment
backoff. The phase is published when the service receives an offline transition
or an automatic reachability check says that work cannot run. An active cycle
stays `running` and publishes its own eventual result. A later reachable cycle
moves a waiting task through `running` as usual.

Do not infer data freshness from the phase alone. The repository remains the
owner of cached data; the timestamps describe polling attempts, not the age of
every record it exposes.

## Fixed delay, backoff, and jitter

The scheduler is fixed-delay rather than `Timer.periodic`:

```text
refresh starts -> refresh completes -> delay -> next refresh starts
```

This prevents a slow request from accumulating timer callbacks. The computed
delay is:

```text
0 failures: base interval + jitter
1+ failures: min(base interval * 2 ^ failures, maxBackoff) + jitter
```

With a 5-second interval and zero jitter:

| Consecutive automatic failures | Next delay |
|---:|---:|
| 0 | 5 s |
| 1 | 10 s |
| 2 | 20 s |
| 3 | 40 s |

The default cap is 5 minutes. The default jitter adds 0 through 399 ms so tasks
with equal intervals do not continually hit the backend together. A successful
cycle resets the failure count. A manually started failure leaves the current
automatic count unchanged.

Changing an interval, stopping timers, or manually resetting cadence increments
a schedule generation. Timer continuations that crossed an asynchronous
reachability check under an older generation cannot re-arm themselves. This is
the structural stale-tick guard; there is no time-window duplicate suppression.

## Connectivity and application lifecycle

`PollingService` listens to `ConnectivityService.connectionStream` and performs
an initial connectivity probe.

`ConnectivityService` may receive another OS event while the HTTP liveness
probe for the previous event is still in flight. It assigns a monotonically
increasing generation to every event and publishes a probe result only while
that generation is still current. Comparing only transport values is not
enough: `wifi -> none -> wifi` repeats the same value and would otherwise let
the first Wi-Fi probe publish after the second one. This latest-event-wins rule
is owned by the producer so every stream consumer receives ordered evidence.

- An offline transition cancels automatic schedules.
- An online transition starts a group-leading cycle.
- Repeated reports of the same connectivity state do not start another leading
  cycle.
- Reachability results are cached for `reachabilityTtl` and shared where
  possible.
- A reachability result from an older connectivity epoch cannot overwrite newer
  evidence.

With the default `pauseInBackground: true`, moving to the background cancels
automatic schedules. Resuming while connected performs a fresh shared
reachability check and starts a group-leading cycle. Neither an offline event nor
a background transition cancels a repository future that is already running;
the service only prevents new automatic work.

`runNow()` is independent of `_isConnected` and foreground state. The owner must
only expose it where an explicit refresh makes sense, and must handle the
repository error returned while the network is unavailable.

## Options

| Option | Default | Effect |
|---|---:|---|
| `pauseInBackground` | `true` | Stops automatic schedules outside the foreground |
| `verifyReachabilityOnTick` | `true` | Checks reachability before periodic work, subject to the TTL cache |
| `reachabilityTtl` | 30 s | Reuses recent reachability evidence |
| `leadingRefreshRequiresVerify` | `true` | Requires reachability before a group-leading refresh |
| `jitterMaxMs` | 400 ms | Adds a random non-negative delay below this bound |
| `maxBackoff` | 5 min | Caps exponential failure backoff |

Tests normally inject zero jitter and a deterministic backoff policy. Production
code should keep jitter unless synchronized backend load is desired and has been
measured.

## Inactive tasks, unregister, and disposal

`Refreshable.isActive` is a permanent opt-out, not a temporary loading or
connectivity flag. When it becomes `false`, the service unregisters the task on
the next automatic attempt. A manual call detects it immediately, unregisters
the task, and returns `StateError`.

Use `handle.unregister()` for a dynamically owned task. It:

1. removes the listener from the service;
2. invalidates and cancels its schedule;
3. publishes `stopped` and closes the state stream.

Disposing `PollingService` performs the same terminal transition for every
remaining handle and cancels its connectivity subscription. Service-level and
handle-side unregister calls ignore repeats. These operations do not cancel the
repository's own in-flight I/O; a repository that needs cancellation must own
that behavior itself.

## Current application registrations

`lib/app/router/main_shell_services.dart` is the composition root for current
polling tasks. Defaults come from `lib/environment_config.dart` and may be
overridden by the matching dart-define.

| Polling listener | Default interval | Condition |
|---|---:|---|
| `UserRepository` | 10 s | Always |
| `SystemInfoRepository` | 300 s | Always |
| `ExternalContactsSyncWorker` | 60 s | Core supports extensions |
| `CdrsSyncWorker` | 10 s | Call history is enabled for the session |
| `VoicemailRepository` | 300 s | Voicemail is available for the session |
| `CallerIdSettingsRepository` | 300 s | Remote implementation is active |
| `FavoritesRepository` | 300 s | Syncable implementation is active |
| `SipSubscriptionsRepository` | 300 s | Syncable implementation is active |
| `IceServersRepository` | 300 s | Core supplies bundled ICE servers |

All environment interval values must be positive. A missing, invalid, or
non-positive runtime override falls back to its compile-time default.

ICE server ticks have additional repository-level renewal rules; see
[`ice_servers.md`](ice_servers.md). `PollingService` does not inspect those
rules, it only invokes the repository contract.

## Adding or migrating a task

Use this checklist:

1. Decide whether the cycle belongs naturally to one repository. If it does,
   implement `Refreshable`; if it coordinates several dependencies, implement
   the worker pattern from [`polling_workers.md`](polling_workers.md).
2. Make `refresh()` return the real completion and error of one attempt.
3. Override `isActive` only for a permanent end of useful polling.
4. Add a positive environment interval when deployments need configuration.
5. Register the same listener instance at the composition boundary.
6. Keep the full handle inside low-level ownership code. A feature worker must
   use `PollingWorkerOwner`.
7. Pass only `PollingTaskStateSource` or `PollingTaskRunner` when another
   component needs state or manual execution.
8. Remove parallel timers and direct refresh paths for the same action.
9. Keep feature-specific loading and error presentation outside
   `PollingService`.
10. Add unit coverage for timing, failure, lifecycle, and ownership behavior.
11. Add or update Patrol coverage when correctness depends on real app
    lifecycle, connectivity, login, or screen-mount behavior.

Repository refresh should be safe to call again after completion. It may update
its own cache or stream, but it must not create an untracked periodic loop.

## Testing

The deterministic unit contract lives in
`test/services/polling_service_test.dart` and
`test/services/connectivity_service_test.dart`. Standard feature ownership is
covered by `test/services/polling_worker_test.dart`. Together they cover:

- boot, reconnect, resume, background pause, and offline recovery;
- fixed delay, jitter, backoff, and stale timer invalidation;
- stable handle identity, replaying state, and offline availability;
- manual single-flight success and failure;
- deferred invalidation debounce, trailing execution, and lifecycle recovery;
- manual versus automatic backoff ownership;
- interval changes, inactive listeners, unregister, and disposal;
- late completion after a terminal stop;
- out-of-order liveness probes across repeated transports, offline events, and
  disposal;
- worker registration, capability delegation, safe invalidation, and ordered
  idempotent teardown.

Run them with:

```bash
fvm flutter test --no-pub test/services/polling_service_test.dart
fvm flutter test --no-pub test/services/connectivity_service_test.dart
fvm flutter test --no-pub test/services/polling_worker_test.dart
```

The on-device invariants live in:

- `patrol_test/polling_connect_invariant_test.dart`;
- `patrol_test/connectivity_probe_ordering_test.dart`;
- `patrol_test/contacts_worker_sync_e2e_test.dart`;
- `patrol_test/cdr_sync_pagination_e2e_test.dart`.

The connectivity-ordering guard drives a real OS network flap, forces the older
probe to finish last, and verifies that the periodic schedule survives. The
connect invariant asserts one user-info request for login, resume, and network
recovery. The Contacts test covers the worker-driven flow from login through UI
data, self-filtering, manual refresh, resume, offline failure, and network
recovery. The CDR pagination test verifies the initial polling registration and
a three-page finite sync cycle against the local Core and SIP adapter.
See [`integration_test_commands.md`](integration_test_commands.md) for setup and
commands, and [`integration_test_coverage.md`](integration_test_coverage.md) for
the scenario index.

## Feature integrations

### Contacts

`ExternalContactsSyncWorker.refresh()` owns one full cycle: fetch through the
remote gateway, filter out the current user, and merge changed data into the
local store. The worker is the polling listener; the remote repository is a
fetch-only gateway and cannot start a second schedule.

`ExternalContactsSync` owns the worker and its registration. The external tab
calls its feature BLoC refresh action. The BLoC receives
`PollingTaskStateSource` and `PollingTaskRunner`, maps the cycle into feature
state, and invokes `runNow()`. The full handle remains private to the standard
owner. A pull during an automatic cycle therefore joins it instead of starting
a second download.

### CDR

`CdrsSyncWorker.refresh()` owns one finite sync cycle: it fetches the initial
page or drains all incremental pages, persists the fetched records as one
batch, and then writes its completed-sync marker when needed. It owns no timer
or connectivity subscription.

`CdrsSync` extends `PollingWorkerOwner<CdrsSyncWorker>` and owns the worker and
its private polling registration. `CallBloc` receives a callback backed by
`requestPostCallRefresh()`: when a call ends, the owner invalidates the task
with a one-second publication delay. Repeated call-ended events therefore
debounce, an active scheduled cycle cannot overlap them, and the normal
periodic cadence is re-armed after the trailing refresh.

The Full and Missed CDR cubits receive `PollingTaskStateSource` and
`PollingTaskRunner` from `CdrsSync`. Pull-to-refresh invokes the current cubit's
feature action, which awaits `runNow()`, so it joins an active scheduled or
post-call cycle and presents that cycle's completion or failure to the user.
Widgets have no polling dependency, and neither presentation consumer can
invalidate or unregister the app-owned task.

Every failed CDR cycle asks the local repository to report an initial-sync
failure, but the repository emits `CdrsInitialSyncFailed` only while its durable
sync cursor is absent. A manual pull that fails after the first successful sync
therefore updates task state and the pull UI without producing an initial-sync
event.

When the app is already offline, `PollingService` correctly skips the worker,
and publishes `waitingForConnectivity` for the CDR polling task. `CdrsSync`
exposes that replaying state to every CDR list. An empty list releases its
initial loader immediately on that state, including when the screen subscribes
after the offline transition. A slow online cycle remains `running`, so it does
not incorrectly flash an empty state. The next successful repository cycle
still resolves and renders the records.

## Non-goals

`PollingService` does not:

- cache domain data;
- choose UI loading or error states;
- retry inside one repository request;
- cancel repository I/O already in progress;
- deduplicate direct calls or work in another service instance;
- decide whether a feature should exist for the session;
- replace repository-specific freshness rules.
