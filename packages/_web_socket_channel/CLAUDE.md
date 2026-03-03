# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Package Purpose

`_web_socket_channel` is an internal platform abstraction layer for WebSocket connectivity. It wraps
`web_socket_channel` and selects the correct implementation at compile time using Dart's conditional
imports (`dart.library.html` for web, `dart.library.io` for native, stub for unsupported platforms).

The package also integrates with the sibling `ssl_certificates` package to apply custom trusted
certificates on native platforms.

## Commands

```bash
# Analyze
dart analyze

# Format (120-character page width, single quotes)
dart format lib/

# Upgrade dependencies
dart pub upgrade
```

## Architecture

### Public API (`lib/_web_socket_channel.dart`)

Two functions form the entire public surface:

- **`connectWebSocket(url, {protocols, connectionTimeout, pingInterval, certs})`** — Opens a
  platform-specific raw socket and returns it as `Future<dynamic>`.
- **`createWebSocketChannel(socket)`** — Wraps the raw socket in a `WebSocketChannel`.

The separation exists so callers can hold the raw socket (e.g., to set `pingInterval` or inspect
state) before handing it to the channel abstraction.

`TrustedCertificates` is re-exported from `ssl_certificates` so consumers only need to import this
package.

### Platform Implementations (`lib/src/`)

| File                            | Platform                 | Key behavior                                                                                                                                                     |
|---------------------------------|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `_web_socket_channel_io.dart`   | Native (dart.library.io) | Creates `SecurityContext` from `TrustedCertificates`, configures `HttpClient` with `connectionTimeout`, sets `pingInterval` on the connected `io.WebSocket`      |
| `_web_socket_channel_html.dart` | Web (dart.library.html)  | Creates `html.WebSocket`, resolves a `Completer` on `onOpen`/`onError`, applies optional `connectionTimeout` via `.timeout()`. SSL and ping are browser-managed. |
| `_web_socket_channel_stub.dart` | Fallback                 | Throws `UnsupportedError` — ensures compilation succeeds on unsupported platforms                                                                                |

### Dependency notes

- `web_socket_channel` is pinned to `^3.0.3`. Version 2.4.1+ introduced a breaking migration to
  `pkg:web` that is incompatible with the current IO/HTML implementation.
- `ssl_certificates` is a local sibling package (`../ssl_certificates`). Its
  `initializeSecurityContext()` helper converts `TrustedCertificates` into a
  `dart:io SecurityContext`.

## Code Style

- Single quotes everywhere (`prefer_single_quotes: true`).
- Line length: 120 characters.
- Linter: `lints/recommended.yaml`.
