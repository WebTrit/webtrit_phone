# Refreshing data by hand

How a user asks a list in the app to fetch again, screen by screen.
Last reviewed: 2026-09-06.

The rule: refreshing is a pull on the list. A screen that can be refreshed
carries no refresh control in its app bar.

This page describes UI behavior. The shared scheduler, task handles, and the
boundary between automatic and manual execution are documented in
[`polling.md`](polling.md). A manual fetch for a data source that is also polled
must use the same task capability to avoid a parallel refresh path. External
Contacts and CDR synchronization follow this rule.

## My account (settings)

`lib/features/settings/view/settings_screen.dart`

Pulling the list down calls `RegisterStatusCubit.fetchStatus()` and nothing
else: the account details and the session status keep arriving on their own
streams, and a failed fetch is reported with a snack bar. The list sits behind
a translucent app bar, so the indicator is pushed down by the same offset the
list is padded with (`edgeOffset`), otherwise the spinner appears under the bar.

A Material list ignores a drag from a mouse, so the list is configured to
accept every pointer kind; on the web build a mouse is the only pointer there
is, and without that the screen could not be refreshed at all.

The app bar carries the logout action instead; refreshing has no button of its
own there.

The screen used to carry a refresh button in the app bar. It was removed
together with its semantics identifier, and the gesture is deliberately the
only entry point: a pull is not part of the accessibility tree, so this refresh
is not reachable by a screen reader and is not driven by the UI test runner.

## Active sessions

`lib/features/settings/features/sessions/view/sessions_screen.dart`

Pulling calls `SessionsCubit.fetch()`. The empty state is rendered as a list
rather than a centred box on purpose - a non-scrollable child would silence the
gesture. The failure state is a centred box with its own retry button, so it
stays outside the gesture.

## Contacts

`lib/features/contacts/features/contacts_external_tab/view/contacts_external_tab.dart`
`lib/features/contacts/features/contacts_local_tab/view/contacts_local_tab.dart`

Both tabs pull to refresh, but only while the list has items: the empty state,
the empty search result and the failure state are placeholders that do not
scroll, so the gesture does nothing there. The external tab offers a text
button in its empty state instead. The local tab also has states where a fetch
is not the answer at all (contacts permission denied, contacts agreement not
accepted) - they lead to the settings or to the agreement.

The external tab calls `ContactsExternalTabBloc.refresh()` and awaits its exact
result. The BLoC receives `PollingTaskRunner` from the `ExternalContactsSync`
owner, so the pull joins a scheduled Contacts cycle when one is already
running. A failed pull shows the same request-failed snack bar as the account
screen. The widget has no polling dependency, and the owner keeps invalidation
and unregister capabilities private.

Both lists sit behind a translucent app bar, so - as on the account screen -
the indicator carries an `edgeOffset`, or the spinner is drawn behind the bar
and the pull looks like it did nothing. It takes the top padding `Scaffold`
gives the body, which is what the first row is placed by too, so the spinner
and the list it belongs to cannot drift apart.

Watch for this on any screen under `ThemedScaffold`: it turns
`extendBodyBehindAppBar` on by itself when the theme carries a gradient or an
image background, so a list that is fine on a flat theme needs the same offset
on a branded one.

## Recent calls

`lib/features/cdrs/view/recent_cdrs_screen.dart` (backend reports the
`callhistory` capability) and `lib/features/recents/view/recents_screen.dart`
(it does not).

The server-backed screen can be refreshed by pulling either the All or Missed
list, including an empty list. Both tabs receive only the
`PollingTaskRunner` capability exposed by `CdrsSync` and await `runNow()`. A
pull therefore joins an active scheduled cycle instead of starting a second
request path, and its spinner closes only when that cycle has persisted its
result. A failure keeps cached records visible and reports the failed explicit
action with a snack bar.

The indicator uses the same top inset as the list because the body extends
behind the app bar. Both populated and empty scrollables use always-scrollable
physics so a short list can still recognize the gesture. A list's pagination
listener ignores positions at or beyond its leading edge, including negative
iOS bounce overscroll, so a pull cannot start `fetchHistory()` beside the
polling cycle. Scrolling toward the bottom remains a separate action: it loads
older pages through `CdrsListCubit.fetchHistory()`.

The local-recents screen cannot be refreshed by hand and has nothing remote to
refresh: its list is written by the app itself and watched live.

Ending a call invalidates the same polling task with a one-second delay so the
backend can publish the CDR. Repeated call-ended events use trailing-edge
debounce, and the refresh cannot overlap the periodic cycle.

An empty cache keeps its initial loader while the first remote cycle is
pending. When automatic polling cannot run offline, the CDR task publishes a
replaying `waitingForConnectivity` state and the screen immediately resolves to
the empty state. A screen opened after the offline transition receives the same
retained state. A slow online sync remains loading instead of being mistaken
for offline, and a later successful sync still populates the list normally.

## Voicemail

`lib/features/settings/features/voicemail/view/voicemail_screen.dart`

No manual refresh either. The list is fetched once when the screen opens and
then follows the repository stream; the state already carries a "refreshing"
flag that draws a thin progress bar, but nothing in the UI triggers a refetch.

## Not on this page

Controls that repeat one action rather than refresh a list: the network test in
diagnostics, the retry of a voicemail recording, the reload button of the
embedded web view, and the retry in the login error dialog.
