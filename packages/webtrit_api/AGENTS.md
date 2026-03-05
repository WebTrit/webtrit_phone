# webtrit_api

Standalone Dart library — typed REST API client for the WebTrit Core backend.
No Flutter dependency, no dependency on `lib/`.

**Backend API reference (Swagger UI):** <https://webtrit.github.io/webtrit_core_pages/>

## Entry Point

`lib/webtrit_api.dart` — single barrel export. Re-exports `dart:io`'s `HttpStatus`,
`http`'s `ClientException`, plus all internal sources.

## Client

`WebtritApiClient` is the only public API surface:

```dart
WebtritApiClient(Uri baseUrl, String tenantId, {
  Duration? connectionTimeout,
  TrustedCertificates certs,
  bool isDebug = false,
})
```

- `buildTenantUrl()` (`@visibleForTesting`) appends `/tenant/{tenantId}`, strips pre-existing tenant segment. All requests under `/api/v1/...`.
- For tests: `WebtritApiClient.inner(...)` accepts an injectable `http.Client`.

## Request/Response Options

- `WebtritApiRequestOptions` — retry count + delay. Factories: `withNoRetries()`,
  `withDefaultRetries()` (3 retries, 1s delay), `withExtraRetries()`.
- `WebtritApiResponseOptions` — decoding: `json` (default), `bytes`, or `raw`.

## Models

All in `lib/src/models/`. Use `@freezed` + `json_serializable` (`FieldRename.snake`).
Never edit `.freezed.dart` / `.g.dart` — re-run `build_runner`.

| Prefix | Domain |
|--------|--------|
| `Session*` | Auth / session lifecycle |
| `User*` | Authenticated user data and contacts |
| `App*` | App-level status, contacts, push tokens |
| `System*` | Health, system info, notifications |
| `Cdr` | Call detail records |
| `Voicemail*` / `UserVoicemail*` | Voicemail resources |
| `CallerIdSettings` | Caller-ID preferences |
| `Demo*` | Demo/CTA endpoints |

## Exceptions

All extend `RequestFailure`:

| Exception | Trigger |
|-----------|---------|
| `EndpointNotSupportedException` | 404 or 501 |
| `UserNotFoundException` | 404 on user endpoint |
| `UnauthorizedException` | 422 with `refresh_token_invalid` |
| `SessionMissingException` | 401 with `session_missing` |

## Dependencies

Depends on `../_http_client` (path dep) for `createHttpClient()` and `TrustedCertificates`.

## Commands

```bash
dart test
dart test test/webtrit_api_test.dart
dart test --name "buildTenantUrl"
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs
```

## Testing Conventions

- Use `MockClient` (`http/testing.dart`) or `mocktail` — never real network calls.
- Assert request method, URL, headers before returning mock response.
- Map error scenarios via status code + JSON body to exercise exception subtypes.
