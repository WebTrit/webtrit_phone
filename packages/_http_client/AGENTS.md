# _http_client

Minimal internal utility package — cross-platform factory for `http.Client` with optional
connection timeouts and custom SSL certificates.

Public API (one function):

```dart
http.Client createHttpClient({Duration? connectionTimeout, TrustedCertificates certs = TrustedCertificates.empty})
```

`TrustedCertificates` is re-exported from the `ssl_certificates` sibling package.

## Architecture

Platform selection via Dart conditional imports in `lib/_http_client.dart`:

| Condition           | File                         | Behavior                                                                                 |
|---------------------|------------------------------|------------------------------------------------------------------------------------------|
| `dart.library.io`   | `src/_http_client_io.dart`   | Native: `IOClient` wrapping `dart:io` `HttpClient` with `SecurityContext`                |
| `dart.library.html` | `src/_http_client_html.dart` | Web: `BrowserClient` (ignores timeout/certs)                                             |
| fallback            | `src/_http_client_stub.dart` | Throws `UnsupportedError`                                                                |

No code generation, no build_runner, no state management.

## Commands

```bash
dart analyze
dart format --line-length 120 lib/
dart test
```

## Code Style

- Line width: 120 characters; single quotes; `package:lints/recommended.yaml`.

## Dependencies

- `http: ^1.5.0` — `Client`, `IOClient`, `BrowserClient`
- `ssl_certificates` (local `../ssl_certificates`) — `TrustedCertificates`, `initializeSecurityContext`
