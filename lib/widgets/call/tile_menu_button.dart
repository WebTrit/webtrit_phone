import 'package:flutter/material.dart';

class TileMenuButton extends StatelessWidget {
  const TileMenuButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface.withAlpha(1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.more_vert, size: 20, color: themeData.textTheme.labelMedium?.color),
      ),
    );
  }
}
