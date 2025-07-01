import 'package:flutter/material.dart';

class UnreadBadge extends StatelessWidget {
  const UnreadBadge({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return CircleAvatar(
      backgroundColor: colorScheme.primary,
      radius: 16,
      child: Text(
        count.toString(),
        style: textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
