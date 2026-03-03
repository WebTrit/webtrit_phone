# Melos Commands

This project uses [melos](https://melos.invertase.dev/) to manage scripts across the monorepo.

## Quick Reference

```bash
melos run --list          # list all available scripts
```

---

## Dependencies

| Command                   | Description                           |
|---------------------------|---------------------------------------|
| `melos run get`           | `flutter pub get` at workspace root   |
| `melos run upgrade`       | Upgrade to latest compatible versions |
| `melos run upgrade:major` | Upgrade including major versions      |
| `melos run outdated`      | Show outdated dependencies            |

---

## Run

| Command                   | Description                            |
|---------------------------|----------------------------------------|
| `melos run start:android` | Run on Android with `dart_define.json` |
| `melos run start:ios`     | Run on iOS device/simulator            |

Pass extra Flutter flags via `FLUTTER_FLAGS`:

```bash
FLUTTER_FLAGS="--debug --verbose" melos run start:android
FLUTTER_FLAGS="-d emulator-5554" melos run start:android
```

---

## Build

| Command                      | Description                             |
|------------------------------|-----------------------------------------|
| `melos run build:apk`        | Build Android APK                       |
| `melos run build:appbundle`  | Build Android App Bundle                |
| `melos run build:ios`        | Build iOS app                           |
| `melos run build:ios:config` | Configure Xcode project only (no build) |

Pass extra Flutter flags via `FLUTTER_FLAGS`:

```bash
FLUTTER_FLAGS="--release" melos run build:apk
FLUTTER_FLAGS="--release" melos run build:appbundle
FLUTTER_FLAGS="--release --no-codesign" melos run build:ios
FLUTTER_FLAGS="--build-name=1.2.3 --build-number=42" melos run build:apk
```

---

## Code Generation

| Command                    | Description                              |
|----------------------------|------------------------------------------|
| `melos run generate`       | Run `build_runner build` in all packages |
| `melos run generate:watch` | Watch mode — rebuild on file change      |
| `melos run generate:clean` | Clean all generated files                |

---

## Formatting & Analysis

| Command               | Description                                              |
|-----------------------|----------------------------------------------------------|
| `melos run fmt`       | Format all Dart code (modifies files)                    |
| `melos run fmt:check` | Check formatting without changes (exit 1 if unformatted) |
| `melos run analyze`   | Run `dart analyze` across the workspace                  |
| `melos run check`     | `fmt:check` + `analyze`                                  |

---

## Testing

| Command                   | Description                    |
|---------------------------|--------------------------------|
| `melos run test`          | Run all tests                  |
| `melos run test:unit`     | Run unit tests only            |
| `melos run test:coverage` | Run tests with coverage report |

---

## CI Pipeline

| Command                | Description                                                |
|------------------------|------------------------------------------------------------|
| `melos run ci`         | Full pipeline: get → generate → fmt:check → analyze → test |
| `melos run smoke:test` | Smoke test all fast, non-destructive scripts               |

---

## Localization

| Command                   | Description                                                     |
|---------------------------|-----------------------------------------------------------------|
| `melos run l10n:generate` | Generate Flutter localization files from ARB                    |
| `melos run l10n:push`     | Push keys to Localizely (requires `LOCALIZELY_TOKEN` in `.env`) |
| `melos run l10n:pull`     | Pull translations from Localizely                               |
| `melos run l10n:fetch`    | `l10n:pull` + `l10n:generate`                                   |

---

## Assets

| Command                     | Description                          |
|-----------------------------|--------------------------------------|
| `melos run icons:generate`  | Generate launcher icons              |
| `melos run splash:generate` | Generate native splash screen        |
| `melos run assets:generate` | `icons:generate` + `splash:generate` |

---

## IDE & Cleanup

| Command               | Description                                                            |
|-----------------------|------------------------------------------------------------------------|
| `melos run ide:sync`  | Copy run configurations from `tool/run/` to `.idea/runConfigurations/` |
| `melos run clean`     | `flutter clean` in all packages                                        |
| `melos run clean:git` | ⚠️ DESTRUCTIVE — `git reset --hard HEAD && git clean -df`              |
