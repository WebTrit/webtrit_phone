# Mock Data Reference

Static test data lives in `lib/data/`. All top-level variables are prefixed with `d`.

## Data Files

### `clock.dart`

```dart

final dFixedTime = DateTime(2022, 7, 20);
```

All screenshots freeze the clock to this value. Use `clock.nowBased(hour: H, minute: M)` from the
`clock` package to create times relative to this date.

### `info.dart`

`userInfo` — `UserInfo` constant with balance, name, company, and main number (`'999'`).

### `app.dart`

`dAppInfo` — `AppInfo` constant.

### `call.dart`

| Variable           | Type         | Description                                          |
|--------------------|--------------|------------------------------------------------------|
| `dAudioActiveCall` | `ActiveCall` | Incoming audio call, connected, from Thomas Anderson |
| `dVideoActiveCall` | `ActiveCall` | Incoming video call, connected, from Thomas Anderson |

Both use `clock.ago(...)` for relative timestamps.

### `recents.dart`

| Variable                 | Type           | Description                                                                             |
|--------------------------|----------------|-----------------------------------------------------------------------------------------|
| `dMockRecentCallHistory` | `List<Recent>` | 5 recent calls with contacts (Thomas Anderson, Dion Dames, Stuart Peterson, Alex Bloom) |

### `cdrs.dart`

| Variable              | Type                 | Description                                  |
|-----------------------|----------------------|----------------------------------------------|
| `dMockCdrRecords`     | `List<CdrRecord>`    | CDR records with direction, status, duration |
| `dMockCallLogEntries` | `List<CallLogEntry>` | Call log entries with timestamps             |

### `favorites.dart`

| Variable     | Type             | Description                       |
|--------------|------------------|-----------------------------------|
| `dFavorites` | `List<Favorite>` | Favorite contacts for main screen |

### `messaging.dart`

| Variable                                  | Type                    | Description                     |
|-------------------------------------------|-------------------------|---------------------------------|
| `dChatsMockChatsRepository`               | `List<Chat>`            | Direct and group chats          |
| `dMessagesMockChatsRepository`            | `List<ChatMessage>`     | Chat messages                   |
| `dConversationsMockSmsConversationsCubit` | `List<SmsConversation>` | SMS conversations               |
| `dMessagesMockSmsConversationsCubit`      | `List<SmsMessage>`      | SMS messages                    |
| `dContactsRepository`                     | `List<Contact>`         | Contacts with phones and emails |
| `dChatUnreadCountsMockUnreadCountCubit`   | `Map<int, int>`         | Chat ID to unread count         |

### `voicemails.dart`

| Variable          | Type              | Description                                      |
|-------------------|-------------------|--------------------------------------------------|
| `dMockVoicemails` | `List<Voicemail>` | 3 voicemails, mixed read/unread, with audio URLs |

### `system_notifications.dart`

| Variable                   | Type                       | Description                                       |
|----------------------------|----------------------------|---------------------------------------------------|
| `dMockSystemNotifications` | `List<SystemNotification>` | System notifications, mixed types and read status |

## Adding New Data

1. Create `lib/data/your_data.dart`
2. Prefix variables with `d` (e.g., `dMockWidgets`)
3. Use `clock.nowBased(...)` for date/time values (not `DateTime.now()`)
4. Import models from `package:webtrit_phone/models/models.dart`
5. Export from `lib/data/data.dart`

### Time Helpers

The `clock` package provides helpers relative to `dFixedTime`:

```dart
import 'package:clock/clock.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

// Absolute time on the fixed date
clock.nowBased
(
hour: 9, minute: 30) // → 2022-07-20 09:30:00

// Relative to "now" (the fixed time)
clock.ago(
minutes
:
10
) // → 10 minutes before dFixedTime
```
