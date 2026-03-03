# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Package Purpose

`webtrit_api` is a standalone Dart library providing a typed REST API client for the WebTrit Core
backend. It has no dependency on Flutter or the main `lib/` tree.

## Backend API Reference

- **Core API (Swagger UI)**: https://webtrit.github.io/webtrit_core_pages/ — the REST API this
  package implements. Use it to look up endpoint paths, request/response schemas, and error codes.
- **Docs repo**: https://github.com/WebTrit/webtrit_docs

## Common Commands

```bash
# Run all tests
dart test

# Run a single test file
dart test test/webtrit_api_test.dart

# Run a single test by name
dart test --name "buildTenantUrl"

# Code generation (after modifying models)
dart run build_runner build --delete-conflicting-outputs

# Watch mode during model development
dart run build_runner watch --delete-conflicting-outputs
```

## Architecture

### Entry Point

`lib/webtrit_api.dart` is the single barrel export. It re-exports `dart:io`'s `HttpStatus`, `http`'s
`ClientException`, plus all internal sources.

### Client (`lib/src/webtrit_api_client.dart`)

`WebtritApiClient` is the only public API surface for making HTTP requests:

```dart
WebtritApiClient
(
Uri baseUrl, String tenantId, {
Duration? connectionTimeout,
TrustedCertificates certs,
bool isDebug = false,
})
```

Multi-tenancy is handled by `buildTenantUrl()` (`@visibleForTesting`), which appends
`/tenant/{tenantId}` to the base URL while stripping any pre-existing tenant segment. All requests
are routed under `/api/v1/...`.

For tests, use `WebtritApiClient.inner(...)` which accepts an injectable `http.Client`.

### Request/Response Options

- `WebtritApiRequestOptions` — controls retry count and delay. Static factories: `withNoRetries()`,
  `withDefaultRetries()` (3 retries, 1 s delay), `withExtraRetries()`.
- `WebtritApiResponseOptions` — selects response decoding: `json` (default), `bytes`, or `raw`.

### Models (`lib/src/models/`)

All models use `@freezed` with `json_serializable` (`FieldRename.snake`). Generated files (
`.freezed.dart`, `.g.dart`) must never be edited by hand — re-run `build_runner` after source
changes.

Model naming follows domain prefixes:

| Prefix                          | Domain                                  |
|---------------------------------|-----------------------------------------|
| `Session*`                      | Authentication / session lifecycle      |
| `User*`                         | Authenticated user data and contacts    |
| `App*`                          | App-level status, contacts, push tokens |
| `System*`                       | Health, system info, notifications      |
| `Cdr`                           | Call detail records                     |
| `Voicemail*` / `UserVoicemail*` | Voicemail resources                     |
| `CallerIdSettings`              | Caller-ID preferences                   |
| `Demo*`                         | Demo/CTA endpoints                      |

### Exceptions (`lib/src/exceptions.dart`)

All failures extend `RequestFailure`. The client maps specific HTTP status / error-code combinations
to subtypes:

| Exception                       | Trigger                          |
|---------------------------------|----------------------------------|
| `EndpointNotSupportedException` | 404 or 501                       |
| `UserNotFoundException`         | 404 on user endpoint             |
| `UnauthorizedException`         | 422 with `refresh_token_invalid` |
| `SessionMissingException`       | 401 with `session_missing`       |

### Local Dependency

Depends on `../_http_client` (path dependency), which provides `createHttpClient()` and
`TrustedCertificates` for certificate pinning and connection timeout configuration.

## Testing Conventions

- Use `http/testing.dart`'s `MockClient` (or `mocktail`) to intercept HTTP — never make real network
  calls.
- Assert request method, URL, and headers before returning a mock response.
- Map error scenarios by returning the appropriate status code + JSON body to exercise exception
  subtype logic.
