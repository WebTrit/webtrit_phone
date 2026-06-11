# App update / version compatibility

How the app detects that it is incompatible with the backend, and how it
prompts the user to update when a newer build is published: the core-version
compatibility dialog and the Play Core in-app update flow.

Last reviewed: 2026-06-11

## Where it lives

- `lib/services/app_update_service.dart` - `AppUpdateService`: the Play Core
  in-app update flow (Android).
- `lib/app/router/main_shell.dart` - calls `AppUpdateService.check()` on
  startup and on every foreground resume.
- `lib/features/main/` - the core-compatibility check and dialog:
  - `bloc/main_bloc.dart` - `MainBloc`: core-version verification + store lookup.
  - `bloc/main_state.dart` - `CoreVersionState` (`Unknown` / `Compatible` /
    `Incompatible` with optional `updateStoreUrl`).
  - `view/main_screen.dart` - `BlocListener` that shows the dialog.
  - `widgets/compatibility_issue_dialog.dart` - the dialog itself.
- `packages/store_info_extractor/` - workspace package that fetches the latest
  published app version from the platform store (its only consumer is `MainBloc`).

## Soft update prompt (Android) - Play Core in-app updates

When a newer build is published in Google Play, the app surfaces the native
Play Core update UI - no in-app dialogs and no client-side version comparison
(Play compares the installed and published version codes itself).

`AppUpdateService.check()` runs on startup and on every foreground resume:

1. An interrupted immediate update (`developerTriggeredUpdateInProgress`) is
   resumed - Play requires the app to finish it.
2. A flexible download that finished while the app was away
   (`InstallStatus.downloaded`) is installed right away, otherwise the user
   keeps running the old version until a cold restart.
3. An available update runs as:
   - **flexible** (background download, install on completion) - the default;
   - **immediate** (blocking native overlay) - only when the release was
     published with in-app update priority >= 4 (Google Play Developer API
     `inAppUpdatePriority`, defaults to 0) or when flexible is not allowed.
4. A declined flexible update is remembered by version code and not
   re-prompted until a newer build is published (in-memory, resets on app
   restart).

The whole flow is a silent no-op on non-Android platforms, on devices without
Google Play services (some white-label fleets), and on sideloaded/debug builds
(Play Core fails there and the failure is swallowed).

Note on version semantics: builds get their `versionName`/`versionCode` from
`--build-name`/`--build-number` at build time (per client); the repo's
`app_version` field never reaches the binary. Publishing any higher version
code triggers the prompt.

Verification: the real flow cannot be exercised locally - it requires a build
installed from Google Play (internal testing track with a lower version code
on the device).

## Compatibility dialog (core version)

When the backend (core) version falls outside the app's supported constraint,
a non-dismissible `AlertDialog` appears ("Compatibility issue") with:

- **Update** - shown only when the store has a newer app version than the one
  installed; opens the store page via `url_launcher` (external browser/store).
- **Logout** - always shown; logs the user out.

```
SystemInfoRepository.infoStream (backend system info)
  -> MainBloc._onSystemInfoArrived
       core version vs EnvironmentConfig.CORE_VERSION_CONSTRAINT
         |- supported   -> Compatible (nothing shown)
         '- unsupported -> StoreInfoExtractor.getStoreInfo(packageName)
                             |- store version > installed -> Incompatible(updateStoreUrl)
                             '- else / lookup error       -> Incompatible(no url)
  -> MainScreen BlocListener -> CompatibilityIssueDialog.show(...)
       Update -> MainBlocAppUpdatePressed -> launchUrl(storeUrl, externalApplication)
```

The store lookup runs **only** when the core is already incompatible - it
answers "can an app update fix this?", not "is there an update".

### store_info_extractor package

`StoreInfoExtractor.getStoreInfo(appPackageName)` picks a client by platform:

| Platform | Client | Method |
|---|---|---|
| Android | `GooglePlayStoreClient` | HTTP GET `play.google.com/store/apps/details?id=<pkg>`, regex `[[["x.y.z"]]]` over the HTML |
| iOS / macOS | `AppleAppStoreClient` | iTunes lookup JSON API (`itunes.apple.com/lookup?bundleId=<pkg>`) |
| Web | `StubStoreClient` | always `null` |

Known limitations: the Android HTML scraping is fragile and is now redundant
for the soft-update use case (Play Core covers it); it remains only as the
Update-button source inside the compatibility dialog. Debug/sideloaded builds
carry version `0.0.0`, so any store version compares as newer there.

## Redesign / in progress

| Mechanism | Trigger | UX | Status |
|---|---|---|---|
| Soft update prompt (above) | newer build published in Google Play | native Play Core prompt, app keeps working | this PR |
| Core compatibility (above) | core version outside the app's constraint | blocking dialog, Update button when the store is newer | shipped |
| Backend-driven force update | backend declares `min_supported_app_version` above the app's version | non-dismissible update prompt + signaling socket not connected | backend done, app side TODO |
| iOS soft update | newer version in the App Store | custom prompt -> App Store (no native API on iOS) | future |

- **Backend-driven force update**: the backend already exposes an optional
  `min_supported_app_version` (semver) in `GET /api/v1/system-info` (`null` =
  not enforced). The app side still needs to read the field, compare against
  its own version, and on failure show a non-dismissible update prompt and
  skip connecting the signaling socket. Open question for white-label builds:
  which version to compare - the per-client `versionName` differs from the
  canonical phone release line.
- **iOS soft update (future)**: plug into the same `MainShell` seam (a single
  `check()` on startup/resume); extract an interface from `AppUpdateService`
  with platform implementations. iOS has no native update UI, so its
  implementation must surface a custom prompt (service code cannot touch
  `BuildContext` - emit an event/notification instead) and needs a version
  source: the kept `AppleAppStoreClient`, or Firebase Remote Config if a
  priority-like signal is wanted.
- **Scraper cleanup**: `GooglePlayStoreClient` (and the `updateStoreUrl`
  branch in `MainBloc` on Android) becomes removable once the force-update
  flow above defines the compatibility dialog's fate. It also contains a stray
  debug `print` to drop with it.
