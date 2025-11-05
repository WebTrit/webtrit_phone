import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';
import '../extensions/extensions.dart';

class DiagnosticPermissionDetails extends StatelessWidget {
  const DiagnosticPermissionDetails({super.key, this.onTap, required this.permissionWithStatus});

  final PermissionWithStatus permissionWithStatus;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final status = permissionWithStatus.status;

    final permissionTitle = permissionWithStatus.permission.title(context);
    final permissionDescription = permissionWithStatus.permission.description(context);
    final statusColor = status.color(context);
    final statusText = permissionWithStatus.status.title(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text(permissionTitle), subtitle: Text(permissionDescription)),
          ListTile(
            title: Text(context.l10n.diagnosticPermissionDetails_title_statusPermission),
            subtitle: Text(statusText, style: textTheme.bodyMedium?.copyWith(color: statusColor)),
          ),
          ListTile(
            title: Text(
              status == PermissionStatus.denied
                  ? context.l10n.diagnosticPermissionDetails_button_requestPermission
                  : context.l10n.diagnosticPermissionDetails_button_managePermission,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
            ),
            trailing: status == PermissionStatus.denied ? null : const Icon(Icons.keyboard_arrow_right),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
