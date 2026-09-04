# Adaptive layout: giving a screen a second arrangement

How to add a landscape arrangement to a screen, distilled from the first
screen that got one - the active call screen (see
[`features/call_ux.md`](features/call_ux.md), section "Landscape", for the
reference implementation). Follow this playbook for the next screens instead
of inventing the shape again.

Last reviewed: 2026-09-04.

## The adaptation axis

The axis the app adapts on today is **window orientation**, and it is decided
in exactly one place: `lib/widgets/orientation_layout_selector.dart`
(`OrientationLayoutSelector`). A screen hands it both arrangements and never
reads the orientation itself:

```dart
OrientationLayoutSelector(
  portrait: MyScreenPortrait(params: params),
  landscape: MyScreenLandscape(params: params),
)
```

If the axis ever changes - window size classes once tablet or desktop
arrangements exist - only the selector changes, and every screen follows.
Do not scatter `MediaQuery.orientation` checks through screens or blocks.

## Step 0: rotation is a product decision

The app is portrait-locked globally (`app/view/app.dart` sends
`PreferredOrientation.portrait` at startup through `OrientationsBloc`) and
unlocked per flow: `features/call/view/call_shell.dart` switches to
`PreferredOrientation.auto` while a call is on screen and back to portrait
after. A screen without an unlock never sees landscape, so adding an
arrangement starts with deciding - and wiring - where its flow unlocks
rotation, the way the call shell does.

## Delivery shape: two stacked PRs

The call screen shipped as a stack, and the split is what made both halves
reviewable. Repeat it:

1. **Preparation, behavior-preserving.** Extract the screen's building
   blocks into standalone widgets, bundle the constructor traffic into one
   params object, move the screen body into `<screen>_portrait.dart`. The
   screen renders exactly as before - the PR is judged on that claim, so
   keep any legacy landscape fallback alive in this half.
2. **The arrangement, almost purely additive.** A new
   `<screen>_landscape.dart`, the `OrientationLayoutSelector` swap, the
   landscape test suites, the feature-doc update. Reviewers read one new
   file and a two-line selector.

Base the second PR's branch on the first and retarget it to the default
branch after the first merges.

## Structure rules

- **Blocks are dumb, screens compose.** A shared block (an info panel, an
  action grid) renders content and fires callbacks; it never decides where
  it stands or reads the orientation. Each arrangement file places the same
  blocks differently. Knobs like `hangupRowShown`/`padded` on the call
  action area are the pattern: the layout above turns off what it places
  itself.
- **One params object.** Everything the arrangements present and dispatch
  travels as a single object built once by the screen
  (`CallControlsParams` is the reference). A new control is one new field,
  not a change in every constructor on the way.
- **State stays on the screen.** Anything both arrangements show (the call
  screen's typed DTMF digits) is owned by the screen, exposed as a
  `ValueListenable`, and merely rendered by the arrangements - so rotation
  can neither lose nor duplicate it, and updating it repaints the listeners
  instead of rebuilding the screen.
- **Rebuild trigger.** Where the screen owns layers around the selector, an
  `OrientationBuilder` around the body guarantees the rebuild on rotation;
  the selector itself subscribes only to the orientation aspect.

## Layout rules for the landscape file

Hard-won on the call screen; treat them as defaults, not suggestions.

- **Budget from constraints, not from the screen size.** Landscape sizes
  derive from `shortestSide` (the height), so on a wide-but-low window they
  can outgrow the width. Zone widths come from `constraints.maxWidth` minus
  the real chrome.
- **Floor every tap target at `kMinInteractiveDimension`.** Zones shrink;
  buttons do not. Compute the zone width at which scaled buttons hit the
  floor and stop shrinking the zone there.
- **Fold, never vanish.** When a dedicated zone no longer fits (the call
  screen's isolated hangup on a split-screen window), fold its control back
  into the main grid so one scale carries everything down together. A
  control the user needs must never be budgeted away.
- **Text yields, buttons do not.** Long names, raised font scale: text
  wraps and tall content scrolls. Never put text and critical buttons under
  one `FittedBox` - the text's growth becomes the buttons' shrink.
- **`FittedBox(scaleDown)` is a guard, not a layout tool.** It backstops
  the degenerate window nobody designed for; the floors above must make it
  a no-op on real devices.

## Test conventions

- **The default 800x600 test surface IS landscape.** A suite that pins
  portrait behavior must say so (`pinPortraitSurface()` in the call harness
  is the pattern), or it silently tests the other arrangement.
- **A landscape suite and a landscape semantics suite** beside the portrait
  ones: zone order, controls that exist only there, activation through
  semantics (`tapViaSemantics`), `expectTapTargetSemantics` and
  `meetsGuideline(labeledTapTargetGuideline)` per
  [`accessibility.md`](accessibility.md).
- **Degenerate surfaces are test cases**: a split-screen-narrow window, a
  doubled font scale, the fold threshold. Assert no overflow and the tap
  floors.
- **Measure with `getRect`, not `getSize`.** Inside a `FittedBox`,
  `getSize` reports the pre-scale layout size and passes vacuously;
  `getRect` applies the transform the user actually gets.
- **Prove every new test can fail**: break the line it pins, watch it go
  red, restore. Commit before the mutation pass - `git checkout --`
  restores the committed state, including over your uncommitted fixes.
