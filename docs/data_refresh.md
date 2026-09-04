# Refreshing data by hand

How a user asks a list in the app to fetch again, screen by screen.
Last reviewed: 2026-09-04.

Who performs these fetches and why a manual refresh cannot race the
periodic schedule: [`docs/refresh_ownership.md`](refresh_ownership.md).

The rule: refreshing is a pull on the list. A screen that can be refreshed
carries no refresh control in its app bar.

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

Neither screen can be refreshed by hand. The list is served from the local
database, which `CdrsSyncWorker` fills on a ten-second poll; scrolling to the
bottom pulls older pages through `CdrsListCubit.fetchHistory()`.

## Voicemail

`lib/features/settings/features/voicemail/view/voicemail_screen.dart`

No manual refresh either. The list is fetched once when the screen opens and
then follows the repository stream; the state already carries a "refreshing"
flag that draws a thin progress bar, but nothing in the UI triggers a refetch.

## Not on this page

Controls that repeat one action rather than refresh a list: the network test in
diagnostics, the retry of a voicemail recording, the reload button of the
embedded web view, and the retry in the login error dialog.
