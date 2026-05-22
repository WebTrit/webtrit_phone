# webtrit_signaling_service_ios

iOS implementation of [`webtrit_signaling_service`](../webtrit_signaling_service/README.md).

---

## How it works

iOS has no persistent background services -- the OS suspends background processes.
The WebSocket always runs directly in the calling isolate.

`WebtritSignalingServiceIos` is a thin subclass of `WebtritSignalingServiceDirect`
(from `webtrit_signaling_service_platform_interface`). All connection logic lives there:
`start()` creates a `SignalingModule`, opens the WebSocket, and replays buffered events
to new subscribers. `attach()` is a no-op -- there is no background service to attach to.

Background call handling on iOS goes through CallKit / PushKit via `webtrit_callkeep`,
not through a persistent signaling service.

---

## Source layout

```
lib/src/
  plugin.dart    - WebtritSignalingServiceIos (extends WebtritSignalingServiceDirect)
```

---

## Related packages

| Package                                                                                                     | Description                                               |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| [`webtrit_signaling_service_platform_interface`](../webtrit_signaling_service_platform_interface/README.md) | Shared interface and `WebtritSignalingServiceDirect` base |
| [`webtrit_signaling_service`](../webtrit_signaling_service/README.md)                                       | Public API aggregator                                     |
| [`webtrit_signaling_service_android`](../webtrit_signaling_service_android/README.md)                       | Android implementation                                    |
