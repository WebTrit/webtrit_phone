# Adding a New Screenshot

This guide walks through the steps to add a new screenshot to the package.

## Checklist

1. [ ] Create mock data (if needed) in `lib/data/`
2. [ ] Create mock BLoC/Cubit/Repository in `lib/mocks/`
3. [ ] Create screenshot widget in `lib/screenshots/`
4. [ ] Register in `lib/router.dart`
5. [ ] Register in `integration_test/take_screenshots_test.dart`
6. [ ] Update barrel exports
7. [ ] Run `dart format screenshots/` and verify with `dart analyze`

---

## Step 1: Mock Data

If the screen displays domain-specific content (contacts, messages, call records), add test data to
`lib/data/`.

Conventions:

- Prefix all top-level variables with `d` (e.g., `dMockVoicemails`, `dFavorites`)
- Use `clock.nowBased(hour: N, minute: N)` for times relative to the fixed clock
- Export the file from `lib/data/data.dart`

```dart
// lib/data/voicemails.dart
import 'package:webtrit_phone/models/models.dart';

final dMockVoicemails = [
  Voicemail('vm-001', '2022-07-20 09:30:00', 45.0, '1234', 'Thomas Anderson', ...),
  Voicemail('vm-002', '2022-07-19 14:15:00', 120.0, '3344', 'Dion Dames', ...),
];
```

## Step 2: Mock BLoC/Cubit

Create `lib/mocks/mock_<name>.dart`. Two patterns:

### BLoC Mock

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:screenshots/data/data.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {
  MockFavoritesBloc();

  factory MockFavoritesBloc.mainScreen() {
    final mock = MockFavoritesBloc();
    whenListen(
      mock,
      const Stream<FavoritesState>.empty(),
      initialState: FavoritesState(favorites: dFavorites),
    );
    return mock;
  }
}
```

### Cubit Mock

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:webtrit_phone/features/features.dart';

class MockNetworkCubit extends MockCubit<NetworkState> implements NetworkCubit {
  MockNetworkCubit();

  factory MockNetworkCubit.initial() {
    final mock = MockNetworkCubit();
    whenListen(
      mock,
      const Stream<NetworkState>.empty(),
      initialState: const NetworkState(/* ... */),
    );
    return mock;
  }
}
```

### Stubbing Extra Methods

If the screen calls methods or reads getters beyond state, stub them with `mocktail`:

```dart
import 'package:mocktail/mocktail.dart';

factory
MockSomeBloc.ready
() {

final mock = MockSomeBloc();
whenListen
(
mock, const Stream.empty(), initialState: SomeState(...));

// Stub a getter
when(() => mock.dateFormat).thenReturn(DateFormat.yMMMd().add_Hm());

// Stub a method (needs registerFallbackValue for custom types)
registerFallbackValue(_FakeMyType());
when(() => mock.doSomething(any())).thenAnswer((_) async {});

return mock;
}

class _FakeMyType extends Fake implements MyType {}
```

### Repository Mock

```dart
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockSmsRepository extends Mock implements SmsRepository {
  MockSmsRepository() {
    when(() => watchUserSmsNumbers()).thenAnswer((_) => const Stream.empty());
  }
}
```

Export from `lib/mocks/mocks.dart` (or `lib/mocks/repository/repository.dart` for repos).

## Step 3: Screenshot Widget

Create `lib/screenshots/<name>_screenshot.dart`. Choose one of two patterns:

### Pattern A: StatelessWidget (simple, inline screens)

Use when the screen doesn't require navigation context (login screens, agreement screens):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:screenshots/mocks/mocks.dart';

class LanguageScreenScreenshot extends StatelessWidget {
  const LanguageScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageScreen();
  }
}
```

### Pattern B: StatefulWidget with Navigator.push (pushed routes)

Use when the screen is normally pushed as a route (settings sub-screens, detail screens):

```dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:screenshots/mocks/mocks.dart';

class ContactScreenScreenshot extends StatefulWidget {
  const ContactScreenScreenshot({super.key});

  @override
  State<ContactScreenScreenshot> createState() => _ContactScreenScreenshotState();
}

class _ContactScreenScreenshotState extends State<ContactScreenScreenshot> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ContactBloc>(create: (_) => MockContactBloc.contactScreen()),
                BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
                // ... all required providers
              ],
              child: const ContactScreen(/* config flags */),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

Key points for Pattern B:

- Use `SchedulerBinding.instance.addPostFrameCallback` to push after first frame
- Set both `transitionDuration` and `reverseTransitionDuration` to `Duration.zero`
- Set `fullscreenDialog: true`
- Return `Placeholder()` from `build()` (it's never visible)

Export from `lib/screenshots/screenshots.dart`.

## Step 4: Register in Router

Add to the `screenshots` list in `lib/router.dart`:

```dart

final screenshots = [
  // ... existing entries
  ScreenshotApp(
    appBloc: appBloc,
    child: const YourNewScreenScreenshot(),
  ),
];
```

## Step 5: Register in Integration Test

Add to `integration_test/take_screenshots_test.dart` inside the appropriate `group`:

```dart
group
('take settings sub-screen screenshots
'
, () {
// ... existing entries
takeScreenshotTestWidgets('your_new_screen', () {
return ScreenshotApp(
appBloc: appContext.appBloc,
child: const YourNewScreenScreenshot(),
);
});
});
```

## Step 6: Update Barrel Exports

| File                                   | Add                                                   |
|----------------------------------------|-------------------------------------------------------|
| `lib/mocks/mocks.dart`                 | `export 'mock_your_bloc.dart';`                       |
| `lib/mocks/repository/repository.dart` | `export 'mock_your_repository.dart';` (if applicable) |
| `lib/screenshots/screenshots.dart`     | `export 'your_new_screen_screenshot.dart';`           |
| `lib/data/data.dart`                   | `export 'your_data.dart';` (if applicable)            |

## Step 7: Verify

```bash
cd screenshots
dart format .
dart analyze
flutter run          # Interactive preview
```

## Common Pitfalls

| Issue                                  | Cause                                      | Fix                                                                                              |
|----------------------------------------|--------------------------------------------|--------------------------------------------------------------------------------------------------|
| `MissingStubError: MockX.someMethod()` | Screen calls a method not stubbed          | Add `when(() => mock.someMethod(any())).thenAnswer(...)`                                         |
| `MissingStubError: MockX.someGetter`   | Screen reads a getter not stubbed          | Add `when(() => mock.someGetter).thenReturn(...)`                                                |
| `ProviderNotFoundException`            | Missing provider in widget tree            | Add the required `Provider`/`BlocProvider` in screenshot widget                                  |
| `AppBarParams not found`               | Screen uses `MainAppBar`                   | Wrap with `AppBarParams(systemNotificationsEnabled: false, pullableCalls: const [], child: ...)` |
| `Null check operator used on null`     | Mock data has null where non-null expected | Update data file to provide non-null values                                                      |
| `non_type_as_type_argument`            | Type not exported via barrel file          | Use direct import path instead of barrel                                                         |
| `registerFallbackValue` needed         | Using `any()` with custom type parameter   | Add `registerFallbackValue(_FakeType())` before `when()`                                         |
