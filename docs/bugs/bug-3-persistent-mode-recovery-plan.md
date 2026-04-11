# Bug 3 — Plan: Persistent Mode Recovery

**Статус:** PLANNING (validated)
**Гілка:** `fix/bug-3-persistent-mode-recovery` від `fix/signaling-fgs-xiaomi-crash`
**PR target:** `fix/signaling-fgs-xiaomi-crash` (umbrella)

---

# Part 1 — Recovery через FCM push path

## Намір

Відновлювати `SignalingForegroundService` після kill в persistent mode через точку входу
`onPushNotificationSyncCallback` — вже існуючий callback що завжди викликається при
incoming call (як з FCM, так і з WebSocket шляху).

## Архітектурний принцип

- Persistent mode XOR push mode — **ніколи одночасно**
- В будь-який момент — **1 активний WebSocket**
- Push WebSocket (тимчасовий, в push isolate) закривається через `_disposeContext()`
- Тільки після цього FGS стартує і відкриває persistent WebSocket

```
FCM push arrives
  └── onPushNotificationSyncCallback
        ├── PushNotificationIsolateManager.run()  ← тимчасовий WS для поточного дзвінка
        └── finally:
              ├── _disposeContext()               ← тимчасовий WS закрито
              └── WebtritSignalingService.connect() ← FGS стартує → persistent WS
```

## Дизайн: `WebtritSignalingService.connect()`

### Pigeon (`signaling.messages.dart`)

```dart
void connect();
```

### Kotlin (`WebtritSignalingServicePlugin.kt`)

```kotlin
override fun connect() {
    if (StorageDelegate.isPushBound(context)) return      // push mode — не наш кейс
    if (SignalingForegroundService.isRunning) return      // вже живий — no-op
    if (StorageDelegate.getCoreUrl(context).isEmpty()) return  // logout guard (clearConnectionConfig)
    if (StorageDelegate.getCallbackDispatcher(context) == 0L) return
    SignalingForegroundService.start(context)
}
```

> **Примітка:** `stopService()` у Plugin викликає `StorageDelegate.clearConnectionConfig()` —
> видаляє coreUrl, tenantId, token. Тому guard `getCoreUrl().isEmpty()` природно блокує
> `connect()` після logout без додаткових перевірок.

### Dart public API

```dart
static Future<void> connect() => _platform.connect();
```

### Call site (`background_isolate_callbacks.dart`)

```dart
@pragma('vm:entry-point')
Future<void> onPushNotificationSyncCallback(CallkeepIncomingCallMetadata? metadata) async {
  try {
    final manager = await _getOrInit();
    await manager.run(metadata).timeout(_kPushNotificationSyncTimeout, ...);
  } catch (e) {
    _logger.severe('onPushNotificationSyncCallback: error=$e');
  } finally {
    await _disposeContext();
    try {
      await WebtritSignalingService.connect();
    } catch (e) {
      // Android 12+: ForegroundServiceStartNotAllowedException якщо BFGS стан
      // вже закінчився до кінця finally. Логуємо, не пробрасуємо.
      _logger.warning('connect() after push failed: $e');
    }
  }
}
```

> **Android 12+ ризик:** Якщо CallKeep bootstrap service встиг зупинитись до кінця
> `_disposeContext()` — процес може вийти з BFGS стану і `startForegroundService()` кине
> `ForegroundServiceStartNotAllowedException`. try-catch запобігає краш всього callback.
> На практиці CallKeep bootstrap service живе протягом всього callback — ризик низький.

## Файли (Part 1)

| Файл | Зміна |
|------|-------|
| `pigeons/signaling.messages.dart` | Додати `void connect()` |
| `android/.../Messages.g.kt` | Регенерувати або додати вручну |
| `lib/src/messages.g.dart` | Регенерувати або додати вручну |
| `android/.../WebtritSignalingServicePlugin.kt` | Реалізувати `connect()` |
| `lib/src/plugin.dart` | `static Future<void> connect()` |
| `webtrit_phone/.../background_isolate_callbacks.dart` | finally block з try-catch |

## Що вирішує Part 1

- FGS вбитий Xiaomi, `START_STICKY` не спрацював
- FCM push прийшов як fallback → `onPushNotificationSyncCallback` обробляє поточний дзвінок
- `connect()` відновлює persistent WS для **майбутніх** дзвінків
- Logout guard через `clearConnectionConfig()` — не рестартує після виходу

## Обмеження Part 1

Закриває лише сценарій **FGS dead + FCM push як fallback**. На пристроях **без Google
Services** FCM фізично відсутній — `onPushNotificationSyncCallback` ніколи не викликається.

---

# Part 2 — Recovery без FCM (WorkManager)

## Намір

Відновлювати FGS незалежно від FCM через два тригери:
1. `onDestroy` → WorkManager one-shot (15с) — graceful kill
2. `onTaskRemoved` → WorkManager one-shot (1с) — swipe з рекентів

WorkManager використовує `JobScheduler` як backend → не потребує Google Play Services.
`Result.retry()` при помилці — WorkManager автоматично ретраїть без periodic watchdog.

**Reference:** `SignalingIsolateService.kt` + `SignalingServiceBootWorker.kt` у `webtrit_callkeep`.

## Дизайн

### A. `build.gradle` — додати залежність (зараз відсутня)

```gradle
dependencies {
    implementation "androidx.core:core-ktx:1.16.0"
    implementation "androidx.work:work-runtime-ktx:2.9.0"  // ← нове
    // ...
}
```

### B. `SignalingForegroundService.kt` — виправити `@Volatile` + два тригери

```kotlin
companion object {
    // БУЛО: var isRunning = false  (не @Volatile — thread safety bug)
    // СТАЛО:
    @Volatile var isRunning = false
}
```

```kotlin
override fun onDestroy() {
    // Першим — до будь-якого teardown, поки процес ще валідний
    if (!StorageDelegate.isPushBound(applicationContext)) {
        SignalingRestartWorker.enqueue(applicationContext, delayMillis = 15_000)
    }
    // Решта teardown
    instance = null
    wakeLock?.let { if (it.isHeld) it.release() }
    stopForeground(STOP_FOREGROUND_REMOVE)
    _isolateFlutterApi = null
    flutterEngineHelper.detachAndDestroyEngine()
    isRunning = false
    super.onDestroy()
}

override fun onTaskRemoved(rootIntent: Intent?) {
    // Swipe з рекентів — відновлення через 1с
    // Якщо сервіс ще живий коли job спрацює → isRunning guard → no-op
    if (!StorageDelegate.isPushBound(applicationContext)) {
        SignalingRestartWorker.enqueue(applicationContext, delayMillis = 1_000)
    }
}
```

### C. `SignalingRestartWorker.kt` (новий файл)

```kotlin
class SignalingRestartWorker(
    context: Context,
    workerParams: WorkerParameters,
) : Worker(context, workerParams) {

    override fun doWork(): Result = try {
        if (!SignalingForegroundService.isRunning &&           // @Volatile — safe cross-thread
            !StorageDelegate.isPushBound(applicationContext) &&
            StorageDelegate.getCoreUrl(applicationContext).isNotEmpty() && // logout guard
            StorageDelegate.getCallbackDispatcher(applicationContext) != 0L
        ) {
            Log.w(TAG, "SignalingRestartWorker: restarting persistent FGS")
            SignalingForegroundService.start(applicationContext)
        }
        Result.success()
    } catch (e: Exception) {
        // Android 12+: ForegroundServiceStartNotAllowedException якщо немає активного FGS
        // і процес в background. Result.retry() — WorkManager ретраїть з exponential backoff.
        // Відновлення відбудеться коли юзер відкриє додаток або з'явиться інший FGS.
        Log.e(TAG, "Failed to restart FGS: $e")
        Result.retry()
    }

    companion object {
        private const val TAG = "SignalingRestartWorker"
        private const val WORK_TAG = "signaling_fgs_restart"

        fun enqueue(context: Context, delayMillis: Long = 15_000) {
            val request = OneTimeWorkRequestBuilder<SignalingRestartWorker>()
                .addTag(WORK_TAG)
                .setInitialDelay(delayMillis, TimeUnit.MILLISECONDS)
                .build()
            // REPLACE: якщо job вже є в черзі — скидає таймер
            WorkManager.getInstance(context)
                .enqueueUniqueWork(WORK_TAG, ExistingWorkPolicy.REPLACE, request)
        }

        fun remove(context: Context) {
            WorkManager.getInstance(context).cancelAllWorkByTag(WORK_TAG)
        }
    }
}
```

### D. `WebtritSignalingServicePlugin.kt` — скасування при явній зупинці

```kotlin
override fun stopService() {
    Log.d(TAG, "stopService")
    SignalingRestartWorker.remove(context)  // ← нове: не рестартувати після logout
    StorageDelegate.clearConnectionConfig(context)
    val service = SignalingForegroundService.instance
    if (service != null) {
        service.gracefulStop { SignalingForegroundService.stop(context) }
    } else {
        SignalingForegroundService.stop(context)
    }
}
```

> **Примітка:** `clearConnectionConfig()` вже видаляє coreUrl і є природним guard в
> `doWork()`. `remove()` додається як explicit скасування для надійності — перший рядок,
> до будь-яких інших дій.

## Обмеження Part 2

**Android 12+ (API 31+) без активного FGS:** `startForegroundService()` з `doWork()`
кидає `ForegroundServiceStartNotAllowedException`. `Result.retry()` ретраїть з exponential
backoff до тих пір поки:
- юзер відкриє додаток → процес в BFGS → retry succeeds
- або інший FGS з'явиться в процесі

На практиці no-GMS пристрої переважно Android < 12. Для Android 12+ без GMS — прийнятна
деградація (відновлення при наступному відкритті додатку). Виправлення через `setExpedited()`
+ `getForegroundInfo()` можливе але суттєво складніше — відкладено.

**Hard kill (SIGKILL):** `onDestroy` не викликається → job не ставиться в чергу →
гарантованого механізму немає до наступного unlock/reboot.

## Файли (Part 2)

| Файл | Зміна |
|------|-------|
| `android/build.gradle` | Додати `work-runtime-ktx:2.9.0` |
| `android/.../SignalingForegroundService.kt` | `@Volatile isRunning`; `onDestroy` → enqueue першим; додати `onTaskRemoved` |
| `android/.../SignalingRestartWorker.kt` | Новий файл |
| `android/.../WebtritSignalingServicePlugin.kt` | `stopService()` → `remove()` першим рядком |

---

# Повна картина (Part 1 + Part 2)

| Сценарій | Пристрій | Механізм | Час відновлення |
|----------|----------|----------|-----------------|
| FGS dead + FCM є | З Google Services | Part 1: `connect()` у push callback | ~1–3с |
| FGS dead, graceful kill | Без FCM | Part 2: `onDestroy` → WorkManager | ~15с |
| FGS dead, swipe з рекентів | Без FCM | Part 2: `onTaskRemoved` → WorkManager | ~1с |
| WorkManager job fails (Android 12+) | Без FCM, Android 12+ | `Result.retry()` → при наступному відкритті | до відкриття |
| Hard kill (SIGKILL) | Будь-який | Немає гарантованого механізму | до unlock/reboot |

# Валідаційний checklist

| Пункт | Статус |
|-------|--------|
| XOR WebSocket — 1 активний завжди | ✅ |
| `clearConnectionConfig` як logout guard | ✅ |
| try-catch навколо `connect()` у finally | ✅ |
| WorkManager dependency у build.gradle | ✅ вказано |
| `@Volatile isRunning` | ✅ виправлено |
| Android 12+ `doWork()` обмеження | ✅ задокументовано |
| `onDestroy` enqueue першим до teardown | ✅ |
| `onTaskRemoved` double-trigger безпека | ✅ (`isRunning` guard) |
| `remove()` першим у `stopService()` | ✅ |
