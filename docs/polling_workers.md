# Polling worker pattern

The polling worker pattern separates one finite feature sync cycle from its scheduling and lifecycle ownership.
Last reviewed: 2026-09-06.

## Scope

This document is the normative contract for feature classes named `*Worker`
that run through `PollingService`. It defines:

- what a polling worker is;
- which dependencies it may own;
- how its registration is owned;
- which capabilities may cross into BLoCs and widgets;
- how new workers are named, placed, and tested.

The scheduler itself is documented in [`polling.md`](polling.md). Application
object lifetimes are documented in
[`dependency_ownership.md`](dependency_ownership.md).

Not every polling listener must become a worker. A repository that naturally
owns one repeatable `refresh()` operation can remain a direct `Refreshable`
registration. Use this pattern when synchronization is feature orchestration
across gateways, repositories, mapping, paging, or persistence, and therefore
does not belong to one repository.

## Standard structure

Every feature polling worker has exactly two roles:

| Role | Standard abstraction | Responsibility |
|---|---|---|
| Cycle executor | `PollingWorker` | Performs one finite domain sync cycle |
| Registration owner | `PollingWorkerOwner<W>` | Registers, exposes safe capabilities, invalidates, and tears down |

The dependency direction is:

```text
widget -> feature action -> BLoC/Cubit -> PollingTaskStateSource -+
                                  |                               |
                                  +------> PollingTaskRunner -----+--> FeatureSync owner
                                                                      |
domain event ----------------> feature-specific method ---------------+
                                                                      |
                                                                      v
                                                              private task handle
                                                                      |
                                                                      v
                                                                PollingService
                                                                      |
                                                                      v
                                                                FeatureSyncWorker
                                                                      |
                                                        remote gateway + local repository
```

Only the owner sees the full `PollingTaskHandle`. A worker does not know that
polling exists. A BLoC or Cubit receives only the capabilities required to map
the task into feature state and actions. A widget depends only on that feature
API, not on polling services.

## `PollingWorker` contract

`lib/services/polling_worker.dart` declares:

```dart
abstract interface class PollingWorker
    implements Refreshable, Disposable {}
```

One `refresh()` call is one complete, finite attempt. An implementation must:

1. start the required remote or local work;
2. await every page and transformation that belongs to the attempt;
3. await durable persistence before completing successfully;
4. preserve the original failure by throwing or rethrowing it;
5. allow another independent call after the previous call completes;
6. report `isActive == false` after disposal;
7. reject `refresh()` after disposal with `StateError`;
8. make repeated `dispose()` calls safe.

The worker must not:

- create `Timer.periodic`, a self-rescheduling timer, or an infinite loop;
- register itself with `PollingService`;
- retain a `PollingTaskHandle`;
- subscribe to connectivity or Flutter application lifecycle events;
- implement cross-cycle single-flight, interval backoff, or task state;
- update BLoC or widget state directly;
- hide a failed cycle by logging and completing successfully.

These rules make completion meaningful. When `refresh()` completes, the
scheduler and every joined manual caller know that the complete cycle is done.
When it fails, `PollingService` can publish the failure and apply the correct
automatic backoff policy.

### Dependencies

A worker may depend on:

- remote repositories or fetch-only gateways;
- local repositories or DAOs through repository interfaces;
- domain mappers and validators;
- a clock or other deterministic cycle input;
- bounded paging required to complete one snapshot;
- bounded retry for an operation inside the current cycle;
- feature-specific policy that decides what the current cycle writes.

A worker must not depend on:

- `PollingService`, `PollingTaskHandle`, or `PollingWorkerOwner`;
- `ConnectivityService` or `WidgetsBinding` lifecycle;
- a BLoC, Cubit, widget, `BuildContext`, or navigation object;
- another timer-based scheduling service;
- a second instance of itself used as a parallel refresh path.

An internal retry is allowed only when it remains part of the same awaited
cycle and has a finite bound. Cross-cycle retry and exponential polling backoff
belong to `PollingService`.

## `PollingWorkerOwner` contract

`PollingWorkerOwner<W>` is the standard lifecycle boundary. Its constructor:

- receives one worker;
- registers that exact instance exactly once;
- retains the full handle privately;
- binds the registration to one configured interval.

The owner implements `PollingTaskStateSource` and `PollingTaskRunner`, so it can
be passed through either narrow interface. It does not expose its worker or
handle.

The base owner also provides `invalidatePollingTask()` to subclasses. This is a
protected domain-trigger building block, not a UI API. It deliberately becomes
a noop after owner disposal or external service teardown, so a late feature
callback cannot synchronously throw while the feature tree is being removed.

Disposal is idempotent and ordered:

```text
mark owner disposed -> unregister task -> dispose worker
```

Unregistering first prevents the scheduler from starting new work while the
worker releases its own resources. Existing repository I/O is not implicitly
cancelled; a worker that supports cancellation must own and await that behavior
inside `dispose()`.

## Feature owner rules

A concrete owner is named for the feature operation, without `Worker`:

```dart
final class ExternalContactsSync
    extends PollingWorkerOwner<ExternalContactsSyncWorker> {
  ExternalContactsSync({
    required super.worker,
    required super.pollingService,
    required super.interval,
  });
}
```

An owner with no feature-specific trigger stays empty. If the domain has an
event such as "a call ended", add a method named in domain language and map it
to protected invalidation:

```dart
void requestPostCallRefresh() {
  invalidatePollingTask(after: const Duration(seconds: 1));
}
```

Do not publish a generic `invalidate()` method from the feature owner. Callers
should express why data became stale, while debounce and cadence remain polling
implementation details.

## Consumer capability rules

Constructor types enforce the permitted operation:

| Consumer need | Inject | Consumer can do |
|---|---|---|
| Map loading, offline, or failure into feature state | `PollingTaskStateSource` into the BLoC or Cubit | Read `state` and subscribe to `states` |
| Handle a feature refresh event | `PollingTaskRunner` into the BLoC or Cubit | Await `runNow()` and emit the result |
| Render state or request refresh | Feature BLoC or Cubit into the widget | Render feature state and invoke feature actions |
| React to a domain event | Feature owner API, for example `CdrsSync.requestPostCallRefresh()` | Request the named domain action |
| Create and destroy a registration | Concrete feature owner only at the composition root | Own the complete lifecycle |

Never inject `PollingTaskHandle` into a widget, BLoC, Cubit, or unrelated
service. It exposes `unregister()` and generic invalidation, so it would let a
consumer destroy or reschedule a task it does not own. Do not inject
`PollingTaskRunner` directly into a widget either; user intent crosses the
presentation boundary as a feature action and the BLoC owns execution.

Passing one concrete owner into two narrowly typed constructor parameters is
intentional. Both consumers share one single-flight registration while the
compiler keeps their permissions separate.

## Registration and lifetime

Create the worker and owner together at the feature composition boundary. In
the current application this is
`lib/app/router/main_shell_services.dart`:

```dart
final worker = ExternalContactsSyncWorker(
  userRepository: context.read<UserRepository>(),
  externalContactsRepository: context.read<ExternalContactsRepository>(),
  contactsRepository: context.read<ContactsRepository>(),
);

return ExternalContactsSync(
  worker: worker,
  pollingService: context.read<PollingService>(),
  interval: interval,
);
```

The provider owns and disposes the concrete owner. It must not also dispose the
worker or unregister the task separately. The owner owns both.

The same worker instance must never be registered by another service. A direct
call to `worker.refresh()` also bypasses the registration's single-flight and
state guarantees. Scheduled work, pull-to-refresh, reconnect, resume, and
domain invalidation must all converge on the one owned registration.

## Errors and feature state

The worker reports domain and persistence failures. `PollingService` converts
the cycle result into task state and owns automatic backoff. The feature maps
that state to its own presentation model.

A manual `runNow()` failure is returned to the BLoC or Cubit. It maps the
failure into feature state; a widget may then show a snack bar while still
rendering cached data. The worker must not know how that failure is presented.

Feature-specific local events may still be emitted by a worker when they
describe committed domain data. Do not reuse an initial-sync event for every
later manual failure; event names and emission conditions must preserve their
domain meaning.

## Naming and file placement

Use the following names consistently:

- `<Feature>SyncWorker` for the finite executor;
- `<Feature>Sync` for its registration owner;
- `syncState` or `syncStateSource` for a `PollingTaskStateSource` field;
- `syncRunner` for a `PollingTaskRunner` field;
- a domain method such as `requestPostCallRefresh()` for invalidation.

Keep a small worker and owner in
`lib/features/<feature>/services/<feature>_sync_worker.dart`. Split them only
when the file becomes difficult to review. The shared abstractions remain in
`lib/services/polling_worker.dart`.

## Test contract

Every new worker or migration needs deterministic unit coverage for:

- one successful cycle, including all paging and persistence;
- the original remote or persistence error reaching the caller;
- a repeated cycle after success and after failure;
- finite retry or timeout behavior owned inside one cycle;
- `isActive` and `refresh()` after disposal;
- idempotent disposal.

The shared owner tests in `test/services/polling_worker_test.dart` cover:

- exact registration identity and interval;
- state and manual-run delegation;
- active invalidation;
- safe invalidation after task stop or owner disposal;
- unregister-before-worker-dispose ordering;
- idempotent teardown.

A feature owner test still verifies that its concrete worker is the object
registered at the composition boundary. BLoC or Cubit tests mock only the
narrow capability they accept, never the full handle. Widget tests mock the
feature BLoC or Cubit, not polling abstractions.

Add Patrol coverage when the invariant depends on real connectivity, app
lifecycle, screen lifetime, or backend paging. Patrol should drive the public
UI path and verify observable requests or stored/rendered data, not call a
worker directly.

## Migration checklist

1. Identify every timer, loop, connectivity subscription, manual refresh, and
   domain-triggered refresh for the feature.
2. Define one finite `refresh()` cycle and make its completion include durable
   persistence.
3. Move that cycle into a `<Feature>SyncWorker implements PollingWorker`.
4. Remove scheduling, lifecycle, and cross-cycle retry from the worker.
5. Create `<Feature>Sync extends PollingWorkerOwner<...>` at the composition
   boundary.
6. Convert domain-triggered refreshes into named owner methods backed by
   `invalidatePollingTask()`.
7. Inject `PollingTaskStateSource` and `PollingTaskRunner` into the feature
   BLoC or Cubit. Keep widgets on the feature API only.
8. Remove direct worker refresh calls and every parallel fetch path.
9. Add worker, owner, consumer, and relevant Patrol coverage.
10. Update this document's adoption status and the feature section in
    [`polling.md`](polling.md).

## Current adoption

### External Contacts

`ExternalContactsSyncWorker` implements the finite cycle and
`ExternalContactsSync` uses the standard owner. The BLoC accepts
`PollingTaskStateSource` and `PollingTaskRunner`; the external Contacts tab
calls `ContactsExternalTabBloc.refresh()` and has no polling dependency.

### CDR migration in progress

On `develop`, `CdrsSyncWorker` still owns its legacy loop. Its migration must
use this same structure: `CdrsSyncWorker implements PollingWorker`, with
`CdrsSync extends PollingWorkerOwner<CdrsSyncWorker>` as the lifecycle owner.
CDR-specific post-call invalidation belongs on `CdrsSync`; task state and manual
refresh reach consumers only through the narrow capabilities above.

## Non-goals

This pattern does not define:

- the interval, backoff, connectivity, or application lifecycle algorithm;
- domain cache schemas or merge policy;
- widget loading and error presentation;
- cancellation of arbitrary repository I/O;
- how direct repository registrations implement their own `refresh()`;
- a generic background-job framework outside `PollingService`.
