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
    super.key,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget? trailing;
  final TextStyle? textStyle;
  final bool showSeparator;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: textStyle),
      trailing: trailing,
      onTap: onTap,
    );

    if (!showSeparator) return tile;

    return Column(mainAxisSize: MainAxisSize.min, children: [tile, const ListTileSeparator()]);
  }
}
