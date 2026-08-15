import 'package:flutter/material.dart';

import '../utils/utils.dart';

/// The frame both call thumbnails share: the small rounded window that floats
/// over the app while a call is up.
///
/// One of them shows the call itself and leads back to it, the other shows the
/// local camera and switches it. They differ only in what they draw inside and
/// in whether they are raised off the page, so everything else about them -
/// their size for the current orientation, the rounded clip and the tap - is
/// stated once, here.
class ThumbnailFrame extends StatelessWidget {
  const ThumbnailFrame({
    super.key,
    required this.orientation,
    required this.onTap,
    required this.child,
    this.smallerSide = ThumbnailLayout.defaultSmallerSide,
    this.raised = false,
  });

  /// Current device orientation; the frame is upright in portrait and lying
  /// down in landscape.
  final Orientation orientation;

  /// What the frame does when pressed. A null callback leaves it inert.
  final VoidCallback? onTap;

  /// The smaller side of the frame; the other one follows the aspect ratio.
  final double smallerSide;

  /// Whether the frame sits on a raised surface with its own shadow.
  final bool raised;

  /// What fills the window: the video or, while there is none to show, what
  /// stands in for it. It is clipped to the rounded shape and stretched to the
  /// whole frame, so it is normally a [Stack] rather than a single child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The tap sits outside the clip so the rounded corners stay pressable.
    final frame = SizedBox.fromSize(
      size: ThumbnailLayout.calcFrameSize(orientation: orientation, smallerSide: smallerSide),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClipRRect(borderRadius: BorderRadius.circular(8), child: child),
      ),
    );

    return raised ? Card(child: frame) : frame;
  }
}
