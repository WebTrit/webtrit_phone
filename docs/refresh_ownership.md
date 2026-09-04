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
- **On-demand refreshes** (a user pulling a list) go through the owner too,
  so they can never race a scheduled tick.

The rule exists because two independent triggers for one endpoint is exactly
how the app used to download the same data twice on every login: a screen
fetched on mount while the connect cycle fetched the same list again within a
second. With one owner that class of duplication cannot exist.

## The port

`OnDemandRefresher` (`lib/common/on_demand_refresher.dart`) is the contract a
consumer declares when it needs a user-driven refresh. It mirrors
`Refreshable`, its sibling in `lib/common`: `Refreshable` is what the owner
asks of a data source ("you can be refreshed"), `OnDemandRefresher` is what a
consumer asks of the owner ("refresh now, on my demand").

Its semantics, implemented by `PollingService.refreshListener()`:

- runs immediately, outside the reachability gate - a user gesture must
  attempt the network and surface its failure, never silently skip;
- reschedules the periodic loop from its completion, so the next tick lands a
  full interval away instead of arriving right after the manual refresh;
- rides an in-flight refresh instead of doubling it - the result arrives
  through the data source's own stream;
- does not swallow errors: the caller decides how to show a failed refresh.

A consumer depends on the port only - it never sees `PollingService`. This is
an instance of the repository-wide pattern described in
[`docs/ports_and_adapters.md`](ports_and_adapters.md); the concrete pieces
here are the port in `lib/common/on_demand_refresher.dart` (consumers depend
on a narrow per-source marker such as `ContactsRefresher`, because dependency
lookup resolves by type and must never hand one source refresher to another
consumer), the adapter in `lib/app/adapters/` binding the service to one
registered listener, and the wiring in
`lib/app/router/main_shell_services.dart` next to the polling registrations,
under the same feature gate - so a consumer can only obtain a port whose
listener the owner actually polls.

## The subscriber contract

A consumer that stopped fetching on its own must still get the first value:
the leading refresh may complete before the consumer subscribes. Therefore a
data source whose fetches are owned by the schedule replays its last known
value to a new stream subscriber (`ExternalContactsRepository.contacts()`,
same idiom as `UserRepository.getAndListen()`). Without the replay, a
broadcast stream would lose the emission and the screen would wait a full
interval for the next tick.

## Migrating the next data source

The external contacts list is the first adopter; the pattern is meant to be
copied. The checklist:

1. The source is registered as a polling listener (most already are).
2. Its stream replays the last known value to a late subscriber.
3. Its consumer stops fetching on mount - subscribing is enough.
4. A user-driven refresh, if the screen has one, goes through its own
   narrow marker port over `OnDemandRefresher` (as `ContactsRefresher`
   does), provided next to the polling registrations, under the same gate.
5. Unit tests pin all three sides: no fetch on start, replay to a late
   subscriber, and the manual refresh delegating to the port.
6. The connect-invariant e2e (`patrol_test/`) gets the endpoint added to its
   single-fetch assertions once the source is migrated.

## Related

- [`docs/ports_and_adapters.md`](ports_and_adapters.md) - the general
  pattern this page instantiates.
- [`docs/data_refresh.md`](data_refresh.md) - the UX side: which screens can
  be pulled and how the gesture behaves.
- [`docs/dependency_ownership.md`](dependency_ownership.md) - who creates and
  disposes the objects involved.
