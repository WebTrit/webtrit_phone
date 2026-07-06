import 'package:flutter/material.dart';

/// Small circular "!" badge used to flag that the session has at least one side
/// issue. Color is driven by the issue severity; callers position it as an
/// overlay (e.g. on the user avatar).
class SessionIssueBadge extends StatelessWidget {
  const SessionIssueBadge({super.key, required this.color, this.size = 14});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1.5),
      ),
      child: Icon(Icons.priority_high, color: Colors.white, size: size),
    );
  }
}
