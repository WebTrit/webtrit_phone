# Incoming-call background scenarios

How an incoming call is delivered and handled depending on the app state and the configured mode.
The single decision that selects the owner of the background work lives in callkeep
(`IncomingCallHandler.maybeInitBackgroundHandling`); see the callkeep doc
`webtrit_callkeep_android/docs/incoming-call-handling.md`. This page shows the app-level scenarios.

GitHub renders the `mermaid` blocks below.

Colour legend:

- blue — `webtrit_callkeep`
- green — `webtrit_signaling_service`
- orange — `webtrit_phone` (app code, incl. app callbacks running on a callkeep / FGS engine)
- grey — external (FCM, signaling server / WebSocket, Android Telecom / system UI)

## All scenarios (combined)

```mermaid
flowchart TB
  classDef ck fill:#dae8fc,stroke:#6c8ebf,color:#000
  classDef sig fill:#d5e8d4,stroke:#82b366,color:#000
  classDef app fill:#ffe6cc,stroke:#d79b00,color:#000
  classDef ext fill:#f5f5f5,stroke:#999999,color:#000

  subgraph A["CASE A - PUSH-BOUND (FCM): app Firebase isolate reports, callkeep runs the ongoing isolate"]
    direction TB
    A_FCM["FCM high-priority push"]:::ext
    A_FMISO["firebase_messaging background isolate (APP)<br/>_firebaseMessagingBackgroundHandler -> reportNewIncomingCall<br/>(no WebSocket here)"]:::app
    A_BOOT["reportNewIncomingCall (bootstrap API)"]:::ck
    A_CKC["CallkeepCore.startIncomingCall"]:::ck
    A_PCS["PhoneConnectionService<br/>:callkeep_core, Telecom"]:::ck
    A_TEL["System call UI + ring"]:::ext
    A_ICS["IncomingCallService (callkeep)<br/>spawns its OWN FlutterEngine (autoRegister = true)"]:::ck
    A_PISO["push isolate (app callback on callkeep engine)<br/>background_isolate_callbacks.dart : onPushNotificationSyncCallback<br/>-> PushNotificationIsolateManager.run (opens its own WebSocket)"]:::app
    A_WS["Signaling server (WebSocket)"]:::ext
    A_ACT["Activity / main UI engine<br/>adopts the call after answer"]:::app
    A_FGS["ForegroundService (callkeep)<br/>bound to Activity, PHostApi + events"]:::ck

    A_FCM --> A_FMISO --> A_BOOT --> A_CKC --> A_PCS --> A_TEL
    A_PCS -. "onShowIncomingCallUi -> start" .-> A_ICS
    A_ICS --> A_PISO
    A_PISO <--> A_WS
    A_PCS -. "on answer: adopts" .-> A_ACT
    A_ACT -. "binds" .-> A_FGS
    A_FGS <--> A_CKC
  end

  subgraph B["CASE B - PERSISTENT / SOCKET (signaling OWNS the engine)"]
    direction TB
    B_WApp["WebtritApplication.onCreate<br/>wires onFgsEngineReady / onFgsEngineDestroyed"]:::app
    B_ATT["WebtritCallkeep.attachToEngine / detach<br/>callkeep channels on FGS engine (no own isolate)"]:::ck
    B_SFGS["SignalingForegroundService (signaling)<br/>OWNS FGS engine (autoRegister = false)<br/>persistent WebSocket"]:::sig
    B_SISO["push isolate (app code on the FGS engine)<br/>background_isolate_callbacks.dart : onSignalingBackgroundCallEvent"]:::app
    B_WS["Signaling server (WebSocket)"]:::ext
    B_BOOT["reportNewIncomingCall (bootstrap API)"]:::ck
    B_CKC["CallkeepCore.startIncomingCall"]:::ck
    B_PCS["PhoneConnectionService<br/>:callkeep_core, Telecom"]:::ck
    B_TEL["System call UI + ring"]:::ext
    B_ACT["Activity / main UI engine<br/>adopts the call after answer"]:::app
    B_FGS["ForegroundService (callkeep)<br/>bound to Activity, PHostApi + events"]:::ck

    B_WApp -. "wires" .-> B_ATT
    B_ATT -. "hosted on" .-> B_SFGS
    B_SFGS <--> B_WS
    B_SFGS --> B_SISO --> B_BOOT --> B_CKC --> B_PCS --> B_TEL
    B_PCS -. "on answer: adopts" .-> B_ACT
    B_ACT -. "binds" .-> B_FGS
    B_FGS <--> B_CKC
  end

  subgraph C["CASE C - APP FOREGROUND (app OWNS the WebSocket)"]
    direction TB
    C_ACT["Activity / main UI engine (foreground)<br/>WebtritCallkeepPlugin attached"]:::app
    C_SMOD["App signaling + CallBloc<br/>owns the WebSocket while foreground"]:::app
    C_WS["Signaling server (WebSocket)"]:::ext
    C_FGS["ForegroundService (callkeep)<br/>bound to Activity, PHostApi + events"]:::ck
    C_CKC["CallkeepCore.startIncomingCall"]:::ck
    C_PCS["PhoneConnectionService<br/>:callkeep_core, Telecom"]:::ck
    C_ICS["IncomingCallService (notification UI)<br/>app active -> SKIP background isolate"]:::ck
    C_TEL["System call UI + ring (in-app)"]:::ext

    C_ACT --- C_SMOD
    C_SMOD <--> C_WS
    C_ACT -. "binds" .-> C_FGS
    C_SMOD -. "call_bloc.dart reportNewIncomingCall (PHostApi)" .-> C_FGS
    C_FGS <--> C_CKC
    C_CKC --> C_PCS --> C_TEL
    C_PCS -. "shows UI via" .-> C_ICS
  end
```

## Case A — push-bound (FCM)

App DEAD -> isolated push isolate; app ALIVE but backgrounded -> main app handles (no isolate).

```mermaid
flowchart TB
  classDef ck fill:#dae8fc,stroke:#6c8ebf,color:#000
  classDef app fill:#ffe6cc,stroke:#d79b00,color:#000
  classDef ext fill:#f5f5f5,stroke:#999999,color:#000

  TITLE["CASE A - PUSH-BOUND (FCM)<br/>app DEAD -> isolated push isolate; app ALIVE but backgrounded -> main app handles (no isolate)"]:::ext
  FCM["FCM high-priority push"]:::ext
  FMISO["firebase_messaging background isolate (APP)<br/>bootstrap.dart : _firebaseMessagingBackgroundHandler<br/>reports the call (no WebSocket here)"]:::app
  BOOT["reportNewIncomingCall (callkeep bootstrap API)"]:::ck
  CKC["CallkeepCore.startIncomingCall"]:::ck
  PCS["PhoneConnectionService<br/>:callkeep_core, Android Telecom"]:::ck
  TEL["System call UI + ring"]:::ext
  ICS["IncomingCallService (callkeep)<br/>starts FGS + shows the ringing UI"]:::ck
  MIBH["IncomingCallHandler.maybeInitBackgroundHandling<br/>checks ActivityLifecycleState"]:::ck
  PISO["[app DEAD] push isolate on callkeep engine (autoRegister = true)<br/>background_isolate_callbacks.dart : onPushNotificationSyncCallback<br/>-> PushNotificationIsolateManager.run, opens its own WebSocket"]:::app
  ALIVE["[app ALIVE, backgrounded] main app already running (Activity ON_STOP)<br/>its CallBloc / signaling handle the call - NO new isolate"]:::app
  WS["Signaling server (WebSocket)"]:::ext
  ACT["Activity / main UI engine"]:::app
  FGS["ForegroundService (callkeep), bound to Activity<br/>PHostApi control + ConnectionEventListener events"]:::ck

  TITLE -.-> FCM
  FCM --> FMISO
  FMISO -- "reportNewIncomingCall" --> BOOT
  BOOT --> CKC --> PCS --> TEL
  PCS -. "onShowIncomingCallUi -> start" .-> ICS
  ICS --> MIBH
  MIBH -- "app DEAD (state null / ON_DESTROY)" --> PISO
  MIBH -- "app ALIVE (ON_RESUME / ON_PAUSE / ON_STOP)" --> ALIVE
  PISO <--> WS
  ALIVE <--> WS
  PISO -. "on answer: handoff -> Activity adopts (Activity sends 200 OK)" .-> ACT
  PISO -. "on decline: performEndCall -> DeclineRequest" .-> WS
  ALIVE --> ACT
  ACT -. "binds" .-> FGS
  FGS <--> CKC
```

## Case B — persistent / socket

Signaling owns the engine; the app is the seam (`WebtritCallkeep.attachToEngine`).

```mermaid
flowchart TB
  classDef ck fill:#dae8fc,stroke:#6c8ebf,color:#000
  classDef sig fill:#d5e8d4,stroke:#82b366,color:#000
  classDef app fill:#ffe6cc,stroke:#d79b00,color:#000
  classDef ext fill:#f5f5f5,stroke:#999999,color:#000

  TITLE["CASE B - PERSISTENT / SOCKET: signaling OWNS the engine, app is the seam"]:::ext
  WApp["WebtritApplication.onCreate<br/>onFgsEngineReady = WebtritCallkeep.attachToEngine<br/>onFgsEngineDestroyed = WebtritCallkeep.detachFromEngine"]:::app
  SFGS["SignalingForegroundService (signaling)<br/>OWNS the FGS FlutterEngine<br/>automaticallyRegisterPlugins = false<br/>persistent WebSocket"]:::sig
  ATT["WebtritCallkeep.attachToEngine<br/>registers callkeep channels on the FGS engine<br/>callkeep does NOT spawn its own isolate"]:::ck
  SISO["push isolate (APP code on the FGS engine)<br/>background_isolate_callbacks.dart : onSignalingBackgroundCallEvent<br/>IncomingCallEvent -> reportNewIncomingCall, HangupEvent -> releaseCall"]:::app
  WS["Signaling server (WebSocket)"]:::ext
  BOOT["reportNewIncomingCall<br/>callkeep bootstrap API"]:::ck
  CKC["CallkeepCore.startIncomingCall"]:::ck
  PCS["PhoneConnectionService<br/>process :callkeep_core, Android Telecom"]:::ck
  TEL["System call UI + ring"]:::ext
  ACT["Activity / main UI engine<br/>adopts the live call after answer"]:::app
  FGSVC["ForegroundService (callkeep, main process)<br/>bound to the Activity (onAttachedToActivity)<br/>PHostApi: call-control from Dart<br/>ConnectionEventListener: CallkeepCore events -> Flutter"]:::ck

  TITLE -.-> WApp
  WApp -. "wires (app is the seam)" .-> ATT
  ATT -. "hosted on" .-> SFGS
  SFGS <--> WS
  SFGS --> SISO --> BOOT --> CKC --> PCS --> TEL
  PCS -. "on answer: Activity adopts" .-> ACT
  ACT -. "binds" .-> FGSVC
  FGSVC <--> CKC
  FGSVC -. "events (PDelegateFlutterApi)" .-> ACT
```

## Case C — app foreground

The app owns the WebSocket; `ForegroundService` bridges the call.

```mermaid
flowchart TB
  classDef ck fill:#dae8fc,stroke:#6c8ebf,color:#000
  classDef app fill:#ffe6cc,stroke:#d79b00,color:#000
  classDef ext fill:#f5f5f5,stroke:#999999,color:#000

  TITLE["CASE C - APP FOREGROUND: the app OWNS the WebSocket, ForegroundService bridges the call"]:::ext
  ACT["Activity / main UI engine (foreground)<br/>WebtritCallkeepPlugin attached (onAttachedToEngine)"]:::app
  SMOD["App signaling + CallBloc<br/>owns the WebSocket while the app is active"]:::app
  WS["Signaling server (WebSocket)"]:::ext
  FGSVC["ForegroundService (callkeep, main process)<br/>bound to the Activity (onAttachedToActivity)<br/>PHostApi: call-control from Dart<br/>ConnectionEventListener: CallkeepCore events -> Flutter"]:::ck
  CKC["CallkeepCore.startIncomingCall"]:::ck
  PCS["PhoneConnectionService<br/>process :callkeep_core, Android Telecom"]:::ck
  ICS["IncomingCallService (notification UI)<br/>maybeInitBackgroundHandling:<br/>app active -> SKIP background isolate"]:::ck
  TEL["System call UI + ring (in-app)"]:::ext

  TITLE -.-> ACT
  ACT --- SMOD
  SMOD <--> WS
  ACT -. "binds" .-> FGSVC
  SMOD -. "call_bloc.dart: reportNewIncomingCall (PHostApi)" .-> FGSVC
  FGSVC <--> CKC
  FGSVC -. "events (PDelegateFlutterApi)" .-> ACT
  CKC --> PCS --> TEL
  PCS -. "shows UI via" .-> ICS
```

## Sequence — Case A (push-bound): answer / decline / missed

```mermaid
sequenceDiagram
    autonumber
    actor User
    participant WS as Signaling server (WS)
    participant FCM as FCM
    participant FMISO as Firebase isolate (app)
    participant CORE as CallkeepCore
    participant PCS as PhoneConnectionService (Telecom)
    participant SYS as Android System UI
    participant ICS as IncomingCallService (callkeep)
    participant PISO as push isolate (app callback)
    participant ACT as Activity + ForegroundService

    WS->>FCM: high-priority push (incoming call)
    FCM->>FMISO: deliver push
    Note over FMISO: bootstrap.dart : _firebaseMessagingBackgroundHandler<br/>reports the call (no WebSocket here)
    FMISO->>CORE: reportNewIncomingCall (bootstrap API)
    CORE->>PCS: startIncomingCall (Telecom addNewIncomingCall)
    PCS->>SYS: onShowIncomingCallUi -> ring + notification
    PCS->>ICS: start IncomingCallService (FGS)
    Note over ICS: spawns its OWN FlutterEngine (autoRegister = true)
    ICS->>PISO: executeDartCallback (app entrypoint)
    Note over PISO: background_isolate_callbacks.dart : onPushNotificationSyncCallback<br/>-> PushNotificationIsolateManager.run
    PISO->>WS: open its OWN WebSocket (ongoing call)
    SYS-->>User: ringing

    alt User answers
        User->>SYS: Answer
        SYS->>PCS: onAnswer
        PCS->>PISO: performAnswerCall (records _answeredCallId; no WS send)
        PISO->>ICS: handoffCall (stop service, keep connection)
        Note over ACT: Activity launches, binds ForegroundService, adopts the connection
        ACT->>WS: answer over the app WebSocket (SIP 200 OK)
        ACT->>CORE: PHostApi: mute / hold / DTMF / end
        CORE-->>ACT: ConnectionEventListener events (PDelegateFlutterApi)
        User->>ACT: Hang up -> SIP BYE
    else User declines
        User->>SYS: Decline
        SYS->>PCS: onReject -> terminateWithCause(REJECTED)
        PCS->>ICS: onDisconnect -> release(IC_RELEASE_WITH_DECLINE)
        ICS->>PISO: handleRelease(answered=false) -> performEndCall
        PISO->>WS: DeclineRequest (the push isolate sends the decline)
        Note over ICS: stop service, dismiss UI
    else Missed (caller cancels)
        WS-->>PISO: HangupEvent
        PISO->>CORE: releaseCall -> terminate connection
        PCS->>SYS: dismiss incoming UI
    end
```

## Sequence — Case B (persistent / socket)

> Caveat: the answer branch (Activity takeover, 200 OK, 4441 eviction) is the *intended* path,
> reconstructed from the documented 4441 / handoff mechanism. `onSignalingBackgroundCallEvent`
> itself only handles `IncomingCallEvent` (report) and `HangupEvent` (release); the persistent
> answer is the WT-1538 area.

```mermaid
sequenceDiagram
    autonumber
    actor User
    participant WS as Signaling server (WS)
    participant APP as WebtritApplication (app glue)
    participant SFGS as SignalingForegroundService (FGS engine)
    participant CORE as CallkeepCore
    participant PCS as PhoneConnectionService (Telecom)
    participant SYS as Android System UI
    participant ACT as Activity + ForegroundService

    Note over APP: onCreate: onFgsEngineReady = WebtritCallkeep.attachToEngine<br/>onFgsEngineDestroyed = WebtritCallkeep.detachFromEngine
    APP->>SFGS: start FGS (persistent / socket mode)
    Note over SFGS: creates its OWN FGS FlutterEngine<br/>automaticallyRegisterPlugins = false
    SFGS->>CORE: wireUpPigeon -> onFgsEngineReady -> attachToEngine<br/>(init ContextHolder + AssetCacheManager, register callkeep channels)
    SFGS->>WS: open persistent WebSocket + register

    WS-->>SFGS: incoming_call event
    Note over SFGS: background_isolate_callbacks.dart : onSignalingBackgroundCallEvent (IncomingCallEvent)<br/>runs on the FGS engine (app code)
    SFGS->>CORE: reportNewIncomingCall (bootstrap channel, hosted)
    Note over CORE: callkeep does NOT spawn its own isolate<br/>(hosted on external engine)
    CORE->>PCS: startIncomingCall (Telecom addNewIncomingCall)
    PCS->>SYS: onShowIncomingCallUi -> ring + full-screen / notification
    SYS-->>User: ringing

    alt User answers
        User->>SYS: Answer
        SYS->>PCS: onAnswer
        PCS->>CORE: markAnswered
        Note over ACT: Activity launches, binds ForegroundService,<br/>adopts the live PhoneConnection
        ACT->>WS: main app takes over the session, SIP 200 OK
        WS-->>SFGS: 4441 controllerForceAttachClose (evict FGS connection)
        ACT->>CORE: PHostApi: mute / hold / DTMF / end
        CORE-->>ACT: ConnectionEventListener events (PDelegateFlutterApi)
    else Missed / hung up before answer
        WS-->>SFGS: HangupEvent
        SFGS->>CORE: releaseCall -> terminate connection
        PCS->>SYS: dismiss incoming UI
    end

    Note over SFGS: on FGS stop: onDestroy -> onFgsEngineDestroyed<br/>-> WebtritCallkeep.detachFromEngine
```
