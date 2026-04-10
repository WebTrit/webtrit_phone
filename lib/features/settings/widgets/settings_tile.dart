import 'package:flutter/material.dart';

import 'list_tile_separator.dart';

/// A reusable settings list tile widget that combines a [ListTile]
/// with an optional [ListTileSeparator] below it.
///
/// Displays a leading [Icon], a text [title], an optional [trailing]
/// widget, and can show or hide the separator via [showSeparator].
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.trailing,
    this.textStyle,
    this.showSeparator = true,
    this.enabled = true,
    this.opacity = 1.0,
    super.key,
  }) : assert(opacity >= 0.0 && opacity <= 1.0, 'opacity must be between 0.0 and 1.0');

  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget? trailing;
  final TextStyle? textStyle;
  final bool showSeparator;
  final VoidCallback onTap;
  final bool enabled;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final tile = Opacity(
      opacity: opacity,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: textStyle),
        trailing: trailing,
        onTap: onTap,
        enabled: enabled,
      ),
    );

    if (!showSeparator) return tile;

    return Column(mainAxisSize: MainAxisSize.min, children: [tile, const ListTileSeparator()]);
  }
}
