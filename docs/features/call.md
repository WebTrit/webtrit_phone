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

The toolbar (AppBar title slot) carries one global status line
(`CallToolbarStatus`): signaling/connectivity trouble (red dot +
"Reconnecting..."), a media failure, or the worst stream-quality warning
across calls (signal meter + label). The central `CallInfo` shows only
name/number, the call description or live duration, and the processing
status.
- `displayName` / `handle`, `remoteVideo`, `muted`, `transfer`.

Single call:

- **1 incoming** - caller info + Decline / Answer.
- **1 active** - caller info + control grid (mute, camera, speaker, transfer,
  hold, keypad) + hang up.
- **1 on hold** - same grid with Hold shown as Resume.

Multiple calls (list-based):

- The screen shows one tappable `CallRow` per call - status badge (RINGING /
  ON CALL / ON HOLD), name, live duration - under an "N calls - tap to choose"
  header. Tapping a row focuses that call.
- The `CallInfo` block and the action area below act on the focused call only.
  A ringing focus gets exactly Decline / Answer plus an "Acting on: <name>"
  hint that spells out the side effect ("<name> will be put on hold" or
  "will be ended"); an active/held focus gets the control grid + End.
- Answer is one intent (`CallControlEvent.answerFocused`): it holds the
  answered calls when possible, ends the non-holdable ones (e.g. an outgoing
  call still ringing), and leaves another ringing incoming call ringing.

### Focused call

`CallState.selectedCallId` + the `focusedCall` getter express which call the
info block and action area act on: the explicitly selected call when it still
maps to a live call, otherwise the derived `current` (= last non-held call).
Auto-focus: a new ringing incoming call grabs the focus; when the focused call
ends, the next ringing incoming call is focused. The media overlay keeps
following the derived `current` call.

## Key widgets

| Widget | File | Role |
|---|---|---|
| `CallActiveScaffold` | `view/call_active_scaffold.dart` | Active call screen; list + focused info + actions |
| `CallList` / `CallRow` | `widgets/call_list.dart` | Tappable per-call rows with status badge + duration |
| `FocusedActionHint` | `widgets/focused_action_hint.dart` | "Acting on" hint + answer side effect |
| `CallInfo` | `widgets/call_info.dart` | Focused-call name / number / status / timer / network quality |
| `IncomingCallActions` | `widgets/incoming_call_actions.dart` | Decline / Answer for the focused ringing call |
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
| Call list | Selectable list of calls + status badges + header; auto-focus rules; info + action area bind to the focused call | Merged (PR #1379) |
| Focused actions | "Acting on" hint + two-button ringing focus (single answerFocused intent); combined-icon buttons removed | Merged (PR #1380) |
| Cleanup / edges | Dead-code and obsolete l10n removal; scaffold-level widget tests for single/multi/3-call states | Merged (PR #1381) |
| Toolbar status | Signaling/connectivity status, media failures and stream quality move to the AppBar status line (global, worst across calls); the central info block keeps only name/description/duration | In review |

The redesign lands on the `refactor/call` integration branch - every stage is a
PR into that branch, and once the whole flow is tested there a single PR merges
it into `develop`. `develop` therefore stays shippable throughout; no feature
flag is involved.

## Keeping this doc current

Update this file in the same PR that changes the call feature - especially the
"Call states" and "Redesign / in progress" sections, and bump `Last reviewed`.
When a redesign stage lands, move it to the shipped behavior above and update its
status here.
