import 'package:flutter/material.dart';

class UnreadBadge extends StatelessWidget {
  const UnreadBadge({super.key, required this.count, required this.isActive, required this.colorScheme});

  final int count;
  final bool isActive;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
