# Call Architecture

`CallBloc` (`lib/features/call/bloc/call_bloc.dart`) is the central component of the entire app.
It implements both `Bloc<CallEvent, CallState>` and `CallkeepDelegate`, making it the single point
that bridges signaling, native call UI, WebRTC media, and the Flutter UI layer.

## Responsibilities

- Manages all active calls (`List<ActiveCall>` in state)
- Owns the `WebtritSignalingClient` lifecycle (connect → handshake → events → disconnect)
- Implements `CallkeepDelegate` — native platform calls directly into the BLoC
- Creates and disposes `RTCPeerConnection` per call via `PeerConnectionManager`
- Persists finished calls to `CallLogsRepository`
- Keeps `LinesStateRepository` in sync for the UI

## Event Categories

| Category | Prefix | Source |
|---|---|---|
| Lifecycle | `CallStarted`, `CallConfigEvent` | App bootstrap |
| Signaling client | `_SignalingClientEvent` | Internal |
| Signaling protocol | `_CallSignalingEvent`, `_HandshakeSignalingEventState` | `WebtritSignalingClient` callbacks |
| Push | `_CallPushEventIncoming` | iOS PushKit / Android FCM isolate |
| User actions | `CallControlEvent` | UI widgets |
| Native perform | `_CallPerformEvent` | `CallkeepDelegate` callbacks |
| WebRTC | `_PeerConnectionEvent` | `RTCPeerConnection` observer |
| UI screen | `CallScreenEvent` | Call screen widget |

## State Structure

```dart
// CallState (immutable, @freezed)
CallServiceState callServiceState   // signaling + registration + network status
List<ActiveCall> activeCalls        // all current calls
int linesCount                      // SIP lines from handshake
bool? minimized                     // overlay vs full-screen
CallAudioDevice? audioDevice
List<CallAudioDevice> availableAudioDevices
```

## ActiveCall Processing Status (state machine)

```
incomingFromPush          push arrived, no signaling offer yet
incomingFromOffer         offer received from signaling
incomingPerformingStarted native answer started
incomingInitializingMedia getting mic/camera
incomingAnswering         AcceptRequest sent, waiting for confirmation
─────────────────────────────────────────────────────────────
outgoingCreated           startCall reported to Callkeep
outgoingConnectingToSignaling waiting for signaling session
outgoingInitializingMedia getting mic/camera
outgoingOfferPreparing    creating RTCPeerConnection + offer
outgoingOfferSent         OutgoingCallRequest sent
─────────────────────────────────────────────────────────────
connected                 media flowing (both directions)
disconnecting             hangup sent, cleanup in progress
```

## Incoming Call Flow

```
Signaling: IncomingCallEvent (JSEP offer)
  → BLoC: reportNewIncomingCall → Callkeep → system UI / Flutter screen
  → User taps Answer
  → CallControlEvent.answered → _CallPerformEvent.answered
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
  → Signaling: AcceptedEvent (remote answer) → setRemoteDescription → connected
```

## Isolates

Two background isolate managers handle calls when the app is not in the foreground.
Both implement `CallkeepBackgroundServiceDelegate` and must be annotated
`@pragma('vm:entry-point')` to survive tree-shaking.

| Manager | Entry point | Trigger | Reconnect |
|---|---|---|---|
| `PushNotificationIsolateManager` | `onPushNotificationSyncCallback` | Android FCM push | No |
| `SignalingForegroundIsolateManager` | `onSignalingSyncCallback` | Android background service | Yes |

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
connectivity. Reconnection is suppressed when the app is backgrounded with no active calls.
Fast reconnect (0 s delay) is used on manual trigger; slow (6 s) on unexpected disconnect.

**iOS audio reset** — on the first and last call, the BLoC forces audio to earpiece via
`AppleNativeAudioManagement` to work around a platform bug where speaker stays active across
calls.
