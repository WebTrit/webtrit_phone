# store_info_extractor

Fetches app metadata (current version and store URL) from Apple App Store and Google Play Store.

## Architecture

`StoreInfoExtractor.getStoreInfo(appPackageName)` performs runtime platform detection:

| Platform    | Client                  | Endpoint                                      |
|-------------|-------------------------|-----------------------------------------------|
| Android     | `GooglePlayStoreClient` | `play.google.com/store/apps/details?id=<pkg>` |
| iOS / macOS | `AppleAppStoreClient`   | `itunes.apple.com/lookup?bundleId=<pkg>`      |
| Web / other | `StubStoreClient`       | always returns `null`                         |

### Client Hierarchy

```
StoreClient (abstract interface)
  └── BaseStoreClient (abstract, holds HTTP client, exposes get())
        ├── AppleAppStoreClient   – JSON response parsing
        ├── GooglePlayStoreClient – HTML regex extraction
        └── StubStoreClient       – no-op
```

### HTTP Client (Conditional Imports)

- `_http_client_io.dart` — `IOClient` wrapping `HttpClient` (Android/iOS)
- `_http_client_html.dart` — `BrowserClient` (Web)
- `_http_client.dart` — throws `UnsupportedError` (fallback)

### Key Types

- **`StoreInfo`** — `{Version version, Uri viewUrl}`; `null` = app not found in store.
- **`StoreInfoExtractorException`** — base; subclasses: `StoreInfoExtractorResponseError`,
  `StoreInfoExtractorResponseFormatException`.

### Parsing Notes

- Apple: `results[0].version` + `results[0].trackViewUrl` from iTunes JSON.
- Google: scrapes Play HTML with regex `\[\[\["(\d+\.\d+\.\d+)"\]\]` — brittle against markup changes.
- Versions validated via `pub_semver`'s `Version.parse`.

## Commands

```bash
flutter test
flutter test test/src/store_clients/apple_app_store_client_test.dart
dart analyze
dart format --line-length=120 .
```

Tests use `http/testing.dart`'s `MockClient`. Each test verifies the outgoing request URL/headers
and version extraction from a fixture response body.
