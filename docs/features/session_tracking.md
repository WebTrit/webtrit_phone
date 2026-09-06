# Session tracking

The settings screen that lists the sessions the account is signed in with and
lets the user sign the other ones out.

Last reviewed: 2026-08-13

## Where it lives

- `lib/features/settings/features/sessions/` - the whole feature:
    - `cubit/sessions_cubit.dart` - `SessionsCubit` + `SessionsState`.
    - `view/sessions_screen_page.dart` - `@RoutePage`; refreshes the shared
      cubit on open and passes the `DateFormat` taken from `AppTime`.
    - `view/sessions_screen.dart` - app bar, pull-to-refresh list, placeholders
      (how every list refreshes: [`../data_refresh.md`](../data_refresh.md)).
    - `widgets/session_tile.dart` - one session row.
- `lib/features/settings/view/settings_router_page.dart` - owns the
  `SessionsCubit`, above both the settings screen and the sessions screen.
- `lib/features/settings/widgets/sessions_list_tile.dart` - the settings row
  with the session-count badge.
- `lib/repositories/sessions/sessions_repository.dart` - `SessionsRepository`
  and its API implementation.
- `lib/models/active_session.dart` - `ActiveSession`, the domain model.
- `lib/mappers/api/active_session_mapper.dart` - `api.UserSession` ->
  `ActiveSession`.
- `packages/webtrit_api` - `getUserSessions` / `deleteUserSession` and the
  `UserSession` DTO.

## Backend contract

| Endpoint                        | Purpose                                                     |
|---------------------------------|-------------------------------------------------------------|
| `GET /user/sessions`            | All active sessions of the current user, `current` flagging the caller's own |
| `DELETE /user/sessions/{id}`    | Revokes one session and tears down its SIP registration; 404 `session_not_found` when it is not the user's |

A session carries the `User-Agent` captured at creation, the app type /
identifier / bundle id, the creation and last-activity timestamps, and two ISO
3166-1 alpha-2 country codes: `location` (resolved once, at creation) and
`last_activity_location` (resolved per request, so it can differ for a roaming
device).

## What labels a session: the User-Agent the app sends

The core simply reads the `user-agent` request header when it creates the
session (`WebtritCoreWeb.ClientInfo.user_agent/1`) and stores it as received -
nothing is parsed or validated server-side. Whatever the app sends is what the
user later reads in this list, so the app sends its own value instead of
leaving the platform default (`Dart/3.x (dart:io)`).

`WebtritApiClient` takes a `userAgent` and puts it on every request.
It is filled from the same string presence uses as its device name -
`AppMetadataProvider.userAgent`, format
`AppName/AppVersion (Model; OSName: OSVersion)` - so a device is labelled
identically in both places. `DefaultAppMetadataProvider.buildUserAgent` holds
that format and is also called directly in `bootstrap`, which builds the API
client factory before the provider exists (the provider needs `featureAccess`).

Wired at every client that can create a session:

| Site                                     | Path                                    |
|------------------------------------------|-----------------------------------------|
| `WebtritApiClientFactory`                | login / OTP / session refresh / signout |
| `main_shell.dart` `WebtritApiClient`      | the authenticated app client            |
| `AutoprovisionCubit`                     | autoprovisioned login                   |

Not wired: the background client in `bootstrap` that fetches system
notifications - it never creates a session, and building the string there would
mean re-initialising package/device info inside the isolate.

On web the header is left to the browser: `User-Agent` is a forbidden header
name there, so the value is dropped rather than sent.

## Entry point and version gate

The row sits in the fixed group at the top of the settings screen and is
deliberately NOT a configurable settings item: there is no `sessions` type in
`app.config.json` and no `SettingsFlavor` for it. It carries a `CountBadge` with
the number of active sessions, which stays blank until the list has loaded, and
the count is spoken after the row's own name. Logging out is not next to it any
more - it is an action in the app bar of that screen.

Both endpoints are core endpoints with no adapter involvement, so there is no
capability flag to advertise them. Availability is decided by the core version
instead: `SettingsMapper` sets `SettingsConfig.sessionsEnabled` from
`CoreInfo.supportsSessionTracking` (`>=0.35.0-alpha <2.0.0`), and
`SettingsScreen` hides the row when it is false, rather than opening a screen
that cannot load.

## Behaviour

- `SettingsRouterPage` provides the `SessionsCubit` above both screens, so the
  badge and the list are one state: revoking a session on the sessions screen
  updates the badge immediately.
- The list is fetched when the settings router is entered, again when the
  sessions screen opens, and on pull-to-refresh. Nothing is cached locally and
  nothing polls: a session list is only interesting while the user is looking
  at it.
- A failed fetch keeps whatever was already loaded and only shows the failure
  placeholder when there is nothing to show.
- The current session gets a "This device" chip and no revoke action - signing
  this device out is what logout in settings is for.
- Revoking removes the row on success and reports failure through a snack bar,
  leaving the row in place.
- "Sign out other sessions" revokes every non-current session one by one, since
  the core has no bulk endpoint. Each success drops its own row, so a partial
  failure still shows exactly what survived; the snack bar reports that
  something failed.

## Tests

- `packages/webtrit_api/test/webtrit_api_test.dart` - the two endpoints,
  including an unknown session status and the 404 `session_not_found` body, plus
  the `User-Agent` header being sent (and omitted when the app provides none).
- `test/data/app_metadata_provider_test.dart` - the User-Agent format and that
  it is the same string presence uses as the device name.
- `test/features/settings/features/sessions/cubit/sessions_cubit_test.dart` -
  fetch, single revoke, revoke-all-others incl. partial failure.
- `test/features/settings/features/sessions/widgets/session_tile_test.dart` -
  row title per app type, current-session badge, revoke action.
- `test/features/settings/widgets/sessions_list_tile_test.dart` - the settings
  row and its count badge.
- `test/data/settings_mapper_test.dart` - the core-version gate behind
  `sessionsEnabled`.
- `test/app/core_version_test.dart` - `supportsSessionTracking` boundaries.
