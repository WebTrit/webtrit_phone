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
    this.trailingLabel,
    this.textStyle,
    this.showSeparator = true,
    this.separatorColor,
    this.enabled = true,
    this.opacity = 1.0,
    super.key,
  }) : assert(opacity >= 0.0 && opacity <= 1.0, 'opacity must be between 0.0 and 1.0');

  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget? trailing;

  /// What a badge in [trailing] stands for, spoken after the row's title.
  ///
  /// A tile merges into a single node whose name is assembled in the order its
  /// parts are drawn, and the trailing slot is drawn last - which is what puts
  /// this behind the title instead of ahead of it. Anything the trailing widget
  /// draws by itself would be read out inside the title.
  final String? trailingLabel;

  final TextStyle? textStyle;
  final bool showSeparator;
  final Color? separatorColor;
  final VoidCallback onTap;
  final bool enabled;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final trailingLabel = this.trailingLabel;
    final trailing = this.trailing;

    // On the trailing widget rather than around the tile: a name given to the
    // tile itself would be assembled before everything the tile draws, and so
    // spoken ahead of the title it is meant to follow.
    final spokenTrailing = trailingLabel == null || trailing == null
        ? trailing
        : Semantics(label: trailingLabel, child: trailing);

    final tile = Opacity(
      opacity: opacity,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: textStyle),
        trailing: spokenTrailing,
        onTap: onTap,
        enabled: enabled,
      ),
    );

    if (!showSeparator) return tile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tile,
        ListTileSeparator(color: separatorColor),
      ],
    );
  }
}
