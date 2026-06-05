import 'package:flutter/material.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(Serdun): move color to style
    // Use outlineVariant (the Material 3 divider role), not surface: surface equals the list
    // background, so the separator was invisible on themes whose surface matches the page.
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(height: 1, indent: 15, endIndent: 15, color: colorScheme.outlineVariant);
  }
}
