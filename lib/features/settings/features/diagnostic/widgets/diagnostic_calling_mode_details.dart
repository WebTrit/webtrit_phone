import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Bottom sheet explaining the limited standalone call mode and its limitations.
class DiagnosticCallingModeDetails extends StatelessWidget {
  const DiagnosticCallingModeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // TODO(Serdun): Move to color scheme
    const statusColor = Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(context.l10n.diagnostic_callingMode_tile_title),
            subtitle: Text(context.l10n.diagnostic_callingMode_standalone_description),
          ),
          ListTile(
            title: Text(context.l10n.diagnosticPermissionDetails_title_statusPermission),
            subtitle: Text(
              context.l10n.diagnostic_callingMode_standalone_title,
              style: textTheme.bodyMedium?.copyWith(color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
