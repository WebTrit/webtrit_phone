import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import '../extensions/extensions.dart';

class DiagnosticSpecialPermissionItem extends StatelessWidget {
  const DiagnosticSpecialPermissionItem({super.key, required this.title, required this.status, required this.onTap});

  final String title;
  final CallkeepSpecialPermissionStatus status;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final statusText = status.title(context);
    final statusColor = status.color(context);

    final statusIcon = status == CallkeepSpecialPermissionStatus.granted ? Icons.check_circle : Icons.error_outline;

    return ListTile(
      onTap: onTap.call,
      title: Text(title),
      subtitle: Text(statusText),
      trailing: Icon(statusIcon, color: statusColor),
    );
  }
}
