# webtrit_signaling_service

The public-facing package of the `webtrit_signaling_service` federated plugin. Add this package
to your app — it aggregates the iOS and Android implementations automatically.

For the full plugin overview, setup guide, and API reference see the
[root README](../README.md).

---

## Package structure

```text
webtrit_signaling_service/
├── lib/src/
│   └── signaling_service.dart          # WebtritSignalingService — start, events, execute, dispose
├── lib/
│   └── webtrit_signaling_service.dart  # Barrel export
└── example/                            # Runnable demo app
    ├── lib/main.dart
    └── android/
```

---

## Installation

```yaml
dependencies:
  webtrit_signaling_service: ^<version>
```

No additional configuration is needed — the correct platform implementation is selected
automatically via federated plugin endorsement.

---

## API (`WebtritSignalingService`)

### Lifecycle

```dart
final service = WebtritSignalingService();

// Persistent mode (default) — service runs until dispose() is called.
await service.start(config);

// Push-initiated mode — service stops when the Activity is closed.
await service.start(config, mode: SignalingServiceMode.pushBound);

// Attach to an already-running service hub (e.g. Activity opens after a push).
await service.attach();

await service.dispose();
```

### Events

```dart
service.events.listen((event) {
  switch (event) {
    case SignalingConnected():                               break;
    case SignalingHandshakeReceived(:final handshake):      break;
    case SignalingConnectionFailed(:final recommendedReconnectDelay): break;
    case SignalingDisconnected(:final knownCode):           break;
    case SignalingProtocolEvent(:final event):              break;
    default:                                               break;
  }
});
```

Subscribe before calling `start()` or `attach()` — the platform implementation replays the
current session buffer to each new subscriber, so late subscribers still receive the full
current state.

### Sending requests

```dart
await service.execute(HangupRequest(
  transaction: 'tx-1',
  line: 1,
  callId: 'call-abc',
));
```

`execute` throws `StateError` when the service is not connected.

### `SignalingServiceMode`

| Value | Behaviour |
| --- | --- |
| `persistent` | Service runs indefinitely; survives app close; restarted on boot (default) |
| `pushBound` | Service stops when the Activity is removed (`onTaskRemoved`); suited for push-initiated calls |

---

## Example app

[`example/`](example/) is a minimal Flutter app that demonstrates connecting to a WebTrit Core
server and logging all `SignalingModuleEvent`s in real time.

```bash
cd example
flutter run -d <device-id>
```

---

## Related packages

| Package | Description |
| --- | --- |
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface and models |
| [`webtrit_signaling_service_android`](../webtrit_signaling_service_android/README.md) | Android implementation |
| [`webtrit_signaling_service_ios`](../webtrit_signaling_service_ios/README.md) | iOS implementation |
