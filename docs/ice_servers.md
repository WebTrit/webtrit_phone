# ICE servers

Where the STUN/TURN servers used for WebRTC come from, how they are cached, and what happens when
the deployment offers none.

Last reviewed: 2026-08-31

## Why it exists

A public STUN server only lets a peer discover its own reflexive address; it cannot relay media, so
calls behind a symmetric NAT fail. Deployments can bundle their own coturn, and the core then serves
its address together with short-lived TURN credentials. The app uses that configuration when it is
there and keeps the public STUN server as its fallback.

## Backend contract

`GET /api/v1/system-info` advertises the capability under `core` - not in `adapter.supported`:

```json
{"core": {"version": "0.36.0", "ice_servers_configured": true}}
```

`GET /api/v1/user/ice-servers` (bearer token) serves the configuration:

```json
{
  "ttl": 43200,
  "ice_servers": [
    {"urls": ["stun:host:3478"]},
    {"username": "1788215689:8", "urls": ["turn:host:3478?transport=udp"], "credential": "..."},
    {"username": "1788215689:8", "urls": ["turns:host:443?transport=tcp"], "credential": "..."}
  ],
  "expires_at": "2026-08-31T22:34:49.607820Z"
}
```

The TURN credentials expire (twelve hours in the example), so a session that outlives the window has
to fetch them again.

## Pieces

| Piece | Where | Role |
|-------|-------|------|
| `getUserIceServers` | `packages/webtrit_api/lib/src/webtrit_api_client.dart` | the request; declared an optional endpoint, so a core without it fails quietly instead of logging a server error |
| `IceServersConfig` | [`../lib/models/ice_servers_config.dart`](../lib/models/ice_servers_config.dart) | the servers, already in `RTCIceServer` shape, plus the single instant their credentials expire |
| `IceServersRepository` | [`../lib/repositories/ice_servers/`](../lib/repositories/ice_servers/) | fetch, cache, renew, and the fallback |
| `CoreSupport.supportsBundledIceServers` | [`../lib/utils/core_support.dart`](../lib/utils/core_support.dart) | the capability flag, read from `core.ice_servers_configured` |
| `IceServersResolver` | [`../lib/features/call/utils/peer_connection_factory.dart`](../lib/features/call/utils/peer_connection_factory.dart) | how a consumer asks for the current servers |

## Resolution

Both WebRTC paths take an `IceServersResolver` - a callback, not a list - so each new peer connection
reads whatever is current at that moment and a renewed TURN credential needs no rebuild:

- calls: `DefaultPeerConnectionFactory`, wired in `lib/app/router/main_shell_blocs.dart`, applies the
  resolved servers whenever the caller passes no explicit configuration;
- the diagnostic network test: `NetworkTesterCubit`, wired in
  `lib/features/settings/features/diagnostic/view/diagnostic_screen_page.dart`, so the candidates it
  gathers are the ones a real call would gather.

`resolveIceServers()` never throws and never returns an empty list. It serves a fresh cached
configuration; otherwise it awaits a first fetch for at most `kIceServersFirstFetchTimeout` (3 s) and
returns `kFallbackRtcIceServers` on timeout or failure. A configuration that is past its renewal
point but not yet expired is served as-is while the renewal runs in the background, so call setup
never waits on it.

Nothing propagates out of a fetch: a failure is logged, reported through
`CrashlyticsUtils.recordError`, and answered with `null`. There is no caller that could act on a
throw - a call resolves the fallback and the next poll retries - and `PollingService` therefore never
sees a failing tick, so its exponential backoff does not apply here and the cadence stays flat.

## Renewal

The repository is a `Refreshable` registered with `PollingService` in
`lib/app/router/main_shell_services.dart` (interval
`WEBTRIT_APP_ICE_SERVERS_REPOSITORY_POLLING_INTERVAL_SECONDS`, 300 s by default) and only when the
core bundles servers - otherwise `EmptyIceServersRepository` is provided, which is not `Refreshable`
at all and so cannot be registered. Only the implementation carries `Refreshable` and `Disposable`;
`IceServersRepository` itself is the one method its consumers call.

Whether the deployment has anything to serve is decided once, by
`CoreSupport.supportsBundledIceServers`, before the repository is built; the repository itself holds
no second opinion and stays `isActive` for the whole session, treating every failure as transient.

A tick is a **noop** unless the cached configuration is due, so a twelve-hour expiration costs one
request per twelve hours rather than one per five minutes. Due means `now` has reached
`expires_at - IceServersConfig.renewalLeadTime` (15 minutes) - renewing ahead of the deadline keeps a
call that starts near the boundary off credentials that expire mid-setup, and leaves room for a
failed attempt to be retried by the next poll.

The model holds no ICE type of its own: `servers` is the list of `RTCIceServer` dictionaries a peer
connection is handed as-is, built once by `IceServersApiMapper` - which is also where an entry
without a URL is dropped, so nothing downstream has to re-check.

The model holds one absolute instant, so the mapper normalizes whatever the backend declared:
`expires_at` when present, otherwise `now + ttl`, and a response carrying neither is treated as
already expired - its servers still serve the call that fetched them, and the next poll asks again.
A backend granting a lifetime shorter than the lead time is therefore refetched every tick, which is
the correct reading of credentials that never live long enough to be renewed early.

A failed fetch is deliberately not cached: the configuration stays due, so the next tick retries
instead of the failure being remembered as a result.

The cache is in memory only. Nothing is written to preferences, so expired credentials cannot
outlive the session, and the cost is one fetch after a cold start.

## Limits

- Applies to **new** peer connections. A call restored after a signaling reconnect does an ICE restart
  on its existing connection and keeps the servers it was created with.
- Background isolates never create peer connections (`CallBloc` is the only site), so they need no ICE
  wiring.
- `IceSettings` (the transport/network filters under media settings) is a separate concern and does not
  interact with this.
