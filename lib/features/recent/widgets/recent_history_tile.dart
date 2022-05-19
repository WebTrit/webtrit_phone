import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/models/models.dart';

import '../recent.dart';

class RecentHistoryTile extends StatelessWidget {
  final Recent recent;
  final void Function(Recent)? onDeleted;

  const RecentHistoryTile({
    Key? key,
    required this.recent,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final onDeleted = this.onDeleted;
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
      confirmDismiss: (direction) => _confirmDelete(context, recent),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(recent),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        title: Text(
          DateFormat.yMMMd().add_jms().format(recent.createdTime),
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

  Future<bool?> _confirmDelete(BuildContext context, Recent recent) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm delete"),
          content: const Text("Are you sure you want to delete current call log?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No".toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text("Yes".toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
