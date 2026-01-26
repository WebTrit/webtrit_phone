import 'package:flutter/material.dart';

/// A custom implementation of a list tile pattern without Material Design constraints.
class PlainListTile extends StatelessWidget {
  const PlainListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.bottom,
    this.selected = false,
    this.selectedTileColor,
    this.horizontalTitleGap = 0,
    this.contentPadding = EdgeInsets.zero,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// The primary content of the tile.
  final Widget title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget displayed before the title.
  final Widget? leading;

  /// A widget displayed after the title.
  final Widget? trailing;

  /// A widget placed below the main tile row.
  final Widget? bottom;

  /// Whether the tile is currently selected.
  final bool selected;

  /// The background color when [selected] is true.
  final Color? selectedTileColor;

  /// The gap between the [leading] widget and the title.
  final double horizontalTitleGap;

  /// Internal padding for the tile content.
  final EdgeInsetsGeometry contentPadding;

  /// Vertical alignment of the row items.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      color: selected ? selectedTileColor : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              if (leading != null) ...[leading!, SizedBox(width: horizontalTitleGap)],
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextStyle(style: Theme.of(context).textTheme.titleMedium!, child: title),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        DefaultTextStyle(style: Theme.of(context).textTheme.bodySmall!, child: subtitle!),
                      ],
                    ],
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
