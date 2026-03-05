# webtrit_signaling

Pure Dart library implementing the WebTrit Core Signalling protocol — a WebRTC/VoIP signaling
layer over WebSocket. No Flutter dependency, no code generation.

**Protocol docs:** <https://github.com/WebTrit/webtrit_docs/blob/main/signaling/index.md>

## Client Lifecycle

`WebtritSignalingClient` is the single public entry point:

```dart
// 1. Connect (static factory)
final client = await WebtritSignalingClient.connect(baseUrl, tenantId, token, force);

// 2. Register callbacks (single-use; throws StateError if called twice)
client.listen(
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

## Message Hierarchy

```
Event / Request
├── SessionEvent / SessionRequest  (field: transaction)
│   └── RegisteringEvent, RegisteredEvent, UnregisteredEvent, RegistrationFailedEvent…
└── LineEvent / LineRequest        (field: line)
    ├── IceTrickleEvent, IceHangupEvent, TransferEvent…
    └── CallEvent / CallRequest    (field: callId)
        ├── IncomingCallEvent, CallingEvent, RingingEvent, AcceptedEvent, HangupEvent…
        └── OutgoingCallRequest, AcceptRequest, DeclineRequest, HangupRequest…
```

Polymorphic deserialization uses decoder maps keyed by the `type` JSON field — no `if/switch`.

## Key Internals

**Transaction pattern** — `execute(Request)` creates a `Transaction` (auto-generated ID, 10s
timeout) backed by a `Completer`. Resolved when matching response arrives; rejected on timeout
or disconnect.

**Keepalive** — after `StateHandshake`, a recurring timer sends `KeepaliveHandshake` at
`keepaliveInterval`. `StateError` on closed socket is caught and logged — do not add bare
`try/catch` that swallows other errors.

**Inbound message kinds:**

| Kind | JSON key | Class | Direction |
|------|----------|-------|-----------|
| Handshake | `handshake` | `StateHandshake`, `KeepaliveHandshake` | Server → Client |
| Event | `event` | `SessionEvent`, `LineEvent`, `CallEvent` | Server → Client |
| Response | `response` | `AckResponse`, `ErrorResponse` | Server → Client |

## Exception Hierarchy

All extend `WebtritSignalingException`:

- `WebtritSignalingErrorException` — server returned error code
- `WebtritSignalingDisconnectedException` — socket closed unexpectedly
- `WebtritSignalingTransactionTimeoutException` — no response within timeout
- `WebtritSignalingKeepaliveTransactionTimeoutException` — keepalive timed out
- `WebtritSignalingBadStateException` — API misuse (e.g. calling `listen()` twice)

## Constraints

- No code generation (no `build_runner`, `freezed`, `.g.dart`). All models hand-written with `Equatable`.
- No Flutter — package must stay platform-independent.
- Callback API, not streams. `listen()` is single-use.
- Outbound JSON: requests implement `toJson()` — do not bypass.

## Test Patterns

- JSON fixtures in `test/src/events/event_jsons.dart` and `error_event_jsons.dart`.
- `MockWebSocketChannel` + `MockWebSocketSink` via `mocktail`; `StreamController` injects server messages.
- `fake_async` for deterministic keepalive/timeout tests.
- `FakeWebtritSignalingClient` in `test/src/factories/` for higher-level tests.

## Commands

```bash
dart test
dart test test/webtrit_signaling_test.dart
dart test --name "buildTenantUrl"
dart analyze
dart format .
```

Connection endpoint: `wss://<host>/signaling/v1?token=<token>[&force=<true|false>]`
