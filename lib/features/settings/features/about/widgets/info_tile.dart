import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveValue = value ?? '-';

    return CopyToClipboard(
      data: effectiveValue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          Text(
            effectiveValue,
            style: themeData.textTheme.labelSmall,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
