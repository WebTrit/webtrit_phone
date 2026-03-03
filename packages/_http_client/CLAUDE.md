# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Package Purpose

`_http_client` is a minimal internal utility package that provides a single cross-platform factory
function for creating `http.Client` instances with optional connection timeouts and custom SSL
certificates.

Public API (one function):

```dart
http.Client createHttpClient({Duration? connectionTimeout, TrustedCertificates certs = TrustedCertificates.empty})
```

`TrustedCertificates` is re-exported from the `ssl_certificates` sibling package for consumer
convenience.

## Architecture

Platform selection is done at compile time via Dart conditional imports in `lib/_http_client.dart`:

| Condition           | File                         | Behavior                                                                                |
|---------------------|------------------------------|-----------------------------------------------------------------------------------------|
| `dart.library.io`   | `src/_http_client_io.dart`   | Native (Android/iOS): `IOClient` wrapping `dart:io` `HttpClient` with `SecurityContext` |
| `dart.library.html` | `src/_http_client_html.dart` | Web: `BrowserClient` (ignores timeout/certs)                                            |
| fallback            | `src/_http_client_stub.dart` | Throws `UnsupportedError`                                                               |

There is no code generation, no build_runner, and no state management in this package.

## Commands

```bash
# Analyze
dart analyze

# Format
dart format --line-length 120 lib/

# Run tests
dart test
```

## Code Style

- Line width: 120 characters
- Single quotes required (`prefer_single_quotes: true`)
- Follows `package:lints/recommended.yaml`

## Dependencies

- `http: ^1.5.0` — provides `Client`, `IOClient`, `BrowserClient`
- `ssl_certificates` (local path `../ssl_certificates`) — provides `TrustedCertificates` and
  `initializeSecurityContext`
