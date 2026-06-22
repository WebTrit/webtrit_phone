# Flutter web support

Status: experimental / in progress. All web-specific code is gated on `kIsWeb`;
native (Android/iOS) behavior is unchanged. The web work lands on the
`feat/web-support` integration branch via a stacked series of PRs (foundation,
signaling, permissions, bundle_id, call/callkeep), which then merges to `develop`.

## Run / build

```bash
# dev
flutter run -d chrome --dart-define-from-file=dart_define.json

# release build (use the configured web bundle_id - see below)
flutter build web --dart-define=WEBTRIT_APP_WEB_BUNDLE_ID=<bundle-id-registered-on-the-server>
```

A bare `flutter build web` leaves the `${WEBTRIT_APP_NAME}` placeholder
unsubstituted and lacks the real web Firebase config; use the project's flavored
web pipeline (configurator -> dart-defines) for a real backend.

## Important dart-defines on web

- `WEBTRIT_APP_WEB_BUNDLE_ID` - the `bundle_id` sent in the session (login) and
  autoprovision requests. Web has no platform bundle identifier, so without this
  the app falls back to the pubspec project name and the server rejects it with
  `unconfigured_bundle_id` (login fails). Set it to a bundle_id registered on the
  server for the `web` app type. (Long term: register the web bundle_id
  server-side so this override is unnecessary.)
- `WEBTRIT_APP_CORE_URL` / `WEBTRIT_APP_DEMO_CORE_URL`, `WEBTRIT_APP_NAME`, etc. -
  same as other platforms.

## Web assets

`web/sqlite3.wasm` (sqlite3 3.3.2) and `web/drift_worker.js` (drift 2.33.0) back
the drift `WasmDatabase` and are served from the app root. Keep them version-matched
to the `drift` / `sqlite3` dependencies.

## What works

Login, contacts, and audio+video calls (WebRTC + signaling over `wss`).

## Not available on web (intentionally skipped / guarded)

- Push notifications (FCM + local notifications) - deferred.
- Background services (WorkManager, callkeep background isolate, persistent
  signaling) - the web platform has none; signaling runs in the main isolate.
- Native lock-screen control and native audio routing - the browser owns the
  audio device.
- Persistent local DB needs OPFS/IndexedDB. In private/incognito mode (or older
  browsers) drift falls back to an in-memory database: local data is lost on
  reload and a warning is logged.

## Architecture notes

- Signaling: federated `webtrit_signaling_service_web` package runs the WebSocket
  signaling in the main isolate (same model as iOS), since web has no background
  service.
- Database: `IsolateDatabase.openWeb()` opens the drift `WasmDatabase` directly
  (no `DriftIsolate` server, `dart:isolate` spawning is unsupported on web).
- Networking: the internal `_web_socket_channel` / `_http_client` / `_tcp_proxy`
  packages select web implementations via conditional imports.
- Remote Config / Firebase Installations init is time-bounded on web so it cannot
  hang startup; the realtime Remote Config stream is skipped on web.
