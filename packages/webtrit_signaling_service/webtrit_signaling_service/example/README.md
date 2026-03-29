# webtrit_signaling_service_example

Demonstrates how to use the `webtrit_signaling_service` plugin.

## Running

Requires a connected Android device (API 26+) or emulator. A real WebTrit Core server is needed
to observe connection and protocol events.

```bash
flutter run -d <device-id>
```

## What it shows

- Configuration form (Core URL, Tenant ID, Token)
- Start / Stop buttons that control the signaling service lifecycle
- Connection status indicator updated in real time from `SignalingModuleEvent`s
- Handshake summary (registration status, keepalive interval, line count)
- Live event log showing all event types as they arrive
