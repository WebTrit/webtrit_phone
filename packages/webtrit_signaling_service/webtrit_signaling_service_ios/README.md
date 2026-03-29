# webtrit_signaling_service_ios

iOS implementation of [`webtrit_signaling_service`](../webtrit_signaling_service/README.md).

On iOS there are no persistent background services — the OS suspends background processes.
The signaling connection therefore runs directly in the main isolate when the app is in the
foreground.

---

## Current state

Fully implemented. `start()` creates a `SignalingModule` directly in the main
isolate and opens the WebSocket connection. `attach()` is a no-op (there is
no background service process on iOS).

---

## Package structure

```text
webtrit_signaling_service_ios/
└── lib/src/
    ├── constants.dart                # connection timeout + reconnect delay
    ├── signaling_client_factory.dart # WebtritSignalingClient factory typedef
    ├── signaling_module.dart         # SignalingModule — WebSocket lifecycle + event stream
    └── plugin.dart                   # WebtritSignalingServiceIos — plugin entry point
```

## How it works

`start()` creates a `SignalingModule`, subscribes to its event stream, and calls `connect()`.
The module manages the `WebtritSignalingClient` lifecycle (connect → handshake → events →
disconnect) and replays its session buffer to any new subscriber.

`attach()` is a no-op — on iOS the module always runs in the main isolate, so there is nothing
to attach to.

Background call handling on iOS goes through CallKit / PushKit (via `webtrit_callkeep`), not
through a persistent signaling service.

---

## Related packages

| Package | Description |
| --- | --- |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md) | Public API aggregator |
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface |
| [`webtrit_signaling_service_android`](../webtrit_signaling_service_android/README.md) | Android implementation |
