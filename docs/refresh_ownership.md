# Who owns data refreshes

How periodically refreshed data is fetched, who is allowed to trigger a fetch,
and how a screen asks for one without racing the schedule.
Last reviewed: 2026-09-04.

## The rule

Every periodically refreshed data source has exactly one owner of its fetch
cadence: `PollingService` (`lib/services/polling_service.dart`). Nothing else
fetches such a source on its own - not a bloc on mount, not a screen on
pull-to-refresh. All three triggers flow through the owner:

- **Connect events** (boot, resume, network recovery) run one leading refresh
  for every registered listener.
- **Periodic ticks** run on the listener's interval, scheduled from the
  completion of the previous run, with backoff on errors.
- **Manual refreshes** (a user pulling a list) call the same single-flight
  cycle on the worker, so they can never overlap a scheduled one.

The rule exists because two independent triggers for one endpoint is exactly
how the app used to download the same data twice on every login: a screen
fetched on mount while the connect cycle fetched the same list again within a
second. With one owner that class of duplication cannot exist.

## The worker shape

The listener the owner drives is a sync worker, not a repository and not a
bloc. `ExternalContactsSyncWorker`
(`lib/features/contacts/services/external_contacts_sync_worker.dart`) is the
reference: its `refresh()` is one full cycle - fetch through the fetch-only
remote gateway, apply the domain rules (filter out the current user), merge
into the local store with its transient-error retries - and it exposes a
small status (`syncing`/`synced`/`failed`) for the screens that show
progress. Errors are rethrown, so the schedule owner applies backoff and an
on-demand caller can surface the failure.

Everything around the worker stays passive:

- the remote gateway (`ExternalContactsRepository`) is fetch-only - it
  cannot start a download of its own, so no second trigger can exist - and
  abstract: the paginated v2 contacts API becomes a second implementation
  behind the same contract, walking its pages internally, and the worker
  never learns which generation it talks to;
- screens read the merged data reactively from the local store, exactly as
  before, and the worker's status for the spinner; nobody fetches on mount;
- a screen's pull-to-refresh awaits the worker's own `refresh()`; the
  single-flight guard inside it keeps a pull from overlapping a scheduled
  cycle, and the thrown error lets the screen show the failure.

`CdrsSyncWorker` is the next candidate for this shape: today it runs its own
loop with its own connectivity checks; its cycle maps onto `refresh()` the
same way.

## Migrating the next data source

The external contacts sync is the first adopter; the pattern is meant to be
copied. The checklist:

1. The sync pipeline lives in a worker whose `refresh()` is one full cycle;
   the worker is registered as the polling listener under its feature gate.
2. The remote side is a fetch-only gateway; no other object can trigger the
   download.
3. Screens read results reactively from the store and the worker's status
   for progress - nothing fetches on mount.
4. A user-driven refresh, if the screen has one, awaits the worker's
   single-flight `refresh()`.
5. Unit tests pin the cycle (fetch + rules + merge + statuses + the
   single-flight guard), the consumer's mapping of the status, and the pull
   delegating to the worker.
6. The connect-invariant e2e (`patrol_test/`) gets the endpoint added to its
   single-fetch assertions once the source is migrated.

## Related

- [`docs/data_refresh.md`](data_refresh.md) - the UX side: which screens can
  be pulled and how the gesture behaves.
- [`docs/dependency_ownership.md`](dependency_ownership.md) - who creates and
  disposes the objects involved.
