# Screenshots Package Overview

The `screenshots/` package captures automated screenshots of every user-visible screen in the app.
It renders real Flutter widgets with mock data, producing deterministic images suitable for store
listings, documentation, and visual regression testing.

## Directory Structure

```
screenshots/
├── lib/
│   ├── main.dart                  # App entry point (fixed clock, bootstrap, runApp)
│   ├── bootstrap.dart             # DI setup, returns AppContext
│   ├── router.dart                # Screenshot index navigation (TabBarView)
│   ├── data/                      # Static mock data (prefixed with `d`)
│   │   ├── data.dart              # Barrel export
│   │   ├── clock.dart             # dFixedTime — frozen DateTime
│   │   ├── call.dart              # dAudioActiveCall, dVideoActiveCall
│   │   ├── cdrs.dart              # dMockCdrRecords, dMockCallLogEntries
│   │   ├── recents.dart           # dMockRecentCallHistory
│   │   ├── messaging.dart         # Chats, SMS conversations, messages, contacts
│   │   ├── favorites.dart         # dFavorites
│   │   ├── voicemails.dart        # dMockVoicemails
│   │   ├── system_notifications.dart
│   │   ├── app.dart               # dAppInfo
│   │   └── info.dart              # userInfo (UserInfo constant)
│   ├── mocks/                     # Mock BLoCs, Cubits, Repositories
│   │   ├── mocks.dart             # Barrel export
│   │   ├── mock_*.dart            # One file per BLoC/Cubit
│   │   ├── repository/            # Mock repositories
│   │   ├── datasources/           # Mock data sources
│   │   └── clients/               # Mock socket clients
│   ├── screenshots/               # Screenshot widget wrappers
│   │   ├── screenshots.dart       # Barrel export
│   │   └── *_screenshot.dart      # One file per screen
│   └── widgets/
│       ├── widgets.dart           # Barrel export
│       └── screenshot_app.dart    # ScreenshotApp — theme, locale, routing wrapper
├── integration_test/
│   └── take_screenshots_test.dart # Integration test that captures images
└── test_driver/
    └── integration_test.dart      # Test driver entry point
```

## How It Works

### Bootstrap (`bootstrap.dart`)

`bootstrap()` initializes real app infrastructure (themes, feature flags, device info) and returns
an `AppContext` record:

```dart
typedef AppContext = ({AppBloc appBloc, List<SingleChildWidget> providers});
```

- `appBloc` — a `MockAppBloc` configured with light theme and English locale
- `providers` — `FeatureAccess`, `PackageInfo`, `DeviceInfo`, `AppMetadataProvider`

### ScreenshotApp Wrapper (`widgets/screenshot_app.dart`)

Every screenshot is wrapped in `ScreenshotApp`, which provides:

- `AppBloc` via `BlocProvider`
- Theme resolution (light/dark based on AppBloc state)
- Localization delegates
- A `ScreenshotRouterDelegate` (single-page Navigator)
- An `IgnorePointer` wrapper (prevents accidental interaction)
- A mock `StackRouter` (satisfies `AutoRoute.of` lookups)

### Router (`router.dart`)

The `IndexInputScreen` builds a `TabBarView` containing all screenshots. URL-based navigation (`/0`,
`/1`, ...) selects a tab. This allows interactive browsing of all screenshots during development.

### Integration Test (`take_screenshots_test.dart`)

The test runner:

1. Initializes `IntegrationTestWidgetsFlutterBinding`
2. Detects device model for filename prefixes (e.g., `Pixel_9/login_screen__modeSelect`)
3. Calls `bootstrap()` once in `setUpAll`
4. For each screenshot:
    - Wraps widget in `MultiProvider` with `appContext.providers`
    - Freezes clock to `dFixedTime` for deterministic timestamps
    - Pumps, settles animations, captures via `binding.takeScreenshot(name)`

### Fixed Clock

All screenshots use `dFixedTime = DateTime(2022, 7, 20)`. The `clock` package's
`withClock(Clock.fixed(dFixedTime), ...)` ensures every timestamp in the UI is deterministic.

## Running Screenshots

### Interactive Preview (hot-reload)

```bash
cd screenshots
flutter run
```

Navigate to `/<index>` to view a specific screenshot (e.g., `/0` for first, `/14` for call screen).

### Capture on Device/Emulator

```bash
cd screenshots
flutter test integration_test/take_screenshots_test.dart
```

Output is saved to `build/integration_test_screenshots/<DeviceModel>/`.

## Current Screenshot Coverage

| Group               | Screenshots                                                                                                           |
|---------------------|-----------------------------------------------------------------------------------------------------------------------|
| Login               | modeSelect, coreUrlAssign, otpSignIn, otpVerify, passwordSignIn, signUp, signUpVerify, switch                         |
| Main tabs           | favorites, recents, keypad, messaging                                                                                 |
| Calls               | audio call, video call                                                                                                |
| Contact & messaging | contact detail, chat conversation, SMS conversation, system notifications                                             |
| CDRs & call log     | recent CDRs, number CDRs, call log                                                                                    |
| Settings            | main settings, media, network, language, diagnostic, caller ID, presence, theme mode, voicemail                       |
| Utility             | about, privacy, permissions, contacts agreement, user agreement, teardown, log records console, embedded error dialog |
