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
  const CountBadge({
    super.key,
    required this.count,
    this.size = 20,
    this.onAccent = false,
    this.maxCount = 99,
    this.color,
    this.onColor,
  });

  final int count;

  /// Height of the badge, and the width it keeps while the number is short.
  ///
  /// A short number leaves the badge a circle of this size; a longer one
  /// stretches it sideways instead of shrinking the digits into the shape, so
  /// the badge stays as tall as the slot it was given and stays legible
  /// whatever it counts.
  final double size;

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

  /// What the badge is filled with, when the accent is not what this count
  /// means - what a delete button is about to remove, say. Take it from the
  /// colour scheme rather than naming a colour, and pass [onColor] with it so
  /// the number stays readable on the fill.
  final Color? color;

  /// Colour of the number, for a badge that sets its own [color].
  final Color? onColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = color ?? (onAccent ? colorScheme.onPrimary : colorScheme.primary);
    final foreground = onColor ?? (onAccent ? colorScheme.primary : colorScheme.onPrimary);

    return ExcludeSemantics(
      // The minimum width is what keeps a short number a circle. It is set from
      // the outside rather than by giving the box an alignment: an aligned box
      // grows to whatever room it is offered, which in a list tile is the whole
      // row.
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: size),
        child: Container(
          height: size,
          padding: EdgeInsets.symmetric(horizontal: size / 5),
          decoration: ShapeDecoration(color: background, shape: const StadiumBorder()),
          child: FittedBox(
            // Shrink only, and only what a badge given a small slot cannot fit:
            // scaling up would blow a single digit out to fill the whole circle.
            fit: BoxFit.scaleDown,
            child: Text(
              count > maxCount ? '$maxCount+' : '$count',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: foreground),
            ),
          ),
        ),
      ),
    );
  }
}
