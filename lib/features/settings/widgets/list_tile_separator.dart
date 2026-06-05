import 'package:flutter/material.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({super.key, this.color});

  /// Override color for the separator. `null` → theme default (outlineVariant).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(height: 1, indent: 15, endIndent: 15, color: color ?? colorScheme.outlineVariant);
  }
}
