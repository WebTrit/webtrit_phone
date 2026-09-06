import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import 'count_badge.dart';

/// A bottom-bar icon carrying an unread count in its corner.
///
/// The corner is decided once, here, rather than by each section that happens
/// to count something: two badges in one bar drawn in different corners read as
/// a defect, and nothing about a particular section makes its own corner right.
///
/// A count of none draws the icon bare. A section decides for itself what it
/// counts; what a zero means - nothing to show - is the same everywhere.
class TabIconCountBadge extends StatelessWidget {
  const TabIconCountBadge({super.key, required this.icon, required this.count});

  /// The icon the bar built for the entry, decorated in place.
  final Widget icon;

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return icon;

    // The badge draws a glyph and says nothing of its own; the count travels as
    // the entry's VALUE.
    //
    // Everywhere else in the app a count is part of the name, drawn after it,
    // because Android composes what it speaks as value, then label - so a value
    // is read out ahead of the name it belongs to. Here that is not available:
    // the caption belongs to the bar, which draws it after this slot and takes
    // it from what is displayed, so there is nothing of ours drawn later to
    // hang the phrase on and no way to add to the caption without changing what
    // is on screen. A value at least says what the number means; its position
    // is the price. See docs/accessibility.md, "Counting things".
    //
    // Deliberately no `container: true`: the node must merge into the entry the
    // bar builds, the one that carries the name, the id and the press.
    final spokenCount = context.parseL10n(
      'common_SemanticsValue_unreadCount',
      arguments: [count],
      // A host without the app's translations still gets a working bar; the
      // badge simply stays silent rather than red-screening the navigation.
      fallback: '',
    );

    // Clipping off, and the badge hung past the icon's corner: inside the box
    // it covers the glyph it is meant to annotate. What sticks out is the
    // badge's own edge, which the bar has room for above and beside the icon.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          right: -4,
          top: -4,
          child: Semantics(
            value: spokenCount,
            child: CountBadge(count: count, size: 14),
          ),
        ),
      ],
    );
  }
}
