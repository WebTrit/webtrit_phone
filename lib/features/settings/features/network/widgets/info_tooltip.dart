import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

class InfoTooltip extends StatelessWidget {
  const InfoTooltip({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      padding: kAllPadding16,
      margin: kAllPadding16,
      showDuration: const Duration(seconds: 10),
      child: IconButton(
        icon: Icon(Icons.info_outline, color: colorScheme.onSurfaceVariant),
        onPressed: null,
      ),
    );
  }
}
