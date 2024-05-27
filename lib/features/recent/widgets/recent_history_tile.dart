import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recent.dart';

class RecentHistoryTile extends StatelessWidget {
  const RecentHistoryTile({
    super.key,
    required this.recent,
    this.dateFormat,
    this.onDeleted,
  });

  final Recent recent;
  final DateFormat? dateFormat;
  final void Function(Recent)? onDeleted;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final onDeleted = this.onDeleted;
    final dateFormat = this.dateFormat ?? DateFormat();

    return Dismissible(
      key: ObjectKey(recent),
      background: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
          ),
        ),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.recents_DeleteConfirmDialog_title,
        content: context.l10n.recents_DeleteConfirmDialog_content,
      ),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(recent),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        title: Text(
          dateFormat.format(recent.createdTime),
        ),
        subtitle: Row(
          children: [
            Icon(
              recent.direction.icon(recent.isComplete),
              size: 16,
              color: recent.isComplete
                  ? (recent.direction == Direction.incoming ? Colors.blue : Colors.green)
                  : Colors.red,
            ),
            const Text(' · '),
            Icon(
              recent.video ? Icons.videocam : Icons.call,
              size: 16,
              color: Colors.grey,
            ),
            const Text(' · '),
            Text(
              recent.isComplete ? _formatDuration(recent.duration!) : 'Missed',
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
