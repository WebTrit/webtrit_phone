# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Package Purpose

`webtrit_signaling` is a pure Dart library implementing the WebTrit Core Signalling protocol — a
WebRTC/VoIP signaling layer over WebSocket. It has **no Flutter dependency** and uses no code
generation.

## Common Commands

```bash
# Run all tests
dart test

# Run a single test file
dart test test/webtrit_signaling_test.dart

# Run tests matching a name pattern
dart test --name "buildTenantUrl"

# Lint
dart analyze

# Format
dart format .
```

Line width is 120 characters (`analysis_options.yaml`). Single quotes are enforced.

## Architecture

### Client Lifecycle

`WebtritSignalingClient` is the single public entry point.

```dart
// 1. Connect (static factory)
final client = await
WebtritSignalingClient.connect
(baseUrl, tenantId, token, force);

// 2. Register callbacks (can only be called once; throws StateError otherwise)
client.listen
(
onStateHandshake: (sh) { ... },
onEvent: (e) { ... },
onError: (e, st) { ... },
onDisconnect: (code, reason) { ... },
);

// 3. Send requests and await acknowledgment
await client.execute(HangupRequest(...));

// 4. Disconnect
await client.disconnect();
```

### 3-Level Message Hierarchy

All Events and Requests share a parallel 3-level class hierarchy:

```
Event / Request
├── SessionEvent / SessionRequest  (field: transaction)
│   └── RegisteringEvent, RegisteredEvent, UnregisteredEvent, RegistrationFailedEvent, ...
└── LineEvent / LineRequest        (field: line)
    ├── IceTrickleEvent, IceHangupEvent, TransferEvent, ...
    └── CallEvent / CallRequest    (field: callId)
        ├── IncomingCallEvent, CallingEvent, RingingEvent, AcceptedEvent, HangupEvent, ...
        └── OutgoingCallRequest, AcceptRequest, DeclineRequest, HangupRequest, ...
```

Polymorphic deserialization uses decoder maps keyed by the `type` JSON field at each level — no
`if/switch` chains.

### Transaction Pattern

`execute(Request)` creates a `Transaction` (auto-generated ID, 10-second default timeout) backed by
a `Completer`. The transaction is stored in `_transactions` and resolved when the matching response
arrives. On timeout or disconnect, all pending transactions are completed with
`WebtritSignalingTransactionTerminateByDisconnectException` /
`WebtritSignalingTransactionTimeoutException`.

### Keepalive

After receiving `StateHandshake`, a recurring timer is started at `keepaliveInterval`. On each tick,
a `KeepaliveHandshake` is sent and awaited. If the socket is already closed when the timer fires,
the resulting `StateError` is caught and logged — do not add bare `try/catch` that swallows other
errors here.

### Handshakes vs Events vs Responses

Three distinct inbound message kinds, distinguished by a top-level JSON discriminator:

| Kind      | JSON key    | Class                                    | Direction                             |
|-----------|-------------|------------------------------------------|---------------------------------------|
| Handshake | `handshake` | `StateHandshake`, `KeepaliveHandshake`   | Server → Client                       |
| Event     | `event`     | `SessionEvent`, `LineEvent`, `CallEvent` | Server → Client                       |
| Response  | `response`  | `AckResponse`, `ErrorResponse`           | Server → Client (in reply to request) |

### Exception Hierarchy

All exceptions extend `WebtritSignalingException`. Key subclasses:

- `WebtritSignalingErrorException` — server returned an error code
- `WebtritSignalingDisconnectedException` — socket closed unexpectedly
- `WebtritSignalingTransactionTimeoutException` — no response within timeout
- `WebtritSignalingKeepaliveTransactionTimeoutException` — keepalive timed out
- `WebtritSignalingBadStateException` — API misuse (e.g., calling `listen()` twice)

## Test Patterns

- **JSON fixtures**: shared constants in `test/src/events/event_jsons.dart` and
  `error_event_jsons.dart`.
- **Mock WebSocket**: `MockWebSocketChannel` + `MockWebSocketSink` via `mocktail`; a
  `StreamController` injects server messages.
- **Timer testing**: `fake_async` for deterministic keepalive and timeout scenarios.
- **Test double**: `FakeWebtritSignalingClient` in `test/src/factories/` for higher-level tests that
  depend on this package.

## Key Constraints

- **No code generation**: no `build_runner`, no `freezed`, no `.g.dart` files. All models are
  hand-written with `Equatable`.
- **No Flutter**: package must remain platform-independent.
- **Callback API, not streams**: `listen()` accepts plain Dart callbacks; there is intentionally no
  `Stream<Event>`.
- **`listen()` is single-use**: calling it a second time throws `WebtritSignalingBadStateException`.
  Guard tests accordingly.
- **Outbound JSON**: requests implement `toJson()` and are serialized before sending; do not bypass
  this.

## References

### Protocol Documentation

The official WebTrit Signalling Protocol (WTSP) specification lives in
[WebTrit/webtrit_docs](https://github.com/WebTrit/webtrit_docs):

- [Signaling protocol overview](https://github.com/WebTrit/webtrit_docs/blob/main/signaling/index.md)
- [Handshakes](https://github.com/WebTrit/webtrit_docs/tree/main/signaling/handshake)
- [Requests](https://github.com/WebTrit/webtrit_docs/tree/main/signaling/requests)
- [Events](https://github.com/WebTrit/webtrit_docs/tree/main/signaling/events)
- [Disconnect codes](https://github.com/WebTrit/webtrit_docs/blob/main/signaling/disconnect_codes.md)
- [WebSocket sub-protocol identifier](https://github.com/WebTrit/webtrit_docs/blob/main/signaling/websocket_subprotocol.md):
  `webtrit-protocol`

Connection endpoint pattern: `wss://<host>/signaling/v1?token=<token>[&force=<true|false>]`

### Related Repositories

| Repository                                                              | Role                                                                                        |
|-------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| [WebTrit/webtrit_phone](https://github.com/WebTrit/webtrit_phone)       | Flutter app monorepo — this package lives inside it at `packages/webtrit_signaling/`        |
| [WebTrit/webtrit_adapter](https://github.com/WebTrit/webtrit_adapter)   | Elixir server that implements the WTSP server endpoint (`/signaling/v1`)                    |
| [WebTrit/webtrit_callkeep](https://github.com/WebTrit/webtrit_callkeep) | Flutter plugin for native call UI (CallKit / ConnectionService) used alongside this package |
| [WebTrit/webtrit_docs](https://github.com/WebTrit/webtrit_docs)         | Protocol specification and API documentation                                                |
