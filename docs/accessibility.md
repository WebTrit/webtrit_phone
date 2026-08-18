# Accessibility

How interactive controls are exposed to screen readers and to UI automation, and
what every feature has to do about it before it ships.

Last reviewed: 2026-08-17

## Why this exists

Flutter builds a second tree next to the widget tree: the semantics tree. Only
what lands there exists for two consumers we owe support to.

- **Screen readers** (TalkBack, VoiceOver) read a node out loud and activate it
  through its semantics action. A node with no name is announced as a bare
  "button", so the user hears what kind of thing it is but never what it does.
  A control that is not in the tree at all cannot be reached by swiping.
- **UI automation** (patrol tests, Maestro flows, the tooling QA runs) finds a
  control by the identifier the node carries; on Android it surfaces as the
  platform resource id. Without an identifier the only anchor left is visible
  text, which changes with the locale and is often not unique anyway - "Proceed"
  names the button on four different login screens.

Both needs are served by the same node, and that is the point of the wrappers
below: the name, the identifier and the activation action must sit on **one**
node. A control whose name lives on a node above its action looks right on
screen, reads right in a dump, and is still broken for both consumers.

## The requirement

Any feature or screen that adds interactive UI ships all of the following. This
is a review gate, not a nice-to-have: a control added without it is a defect
that only surfaces months later, when someone runs a screen reader or writes a
flow against the screen.

1. **Every interactive control has a name** - the wrapper's `label`, or a
   documented reason it needs none (the control already exposes a proper visible
   or framework-provided label, see the Material note in Traps).
2. **Every control automation has to reach has an identifier** declared in
   [`lib/app/keys.dart`](../lib/app/keys.dart) as a `const String ...Id`, never a
   literal in the widget. Add a `Key` built from that constant only when the
   control also needs a widget-test anchor; screen anchors and controls that no
   widget test looks up live in the identifier-only groups of that file.
3. **Names come from localization** - never a hardcoded English string. A new key
   is named `<bloc>_SemanticsLabel_<control>` and is added to all four arb files
   (`app_en`, `app_it`, `app_uk`, `app_th`); an existing key whose text already
   reads as the name of the control may be reused instead.
4. **The screen has a `*_semantics_test.dart`.** For each control it asserts name
   + identifier + action on one node via `expectTapTargetSemantics`, drives
   activation through `tapViaSemantics`, and closes with
   `meetsGuideline(labeledTapTargetGuideline)` over the whole screen. Pass both
   `label` and `identifier` to the matcher explicitly: they are optional
   arguments, so an omitted one is not checked at all and the test pins nothing
   about it. Both helpers live in
   [`test/helpers/semantics.dart`](../test/helpers/semantics.dart).
5. **After renaming anything in `keys.dart`**, grep `patrol_test/` and
   `integration_test/`. `patrol_test/**` is excluded from analysis
   (`analysis_options.yaml`), so a stale constant keeps `flutter analyze` and the
   pre-push hook green and breaks the whole end-to-end run at compile time.

## Attaching it: pick the wrapper

All three wrappers are exported from `lib/widgets/widgets.dart`; import the barrel.

**`SemanticAction`** - a tap target. It merges the subtree into a single node, so
name, identifier and action cannot drift apart. Use the default constructor for
controls that already announce their own role, and `SemanticAction.button` for
bare tap targets (`GestureDetector`, `InkWell`) so the button role is added.

```dart
SemanticAction(
  label: context.l10n.callTile_SemanticsLabel_call(widget.name),
  identifier: callTileDialId,
  child: IconButton(icon: const Icon(Icons.call), onPressed: _dial),
)
```

The child must contain exactly **one** interactive control. Merging a subtree
with several tappable descendants collapses them into one node and the others
become unreachable.

**`SemanticId`** - a node that carries an identifier and changes nothing about how
the subtree is announced (it does add that one node of its own). For the two cases
where merging is wrong:

- a screen anchor, so a flow can tell which screen it is on before touching any
  control (merging would collapse the whole screen into one node);
- a text field, which has to keep its own node because merging would swallow the
  activation of whatever its decoration hosts, such as the password visibility
  toggle.

A text field whose decoration hosts nothing pressable and whose only name is a
hint is the one exception: a hint disappears with the first letter typed, so the
field ends up with no name at all, and `SemanticId` cannot add one - a name put
on a node above the field leaves the value and the editing actions on the node
below, which is the same split this whole section is about. Merge it instead
(`MergeSemantics` around `Semantics(label:, identifier:)`), the way the keypad
number (`lib/features/keypad/view/keypad_view.dart`) and the message field
(`lib/features/messaging/widgets/message_list_view/message_text_field.dart`) do.
Check the merge in a test by asserting the value on the same node as the name:
`isSemantics(label: ..., identifier: ..., value: 'hello', isTextField: true)`.
One more thing to know before reaching for a device to confirm it: the name of a
text field arrives on Android as the HINT, so `uiautomator dump` shows an empty
`content-desc` and Maestro cannot match it - address fields by id there.

**Never wrap a tap target in a plain `Semantics(identifier: ...)`.** An identifier
forces its own semantics boundary, so the id ends up on a node above the one
carrying the action: the screen reader announces an unnamed button and automation
cannot activate what it just found by id. The in-call buttons were announced as a
bare "button" for exactly this reason before they were fixed - their name sat on a
node split off from the one that could be activated.

**`SemanticIdOfAncestor`** - an identifier for a control whose node is built by a
widget we do not own and cannot wrap. The entries of a `BottomNavigationBar` are
the case it was written for: the bar itself builds the node that carries the
caption, the selected state and the press, and nothing we pass in can become
that node. Wrapping the icon in `Semantics(identifier: ...)` does not help - an
identifier implicitly introduces a node of its own (framework `basic.dart`), so
the id lands on an empty node inside the entry, with no name to announce and no
action to press. This widget contributes the id to the description the ancestor
compiles instead of declaring a node, so it ends up on the entry itself.

Reach for it only when the id cannot be declared on the control: it depends on
who builds the node above, which is not visible from the call site. Where the
subtree can be wrapped, `SemanticAction` is the answer.

Note that a widget that merges its subtree needs none of this - `getSemanticsData`
picks an identifier up from a merged child, which is why an id inside a `Tab` or a
segment of a `SegmentedButton` lands on the merged node (see Traps).

A raw `Semantics` is still the right tool in two situations. One is a node that
declares the name, the identifier **and** the action itself, which is how the
keypad keys are done (`lib/widgets/keypad_key_button.dart`): the key takes pointer
input through a bare `Listener` for performance, so the node has to supply the
action that assistive technology activates. That shape is only safe together with
`excludeSemantics: true` - without it the widgets below (there is a decorative
`TextButton` among them) keep forming nodes of their own, and you are back to a
nameless inner node owning the activation. The other situation is a node that is
not a control at all: a status or progress message published with
`liveRegion: true`, or a value read out next to a meter.

## Helpers that already exist

Reach for these before writing anything new; each one carries a rule that is easy
to get wrong on your own.

- **`SemanticAction`, `SemanticId`, `SemanticIdOfAncestor`** (`lib/widgets/`) - the
  three wrappers above, exported from the widgets barrel.
- **`CallActionButton`, `CallActionMenuButton`**
  (`lib/features/call/widgets/call_action_button.dart`) - every in-call action
  button. They take the `label` and the `identifier`, and keep the visual
  long-press tooltip with `excludeFromSemantics: true` so it is not spoken on top
  of the name. In the menu flavor the styling button opens the menu itself,
  because after the merge its handler is what the node's tap action runs.
- **`context.showSnackBar`** (`lib/extensions/build_context.dart`) - already wraps
  the message in a `SemanticId`, so a flow can wait for the snackbar by id, and
  keeps a snackbar that carries an action on screen until it is dismissed:
  three seconds is not enough to notice an action, let alone reach it with a
  screen reader.
- **`keypadKeyId(text)`** (`lib/app/keys.dart`) - the shape to copy for a family
  of repeated controls: one prefix constant plus a function, instead of one
  constant per instance.
- **`expectTapTargetSemantics`, `tapViaSemantics`**
  (`test/helpers/semantics.dart`) - the test side of the same contract.

## Writing the name

Name the action, not the widget: "Call John Smith", "Show password", "Rearrange
favorites". Leave the role out - the platform appends "button" itself, so a label
of "Call button" is spoken as "Call button, button".

Keep identity in the label when the control is one of many identical ones (the
call button in a list row, an account badge), and exclude the decorative piece
that would otherwise be read as a bare number or letter: an avatar initial or an
unread count is announced as "1" and collides with everything else on screen.
Merge the count into the label ("Notifications, 3") and keep the raw glyph out of
the tree.

## Verifying it

- **Unit level** is where the contract is pinned. `expectTapTargetSemantics` also
  asserts the node has no stray tooltip, because a tooltip merged in from a
  nested widget is spoken on top of the label (appended to it on iOS) and is
  otherwise easy to miss.
- **Activate through semantics, never `tester.tap`.** A pointer tap can pass
  while the semantics path is broken - the merged node's action pointing at a
  no-op - which is exactly how an overflow menu once became unopenable for
  TalkBack while its widget test stayed green.
- **`labeledTapTargetGuideline` is a floor, not a substitute.** It only fails a
  tappable node that has neither label nor tooltip, and it skips text fields,
  invisible and merged nodes; it does not look at identifiers at all. It catches
  the control someone forgot; per-control asserts catch the control that is named
  on the wrong node.
- **With a screen reader actually on**, at least once per screen. From `adb` that
  takes two settings, not one - naming the service does nothing until the master
  switch is flipped as well (the service name differs per vendor; this one is a
  Samsung tablet):

  ```bash
  adb shell settings put secure enabled_accessibility_services \
    com.samsung.android.accessibility.talkback/com.samsung.android.marvin.talkback.TalkBackService
  adb shell settings put secure accessibility_enabled 1
  # TalkBack asks for phone access on first run; the dialog covers the app and
  # spoils any tree dump, so grant it up front
  adb shell pm grant com.samsung.android.accessibility.talkback android.permission.READ_PHONE_STATE
  ```
- **On a device**, dump the tree with `adb shell uiautomator dump`. A Maestro dump
  takes 3-5 seconds, which is slower than UI that auto-hides, so it can report an
  empty tree for controls that are really there.
- **Check the control is pressable by finger too**, not only reachable in the
  tree. Two controls in this app were fully named and completely unpressable,
  drawn under the tab bar the main screen floats over its pages, and only a
  pointer tap on a device showed it. A screen reader activates through the
  semantics action and never notices.

## Traps

Learned the hard way; none of these is caught by the analyzer or by a pointer
test.

1. **A merged node inherits the rectangle of the whole subtree.** Merge a row
   into one control and the node becomes row-wide while the actually tappable
   area stays a small box at its left edge. The tree then promises a target that
   does not exist. If you merge a row, make the **whole** row tappable
   (`GestureDetector` with `behavior: HitTestBehavior.opaque`); otherwise do not
   merge.
2. **Do not merge a row that contains a link.** Merging kills the link's
   activation. Keep the name on the control and leave the text as its own node,
   even at the cost of the sentence being read twice.
3. **A child's identifier survives a merge, and only a merge.** `getSemanticsData()`
   picks it up when the parent has none, so an id on a segment's label lands on the
   same node that carries selection and the tap; `TabBar` merges each tab the same
   way, and `ExtTab` relies on it. A parent that only opens a container without
   merging - `BottomNavigationBar` does that per entry - picks up nothing, and the
   id sits on a node of its own instead: that is what `SemanticIdOfAncestor` is for.
4. **`opacity: 0`, `Offstage` and friends remove the subtree from semantics
   entirely.** Controls that fade out or auto-hide stop existing for a screen
   reader, not just visually. Keep them reachable while a screen reader is on -
   and read `MediaQuery.accessibleNavigation` only while the app is `resumed`:
   when a foreign window (a permission dialog, for instance) covers the app, the
   platform reports the flag as `false` and any state derived from it flips back.
5. **A `Tooltip` is not a reliable name.** It works for `IconButton`, where the
   tooltip sits inside the button's own semantics wrapper, and it does not work
   for `TextButton` and the other `ButtonStyleButton`s, which force a semantics
   container of their own - the tooltip then names a node that cannot be
   activated. An existing tooltip is not evidence a control is covered. Keep a
   tooltip you want visually, but mark it `excludeFromSemantics: true` and put the
   name on the semantics node, the way `CallActionButton` does.
6. **Input taken through a raw `Listener` has no semantic action at all.** The
   keypad keys read pointer events directly for performance, so a screen reader
   press produced visual feedback and no digit. Such a control needs the action
   declared next to the listener, not only the name.
7. **Material may have named the control already.** On Android the back button
   ships `Icon(semanticLabel: backButtonTooltip)` deliberately (framework
   `action_buttons.dart`), so wrapping it adds a second name and it is announced
   as "Back Back". Check the framework first.
8. **`ExcludeSemantics` on visible text leaves a silent zone.** Hiding a sentence
   so it is not read twice makes most of the row mute to explore-by-touch. Merge
   instead of hiding.
9. **A custom semantics action can cost more than it adds.** Adding one to a list
   row can break the row's node apart and take away the move actions the list
   itself provides. Prefer the action the framework already exposes.

## Third-party widgets

A control that comes from a package cannot be named in place. Wrap it where we use
it if the widget tree allows, and otherwise fix it upstream - the emoji picker tabs
need both. Record what is missing rather than leaving a nameless control behind
with no trace.

## Open points

- Identifiers are camelCase, mirroring the `keys.dart` constants. That is a
  deliberate deviation from the snake_case scheme QA proposed, and the convention
  is still to be confirmed with them.
- Everything above was verified on Android, with TalkBack and with Android UI
  automation. VoiceOver has not been run over these screens yet, so iOS-specific
  wording (a tooltip is appended to the label there) rests on the framework
  behaviour rather than on a device check.
