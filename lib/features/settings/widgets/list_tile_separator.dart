import 'package:flutter/material.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO(Serdun): move color to style
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(
      height: 1,
      indent: 15,
      endIndent: 15,
      color: colorScheme.surface,
    );
  }
}
