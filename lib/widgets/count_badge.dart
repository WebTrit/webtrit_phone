import 'package:flutter/material.dart';

/// The little filled shape that carries a number: unread messages, selected
/// items, members of a group.
///
/// It says nothing to a screen reader, and that is deliberate rather than an
/// omission. Wherever it is drawn it sits inside a node someone else names - a
/// tab, a list tile, a button - and a raw digit merged into such a node is read
/// out as part of that node's name ("3, Chats"). The host names the count
/// instead, as the state of the thing the badge decorates: `ExtTab(value: ...)`
/// for a tab, `Semantics(value: ...)` otherwise, or its own label when the
/// control names itself. See docs/accessibility.md, "Counting things".
///
/// It also draws whatever count it is handed, including none: a badge is
/// visible exactly when its host decides there is something to show, and the
/// host is the one that has to make that decision anyway to know whether to
/// speak the count.
class CountBadge extends StatelessWidget {
  const CountBadge({super.key, required this.count, this.diameter, this.onAccent = false, this.maxCount = 99});

  final int count;

  /// Size of a badge that has to fit a slot of its own - the corner of a
  /// bottom-bar icon, say. Left out, the badge takes the width of its number.
  ///
  /// A fixed size cannot grow with the digits, so it shrinks them instead;
  /// pick [maxCount] small enough that the number stays legible at this size.
  final double? diameter;

  /// Whether the badge is drawn on top of the accent colour rather than on the
  /// surface - the selected tab of a tab bar, say. The pair of colours is the
  /// same either way, swapped, so the badge stays visible on both grounds.
  final bool onAccent;

  /// Largest number drawn as itself; beyond it the badge draws "99+".
  ///
  /// Only the drawing is capped. What a screen reader says comes from the host,
  /// which has the true count - a badge reading "99+" is still announced as
  /// "128 unread".
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = onAccent ? colorScheme.onPrimary : colorScheme.primary;
    final foreground = onAccent ? colorScheme.primary : colorScheme.onPrimary;

    final label = Text(
      count > maxCount ? '$maxCount+' : '$count',
      style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: foreground),
    );

    final diameter = this.diameter;

    return ExcludeSemantics(
      child: diameter == null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: ShapeDecoration(color: background, shape: const StadiumBorder()),
              child: label,
            )
          : Container(
              width: diameter,
              height: diameter,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(color: background, shape: BoxShape.circle),
              child: FittedBox(child: label),
            ),
    );
  }
}
