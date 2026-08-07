# Call - architecture

`CallBloc` (`lib/features/call/bloc/call_bloc.dart`) is the central component of the entire app.
It implements both `Bloc<CallEvent, CallState>` and `CallkeepDelegate`, making it the single point
that bridges signaling, native call UI, WebRTC media, and the Flutter UI layer.

The product/UX view lives in [`call_ux.md`](call_ux.md); incoming-call background scenarios with
diagrams in [`../incoming_call_scenarios.md`](../incoming_call_scenarios.md).

## Where it lives

- `lib/features/call/` - the whole feature: bloc, views, widgets, extensions.
    - `bloc/` - `CallBloc`, `CallState`, `CallEvent` (the brain).
    - `view/call_active_scaffold.dart` - the active call screen layout.
    - `widgets/` - `CallInfo`, `IncomingCallActions`, `ActiveCallActions`,
      video overlays, keypad.
- `webtrit_callkeep` (sibling plugin) - native call UI (CallKit on iOS,
  ConnectionService on Android).

## Responsibilities

- Manages all active calls (`List<ActiveCall>` in state)
- Owns the `SignalingModule` lifecycle (connect → handshake → events → disconnect → dispose)
- Implements `CallkeepDelegate` — native platform calls directly into the BLoC
- Creates and disposes `RTCPeerConnection` per call via `PeerConnectionManager`
- Persists finished calls to `CallLogsRepository`
- Keeps `LinesStateRepository` in sync for the UI

## Event Categories

| Category           | Prefix                                                 | Source                                                     |
|--------------------|--------------------------------------------------------|------------------------------------------------------------|
| Lifecycle          | `CallStarted`, `CallConfigEvent`                       | App bootstrap                                              |
| Signaling client   | `_SignalingClientEvent`                                | Internal                                                   |
| Signaling protocol | `_CallSignalingEvent`, `_HandshakeSignalingEventState` | `WebtritSignalingClient` callbacks                         |
| Push               | `_CallPushEventIncoming`                               | iOS PushKit / Android FCM isolate                          |
| User actions       | `CallControlEvent`                                     | UI widgets                                                 |
| Native perform     | `_CallPerformEvent`                                    | `CallkeepDelegate` callbacks                               |
| WebRTC             | `_PeerConnectionEvent`                                 | `RTCPeerConnection` observer                               |
| UI screen          | `CallScreenEvent`                                      | Call screen widget                                         |
| Global             | `_GlobalEvent`                                         | Internal — presence and dialog-info updates from signaling |

## State Structure

```dart
// CallState (immutable, @freezed)
CallServiceState callServiceState // signaling + registration + network status
List<ActiveCall> activeCalls // all current calls
int linesCount // SIP lines from handshake
bool? minimized // overlay vs full-screen
CallAudioDevice? audioDevice

List<CallAudioDevice> availableAudioDevices

AppLifecycleState? currentAppLifecycleState // last known Flutter lifecycle state
```

## ActiveCall Processing Status (state machine)

```
incomingFromPush          push arrived, no signaling offer yet
incomingFromOffer         offer received from signaling
incomingSubmittedAnswer   answer submitted to Callkeep, awaiting performAnswerCall
incomingPerformingStarted native answer started
incomingInitializingMedia getting mic/camera
incomingRestoringMedia    call restored after reconnect; re-establishing ICE via renegotiation
incomingAnswering         AcceptRequest sent, waiting for confirmation
─────────────────────────────────────────────────────────────
outgoingCreated           startCall reported to Callkeep
outgoingCreatedFromRefer  outgoing call initiated by a SIP REFER (blind transfer target)
outgoingConnectingToSignaling waiting for signaling session
outgoingInitializingMedia getting mic/camera
outgoingRestoringMedia    call restored after reconnect; re-establishing ICE via renegotiation
outgoingOfferPreparing    creating RTCPeerConnection + offer
outgoingOfferSent         OutgoingCallRequest sent
outgoingRinging           remote side ringing (RingingEvent; the local ringback
                          is governed by OutgoingRingbackController - see below)
─────────────────────────────────────────────────────────────
connected                 media flowing (both directions)
disconnecting             hangup sent, cleanup in progress
```

## Incoming Call Flow

```
Signaling: IncomingCallEvent (JSEP offer)
  → BLoC: reportNewIncomingCall → Callkeep → system UI / Flutter screen
  → User taps Answer
  → CallControlEvent.answered → incomingSubmittedAnswer → _CallPerformEvent.answered
  → get user media → RTCPeerConnection → setRemoteDescription(offer)
  → createAnswer → AcceptRequest to signaling
  → Signaling: AcceptedEvent → setRemoteDescription(answer) → connected
```

iOS push path (app backgrounded/killed):

```
PushKit push → didPushIncomingCall → _CallPushEventIncoming
  → ActiveCall(status: incomingFromPush)   ← placeholder until offer arrives
  → signaling connects → IncomingCallEvent enriches the existing ActiveCall
```

## Outgoing Call Flow

```
UI: CallController.createCall(number, video)
  → CallControlEvent.started
  → callkeep.startCall → performStartCall callback
  → _CallPerformEvent.started
  → wait signaling ready → get user media → RTCPeerConnection
  → createOffer → OutgoingCallRequest to signaling
  → Signaling: RingingEvent → outgoingRinging (local tone start SCHEDULED, not played)
  → Signaling: ProceedingEvent (SIP code): 180 → no early media coming, tone starts now;
      183 → the switch may follow with its own audio, the short wait stays on
  → Signaling: ProgressEvent (early media) → setRemoteDescription →
      ActiveCall.earlyMedia = true, local tone stays off for the rest of setup
  → Signaling: AcceptedEvent (remote answer) → setRemoteDescription → connected
```

### Ringback: whose tone the caller hears

All start/stop rules live in `OutgoingRingbackController`
(`features/call/utils/`). The app cannot know upfront whether the network will
play a ringback of its own, so a ringing answer only ARMS a short delayed start
and the following signals decide:

| Signal | Meaning | Effect on the tone |
|--------|---------|--------------------|
| `RingingEvent` | 180 or 183 without a session description | arms the delayed start (repeats keep the first deadline) |
| `ProceedingEvent` 180 | plain alerting, no network audio coming | starts the tone right away |
| `ProceedingEvent` 183 | the switch is still working on it | keeps the wait |
| `ProgressEvent` | early media (a description arrived) | `ActiveCall.earlyMedia = true`, tone silenced for the rest of the setup |
| answer / hangup / failure | the ringing phase is over | tone silenced, pending start dropped |

Whatever fires last, the controller asks
[ActiveCall.shouldPlayLocalRingback] again at the moment it would actually
play, so a call that was answered, ended or picked up network audio in the
meantime stays silent.

Network plays its own ringback (the interesting case - a switch may report
plain ringing AFTER it already started streaming, which used to put both tones
on top of each other):

```
+1.4s  RingingEvent            → start armed (+1s)
+1.4s  ProceedingEvent 183     → wait kept
+2.2s  ProgressEvent           → setRemoteDescription → earlyMedia = true
                                 → tone silenced, armed start dropped
+2.3s  RingingEvent            → start armed again
+2.3s  ProceedingEvent 180     → start now → shouldPlayLocalRingback == false
                                 → suppressed; only the network tone is heard
```

No network ringback (the ordinary call):

```
+1.2s  RingingEvent            → start armed (+1s)
+1.24s ProceedingEvent 180     → start now → the app's own tone plays
+18s   AcceptedEvent           → tone silenced, media flows
```

The ~40 ms gap between the two events is why an ordinary call does not wait out
the full second. A backend that sends no `ProceedingEvent` at all falls back to
the armed deadline - one second of silence, then the tone.

## Isolates

Two background isolate managers handle calls when the app is not in the foreground.
Both implement `CallkeepBackgroundServiceDelegate` and must be annotated
`@pragma('vm:entry-point')` to survive tree-shaking.

| Manager                             | Entry point                      | Trigger                    | Reconnect |
|-------------------------------------|----------------------------------|----------------------------|-----------|
| `PushNotificationIsolateManager`    | `onPushNotificationSyncCallback` | Android FCM push           | No        |
| `SignalingForegroundIsolateManager` | `onSignalingSyncCallback`        | Android background service | Yes       |

Each isolate initialises its own dependency graph (storage, DB, logger, repositories) because
Flutter isolates share no memory. The isolate receives `CallkeepServiceStatus` and
`CallkeepIncomingCallMetadata` from the native side.

## Key Patterns

**Perform-event futures** — `CallkeepDelegate` callbacks (`performStartCall`,
`performAnswerCall`, `performEndCall`) are `async` and return `Future<bool>`. The BLoC completes
these futures only after the actual operation finishes, so the native side waits for the result.

**Push enrichment** — an incoming call can arrive via push before signaling is ready. The BLoC
creates a placeholder `ActiveCall(status: incomingFromPush)` and later merges the signaling
offer into it when `IncomingCallEvent` arrives, instead of creating a duplicate entry.

**Disposal barrier** — `PeerConnectionManager` tracks pending disposal futures. Creating a new
`RTCPeerConnection` for a call ID waits until the previous one is fully disposed, preventing
resource races on rapid call sequences.

**Connectivity-aware reconnection** — the BLoC monitors both `AppLifecycleState` and network
connectivity. The signaling socket is kept alive when the app is backgrounded so incoming calls
can arrive via WebSocket without relying on push. Reconnect is triggered on
`AppLifecycleState.resumed` (in case the OS dropped the connection) and on network restore.
A forced fast reconnect (0 s delay, force=true) is also triggered inside
`__onCallPerformEventAnswered` when the user answers from a push notification and signaling is
not yet connected, reducing the risk of timing out while waiting for the SDP offer.
Disconnect is only initiated on connectivity loss (`ConnectivityResult.none`).

**Call restoration** — when the signaling session reconnects mid-call, the BLoC restores active
calls from the server's accepted-call list (`_RestoreAcceptedCall`). Restored calls skip the
normal answer/start flow and enter `incomingRestoringMedia` or `outgoingRestoringMedia` directly.
Media is re-established via ICE restart (renegotiationNeeded → `UpdateRequest`), not by
replaying the original offer/answer exchange.

**Blind transfer** — `CallControlEvent.blindTransferInitiated` creates a new outgoing
`ActiveCall` with status `outgoingCreatedFromRefer`, linked to the original call via `fromReferId`.
The transfer target follows the normal outgoing flow from that status onward.

**iOS audio reset** — on the first and last call, the BLoC forces audio to earpiece via
`AppleNativeAudioManagement` to work around a platform bug where speaker stays active across
calls.

## Signaling edges (`onChange` / `onError`)

How `CallBloc` reacts to signaling/reconnect edges. The signaling layer itself is documented
in [`../signaling_architecture_target.md`](../signaling_architecture_target.md); this section
covers only the CallBloc-side behaviour.

### Background call-active edge (`onChange`)

`CallBloc.onChange` re-notifies `SignalingReconnectController` whenever `CallState.isActive`
flips. This covers a gap the app-lifecycle handler cannot: `_onAppLifecycleStateChanged`
samples `isActive` only at the instant the app moves between foreground and background, so it
never re-fires for a call that becomes active (an incoming call answered from a push) or ends
while the app is *already* backgrounded.

The block acts only while the app is `paused` / `detached` / `inactive`:

| Transition (while backgrounded) | Call into controller                     | Why                                                                                                                 |
|---------------------------------|------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| call became active, socket down | `notifyForceReconnect()`                 | reconnect now so signaling can carry the call, instead of waiting for the next lifecycle/network event              |
| active-call presence changed    | `notifyHasActiveCalls(...)`              | refresh the active-call guard so a background reconnect can fire during the call; disconnect if the call just ended |
| last call ended                 | `notifyAppPaused(hasActiveCalls: false)` | move to the paused-no-calls state so the controller stops holding the connection open                               |

The reconnect/notification policy itself stays in `SignalingReconnectController`; `onChange`
only feeds it lifecycle edges.

### Call finalization on signaling loss (`onError`)

`CallBloc.onError` is the BLoC catch-all for uncaught exceptions thrown inside event handlers
(nothing in the call feature calls `addError`). It only logs. It deliberately does **not**
finalize the active call, even though a stale placeholder once suggested it should: `onError`
carries no call context (only `error` + `stackTrace`), so it cannot tell which `ActiveCall` an
exception belongs to, and a live call must survive a transient signaling/network drop rather
than be torn down on the first error.

Finalization of a call whose signaling drops is instead handled by four narrower paths that do
have call context:

| Path                         | Where                                                                                                                                                                   | Behaviour                                                                                                                                        |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Survive-and-recover          | `__onSignalingClientEventConnected` (`safeRenegotiate`), `_onConnectivityResultChanged` / `__onMutationIceConnectionFailed` (`restartIce`), the silent disconnect codes | keep the call in `activeCalls` across the outage and recover it on reconnect instead of finalizing it                                            |
| Remote hangup                | `__onCallSignalingEventHangup` -> `__onMutationSignalingHangup` -> `callkeep.reportEndCall`                                                                             | when signaling reconnects and the server tore the leg down, its hangup ends the call authoritatively                                             |
| `requestCallIdError` cleanup | `__onSignalingClientEventDisconnected`                                                                                                                                  | for calls already marked `wasHungUp`, completes them once the disconnect confirms the call id is gone                                            |
| Visible ICE issue            | `__onPeerConnectionEventIceConnectionStateChanged`                                                                                                                      | a persistent ICE failure surfaces `iceConnectionIssue` on the call so the user can end it manually instead of it sitting as an invisible phantom |

So `onError` stays a pure logger by design; the "finalize the affected call" responsibility
lives in the disconnect / hangup / ICE paths above, not in the catch-all.
