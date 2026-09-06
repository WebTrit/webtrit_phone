# Background polling

`PollingService` coordinates periodic, lifecycle-triggered, and manual refreshes without overlapping work for the same registration.
Last reviewed: 2026-09-06.

## Scope and current status

This document describes the background polling contract implemented by:

- `lib/services/polling_service.dart`;
- `lib/services/polling_task_handle.dart`;
- `lib/services/connectivity_service.dart`;
- `lib/common/refreshable.dart`;
- `lib/utils/fixed_delay_scheduler.dart`;
- `lib/app/router/main_shell_services.dart`.

The service owns scheduling, connectivity checks, backoff, and task state. A
repository owns the actual fetch and decides whether it is still active. A
consumer receives only the task capability it needs instead of the ownership
handle, starting another timer, or calling the same `Refreshable.refresh()`
through a parallel path.

Most app registrations are still supplied through the `PollingService`
constructor because no consumer needs their handles. External Contacts is
registered explicitly: `ExternalContactsSync` owns its worker and retains the
handle used by the screen. The CDR migration is called out under
[Migration in progress](#migration-in-progress); it is not current behavior.

UI pull-to-refresh behavior is a separate concern. See
[`data_refresh.md`](data_refresh.md) for the screens and gestures that expose it.

## Components and ownership

| Component | Responsibility | Lifetime |
|---|---|---|
| `Refreshable` | Provides `refresh()` and the permanent `isActive` opt-out | Repository-defined |
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
lifetime rules.

## Core invariants

The contract has six invariants:

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

The single-flight guarantee only covers calls routed through the same
`PollingService` registration. A direct call to `repository.refresh()`, a second
service, or a second repository instance bypasses it.

## Execution model

All supported triggers converge on one refresh-cycle runner:

```text
boot / reconnect / resume ----+
periodic timer ---------------+--> one in-flight refresh --> state --> next schedule
PollingTaskHandle.runNow() ----+
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

Register a repository with its base interval and retain the returned handle at
the composition boundary:

```dart
final contactsWorker = ExternalContactsSyncWorker(
  userRepository: userRepository,
  externalContactsRepository: externalContactsRepository,
  contactsRepository: contactsRepository,
);
final contactsPolling = pollingService.register(
  PollingRegistration(
    listener: contactsWorker,
    interval: const Duration(minutes: 1),
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

Prefer retaining the handle when the registration is created. Do not make an
unrelated screen re-register a repository only to discover its handle. Keep
the full handle with the registration owner and pass `PollingTaskStateSource`,
`PollingTaskRunner`, or a narrower application-specific capability to consumers.

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
constructor. Migrate a task to explicit `register()` at the
composition boundary when another component needs on-demand control or state.

## Manual refresh

Use `runNow()` for an on-demand refresh of a registered task:

```dart
try {
  await contactsPolling.runNow();
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

| Repository | Default interval | Condition |
|---|---:|---|
| `UserRepository` | 10 s | Always |
| `SystemInfoRepository` | 300 s | Always |
| `ExternalContactsSyncWorker` | 60 s | Core supports extensions |
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

1. Implement `Refreshable` on the repository that owns the data fetch.
2. Make `refresh()` return the real completion and error of one attempt.
3. Override `isActive` only for a permanent end of useful polling.
4. Add a positive environment interval when deployments need configuration.
5. Register the same repository instance at the composition boundary.
6. Retain its full handle with the owner and pass only `PollingTaskStateSource`
   or `PollingTaskRunner` when another component needs state or manual execution.
7. Remove parallel timers and direct refresh paths for the same action.
8. Keep feature-specific loading and error presentation outside
   `PollingService`.
9. Add unit coverage for timing, failure, lifecycle, and ownership behavior.
10. Add or update Patrol coverage when correctness depends on real app
    lifecycle, connectivity, login, or screen-mount behavior.

Repository refresh should be safe to call again after completion. It may update
its own cache or stream, but it must not create an untracked periodic loop.

## Testing

The deterministic unit contract lives in
`test/services/polling_service_test.dart` and
`test/services/connectivity_service_test.dart`. It covers:

- boot, reconnect, resume, background pause, and offline recovery;
- fixed delay, jitter, backoff, and stale timer invalidation;
- stable handle identity, replaying state, and offline availability;
- manual single-flight success and failure;
- manual versus automatic backoff ownership;
- interval changes, inactive listeners, unregister, and disposal;
- late completion after a terminal stop.
- out-of-order liveness probes across repeated transports, offline events, and
  disposal.

Run them with:

```bash
fvm flutter test --no-pub test/services/polling_service_test.dart
fvm flutter test --no-pub test/services/connectivity_service_test.dart
```

The on-device invariants live in:

- `patrol_test/polling_connect_invariant_test.dart`;
- `patrol_test/connectivity_probe_ordering_test.dart`;
- `patrol_test/contacts_worker_sync_e2e_test.dart`.

The connectivity-ordering guard drives a real OS network flap, forces the older
probe to finish last, and verifies that the periodic schedule survives. The
connect invariant asserts one user-info request for login, resume, and network
recovery. The Contacts test covers the worker-driven flow from login through UI
data, self-filtering, manual refresh, resume, offline failure, and network
recovery.
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
receives the retained `PollingTaskHandle`: the BLoC maps task state to its
loading/error state, and pull-to-refresh awaits `runNow()`. A pull during an
automatic cycle therefore joins it instead of starting a second download.

## Migration in progress

### CDR

Recent-call synchronization is currently owned by `CdrsSyncWorker`, which has
its own ten-second loop and is not a `PollingService` registration. A later
migration can align it with the same execution and lifecycle contract, but this
document does not describe that future design as current behavior.

## Non-goals

`PollingService` does not:

- cache domain data;
- choose UI loading or error states;
- retry inside one repository request;
- cancel repository I/O already in progress;
- deduplicate direct calls or work in another service instance;
- decide whether a feature should exist for the session;
- replace repository-specific freshness rules.
