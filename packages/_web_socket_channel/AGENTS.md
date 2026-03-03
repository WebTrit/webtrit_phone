# _web_socket_channel

Internal platform abstraction for WebSocket connectivity. Wraps `web_socket_channel` with
conditional imports; integrates with `ssl_certificates` for custom certificates on native.

## Public API

Two functions form the entire public surface:

- **`connectWebSocket(url, {protocols, connectionTimeout, pingInterval, certs})`** — opens a
  platform-specific raw socket, returns `Future<dynamic>`.
- **`createWebSocketChannel(socket)`** — wraps the raw socket in a `WebSocketChannel`.

`TrustedCertificates` is re-exported from `ssl_certificates`.

## Architecture

| File                            | Platform                 | Key behavior                                                                                     |
|---------------------------------|--------------------------|--------------------------------------------------------------------------------------------------|
| `_web_socket_channel_io.dart`   | Native (dart.library.io) | `SecurityContext` from certs, `connectionTimeout`, `pingInterval` on `io.WebSocket`              |
| `_web_socket_channel_html.dart` | Web (dart.library.html)  | `html.WebSocket`, resolves `Completer` on open/error, optional `.timeout()`. SSL/ping browser-managed. |
| `_web_socket_channel_stub.dart` | Fallback                 | Throws `UnsupportedError`                                                                        |

`web_socket_channel` pinned to `^3.0.3` — v2.4.1+ introduced a breaking `pkg:web` migration
incompatible with the current IO/HTML implementation.

## Commands

```bash
dart analyze
dart format lib/
dart pub upgrade
```

## Code Style

- Single quotes; 120-char line width; `lints/recommended.yaml`.
