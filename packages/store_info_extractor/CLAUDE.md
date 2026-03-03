# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run all tests
flutter test

# Run a single test file
flutter test test/src/store_clients/apple_app_store_client_test.dart

# Analyze
dart analyze

# Format (page width: 120)
dart format --line-length=120 .
```

## Architecture

This package fetches app metadata (current version and store URL) from Apple App Store and Google Play Store.

### Platform → Client Dispatch

`StoreInfoExtractor.getStoreInfo(appPackageName)` performs runtime platform detection and delegates to the appropriate client:

| Platform    | Client                  | Endpoint                                      |
|-------------|-------------------------|-----------------------------------------------|
| Android     | `GooglePlayStoreClient` | `play.google.com/store/apps/details?id=<pkg>` |
| iOS / macOS | `AppleAppStoreClient`   | `itunes.apple.com/lookup?bundleId=<pkg>`      |
| Web / other | `StubStoreClient`       | (always returns `null`)                       |

### Client Hierarchy

```
StoreClient (abstract interface)
  └── BaseStoreClient (abstract, holds HTTP client, exposes get())
        ├── AppleAppStoreClient   – JSON response parsing
        ├── GooglePlayStoreClient – HTML regex extraction
        └── StubStoreClient       – no-op
```

### HTTP Client (Conditional Imports)

`src/_http_client/` uses conditional imports to provide a platform-specific `Client`:

- `_http_client_io.dart` — `IOClient` wrapping `HttpClient` (Android/iOS)
- `_http_client_html.dart` — `BrowserClient` (Web)
- `_http_client.dart` — throws `UnsupportedError` (fallback)

### Key Types

- **`StoreInfo`** — `{Version version, Uri viewUrl}` returned on success; `null` means the app was not found in that store.
- **`StoreInfoExtractorException`** — base exception; subclasses: `StoreInfoExtractorResponseError` (HTTP status errors), `StoreInfoExtractorResponseFormatException` (parse failures).

### Parsing Notes

- Apple: parses `results[0].version` and `results[0].trackViewUrl` from the iTunes JSON response.
- Google: scrapes Play Store HTML using the regex `\[\[\["(\d+\.\d+\.\d+)"\]\]` — brittle against markup changes.
- Versions are validated via `pub_semver`'s `Version.parse`.

### Tests

Tests use `http/testing.dart`'s `MockClient` and live under `test/src/store_clients/`. Each test verifies the outgoing request URL/headers and version extraction from a fixture response body.
