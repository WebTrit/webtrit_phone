import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/dialog_info.dart';

class DialogsInfoView extends StatefulWidget {
  const DialogsInfoView({required this.dialogInfo, super.key});

  final List<DialogInfo> dialogInfo;

  @override
  State<DialogsInfoView> createState() => _DialogsInfoViewState();
}

class _DialogsInfoViewState extends State<DialogsInfoView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Text(
            l10n.contacts_DialogsInfoView_title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          for (final dialogInfo in widget.dialogInfo) callTile(dialogInfo),
        ],
      ),
    );
  }

  Widget callTile(DialogInfo dialog) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final contentColor = colorScheme.onSurface;

    String destination = 'N/A';
    if (dialog.remoteDisplayName != null && dialog.remoteNumber != null) {
      destination = '${dialog.remoteDisplayName} <${dialog.remoteNumber}>';
    } else if (dialog.remoteDisplayName != null) {
      destination = dialog.remoteDisplayName!;
    } else if (dialog.remoteNumber != null) {
      destination = dialog.remoteNumber!;
    }
    return Row(
      children: [
        Stack(
          children: [
            Icon(Icons.call_outlined, size: 16, color: contentColor),
            Positioned(
              right: 1,
              top: 1,
              child: switch (dialog.direction) {
                DialogDirection.initiator => Icon(Icons.call_made, size: 8, color: contentColor),
                DialogDirection.recipient => Icon(Icons.call_received, size: 8, color: contentColor),
                _ => Icon(Icons.phone_in_talk, size: 8, color: contentColor),
              },
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(destination, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 8),
        Text(dialog.arrivalTime.toLocal().toHHmm, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
