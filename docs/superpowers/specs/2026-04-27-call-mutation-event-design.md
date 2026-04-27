# CallMutationEvent — Sequential Mutation Queue for CallBloc

**Date:** 2026-04-27
**Branch:** fix/call_handling_improvements
**File in scope:** `lib/features/call/bloc/call_bloc.dart`

## Problem

`CallBloc` registers multiple event categories each with their own `sequential()` transformer:
`_CallPerformEvent`, `CallControlEvent`, `_CallSignalingEvent`, `_PeerConnectionEvent`, etc.
Each category's queue serializes events within that category, but the queues themselves run
**concurrently** with each other. This means a `_CallPerformEvent` handler and a
`_CallSignalingEvent` handler can execute simultaneously, both reading and mutating shared
resources: `_peerConnectionManager`, `callkeep`, and `_signalingModule`. This causes races on
critical VoIP state (PeerConnection setup, SDP exchange, native call UI state).

## Solution

Introduce a single private sealed class `_CallMutationEvent extends CallEvent` registered with
one global `sequential()` transformer. All async operations that touch `_peerConnectionManager`,
`callkeep` (any invocation), or `_signalingModule.execute()` /
`_signalingModule.cancelRequestsByCallId()` move into `_CallMutationEvent` variant handlers.
Existing event handlers become thin dispatchers: they keep guards, early emits, and
`fulfill()`/`fail()` calls, then `add(_CallMutationEvent.xxx(...))`.

**Core invariant:** only `_onCallMutationEvent` and the private methods it calls may touch
`_peerConnectionManager`, `callkeep`, or `_signalingModule` for mutations.
Reading `_signalingModule.isConnected` for a guard is permitted anywhere.

## Architecture

```
CallBloc event streams (concurrent)
  _CallPerformEvent  ──sequential──┐
  _CallControlEvent  ──sequential──┤  thin dispatchers → add(_CallMutationEvent.xxx)
  _CallSignalingEvent──sequential──┤
  _PeerConnectionEvent─sequential──┤
  _IceRestartTriggered─sequential──┤
  _CallPushEventIncoming───────────┤
  _RestoreAcceptedCall─────────────┘
                                   ↓
  _CallMutationEvent ──sequential── one global queue
                                   ↓
        _peerConnectionManager  callkeep  _signalingModule
```

BLoC constructor registration (added after existing `on<>` block):

```dart
on<_CallMutationEvent>(_onCallMutationEvent, transformer: sequential());
```

## Dispatch Pattern

### `_CallPerformEvent` handlers

`fulfill()` is called immediately before dispatching the mutation. The mutation handler owns
all async work that was previously below the `fulfill()` call.

```dart
Future<void> __onCallPerformEventAnswered(_CallPerformEventAnswered event, Emitter<CallState> emit) async {
  // guards / canPerformAnswer check stays here
  if (!canPerformAnswer) return;

  event.fulfill();                                           // called immediately
  emit(state.copyWith(...incomingPerformingStarted...));    // initial state emit stays
  add(_CallMutationEvent.performAnswer(event.callId));      // rest moves to mutation
}
```

`fail()` calls for early-exit paths remain in the original handler.

### `_CallControlEvent` handlers

Guards and state-only emits stay; resource calls move.

```dart
Future<void> __onCallControlEventAnswered(_CallControlEventAnswered event, Emitter<CallState> emit) async {
  // canSubmitAnswer guard stays
  emit(state.copyWith(...incomingSubmittedAnswer...));     // emit stays
  add(_CallMutationEvent.controlAnswer(event.callId));    // callkeep.answerCall moves
}
```

### `_CallSignalingEvent`, `_PeerConnectionEvent`, others

Same pattern: guards + state-only emits stay, all async resource calls move to mutation variant.

## Variant Inventory (~28 variants)

| Source handler | Mutation variant |
|---|---|
| `__onCallPerformEventStarted` | `_CallMutationEvent.performStart(callId)` |
| `__onCallPerformEventAnswered` | `_CallMutationEvent.performAnswer(callId)` |
| `__onCallPerformEventEnded` | `_CallMutationEvent.performEnd(callId)` |
| `__onCallPerformEventSetHeld` | `_CallMutationEvent.performSetHeld(callId, onHold)` |
| `__onCallPerformEventSetMuted` | `_CallMutationEvent.performSetMuted(callId, muted)` |
| `__onCallPerformEventSentDTMF` | `_CallMutationEvent.performSendDTMF(callId, key)` |
| `__onCallPerformEventAudioDeviceSet` | `_CallMutationEvent.performSetAudioDevice(callId, device)` |
| `__onCallControlEventStarted` | `_CallMutationEvent.controlStart(callId, ...)` |
| `__onCallControlEventAnswered` | `_CallMutationEvent.controlAnswer(callId)` |
| `__onCallControlEventEnded` | `_CallMutationEvent.controlEnd(callId)` |
| `__onCallControlEventSetHeld` | `_CallMutationEvent.controlSetHeld(callId, onHold)` |
| `__onCallControlEventSetMuted` | `_CallMutationEvent.controlSetMuted(callId, muted)` |
| `__onCallControlEventSentDTMF` | `_CallMutationEvent.controlSendDTMF(callId, key)` |
| `_onCallControlEventCameraSwitched` | `_CallMutationEvent.controlSwitchCamera(callId)` |
| `_onCallControlEventCameraEnabled` | `_CallMutationEvent.controlSetCameraEnabled(callId, enabled)` |
| `_onCallControlEventBlindTransferSubmitted` | `_CallMutationEvent.controlBlindTransfer(callId, ...)` |
| `_onCallControlEventAttendedTransferSubmitted` | `_CallMutationEvent.controlAttendedTransfer(callId, ...)` |
| `_onCallControlEventAttendedRequestApproved` | `_CallMutationEvent.controlAttendedApprove(callId, ...)` |
| `_onCallControlEventAttendedRequestDeclined` | `_CallMutationEvent.controlAttendedDecline(callId, ...)` |
| `__onCallSignalingEventIncoming` | `_CallMutationEvent.signalingIncoming(callId, ...)` |
| `__onCallSignalingEventAccepted` | `_CallMutationEvent.signalingAccepted(callId, jsep)` |
| `__onCallSignalingEventHangup` | `_CallMutationEvent.signalingHangup(callId, code, reason)` |
| `__onCallSignalingEventCallUpdating` | `_CallMutationEvent.signalingCallUpdating(callId, ...)` |
| `__onPeerConnectionEventRenegotiationNeeded` | `_CallMutationEvent.renegotiate(callId)` |
| `__onPeerConnectionEventIceCandidateIdentified` | `_CallMutationEvent.trickleIce(callId, candidate)` |
| `_onIceRestartTriggered` | `_CallMutationEvent.restartIce(callId)` |
| `_onCallPushEventIncoming` | `_CallMutationEvent.pushIncoming(callId, ...)` |
| `_onRestoreAcceptedCall` | `_CallMutationEvent.restoreCall(callId, ...)` |

**Not redirected** (no PC/callkeep/signaling mutations):
`CallScreenEvent`, `_CallControlEventFailureApproved`, `_CallControlEventBlindTransferInitiated`,
`_CallControlEventAttendedTransferInitiated`, `_CallControlEventAudioDeviceSet`,
`_SignalingClientEvent`, `_HandshakeSignalingEventState`, `_GlobalEvent`,
`_AppLifecycleStateChanged`, `_ConnectivityResultChanged`, `CallConfigEvent`.

## Naming Conventions

- Variant classes: `_CallMutationEvent<Category><Action>` (e.g. `_CallMutationEventPerformAnswer`)
- Factory constructors: camelCase matching the action (e.g. `_CallMutationEvent.performAnswer(...)`)
- Mutation sub-handlers: `__onMutation<Category><Action>` (double underscore, consistent with
  existing `__on*` convention)
- Dispatcher: `_onCallMutationEvent` (switch dispatches to `__onMutation*`)

## File Organization

- `call_event.dart`: all `_CallMutationEvent` variant classes added after existing sealed classes
- `call_bloc.dart`:
  - `on<_CallMutationEvent>` registration added at end of constructor `on<>` block
  - `_onCallMutationEvent` dispatcher and all `__onMutation*` handlers grouped together,
    placed after the existing `__onCallPerformEvent*` block

No new files required.

## Queue Semantics

The queue is **global** — mutations for different calls serialize behind each other. This is
intentional for now: the races being fixed (signaling vs perform, control vs signaling) are
cross-call as well as same-call. Per-call queuing can be introduced later if latency becomes
measurable in multi-call scenarios.

## What Does NOT Change

- Existing event class hierarchy — no variants removed or renamed
- Transformer assignments for non-mutation events
- `callkeep.setDelegate` and `callkeep.reportUpdateCall` in `CallScreenEvent` handlers
  (these are UI-driven reporting calls, not resource-mutating operations)
- `_signalingModule.isConnected` reads (guard-only, not mutations)
- `fulfill()` / `fail()` mechanics in `_CallPerformEvent` — called before dispatch, unchanged
