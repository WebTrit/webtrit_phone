# Call

The in-app calling experience: placing and receiving SIP/WebRTC calls, the
full-screen call UI, multi-call handling (hold/resume, transfer), and the native
CallKit / ConnectionService integration.

This page is the index for the feature; each area has its own doc below.

Last reviewed: 2026-06-10

## Where it lives

- `lib/features/call/` - the whole feature: bloc, views, widgets, extensions.
  - `bloc/` - `CallBloc`, `CallState`, `CallEvent` (the brain).
  - `view/call_active_scaffold.dart` - the active call screen layout.
  - `widgets/` - `CallInfo`, `IncomingCallActions`, `ActiveCallActions`,
    video overlays, keypad.
- `webtrit_callkeep` (sibling plugin) - native call UI (CallKit on iOS,
  ConnectionService on Android).

## Docs

- [`call_ux.md`](call_ux.md) - product / UX: what the user can do, the screen
  states, key widgets, and the in-progress list-based redesign.
- [`call_arch.md`](call_arch.md) - code / architecture: `CallBloc`
  responsibilities, event categories, processing-status state machine, flows,
  isolates, key patterns, signaling edges (`onChange` / `onError`).
- [`incoming_call_scenarios.md`](incoming_call_scenarios.md) - incoming-call
  background scenarios (push-bound / persistent / foreground) with diagrams.
- [`../signaling_architecture_target.md`](../signaling_architecture_target.md) -
  the signaling layer (cross-cutting; shared by call and push).
