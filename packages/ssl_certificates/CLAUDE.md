# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Purpose

Minimal Dart package that wraps `dart:io`'s `SecurityContext` to load custom trusted X.509
certificates (e.g. self-signed CAs). No external runtime dependencies — pure Dart stdlib.

## Commands

```bash
dart pub get
dart analyze
dart format lib/ --line-length 120
```

## Architecture

Three files form the entire public API:

| File                                | Role                                                   |
|-------------------------------------|--------------------------------------------------------|
| `lib/ssl_certificates.dart`         | Barrel export                                          |
| `lib/src/trusted_certificates.dart` | Data models: `TrustedCertificates`, `TrustCertificate` |
| `lib/src/securety_context.dart`     | Single function `initializeSecurityContext()`          |

### Data flow

1. Caller builds `TrustedCertificates` from a list of `TrustCertificate` (raw `List<int>` bytes +
   optional password string).
2. `initializeSecurityContext(trustedCertificates)` returns `SecurityContext?` — `null` when the
   list is empty, otherwise a `SecurityContext(withTrustedRoots: true)` with every cert registered
   via `setTrustedCertificatesBytes`.

### Key design choices

- `TrustedCertificates.empty` is a `const` singleton for the no-cert case.
- `TrustCertificate` uses a private `_internal` constructor; the public factory throws
  `ArgumentError` if `bytes` is empty.
- Returning `null` (rather than throwing) when no certs are configured lets callers branch simply
  without try/catch.

## Known Issues

- `securety_context.dart` has a misspelling ("securety" vs "security"). Do not rename it without
  also updating the barrel export `lib/ssl_certificates.dart` and any package dependents.
- `README.md` documents a class named `BridgeX509Certificate`; the actual class is
  `TrustCertificate`. The README is outdated.
