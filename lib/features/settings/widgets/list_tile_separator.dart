import 'package:flutter/material.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({super.key, this.color});

  /// Override color for the separator. `null` → the previous default (`colorScheme.surface`),
  /// so a visible separator is opt-in via a configured color rather than forced on every theme.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(height: 1, indent: 15, endIndent: 15, color: color ?? colorScheme.surface);
  }
}
