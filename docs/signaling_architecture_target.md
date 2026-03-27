# Target Signaling Architecture

## Контекст і мотивація

Поточна кодова база має два паралельні класи, що виконують одну роль — управління
`WebtritSignalingClient`:

| Клас | Де використовується | Проблема |
|------|---------------------|---------|
| `SignalingModule` | `CallBloc` (головний ізолят) | Жорстко зав'язаний на `CallState` і `emit` |
| `SignalingManager` | `IsolateManager` (фонові ізоляти) | Дублює логіку reconnect, disconnect, event routing |

**Кінцева мета:** один `SignalingModule` — **незалежний event source**, без будь-яких
знань про `CallState`, BLoC, `Notification`, `RegistrationStatus` чи інші
концепти застосунку. Може жити в головному ізоляті, фоновому ізоляті, або в
інтеграційному тесті без жодного зв'язку з UI чи WebRTC.

---

## Принципи нового дизайну

### SignalingModule — pure event source

Модуль знає лише про одне: **WebSocket-з'єднання з сигналінг-сервером**.

**Відповідає за:**

- Lifecycle `WebtritSignalingClient` (connect / disconnect)
- Інтерпретацію disconnect-кодів — це **протокольне знання** (код 4441 → fast
  reconnect, `protocolError` → не reconnect)
- Публікацію typed-подій у stream

**Не знає нічого про:**

- `CallState`, `ActiveCall`, BLoC, `emit`
- `Notification` (app-specific)
- `RegistrationStatus`, `dispatchCompleteCall` (BLoC concerns)
- Чи додаток активний, чи є мережа — це **environmental знання**, не протокольне

---

## API модуля

### Stream подій

```dart
sealed class SignalingModuleEvent {}

class SignalingConnecting       extends SignalingModuleEvent {}
class SignalingConnected        extends SignalingModuleEvent {}
class SignalingConnectionFailed extends SignalingModuleEvent {
  final Object error;
}
class SignalingDisconnecting    extends SignalingModuleEvent {}

/// Сервер або клієнт закрив з'єднання.
///
/// [recommendedReconnectDelay] — протокольна рекомендація модуля:
///   - Duration(0)         → reconnect негайно (напр. код 4441)
///   - Duration(seconds:6) → slow reconnect
///   - null               → не reconnect (напр. protocolError)
///
/// Consumer сам вирішує чи виконувати рекомендацію (враховуючи
/// стан мережі, app lifecycle тощо).
class SignalingDisconnected extends SignalingModuleEvent {
  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  final StateHandshake handshake;
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  final Event event;
}
```

### Публічний інтерфейс

```dart
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates trustedCertificates,
    required SignalingClientFactory signalingClientFactory,
  });

  /// Stream усіх подій модуля. Broadcast stream — підписуватись можуть кілька listeners.
  Stream<SignalingModuleEvent> get events;

  /// Прямий доступ до клієнта для надсилання requests (HangupRequest, AcceptRequest тощо).
  WebtritSignalingClient? get signalingClient;

  Future<void> connect();
  Future<void> disconnect();
  Future<void> dispose();
}
```

**Немає делегата. Немає callbacks. Немає залежностей від застосунку.**

---

## Reconnect: розподіл відповідальності

```
Модуль знає:             Consumer знає:
─────────────            ──────────────
Який код прийшов    →    Чи app активний
Що він означає      →    Чи є мережа
Скільки чекати      →    Чи взагалі треба reconnect зараз
(recommendedDelay)
```

Consumer-логіка reconnect (приклад для CallBloc):

```dart
_signalingModule.events.listen((event) {
  if (event is SignalingDisconnected) {
    final delay = event.recommendedReconnectDelay;
    if (delay != null && state.isAppActive && state.hasConnectivity) {
      Future.delayed(delay, _signalingModule.connect);
    }
  }
});
```

Consumer-логіка reconnect (приклад для IsolateManager):

```dart
_signalingModule.events.listen((event) {
  if (event is SignalingDisconnected) {
    final delay = event.recommendedReconnectDelay;
    if (delay != null && !_networkNone) {
      Future.delayed(delay, _signalingModule.connect);
    }
  }
});
```

---

## CallBloc — споживач stream

`CallBloc` **не реалізує жодного делегата**. Він підписується на `events` і
маппить їх у свій стейт та внутрішні події:

```dart
late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;

// У конструкторі:
_signalingSubscription = _signalingModule.events.listen((event) {
  switch (event) {
    case SignalingConnecting():
      add(const _SignalingStatusEvent.connecting());
    case SignalingConnected():
      add(const _SignalingStatusEvent.connected());
    case SignalingConnectionFailed(:final error):
      add(_SignalingStatusEvent.failed(error));
    case SignalingDisconnected(:final code, :final recommendedReconnectDelay):
      add(_SignalingStatusEvent.disconnected(code));
      _scheduleReconnectIfNeeded(recommendedReconnectDelay);
    case SignalingHandshakeReceived(:final handshake):
      add(_HandshakeSignalingEventState(...));
    case SignalingProtocolEvent(:final event):
      _onSignalingEventMapper(event);
    default:
      break;
  }
});
```

---

## IsolateManager — споживач stream

`IsolateManager` підписується тільки на те, що йому потрібно:

```dart
_signalingModule.events.listen((event) {
  switch (event) {
    case SignalingHandshakeReceived(:final handshake):
      _onHandshake(handshake);
    case SignalingProtocolEvent(:final event):
      _onProtocolEvent(event);
    case SignalingDisconnected(:final recommendedReconnectDelay):
      if (recommendedReconnectDelay != null && !_networkNone) {
        Future.delayed(recommendedReconnectDelay, _signalingModule.connect);
      }
    default:
      break;
  }
});
```

`IsolateManager` сам управляє:

- `_lines` — з `SignalingHandshakeReceived` (для `declineCall` / `hangupCall`)
- `_pendingRequests` — черга запитів до встановлення з'єднання
- Connectivity monitoring — через `connectivity_plus`

---

## Інтеграційні тести

`SignalingModule` тестується повністю ізольовано від BLoC і WebRTC:

```dart
test('connect → handshake → disconnect lifecycle', () async {
  final module = SignalingModule(
    coreUrl: 'https://...',
    tenantId: '...',
    token: '...',
    trustedCertificates: TrustedCertificates.empty,
    signalingClientFactory: defaultSignalingClientFactory,
  );

  final events = <SignalingModuleEvent>[];
  final sub = module.events.listen(events.add);

  await module.connect();

  // Дочекатись handshake
  await module.events
      .whereType<SignalingHandshakeReceived>()
      .first
      .timeout(const Duration(seconds: 15));

  await module.disconnect();
  await sub.cancel();
  await module.dispose();

  expect(events, [
    isA<SignalingConnecting>(),
    isA<SignalingConnected>(),
    isA<SignalingHandshakeReceived>(),
    isA<SignalingDisconnecting>(),
    isA<SignalingDisconnected>(),
  ]);
});
```

**Немає `CallState`. Немає `CallBloc`. Немає mock-ів BLoC-рівня.**

---

## Діаграма залежностей

```
До:
  CallBloc ──uses──► SignalingModule  (знає про CallState, emit)
  IsolateManager ──► SignalingManager (окремий клас, дублює логіку)

Після:
  CallBloc ──subscribes──► SignalingModule.events  (pure stream)
  IsolateManager ──────────► SignalingModule.events  (той самий клас)
  SignalingManager ──► [видалений]
  SignalingModuleDelegate ──► [видалений]
```

---

## Що видалити

| Що | Де |
|----|-----|
| `SignalingModuleDelegate` | `signaling_module.dart` |
| `performConnect(emit, isCancelled)` | `signaling_module.dart` |
| `performDisconnect(emit, isCancelled)` | `signaling_module.dart` |
| `handleDisconnected(code, reason, emit, isCancelled)` | `signaling_module.dart` |
| `SignalingManager` | `lib/common/signaling_manager.dart` |
| `export 'signaling_manager.dart'` | `lib/common/common.dart` |

---

## Кроки реалізації

1. **`signaling_module.dart`** — sealed `SignalingModuleEvent`, `StreamController.broadcast()`,
   публічний API `connect()` / `disconnect()` / `dispose()` / `events` / `signalingClient`
2. **`call_bloc.dart`** — підписка на `_signalingModule.events`, видалити `SignalingModuleDelegate`,
   `_scheduleReconnectIfNeeded` з перевіркою `state.isAppActive && state.hasConnectivity`
3. **`isolate_manager.dart`** — підписка на `_signalingModule.events`,
   port `_lines`, `_pendingRequests`, connectivity monitoring
4. Видалити `lib/common/signaling_manager.dart`
5. Оновити `lib/common/common.dart`
6. **Інтеграційні тести** — чисті тести без BLoC, перевірка послідовності подій у stream

---

## Прийняті рішення

| Питання | Рішення |
|---------|---------|
| `connect()` — Future чи fire-and-forget? | **Fire-and-forget.** Одразу повертається, `SignalingConnected` приходить через stream. Два канали для одного факту — зайве. |
| Дедуплікація помилок connect | **`_lastConnectError` залишається в модулі.** Це протокольна деталь — не спамити однаковою помилкою. Модуль додає `isRepeated: bool` до `SignalingConnectionFailed`, consumer вирішує що з цим робити. |
| `recommendedReconnectDelay` у `SignalingConnectionFailed` | **Так, додати** — консистентно з `SignalingDisconnected`. Consumer не hardcode-ить затримку, отримує її від модуля. При connect failure значення завжди `kSignalingClientReconnectDelay`. |

---

## Фінальний вигляд sealed подій

```dart
sealed class SignalingModuleEvent {}

class SignalingConnecting extends SignalingModuleEvent {}

class SignalingConnected extends SignalingModuleEvent {}

/// Connect не вдався (SocketException, TlsException тощо).
///
/// [isRepeated] — true якщо це та сама помилка що і попередній раз
/// (модуль відстежує через internal [_lastConnectError]).
/// Consumer може не показувати нотифікацію якщо [isRepeated] == true.
///
/// [recommendedReconnectDelay] — завжди [kSignalingClientReconnectDelay].
class SignalingConnectionFailed extends SignalingModuleEvent {
  final Object error;
  final bool isRepeated;
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting extends SignalingModuleEvent {}

/// З'єднання закрито (сервером або клієнтом).
///
/// [recommendedReconnectDelay]:
///   - Duration(0)          → reconnect негайно (напр. код 4441)
///   - Duration(seconds: 6) → slow reconnect
///   - null                 → не reconnect (напр. protocolError)
class SignalingDisconnected extends SignalingModuleEvent {
  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  final StateHandshake handshake;
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  final Event event;
}
```

### Публічний інтерфейс (фінальний)

```dart
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates trustedCertificates,
    required SignalingClientFactory signalingClientFactory,
  });

  /// Broadcast stream усіх подій модуля.
  Stream<SignalingModuleEvent> get events;

  /// Прямий доступ до клієнта для надсилання requests.
  WebtritSignalingClient? get signalingClient;

  /// Fire-and-forget. Результат приходить через [events].
  void connect();

  Future<void> disconnect();
  Future<void> dispose();
}
