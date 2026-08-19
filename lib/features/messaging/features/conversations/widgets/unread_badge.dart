import 'package:flutter/material.dart';

/// The little filled circle carrying a number of unread conversations.
///
/// It says nothing to a screen reader on purpose. Wherever it is drawn it
/// sits inside a node someone else names - a tab, a list tile - and a raw
/// digit merged into such a node is read out as part of that node's name
/// ("3, Chats"). The host names the count instead, as the state of the thing
/// it decorates: `ExtTab(value: ...)` for a tab, `Semantics(value: ...)`
/// otherwise. See docs/accessibility.md.
class UnreadBadge extends StatelessWidget {
  const UnreadBadge({super.key, required this.count, required this.isActive, required this.colorScheme});

  final int count;
  final bool isActive;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: 14,
        height: 14,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          child: Text(
            count.toString(),
            style: TextStyle(color: isActive ? colorScheme.onSurface : colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
