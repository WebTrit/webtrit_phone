import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call_log.dart';

class CallLogHistoryTile extends StatelessWidget {
  const CallLogHistoryTile({super.key, required this.callLogEntry, this.dateFormat, this.onDeleted});

  final CallLogEntry callLogEntry;
  final DateFormat? dateFormat;
  final void Function(CallLogEntry)? onDeleted;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final onDeleted = this.onDeleted;
    final dateFormat = this.dateFormat ?? DateFormat();

    return Dismissible(
      key: ObjectKey(callLogEntry),
      background: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(alignment: Alignment.centerRight, child: Icon(Icons.delete_outline)),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.recents_DeleteConfirmDialog_title,
        content: context.l10n.recents_DeleteConfirmDialog_content,
      ),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(callLogEntry),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        title: Text(dateFormat.format(callLogEntry.createdTime)),
        subtitle: Row(
          children: [
            Icon(
              callLogEntry.direction.icon(callLogEntry.isComplete),
              size: 16,
              color: callLogEntry.isComplete
                  ? (callLogEntry.direction == CallDirection.incoming ? Colors.blue : Colors.green)
                  : Colors.red,
            ),
            const Text(' · '),
            Icon(callLogEntry.video ? Icons.videocam : Icons.call, size: 16, color: Colors.grey),
            const Text(' · '),
            Text(
              callLogEntry.isComplete
                  ? _formatDuration(callLogEntry.duration ?? Duration.zero)
                  : context.l10n.recents_HistoryTile_missedCallText,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return [
      duration.inHours,
      duration.inMinutes,
      duration.inSeconds,
    ].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }
}
