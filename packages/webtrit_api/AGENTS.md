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

- `RequestOptions` — retry count + delay. Factories: `withNoRetries()`,
  `withDefaultRetries()` (3 retries, 1s delay), `withExtraRetries()`.
- `ResponseOptions` — decoding: `json` (default), `bytes`, or `raw`; plus
  `optionalEndpoint` (default `false`) marking the endpoint as optional in the
  adapter contract. Constructed inside the client methods, not caller-supplied.

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

All extend `RequestFailure`, which carries the status code, the parsed error
body, and classification getters: `isClientError` (4xx), `isServerError` (5xx),
`isTransient` (408/425/429), `errorCode` (backend error code from the body).

| Exception | Trigger |
|-----------|---------|
| `SessionMissingException` | 401 with `session_missing` |
| `UnauthorizedException` | 401 with `token_invalid`; 422 with `refresh_token_invalid` |
| `UserNotFoundException` | 404 with `user_not_found` (any endpoint); any 404 from `getUserInfo` / `createSessionOtp` |
| `EndpointNotSupportedException` | methods declared `ResponseOptions(optionalEndpoint: true)` only: 501, or 404 without a backend error code |
| `VoicemailNotConfiguredException` | `voicemail_not_configured` |
| `PasswordChangeRequiredException` | `password_change_required` |

Failure log level: client errors (4xx) log as `warning`; `severe` is reserved
for server-side (5xx) and transport failures. `EndpointNotSupportedException`
and `VoicemailNotConfiguredException` are not logged.

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
