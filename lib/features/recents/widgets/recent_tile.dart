import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recents.dart';

class RecentTile extends StatelessWidget {
  const RecentTile({
    super.key,
    required this.recent,
    required this.callNumbers,
    required this.dateFormat,
    this.onTap,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onDelete,
    this.onCallFrom,
  });

  final Recent recent;
  final List<String> callNumbers;
  final DateFormat dateFormat;
  final Function()? onTap;
  final Function()? onAudioCallPressed;
  final Function()? onVideoCallPressed;
  final Function()? onTransferPressed;
  final Function()? onChatPressed;
  final Function()? onSendSmsPressed;
  final Function()? onViewContactPressed;
  final Function()? onCallLogPressed;
  final Function()? onDelete;
  final Function(String)? onCallFrom;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final presenceParams = PresenceViewParams.of(context);
    final callLogEntry = recent.callLogEntry;
    final contact = recent.contact;
    final callNumber = callLogEntry.number;

    final name = switch (presenceParams.hybridPresenceSupport) {
      true => '${recent.name} ${contact?.presenceInfo.primaryStatusIcon ?? ''}',
      false => recent.name,
    };

    final directionIcon = Icon(
      callLogEntry.direction.icon(callLogEntry.isComplete),
      size: 16,
      color: callLogEntry.isComplete
          ? (callLogEntry.direction == CallDirection.incoming ? Colors.blue : Colors.green)
          : Colors.red,
    );

    final videoIcon = Icon(callLogEntry.video ? Icons.videocam : Icons.call, size: 16, color: Colors.grey);

    return CallTile(
      dismissibleObject: recent,
      leading: LeadingAvatar(
        username: recent.name,
        thumbnail: contact?.thumbnail,
        thumbnailUrl: contact?.thumbnailUrl,
        registered: contact?.registered,
        presenceInfo: contact?.presenceInfo,
        dialogInfo: contact?.dialogInfo,
      ),
      name: name,
      subName: callNumber,
      subtitleLeading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [directionIcon, const SizedBox(width: 4), videoIcon],
      ),
      timeLabel: dateFormat.format(callLogEntry.createdTime),
      dismissible: true,
      dismissBackground: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(alignment: Alignment.centerRight, child: Icon(Icons.delete_outline)),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.recents_DeleteConfirmDialog_title,
        content: context.l10n.recents_DeleteConfirmDialog_content,
      ),
      onDismiss: onDelete,
      onTap: onTap,
      callNumbers: callNumbers,
      onAudioCallPressed: onAudioCallPressed,
      onVideoCallPressed: onVideoCallPressed,
      onTransferPressed: onTransferPressed,
      onChatPressed: onChatPressed,
      onSendSmsPressed: onSendSmsPressed,
      onViewContactPressed: onViewContactPressed,
      onCallLogPressed: onCallLogPressed,
      onCallFrom: onCallFrom,
      copyNumber: callNumber,
      onDelete: onDelete,
    );
  }
}
