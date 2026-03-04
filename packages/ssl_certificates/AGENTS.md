# ssl_certificates

Minimal Dart package wrapping `dart:io`'s `SecurityContext` to load custom trusted X.509
certificates (e.g. self-signed CAs). No external runtime dependencies — pure Dart stdlib.

## Public API

| File                                | Role                                                    |
|-------------------------------------|---------------------------------------------------------|
| `lib/ssl_certificates.dart`         | Barrel export                                           |
| `lib/src/trusted_certificates.dart` | Data models: `TrustedCertificates`, `TrustCertificate`  |
| `lib/src/securety_context.dart`     | Single function `initializeSecurityContext()`           |

### Data Flow

1. Caller builds `TrustedCertificates` from a list of `TrustCertificate` (raw `List<int>` bytes + optional password).
2. `initializeSecurityContext(trustedCertificates)` returns `SecurityContext?` — `null` when list is empty, otherwise `SecurityContext(withTrustedRoots: true)` with every cert registered via `setTrustedCertificatesBytes`.

### Key Design

- `TrustedCertificates.empty` is a `const` singleton.
- `TrustCertificate` uses a private `_internal` constructor; public factory throws `ArgumentError` if `bytes` is empty.
- Returns `null` (not throws) when no certs configured — callers branch simply without try/catch.

## Known Issues

- `securety_context.dart` has an intentional misspelling ("securety" not "security"). Do not
  rename it without also updating the barrel export `lib/ssl_certificates.dart` and all package
  dependents (`_http_client`, `_web_socket_channel`).
- `README.md` documents `BridgeX509Certificate`; the actual class is `TrustCertificate`. README is outdated.

## Commands

```bash
dart pub get
dart analyze
dart format lib/ --line-length 120
```
