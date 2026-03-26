# Call Architecture

`CallBloc` (`lib/features/call/bloc/call_bloc.dart`) is the central component of the entire app.
It implements both `Bloc<CallEvent, CallState>` and `CallkeepDelegate`, making it the single point
that bridges signaling, native call UI, WebRTC media, and the Flutter UI layer.

## File Layout

The class is split across six `part` files that share one library boundary (`call_bloc.dart`).

| File | Purpose |
|------|---------|
| `call_bloc.dart` | Root: imports, constructor, event registration, `close()` |
| `call_event.dart` | All event classes (sealed hierarchies) |
| `call_state.dart` | `CallState`, `ActiveCall`, audio device models |
| `platform_bridge.dart` | `_PlatformBridgeMixin` — `CallkeepDelegate` implementation |
| `signaling_module.dart` | `SignalingModule` class + `_SignalingHandlers` extension — signaling lifecycle |
| `call_session.dart` | `_CallSession` extension — per-call WebRTC state machine |
| `transfer_coordinator.dart` | `_TransferCoordinator` extension — blind and attended transfer |

Helper services live in `lib/features/call/utils/`:
`AudioDeviceManager`, `PresenceSyncService`, `CallHistoryRecorder`.

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

### User-action events (`CallControlEvent`)

| Factory | Description |
|---------|-------------|
| `.started(...)` | Initiate a call |
| `.answered(callId)` | Answer incoming call |
| `.ended(callId)` | Hang up |
| `.setHeld(callId, onHold)` | Hold / unhold |
| `.setMuted(callId, muted)` | Mute / unmute |
| `.sentDTMF(callId, key)` | DTMF tone |
| `.cameraSwitched(callId)` | Front ↔ rear camera |
| `.cameraEnabled(callId, enabled)` | Enable / disable local video |
| `.audioDeviceSet(callId, device)` | Switch audio output |
| `.failureApproved(callId)` | Dismiss a failed call |
| `.blindTransferInitiated(callId)` | Begin blind transfer |
| `.attendedTransferInitiated(callId)` | Begin attended transfer |
| `.blindTransferSubmitted(number)` | Submit blind transfer destination |
| `.attendedTransferSubmitted(referorCall, replaceCall)` | Submit attended transfer |
| `.attendedRequestApproved(referId, referTo)` | Accept incoming REFER |
| `.attendedRequestDeclined(callId, referId)` | Reject incoming REFER |

### Native perform events (`_CallPerformEvent`)

Each event carries a `Completer<bool>`. The native CallKit / ConnectionService layer blocks until
the BLoC calls `event.fulfill()` or `event.fail()`.

| Factory | Native callback |
|---------|----------------|
| `.started(callId, handle, video)` | `performStartCall` |
| `.answered(callId)` | `performAnswerCall` |
| `.ended(callId)` | `performEndCall` |
| `.setHeld(callId, onHold)` | `performSetHeld` |
| `.setMuted(callId, muted)` | `performSetMuted` |
| `.sentDTMF(callId, key)` | `performSendDTMF` |
| `.audioDeviceSet(callId, device)` | `performAudioDeviceSet` |
| `.audioDevicesUpdate(callId, devices)` | `performAudioDevicesUpdate` |

### Signaling protocol events (`_CallSignalingEvent`)

| Factory | SIP equivalent | Key fields |
|---------|----------------|------------|
| `.incoming` | `INVITE` (inbound) | `callId, line, caller, jsep` |
| `.ringing` | `180 Ringing` | `callId` |
| `.progress` | `183 Session Progress` | `callId, jsep` |
| `.accepted` | `200 OK` | `callId, jsep` |
| `.hangup` | `BYE` / error | `callId, code, reason` |
| `.updating` | re-`INVITE` offer | `callId, jsep` |
| `.updated` | re-`INVITE` confirmed | `callId` |
| `.transfer` | `REFER` received | `referId, referTo, replaceCallId` |
| `.transferring` | Transfer in progress | `callId` |
| `.notifyDialog` | `NOTIFY` dialog-info | `userActiveCalls` |
| `.notifyRefer` | `NOTIFY` refer | `state: ReferNotifyState` |
| `.notifyPresence` | `NOTIFY` presence | `number, presenceInfo` |
| `.registration` | `REGISTER` result | `status, code, reason` |

## Event Transformer Strategies

| Event type | Transformer | Rationale |
|-----------|-------------|-----------|
| `CallStarted` | `sequential()` | Lifecycle events must not overlap |
| `_CallPerformEvent` | `sequential()` | Native callbacks must complete in order |
| `CallControlEvent` | `sequential()` | User actions must not interleave |
| `_CallSignalingEvent` | `sequential()` | SIP events are protocol-ordered |
| `_PeerConnectionEvent` | `sequential()` | WebRTC state machine is sequential |
| `_CallPushEventIncoming` | `sequential()` | Push events must not interleave with each other |
| `_HandshakeSignalingEventState` | `sequential()` | Handshake must complete before next one starts |
| `_SignalingClientEvent` | `restartable()` | New connection supersedes pending |

## State Structure

```dart
// CallState (immutable, @freezed)
CallServiceState callServiceState   // signaling + registration + network status
List<ActiveCall> activeCalls        // all current calls
int linesCount                      // SIP lines from handshake
bool? minimized                     // null=hidden, true=overlay, false=full screen
CallAudioDevice? audioDevice
List<CallAudioDevice> availableAudioDevices
```

Computed getters: `isHandshakeEstablished`, `isSignalingEstablished`, `isActive`,
`shouldListenToProximity`, `display` (`none / noneScreen / overlay / screen`).

Mutation helpers: `copyWithMappedActiveCall`, `copyWithPushActiveCall`, `copyWithPopActiveCall`,
`retrieveIdleLine()`.

### `ActiveCall` fields

| Field | Type | Description |
|-------|------|-------------|
| `direction` | `CallDirection` | `incoming` / `outgoing` |
| `line` | `int?` | SIP line index (–1 = undefined) |
| `callId` | `String` | UUID identifying the call |
| `handle` | `CallkeepHandle` | Number / email / generic identifier |
| `createdTime` | `DateTime` | When the call object was created |
| `video` | `bool` | Whether video was requested |
| `processingStatus` | `CallProcessingStatus` | Current state-machine position |
| `held` | `bool` | Call is on hold |
| `muted` | `bool` | Mic is muted |
| `updating` | `bool` | Re-INVITE negotiation in progress |
| `incomingOffer` | `JsepValue?` | SDP offer received but not yet answered |
| `displayName` | `String?` | Remote party display name |
| `fromReferId` | `String?` | Refer ID when call originates from attended transfer |
| `acceptedTime` | `DateTime?` | When `connected` was first reached |
| `hungUpTime` | `DateTime?` | When disconnect completed |
| `transfer` | `Transfer?` | Active transfer state |
| `failure` | `Object?` | Error that caused the call to fail |
| `localStream` | `MediaStream?` | Mic/camera stream |
| `remoteStream` | `MediaStream?` | Remote audio/video stream |
| `speakerOnBeforeMinimize` | `bool?` | Speaker state saved before minimizing |

Key computed getters: `isCameraActive` (`video && hasLocalVideoTrack`), `remoteVideo`.

`ActiveCallIterableExtension`: `.current` (last non-held), `.nonCurrent`, `.blindTransferInitiated`.

## ActiveCall Processing Status (state machine)

```
incomingFromPush          push arrived, no signaling offer yet
incomingFromOffer         offer received from signaling
incomingPerformingStarted native answer started
incomingInitializingMedia getting mic/camera
incomingAnswering         AcceptRequest sent, waiting for confirmation
─────────────────────────────────────────────────────────────
outgoingCreated           startCall reported to Callkeep
outgoingCreatedFromRefer  second leg of an attended transfer
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
  → _CallPerformEvent.fulfill()  ← native side unblocks
```

iOS push path (app backgrounded/killed):

```
PushKit push → didPushIncomingCall → _CallPushEventIncoming
  → ActiveCall(status: incomingFromPush)   ← placeholder until offer arrives
  → signaling connects → IncomingCallEvent enriches the existing ActiveCall
```

If the offer does not arrive within `kSignalingClientConnectionTimeout`, the placeholder is
failed and `SignalingConnectFailedNotification` is shown.

## Outgoing Call Flow

```
UI: CallController.createCall(number, video)
  → CallControlEvent.started
  → callkeep.startCall → performStartCall callback
  → _CallPerformEvent.started
  → wait signaling ready → get user media → RTCPeerConnection
  → createOffer → OutgoingCallRequest to signaling
  → Signaling: AcceptedEvent (remote answer) → setRemoteDescription → connected
  → _CallPerformEvent.fulfill()
```

## Transfer Flows

### Blind transfer

```
CallControlEvent.blindTransferInitiated(callId)
  → hold the call → state: BlindTransferInitiated, minimized=true

CallControlEvent.blindTransferSubmitted(number)
  → guard: number already in activeCalls? → ActiveLineBlindTransferWarningNotification
  → TransferRequest sent to signaling
  → state: BlindTransferTransferSubmitted

Signaling: TransferringEvent → transfer in progress indicator
```

### Attended transfer

```
CallControlEvent.attendedTransferInitiated(callId)
  → hold the call → minimized=true → user dials second call

CallControlEvent.attendedTransferSubmitted(referorCall, replaceCall)
  → TransferRequest(replaceCallId) sent → state: AttendedTransferTransferSubmitted

Signaling sends REFER to the remote party:
  _CallSignalingEvent.transfer → state: AttendedTransferRequestReceived

  CallControlEvent.attendedRequestApproved → new outgoing ActiveCall(fromReferId)
  CallControlEvent.attendedRequestDeclined → DeclineRequest → transfer cleared
```

## Signaling Module

### Connection lifecycle

```
CallStarted → _connectSignalingClient()
  → WebtritSignalingClient.connect(coreUrl, tenantId, token)
  → client.listen(onStateHandshake, onEvent, onError, onDisconnect: _onSignalingDisconnect)
  → StateHandshake → _HandshakeSignalingEventState

Disconnect:
  → _onSignalingDisconnect(code, reason)
  → schedule reconnect (see table below)
```

### Reconnect strategy

| Trigger | Delay |
|---------|-------|
| `CallStarted` / network restored / app resumed | 0 s |
| Code 4441 (server force-close) | 0 s |
| Unexpected disconnect | 6 s |
| Code `sessionMissedError` | 6 s; also triggers `onSessionInvalidated` via `_handleSignalingSessionError` in `CallBloc.onChange` |

Reconnect is suppressed when the app is backgrounded with no active calls.

### Handshake processing

On each `StateHandshake` the BLoC:

1. Enriches existing `ActiveCall` entries with server-reported line/callId matches.
2. Cleans up any server-reported calls with no local match (sends `HangupRequest`).
3. Drops local calls absent from the server list (sends `HangupRequest`, pops from state).
4. Updates `PresenceSyncService` with the latest user-active-calls and contact presence data.

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

**Perform-event completer drain** — `_PlatformBridgeMixin` tracks in-flight perform events in
`Set<_CallPerformEvent>.identity()`. `CallBloc.close()` calls `_drainPendingPerformEvents()` before
`super.close()` to fail all pending completers, preventing the native layer from hanging on teardown.
`Set.identity()` is used so two structurally equal events (same `callId`) are tracked separately.

**Push enrichment** — an incoming call can arrive via push before signaling is ready. The BLoC
creates a placeholder `ActiveCall(status: incomingFromPush)` and later merges the signaling
offer into it when `IncomingCallEvent` arrives, instead of creating a duplicate entry.

**Stale-state guard** — after any `await` inside an event handler, `emit` is always built from
the current `state` snapshot (post-await), not from a variable captured before the await, to
avoid reverting intermediate state changes.

**Disposal barrier** — `PeerConnectionManager` tracks pending disposal futures. Creating a new
`RTCPeerConnection` for a call ID waits until the previous one is fully disposed, preventing
resource races on rapid call sequences.

**Connectivity-aware reconnection** — the BLoC monitors both `AppLifecycleState` and network
connectivity. Reconnection is suppressed when the app is backgrounded with no active calls.
Fast reconnect (0 s delay) is used on manual trigger; slow (6 s) on unexpected disconnect.

**iOS audio reset** — on the first and last call, the BLoC forces audio to earpiece via
`AppleNativeAudioManagement` to work around a platform bug where speaker stays active across
calls.

**Error narrowing** — `catch` clauses in signaling handlers use `on Error { rethrow }` before
the general `catch (e, s)` block to avoid swallowing programmer errors (`StateError`, `TypeError`).
