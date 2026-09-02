import 'package:flutter/material.dart';

/// A layer of a [Stack] that can be taken out of the way without being taken
/// out of the tree, and knows what that costs.
///
/// Use it for a block that has to keep coming and going over something that
/// must not move underneath - a video, a map, a photo. It fades rather than
/// disappears, so nothing behind it is relaid out, and it holds the space it
/// had, so nothing jumps when it comes back.
///
/// A fully transparent layer is gone from the accessibility tree, so it must
/// stop taking taps at the same moment it stops being visible: [hidden] governs
/// both, and there is no state in which it is invisible yet still pressable.
/// That also means hiding it takes everything inside it away from anyone using
/// a screen reader - so whatever is the only way to do something (end a call,
/// leave a screen) must not be hidden while assistive technology is in use.
/// The decision belongs to the caller; this layer only makes the cost explicit.
///
/// [padding] insets the content while the layer itself stays full-bleed, which
/// is how a screen keeps a picture running edge to edge with its controls clear
/// of the notch and the system bars. Pass [MediaQueryData.padding] for that, or
/// [EdgeInsets.zero] when the surroundings already take care of it.
///
/// Must be placed directly inside a [Stack]:
///
/// ```dart
/// Stack(
///   children: [
///     const VideoSurface(),
///     HideableLayer(
///       hidden: controlsHidden,
///       padding: MediaQuery.paddingOf(context),
///       child: const CallControls(),
///     ),
///   ],
/// )
/// ```
///
/// Reach for something else when the block can simply leave the tree - an `if`
/// in the children list is cheaper and needs no layer - or when it should keep
/// its space without fading, which is what [Visibility] and [Offstage] are for.
class HideableLayer extends StatelessWidget {
  const HideableLayer({super.key, required this.hidden, required this.padding, required this.child});

  /// Whether the layer is currently out of the way.
  final bool hidden;

  /// The area the system reserves for itself around the screen.
  final EdgeInsets padding;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: padding.left,
      right: padding.right,
      top: padding.top,
      bottom: padding.bottom,
      child: AnimatedOpacity(
        opacity: hidden ? 0 : 1,
        duration: kThemeAnimationDuration,
        child: IgnorePointer(ignoring: hidden, child: child),
      ),
    );
  }
}
