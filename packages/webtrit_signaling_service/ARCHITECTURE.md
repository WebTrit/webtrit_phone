# webtrit_signaling_service — Architecture

> Plugin internals: layers, hub, isolates, modes, event model.
> For app-level integration see [
`docs/signaling_architecture_target.md`](../../docs/signaling_architecture_target.md).

---

## Package structure

```mermaid
graph LR
    App["App / CallBloc"] -->|imports| Umbrella["webtrit_signaling_service\n(WebtritSignalingService)"]
    Umbrella -->|delegates to| PI["webtrit_signaling_service\n_platform_interface\n(SignalingServicePlatform)"]
    PI -->|implemented by| Android["webtrit_signaling_service_android"]
    PI -->|implemented by| IOS["webtrit_signaling_service_ios"]
    Android & IOS -->|uses| Signaling["webtrit_signaling\n(WebtritSignalingClient)"]
```

---

## Three-layer model

Each layer knows only the one below it — never above.

```mermaid
graph TD
    subgraph "Layer 3 — Consumer"
        CB["CallBloc\n(main isolate)"]
        PIM["PushNotificationIsolateManager\n(background isolate)"]
        SFIM["SignalingForegroundIsolateManager\n(background isolate, Android)"]
    end

    subgraph "Layer 2 — SignalingModule"
        SM["SignalingModule\n· owns client lifecycle\n· session replay buffer\n· emits typed events\n· recommends reconnect delay"]
    end

    subgraph "Layer 1 — Protocol"
        WSC["WebtritSignalingClient\n· raw WebSocket frames\n· JSON encode/decode\n· keepalive timer\n· transaction map"]
    end

    CB & PIM & SFIM -->|" Stream&lt;SignalingModuleEvent&gt; "| SM
    SM -->|callbacks| WSC
    WSC -->|WebSocket| Server["WebTrit Core"]
```

| Layer                                | Knows                                                      | Does NOT know                                     |
|--------------------------------------|------------------------------------------------------------|---------------------------------------------------|
| `WebtritSignalingClient`             | Raw WebSocket, JSON protocol, transactions                 | App lifecycle, reconnect logic                    |
| `SignalingModule`                    | Disconnect codes, reconnect delay hints, session buffering | Network state, active calls, whether to reconnect |
| Consumer (CallBloc / IsolateManager) | App lifecycle, network, active calls                       | WebSocket internals                               |

---

## iOS vs Android

```mermaid
graph TD
    subgraph iOS["iOS — main isolate only"]
        direction TB
        ios_cb["CallBloc"] -->|events| ios_sm["SignalingModule"]
        ios_sm -->|WebSocket| ios_srv["WebTrit Core"]
    end

    subgraph Android["Android — foreground service + hub"]
        direction TB
        and_cb["CallBloc\n(main isolate)"] -->|events via hub| and_hm["SignalingHubModule"]
        and_push["Push isolate"] -->|events via hub| and_hm2["SignalingHubModule"]
        and_hm & and_hm2 -->|" IsolateNameServer\nSendPort "| and_hub["SignalingHub\n(background isolate)"]
        and_hub -->|owns| and_sm["SignalingModule"]
        and_sm -->|WebSocket| and_srv["WebTrit Core"]
        and_hub -->|foreground| and_svc["SignalingForegroundService"]
    end
```

On iOS the socket lives in the main isolate and is recreated each time the app foregrounds.
On Android the socket lives in a background isolate inside a foreground service — it survives
app backgrounding and dispatches incoming calls when the app is closed.

---

## Android hub architecture

```mermaid
graph TD
    subgraph "Kotlin"
        FS["SignalingForegroundService\n(remoteMessaging)"]
        BR["SignalingBootReceiver\n(BOOT_COMPLETED)"]
        FEH["FlutterEngineHelper"]
    end

    subgraph "Background Dart isolate"
        EP["onSignalingServiceSync()\n@pragma vm:entry-point"]
        SFIM2["SignalingForegroundIsolateManager"]
        HUB["SignalingHub\n(IsolateNameServer port)"]
        SM2["SignalingModule"]
    end

    subgraph "Main isolate"
        ANDROID["WebtritSignalingServiceAndroid"]
        HM["SignalingHubModule"]
        HC["SignalingHubClient"]
        BLOC["CallBloc"]
    end

    subgraph "Push isolate"
        PHC["SignalingHubClient"]
        PHM["SignalingHubModule"]
    end

    BR -->|starts| FS
    FS -->|spawns| FEH --> EP --> SFIM2
    SFIM2 --> HUB & SM2
    HUB <-->|" SendPort "| HC --> HM --> BLOC
    HUB <-->|" SendPort "| PHC --> PHM
    ANDROID -->|Pigeon| FS
    ANDROID --> HC
```

### Hub wire protocol (pure Dart ports — no platform channels)

| Direction    | Message                   | Description                                                 |
|--------------|---------------------------|-------------------------------------------------------------|
| Client → Hub | `{ sub, id, replyPort }`  | Subscribe; hub replies with ack then replays session buffer |
| Client → Hub | `{ unsub, id }`           | Unsubscribe                                                 |
| Client → Hub | `{ exec, id, corr, req }` | Execute request; hub replies `[result, corr, error?]`       |
| Hub → Client | `SignalingModuleEvent`    | Forwarded to every subscriber in real time                  |

### `attach()` sequence — why `awaitAck` comes before `start()`

```
awaitAck()   ← registers the internal Completer FIRST (before ack can arrive)
start()      ← sends {sub} to hub → hub sends sub-ack + session buffer replay
await ack    ← now safe to wait; ack arrives because start() already fired
```

Awaiting the future before `start()` always times out — `start()` is what triggers the ack.

---

## Service modes

```mermaid
stateDiagram-v2
    [*] --> Stopped
    Stopped --> Persistent: start(mode: persistent)
    Stopped --> PushBound: start(mode: pushBound)
    Persistent --> Persistent: app close\n(service keeps running)
    Persistent --> Persistent: reboot\n(BootReceiver restarts)
    Persistent --> Stopped: dispose()
    PushBound --> Stopped: app swiped away\n(onTaskRemoved → stopSelf)
    PushBound --> PushBound: Activity opens\nattach() — no new WebSocket
    PushBound --> Stopped: dispose()
```

|                     | `persistent`                                       | `pushBound`                                  |
|---------------------|----------------------------------------------------|----------------------------------------------|
| Survives app close  | Yes                                                | No — `onTaskRemoved` stops service           |
| Survives reboot     | Yes — `SignalingBootReceiver`                      | No                                           |
| Incoming calls      | WebSocket always live → direct `IncomingCallEvent` | Server sends FCM push (no active socket)     |
| When Activity opens | `attach()` — connects to running hub               | `attach()` — connects to hub started by push |
| `onStartCommand`    | `START_STICKY`                                     | `START_NOT_STICKY`                           |

---

## Event model

```mermaid
graph LR
    SME["SignalingModuleEvent\n(sealed)"]
    SME --> C1["SignalingConnecting"]
    SME --> C2["SignalingConnected"]
    SME --> C3["SignalingConnectionFailed\n· error\n· isRepeated\n· recommendedReconnectDelay"]
    SME --> C4["SignalingDisconnecting"]
    SME --> C5["SignalingDisconnected\n· code?\n· reason?\n· knownCode\n· recommendedReconnectDelay?"]
    SME --> C6["SignalingHandshakeReceived\n· handshake (StateHandshake)"]
    SME --> C7["SignalingProtocolEvent\n· event (IncomingCallEvent,\n HangupEvent, etc.)"]
```

`recommendedReconnectDelay` in `SignalingDisconnected`:

| Value                  | Meaning                                                              |
|------------------------|----------------------------------------------------------------------|
| `Duration.zero`        | Reconnect immediately (code 4441 — server evicted duplicate session) |
| `Duration(seconds: 3)` | Standard slow reconnect                                              |
| `null`                 | Do not reconnect (protocol error)                                    |

---

## Session replay buffer

`connect()` is called in `initState()` — before `CallBloc` is built. When `CallBloc` subscribes
later it gets the full session history via the buffer:

```
MainShellState.initState()
  └─ SignalingModule.connect()

  buffered:  Connecting → Connected → HandshakeReceived(lines)

CallBloc constructed later:
  └─ service.events.listen(...)
       ├─ [replay] SignalingConnecting
       ├─ [replay] SignalingConnected
       ├─ [replay] SignalingHandshakeReceived
       └─ [live]   future events...
```

`connect()` clears the buffer — each reconnect starts fresh.
Both `SignalingModule` and `SignalingHubModule` maintain independent session buffers.

---

## Reconnect — who decides what

```mermaid
sequenceDiagram
    participant WS as WebSocket
    participant SM as SignalingModule
    participant CB as CallBloc
    WS ->> SM: onDisconnect(code, reason)
    SM ->> SM: interpret code → recommendedReconnectDelay
    SM ->> CB: SignalingDisconnected(recommendedReconnectDelay)
    Note over CB: Timer(delay, () {<br/> if (isClosed) return<br/> if (!appActive) return<br/> if (!networkActive) return<br/> service.connect()<br/>})
```

`SignalingModule` owns **protocol knowledge** (what the code means).
`CallBloc` owns **app context** (whether reconnect makes sense right now).

---

## Background incoming call handler (Android)

When the app is closed and the service runs in `persistent` mode, incoming calls arrive in
the background isolate. The plugin dispatches them via a registered Dart callback:

```
SignalingForegroundIsolateManager receives IncomingCallEvent
  └─ _dispatchIncomingCall(event)
       └─ PluginUtilities.getCallbackFromHandle(incomingCallHandlerHandle)
            └─ onSignalingBackgroundIncomingCall(event)   ← app-side
                 └─ callkeep.reportNewIncomingCall(...)
```

The callback must be a **top-level function** annotated `@pragma('vm:entry-point')`.
The plugin resolves the raw handle internally via `PluginUtilities.getCallbackHandle(callback)`
and persists it to `SharedPreferences`; the background isolate reads it at each sync —
the main isolate does not need to be alive.

---

## Key design decisions

| Question                                 | Decision               | Why                                                                                                                      |
|------------------------------------------|------------------------|--------------------------------------------------------------------------------------------------------------------------|
| `connect()` — Future or fire-and-forget? | Fire-and-forget        | Result arrives via stream; two channels for the same fact are redundant                                                  |
| Where does protocol knowledge live?      | `SignalingModule`      | Disconnect codes and delays are protocol detail, not app logic                                                           |
| Where does reconnect decision live?      | Consumer               | Only the consumer knows app state, network, and active calls                                                             |
| Session buffer — `rxdart` or manual?     | Manual `List`          | `ReplaySubject` has no `clear()` in v0.28; manual list gives full control                                                |
| `dispose()` closes the events stream?    | No                     | Closing would silently terminate active BLoC subscribers via `onDone`; stream stays open across `dispose`/`start` cycles |
| iOS background service?                  | No — main isolate only | iOS suspends background processes; no equivalent of Android foreground service                                           |
