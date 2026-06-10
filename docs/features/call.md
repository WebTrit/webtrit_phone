# Call

The in-app calling experience: placing and receiving SIP/WebRTC calls, the
full-screen call UI, multi-call handling (hold, swap, transfer), and the native
CallKit / ConnectionService integration.

Last reviewed: 2026-06-10

## Where it lives

- `lib/features/call/` - the whole feature: bloc, views, widgets, extensions.
  - `bloc/` - `CallBloc`, `CallState`, `CallEvent` (the brain; see below).
  - `view/call_active_scaffold.dart` - the active call screen layout.
  - `widgets/` - `CallInfo`, `IncomingCallActions`, `ActiveCallActions`,
    video overlays, keypad.
- `webtrit_callkeep` (sibling plugin) - native call UI (CallKit on iOS,
  ConnectionService on Android).

Deeper references:

- [`../call_architecture.md`](../call_architecture.md) - `CallBloc` responsibilities,
  event categories, processing-status state machine, isolates, key patterns.
- [`../incoming_call_scenarios.md`](../incoming_call_scenarios.md) - incoming-call
  background scenarios (push-bound / persistent / foreground) with diagrams.
- [`../signaling_architecture_target.md`](../signaling_architecture_target.md) -
  signaling layer.

## What the user can do

- Place an outgoing audio or video call.
- Receive an incoming call (foreground, backgrounded, or killed via push).
- During an active call: mute, toggle camera, switch audio device (earpiece /
  speaker / Bluetooth), open the keypad (DTMF), hold/resume, transfer (blind or
  attended), and hang up.
- Handle a second call: a new incoming call while one is active, or two calls at
  once - answer one and put the other on hold, or decline.

## Call states (UX)

The active call screen (`CallActiveScaffold`) renders from `CallState.activeCalls`.
Each call is an `ActiveCall` with the flags the UI reads:

- `isIncoming`, `wasAccepted` (has `acceptedTime`) - ringing vs answered.
- `held` - on hold.
- `processingStatus` - fine-grained lifecycle (see the state machine in the
  architecture doc).
- `displayName` / `handle`, `remoteVideo`, `muted`, `transfer`.

Single call:

- **1 incoming** - caller info + Decline / Answer.
- **1 active** - caller info + control grid (mute, camera, speaker, transfer,
  hold, keypad) + hang up.
- **1 on hold** - same grid with Hold shown as Resume.

Multiple calls today (stacked layout):

- The screen stacks a `CallInfo` block per call. The "current" call is derived,
  not explicitly chosen: `activeCalls.current` = the last non-held call.
- For a second incoming call while one is active, `IncomingCallActions` shows
  combined-icon buttons: End & Answer (`call_end` + `call`), Decline (`call_end`),
  Hold & Answer (`pause` + `call`). Hold is impossible while a call is ringing,
  so the user answers first; the combined actions end or hold the other call,
  then answer.

### Focused call

`CallState.selectedCallId` + the `focusedCall` getter express which call the
action area acts on. `focusedCall` returns the explicitly selected call when it
still maps to a live call, otherwise the derived `current`; it is `null` only
when there are no active calls. Today nothing sets `selectedCallId`, so
`focusedCall` mirrors `current`. This is the seam the list-based UI consumes
(see below).

## Key widgets

| Widget | File | Role |
|---|---|---|
| `CallActiveScaffold` | `view/call_active_scaffold.dart` | Active call screen; lays out info + actions per call |
| `CallInfo` | `widgets/call_info.dart` | Per-call name / number / status / timer / network quality |
| `IncomingCallActions` | `widgets/incoming_call_actions.dart` | Ringing-call buttons (decline / answer / combined) |
| `ActiveCallActions` | `widgets/active_call_actions.dart` | In-call control grid + hang up + keypad |

## Redesign / in progress - list-based call flow

The multi-call UI is being reworked into a single, consistent model:

- The screen is always a **list of calls** - 1 call is a list of 1, N calls a
  list of N. No separate "incoming" vs "active" screen.
- Each row shows name + a status badge (RINGING / ON CALL / ON HOLD) + timer.
  When more than one call exists, a header reads "N calls - tap to choose".
- **Focus, then act**: tap a row to focus it; one bottom action area acts on the
  focused call only, with an "Acting on: <name>" hint that spells the side effect
  ("<other> will be put on hold"). At most two action buttons for a ringing
  focus (Decline / Answer); the in-call control grid for an active/held focus.
- This removes the combined-icon row, which was hard to read at the worst moment
  (resolves the "unclear second-incoming buttons" reports, WT-1071 / WT-1462).

Rollout is incremental (foundations first, then UI), each step behind tests:

| Stage | Scope | Status |
|---|---|---|
| Focus state | `selectedCallId` + `focusedCall` + `callSelected` event (invisible groundwork) | Merged (PR #1376) |
| Action intents | Combined actions (hold&accept / hangup&accept / swap) move into bloc intents | Merged (PR #1378) |
| Call list | Selectable list of calls + status badges + header; auto-focus (a new ringing call grabs focus, the next ringing one after the focused call ends); info + action area bind to the focused call | In review |
| Focused actions | Single action area + "Acting on" hint; drop combined-icon buttons | Planned |
| Cleanup / edges | Single-call polish, dead-code removal, 3-call / transfer / landscape | Planned |

The redesign lands on the `refactor/call` integration branch - every stage is a
PR into that branch, and once the whole flow is tested there a single PR merges
it into `develop`. `develop` therefore stays shippable throughout; no feature
flag is involved.

## Keeping this doc current

Update this file in the same PR that changes the call feature - especially the
"Call states" and "Redesign / in progress" sections, and bump `Last reviewed`.
When a redesign stage lands, move it to the shipped behavior above and update its
status here.
