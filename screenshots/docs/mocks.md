# Mock Reference

This document lists all mocks in the `screenshots/` package, grouped by category.

## Packages Used

- **`bloc_test`** — provides `MockBloc<E, S>`, `MockCubit<S>`, and `whenListen()`
- **`mocktail`** — provides `Mock`, `Fake`, `when()`, `any()`, `registerFallbackValue()`

## Mock Index

### App & Session

| Mock                      | Type                             | Factories                                      | Used By                               |
|---------------------------|----------------------------------|------------------------------------------------|---------------------------------------|
| `MockAppBloc`             | `MockBloc<AppEvent, AppState>`   | `.allScreen(themeSettings, themeMode, locale)` | All screenshots (via `ScreenshotApp`) |
| `MockSessionStatusCubit`  | `MockCubit<SessionStatusState>`  | `.initial()`                                   | Settings screen                       |
| `MockRegisterStatusCubit` | `MockCubit<RegisterStatusState>` | `.initial()`                                   | Settings screen                       |

### Login

| Mock                | Type                       | Factories                                                                                                                                                                                               |
|---------------------|----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `MockLoginCubit`    | `MockCubit<LoginState>`    | `.loginModeSelectScreen()`, `.loginCoreUrlAssignScreen()`, `.loginOtpSignInScreen()`, `.loginOtpVerifyInScreen()`, `.loginPasswordSignInScreen()`, `.loginSignUpScreen()`, `.loginSignUpVerifyScreen()` |
| `MockEmbeddedCubit` | `MockCubit<EmbeddedState>` | `.initial()`                                                                                                                                                                                            |

### Main Screen

| Mock                       | Type                                                     | Factories       |
|----------------------------|----------------------------------------------------------|-----------------|
| `MockMainBloc`             | `MockBloc<MainEvent, MainState>`                         | `.mainScreen()` |
| `MockFavoritesBloc`        | `MockBloc<FavoritesEvent, FavoritesState>`               | `.mainScreen()` |
| `MockRecentsBloc`          | `MockBloc<RecentsEvent, RecentsState>`                   | `.mainScreen()` |
| `MockKeypadCubit`          | `MockCubit<KeypadState>`                                 | `.mainScreen()` |
| `MockMicrophoneStatusBloc` | `MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>` | `.initial()`    |

### Contacts

| Mock                          | Type                                   | Factories          |
|-------------------------------|----------------------------------------|--------------------|
| `MockContactBloc`             | `MockBloc<ContactEvent, ContactState>` | `.contactScreen()` |
| `MockContactsLocalTabBloc`    | `MockBloc<...>`                        | `.mainScreen()`    |
| `MockContactsExternalTabBloc` | `MockBloc<...>`                        | `.mainScreen()`    |
| `MockContactsSearchBloc`      | `MockBloc<...>`                        | `.mainScreen()`    |

### Messaging

| Mock                         | Type                                       | Factories         |
|------------------------------|--------------------------------------------|-------------------|
| `MockMessagingBloc`          | `MockBloc<MessagingEvent, MessagingState>` | `.initial()`      |
| `MockChatConversationsCubit` | `MockCubit<ChatConversationsState>`        | `.withMockData()` |
| `MockConversationCubit`      | `MockCubit<ConversationState>`             | `.withMessages()` |
| `MockChatTypingCubit`        | `MockCubit<TypingUsers>`                   | `.idle()`         |
| `MockChatsForwardingCubit`   | `MockCubit<ChatMessage?>`                  | `.initial()`      |
| `MockSmsConversationsCubit`  | `MockCubit<SmsConversationsState>`         | `.withMockData()` |
| `MockSmsConversationCubit`   | `MockCubit<SmsConversationState>`          | `.withMessages()` |
| `MockSmsTypingCubit`         | `MockCubit<TypingNumbers>`                 | `.idle()`         |
| `MockUnreadCountCubit`       | `MockCubit<UnreadCountState>`              | `.initial()`      |

### Calls & CDRs

| Mock                        | Type                                   | Factories                             |
|-----------------------------|----------------------------------------|---------------------------------------|
| `MockCallBloc`              | `MockBloc<CallEvent, CallState>`       | `.mainScreen()`, `.callScreen(video)` |
| `MockCallRoutingCubit`      | `MockCubit<CallRoutingState>`          | `.initial()`                          |
| `MockFullRecentCdrsCubit`   | `MockCubit<FullRecentCdrsState>`       | `.withCdrs()`                         |
| `MockMissedRecentCdrsCubit` | `MockCubit<MissedRecentCdrsState>`     | `.withRecords()`                      |
| `MockNumberCdrsLogCubit`    | `MockCubit<NumberCdrsLogState>`        | `.withRecords()`                      |
| `MockCallLogBloc`           | `MockBloc<CallLogEvent, CallLogState>` | `.withHistory()`                      |

### Settings

| Mock                         | Type                                     | Factories          |
|------------------------------|------------------------------------------|--------------------|
| `MockSettingsBloc`           | `MockBloc<SettingsEvent, SettingsState>` | `.settingScreen()` |
| `MockMediaSettingsCubit`     | `MockCubit<MediaSettingsState>`          | `.initial()`       |
| `MockNetworkCubit`           | `MockCubit<NetworkState>`                | `.initial()`       |
| `MockDiagnosticCubit`        | `MockCubit<DiagnosticState>`             | `.initial()`       |
| `MockCallerIdSettingsCubit`  | `MockCubit<CallerIdSettingsState>`       | `.initial()`       |
| `MockPresenceSettingsCubit`  | `MockCubit<PresenceSettings>`            | `.initial()`       |
| `MockVoicemailCubit`         | `MockCubit<VoicemailState>`              | `.withItems()`     |
| `MockLogRecordsConsoleCubit` | `MockCubit<LogRecordsConsoleState>`      | `.withRecords()`   |

### Notifications

| Mock                                  | Type                                       | Factories              |
|---------------------------------------|--------------------------------------------|------------------------|
| `MockNotificationsBloc`               | `MockBloc<..., NotificationsState>`        | `.initial()`           |
| `MockSystemNotificationCounterCubit`  | `MockCubit<int>`                           | `.withDefaults()`      |
| `MockSystemNotificationsScreenCubit`  | `MockCubit<SystemNotificationScreenState>` | `.withNotifications()` |

### User Info

| Mock                | Type                        | Factories    |
|---------------------|-----------------------------|--------------|
| `MockUserInfoCubit` | `MockCubit<UserInfoState>`  | `.initial()` |
| `MockAboutBloc`     | `MockBloc<..., AboutState>` | `.initial()` |

### Permissions

| Mock                   | Type                          | Factories    |
|------------------------|-------------------------------|--------------|
| `MockPermissionsCubit` | `MockCubit<PermissionsState>` | `.initial()` |

### Repositories

| Mock                     | Implements           | Notes                                                    |
|--------------------------|----------------------|----------------------------------------------------------|
| `MockContactsRepository` | `ContactsRepository` | Custom stream controller, `getContactBySource` from data |
| `MockSmsRepository`      | `SmsRepository`      | Stubs `watchUserSmsNumbers()` → empty stream             |

### Data Sources

| Mock                     | Implements           |
|--------------------------|----------------------|
| `MockCacheConfigService` | `CacheConfigService` |

### Clients

| Mock                | Implements                   |
|---------------------|------------------------------|
| `MockPhoenixSocket` | Phoenix socket for messaging |

## Factory Naming Conventions

| Name                                               | When to use                                     |
|----------------------------------------------------|-------------------------------------------------|
| `.initial()`                                       | Default/empty state                             |
| `.mainScreen()`                                    | State as shown on the main screen               |
| `.callScreen(video)`                               | State for the call screen                       |
| `.contactScreen()`                                 | State for the contact detail screen             |
| `.withItems()` / `.withMessages()` / `.withCdrs()` | State populated with mock data                  |
| `.withMockData()`                                  | General populated state                         |
| `.idle()`                                          | Inactive/idle state (e.g., no typing indicator) |
| `.settingScreen()`                                 | State for the settings screen                   |

## Stubbing Patterns

### Getter

```dart
when(() => mock.dateFormat).thenReturn(DateFormat.yMMMd().add_Hm());
when(() => mock.smsFallbackAvailable).thenReturn(false);
when(() => mock.number).thenReturn('1234');
```

### Async Method

```dart
when(() => mock.userReadedUntilUpdate(any())).thenAnswer((_) async {});
when(() => mock.markAsSeen(any())).thenAnswer((_) async {});
```

### Method with Custom Type Parameter

```dart
class _FakeSystemNotification extends Fake implements SystemNotification {}

factory MockSomeBloc.ready() {
  registerFallbackValue(_FakeSystemNotification());

  final mock = MockSomeBloc();
  when(() => mock.markAsSeen(any())).thenAnswer((_) async {});
  return mock;
}
```
