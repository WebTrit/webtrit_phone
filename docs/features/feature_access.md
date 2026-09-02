# Feature access: how runtime configuration reaches the app

What the app is allowed to show and do - voicemail, call history, extensions,
chats, self-config and so on - is not fixed at build time. It is assembled at
runtime from several sources into one object, `FeatureAccess`, and every screen
and service reads its answers from there. This doc explains where that object
comes from, and - the part that matters most in practice - WHEN a change to the
configuration actually takes effect.

Last reviewed: 2026-08-18

## Where the configuration comes from

`FeatureAccess` is assembled from three inputs:

- the application config (`AppConfig`) - the white-label configuration built
  into the app or delivered by the configurator: which tabs exist, which login
  flows are enabled, embedded pages, and so on;
- the backend capabilities (`system-info.adapter.supported`) - what the
  connected core/adapter can actually do: `voicemail`, `callHistory`,
  `extensions`, `recordings` and friends. Fetched on login and refreshed by
  background polling;
- Firebase Remote Config overrides - server-side toggles layered on top.

The assembly lives in `lib/data/feature_access.dart`; the reactive stream that
recombines these sources is built in bootstrap (`FeatureAccessStreamFactory`)
and provided app-wide by `RootApp` as a `StreamProvider<FeatureAccess>`.

## The one rule: a session runs on a snapshot

The moment the user gets past login and the main shell mounts, the shell takes
the CURRENT `FeatureAccess` value and pins it for the whole session
(`MainShell` shadows the reactive provider with a plain
`Provider<FeatureAccess>.value` over the session subtree - see
`lib/app/router/main_shell.dart`). Everything below the shell - repositories,
services, blocs, screens - reads that snapshot through an ordinary
`context.read<FeatureAccess>()` and therefore sees one consistent set of
answers from the first frame of the session to the last.

Consequences, in plain terms:

- A configuration change that arrives DURING a live session (a capability
  flipped on the backend, a Remote Config push, a configurator edit) does NOT
  apply to that session. Nothing appears, nothing disappears, nothing breaks
  mid-call. The change is not lost: the stream and its cache keep updating in
  the background.
- The change takes effect at the NEXT session start: logout/login or an app
  restart mounts a fresh shell, which pins a fresh snapshot. Logging into a
  different account or a different core works the same way - the login flow
  fetches that backend's `system-info` before the shell mounts, so the new
  session pins the new backend's capabilities.
- Everything OUTSIDE the session subtree stays reactive. The login flow and
  the version gates read the live stream; the force-update gate can still
  interrupt a session. Theme and locale are separate streams, not part of
  `FeatureAccess`, and keep applying live (including mid-call).

## Why it works this way

Before the pin, the shell rebuilt its provider tree on every `FeatureAccess`
emission. When an update changed the SHAPE of the tree (a conditional
provider such as voicemail or the CDR sync worker appearing or disappearing),
the blocs of the old shape were closed while the navigator and its screens
survived and kept talking to them - and events sent to a closed bloc are
swallowed silently. The visible symptom: after a background config update the
call button (or chats, or history) just stopped doing anything, with no error
anywhere. Pinning the session to one snapshot removes the whole class: the
session tree is stable by construction, and the moment configuration applies
is well-defined and testable.

The regression test for the class lives in
`test/app/router/main_shell_feature_access_change_test.dart`: flip a
capability mid-session and assert the shell keeps the exact same bloc
instances.

## Notes for specific cases

- "Enable verbose logging for a live user via Remote Config" does not reach a
  running session anymore (value-level settings are pinned too). If hot log
  switching is ever needed, wire the logging knob to the Remote Config stream
  directly, above the shell - a config value that changes no tree shape is
  safe to apply live.
- The configurator's realtime preview mirrors the same semantics: editing the
  feature configuration relaunches the embedded app (a fresh boot with fresh
  dependencies), because pushing config into a running session would, by the
  rule above, change nothing.
