# webtrit_signaling_service (plugin root)

Federated Flutter plugin — standalone signaling service that owns the WebSocket
lifecycle as an Android foreground service (persistent or push-bound) and a
main-isolate module on iOS.

## Package Map

| Package | Role |
|---------|------|
| `webtrit_signaling_service` | Public umbrella — `WebtritSignalingService` façade |
| `webtrit_signaling_service_platform_interface` | Shared contract — `SignalingServicePlatform`, `SignalingModuleEvent`, `SignalingServiceConfig` |
| `webtrit_signaling_service_android` | Android implementation — foreground service + IsolateNameServer hub |
| `webtrit_signaling_service_ios` | iOS implementation — main-isolate `SignalingModule` |

## Sub-package Docs

@webtrit_signaling_service/AGENTS.md
@webtrit_signaling_service_platform_interface/AGENTS.md
@webtrit_signaling_service_android/AGENTS.md
@webtrit_signaling_service_ios/AGENTS.md
