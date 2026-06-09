import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Diagnostic row shown only when the device runs in the limited standalone
/// call mode (no Android Telecom). Warns the user that incoming-call delivery
/// may be delayed; tapping opens the details sheet.
class DiagnosticCallingModeItem extends StatelessWidget {
  const DiagnosticCallingModeItem({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // TODO(Serdun): Move to color scheme
    const statusColor = Colors.orange;

    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.phone_in_talk, color: statusColor),
      title: Text(context.l10n.diagnostic_callingMode_standalone_title),
      subtitle: Text(
        context.l10n.diagnostic_callingMode_standalone_caption,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: statusColor),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
