# Presence

How the app learns other users' presence (available / activities / on a call)
and where it shows it, most visibly as the status badge on contact avatars.

Last reviewed: 2026-08-19

## State model

- `lib/models/presence/presence_info.dart` - `PresenceInfo`: `available`
  (bool), free-text `note`, emoji `statusIcon`, `activities`, `device`,
  `source` (`sip` | `direct`). A contact maps to a LIST of these - one per
  device/source - so all read sites go through the
  `PresenceInfoListExtension` helpers: `anyAvailable`, `primary`
  (on-the-phone wins, then most recent available with activities, and so on),
  `primaryActivity`, `primaryNote`, `primaryStatusIcon`.
- `lib/models/presence/presence_activity.dart` - `PresenceActivity`: 12
  values (`away`, `busy`, `doNotDisturb`, `sleeping`, `permanentAbsence`,
  `onThePhone`, `meal`, `meeting`, `appointment`, `vacation`, `travel`,
  `inTransit`).
- `lib/models/dialog_info.dart` - BLF dialog state per number:
  `DialogState { trying, proceeding, early, confirmed, terminated, unknown }`,
  direction, tags, the `pullable` getter used by Call Pull.

## Data flow

All presence and dialog data arrives over the signaling socket and is
persisted locally, then joined onto contacts:

1. `CallBloc` consumes the initial handshake state and the live
   `NumberPresenceUpdate` / `NumberDialogsUpdate` events
   (`lib/features/call/bloc/call_bloc.dart`).
2. They are written to drift via
   `lib/repositories/presence/presence_info_repository.dart` and
   `lib/repositories/dialog_info/`.
3. `lib/repositories/contacts/contacts_repository.dart` joins
   `presenceInfo` + `dialogInfo` onto each contact, so tiles simply read
   `contact.presenceInfo` / `contact.dialogInfo`.

Independently of the hybrid path, a contact record still carries the legacy
`registered: bool?` flag, which feeds the older badge (next section).

## Avatar badges: two systems plus one indicator

`lib/widgets/leading_avatar.dart` (`LeadingAvatar`) knows nothing about
presence: it exposes a `badge` slot that receives the whole avatar square.
The status badge is a separate widget,
`lib/widgets/avatar_status_badge.dart` (`AvatarStatusBadge`) - call sites
build it via `AvatarStatusBadge.maybe(...)`, which returns `null` (no badge
mounted) when there is no status data at all. The badge sizes and anchors
itself via `lib/utils/badge_layout.dart` as an
`avatar diameter * sizeFactor` square, and decides which bottom-right badge
renders by `PresenceViewParams.hybridPresenceSupport` - the two are
mutually exclusive. The top-left smart-contact indicator is still drawn by
`LeadingAvatar` itself:

| Overlay | Widget | Placement | Default sizeFactor | Shown when |
|---|---|---|---|---|
| Registered dot (legacy) | `_RegisteredDot` (avatar_status_badge.dart) | bottom-right, inside the box | 0.2 | hybrid presence OFF and `registered != null` |
| Presence mark | `lib/widgets/sip_presence_indicator.dart` | centre ON the avatar's edge (`BadgeLayout.onCircleEdgeSquare`) | 0.5 | hybrid presence ON and `presenceInfo != null` |
| Smart-contact indicator | `_smartIndicator` (leading_avatar.dart) | top-left | 0.4 | `smart: true` (unrelated to presence) |

The default avatar radius is 20 (diameter 40), so the presence mark is 20 dp
across and the legacy dot 8 dp. All sizeFactors are themable per deployment
(see below).

The presence mark is placed by its CENTRE on the circle inscribed in the
avatar box, so about a tenth of the avatar diameter hangs outside the
silhouette. That is deliberate: centred inside, a mark this size covers the
face or the initials underneath. Consequences worth knowing:

- the overhang is paint-only - the avatar keeps its size, no row reflows, and
  the part that sticks out lives in the gap that already separated the avatar
  from the text;
- nothing above the badge may clip: `LeadingAvatar` and `AvatarStatusBadge`
  both use `clipBehavior: Clip.none`, and no current host wraps the avatar in
  a clip. A new host that does would cut the mark;
- the overhanging part is NOT hit-testable (Flutter does not hit-test outside
  a box), which is fine while the mark is not interactive;
- on a large avatar the mark scales with it, so leave room below: the chat
  profile screen (`radius: 50`) keeps 16 dp before the name for exactly this.

The legacy registration dot deliberately stays INSIDE the box: it carries no
ring, so half of it on the row background would read as a partial dot.

`SipPresenceIndicator` renders:

- a colored disc - the color is BINARY: `presenceInfo.anyAvailable` picks
  `availableColor`, otherwise `unavailableColor`. Activities and BLF state
  do NOT change the color;
- an optional activity glyph INSIDE the disc, in `iconColor`. Icon choice:
  any `dialogInfo` entry present -> `phone_in_talk` (note: the list is not
  filtered by `DialogState`, so a ringing dialog lights it too - in
  production `early` is the most common state), else the icon for
  `presenceInfo.primaryActivity`;
- the ring around the disc (`Theme.scaffoldBackgroundColor`, which can
  mismatch on surfaces that are not the scaffold background) and the glyph
  are a SHARE of the mark - 0.1 and 0.55 of its side. They have to be:
  the same widget is rendered at a fixed 16x16 in the presence pickers
  (`presence_settings_screen.dart`, `presence_info_view.dart`), where a fixed
  ring plus a fixed glyph would leave the availability colour a sliver.

The emoji `statusIcon` and the `note` never reach the badge - contact tiles
append them to the title/subtitle text instead
(`lib/features/contacts/widgets/contact_tile.dart`), and a BLF dialog swaps
the subtitle to remote-party info there.

## Colors and theming

The presence badge style flows through the standard theme pipeline:

- theme JSONs `assets/themes/original.widget.{light,dark}.config.json` ->
  `presenceBadge` (`sizeFactor`, `availableColor`, `unavailableColor`,
  `iconColor`) and
  `registeredBadge` (`sizeFactor`, `registeredColor`, `unregisteredColor`);
- parsed by `PresenceBadgeStyleConfig` in
  `packages/webtrit_appearance_theme/lib/models/common/leading_avatar_style_config.dart`;
- mapped in `lib/theme/factory/styles/leading_avatar_style_factory.dart`
  into `PresenceBadgeStyle` (`lib/theme/styles/presence_badge_style.dart`).

The shipped themes name none of these: the app's own values live in
`LeadingAvatarStyle.defaults` - `colorScheme.tertiary` (available),
`colorScheme.onSurfaceVariant` (unavailable), `colorScheme.surface` (glyph)
and the sizes above. A theme that writes one of them pins it for good, so the
shipped files carry them only as disabled `_`-prefixed examples. There is no
per-activity or busy/on-call color role today.

The legacy dot resolves its colors from `RegisteredStatusStyles`
(`lib/theme/factory/styles/registered_status_style_factory.dart`, fed by
`statuses.registrationStatuses` in the theme JSON). Note its fallback is
`colors.error` for BOTH states.

## Where the badge appears

Passed `presenceInfo`/`dialogInfo` (hybrid badge):

- contacts list and search: `lib/features/contacts/widgets/contact_tile.dart`
  via `contact_tile_adapter.dart`;
- favorites: `lib/features/favorites/widgets/favorite_tile.dart`;
- recents: `lib/features/recents/widgets/recent_tile.dart`; CDRs:
  `lib/features/cdrs/widgets/cdr_tile.dart`;
- chats: conversation list tile, conversation header, message avatars, chat
  details;
- the presence settings screen previews `SipPresenceIndicator` directly at a
  fixed 16x16.

No badge by design:

- the big avatar on the contact details screen
  (`lib/features/contact/view/contact_screen.dart`) - presence is shown
  there as a textual section (`widgets/presence_info_view.dart`) instead;
- the in-call header (`lib/features/call/widgets/call_remote_avatar.dart`
  deliberately renders without badges).

Legacy-dot-only sites (screens that pass just `registered`): number CDRs,
call log, SMS tiles, contact pickers.

## Enablement and gating

`PresenceViewParams` (`lib/utils/view_params/presence_view_params.dart`) is
provided by the main shell from `FeatureAccess.sipPresenceConfig`
(`lib/app/router/main_shell.dart`); the mapping lives in
`SipPresenceMapper.map` (`lib/data/feature_access.dart`):

- `hybridPresenceSupport` = app config `supported` contains hybrid presence
  AND the core reports `hybridPresenceAware`;
- `presenceViaSipSupport` additionally requires the adapter's
  `supportsSipPresence`;
- `dialogsViaSipBlfSupport` additionally requires `supportsSipDialogs`.

SIP presence/BLF subscriptions are also per-contact opt-in: checkboxes on
the contact details screen write `SipSubscriptionType.presence/dialog`
through `SipSubscriptionsRepository`; syncing the subscription list to the
backend is gated by `subsSyncEnabled`
(`lib/models/feature_access/sip_presence_config.dart`).

Publishing the user's OWN presence (the presets under Settings -> Presence,
`lib/features/settings/features/presence/`) rides the same gating; the
periodic send is driven from `CallBloc`.

## Test coverage

`test/widgets/avatar_status_badge_test.dart` pins the badge contract: which
generation renders under `hybridPresenceSupport`, the default 0.2/0.5 sizes,
the legacy dot colors, the mark's centre sitting on the avatar's edge with
the glyph inside it, and the no-data cases (including
`AvatarStatusBadge.maybe` returning `null`).
`test/theme/leading_avatar_style_defaults_test.dart` pins that a theme is
read as overrides only - what it leaves out comes from the app values.
`test/widgets/leading_avatar_test.dart` covers name-derived avatar colors
and the badge slot, including a composition test asserting the slot hands
the badge exactly the avatar diameter. There are no golden tests for these
widgets, and `BadgeLayout` has no test of its own - its geometry is covered
through the widgets.
