import 'package:flutter/material.dart';

class AnimatedProgressLine extends StatelessWidget {
  const AnimatedProgressLine(this.progress, {super.key});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0, end: progress.clamp(0, 1)),
      builder: (_, double value, __) => LinearProgressIndicator(
        value: value,
        color: colorScheme.primary,
        backgroundColor: colorScheme.secondary,
      ),
    );
  }
}
