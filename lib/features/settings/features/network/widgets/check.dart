import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  const Check({
    super.key,
    required this.selected,
    this.enabled = true,
  });

  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final icon = selected ? Icons.check_circle_sharp : Icons.check_circle_outline;
    final color = selected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return Icon(icon, color: enabled ? color : color.withValues(alpha: 0.5));
  }
}
