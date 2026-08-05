import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';

class DiagnosticXiaomiPermissionDetails extends StatelessWidget {
  const DiagnosticXiaomiPermissionDetails({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    this.onTap,
  });

  final String title;
  final String description;
  final CallkeepSpecialPermissionStatus status;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final statusText = status.title(context);
    final statusColor = status.color(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text(title), subtitle: Text(description)),
          ListTile(
            title: Text(context.l10n.diagnosticPermissionDetails_title_statusPermission),
            subtitle: Text(statusText, style: textTheme.bodyMedium?.copyWith(color: statusColor)),
          ),
          ListTile(
            title: Text(
              context.l10n.diagnosticPermissionDetails_button_managePermission,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
            ),
            subtitle: Text(context.l10n.diagnostic_xiaomi_navigate_section, style: textTheme.bodySmall),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
