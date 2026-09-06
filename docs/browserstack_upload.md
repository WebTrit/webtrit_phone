# BrowserStack App Live Upload

Upload app builds to [BrowserStack App Live](https://app-live.browserstack.com/) for
manual testing on real devices. This is the way to check behavior on hardware we do not
have on hand (for example OEM Android phones such as Xiaomi, Oppo, or Vivo with their
vendor-specific battery and background restrictions).

The tooling consists of `tool/scripts/browserstack_upload.sh` and the
`melos run browserstack:upload` wrapper.

## One-time setup

1. Sign in at [browserstack.com](https://www.browserstack.com/) and copy your username
   and access key from
   [Account settings](https://www.browserstack.com/accounts/profile/details).
2. Put them into the repo-root `.env` (see `.env.example`):

   ```bash
   BROWSERSTACK_USERNAME=your-browserstack-username
   BROWSERSTACK_ACCESS_KEY=your-browserstack-access-key
   ```

## Usage

Build a debug apk and upload it in one step (optional features follow `dart_define.json`):

```bash
tool/scripts/browserstack_upload.sh --build
```

Build in release mode:

```bash
tool/scripts/browserstack_upload.sh --build --release
```

Upload without building - the script picks the newest apk from
`build/app/outputs/flutter-apk`:

```bash
tool/scripts/browserstack_upload.sh
```

Upload a specific file (apk, aab, or ipa):

```bash
tool/scripts/browserstack_upload.sh path/to/app.apk
```

List recent App Live uploads:

```bash
tool/scripts/browserstack_upload.sh --list
```

Via melos, pass flags through `BS_ARGS`:

```bash
BS_ARGS="--build" melos run browserstack:upload
```

## How builds show up in App Live

- Every upload carries a custom id, `webtrit_phone` by default (override with
  `--custom-id <id>`). In the App Live app picker, choose the app with that id -
  App Live automatically selects the newest build uploaded under it.
- When building with `--build`, the apk is stamped with the `app_version` from
  `pubspec.yaml` as the version name and an hourly UTC date code (`yymmddhh`) as the
  build number, so uploads are distinguishable in the App Live UI. (The committed
  standard `version:` field stays `0.0.0+0` by convention.)

## Practical notes

- Android apks are installed as-is (not re-signed), so Firebase push notifications
  work in the App Live session.
- iOS ipas are re-signed by BrowserStack, which breaks the push entitlement - push
  notifications and CallKit incoming calls do not work there. Use App Live iOS
  sessions for UI checks only.
- Uploads are kept for 30 days, then deleted automatically.
- Device logs (logcat) are available in the DevTools panel of a running App Live
  session and can be saved with its download button. There is no API for App Live
  session logs - the download button is the only way to get them.
