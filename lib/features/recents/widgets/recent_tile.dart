import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recents.dart';

class RecentTile extends StatelessWidget {
  final Recent recent;
  final GestureTapCallback? onInfoTap;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final void Function(Recent)? onDeleted;

  const RecentTile({
    Key? key,
    required this.recent,
    this.onInfoTap,
    this.onTap,
    this.onLongPress,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onDeleted = this.onDeleted;
    return Dismissible(
      key: ObjectKey(recent),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
      confirmDismiss: (direction) => _confirmDelete(context, recent),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(recent),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: LeadingAvatar(
          username: recent.name,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              recent.createdTime.format(context),
            ),
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.info_outlined),
              onPressed: onInfoTap,
            ),
          ],
        ),
        title: Text(
          recent.name,
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
            const Text(' '),
            Icon(
              recent.video ? Icons.videocam : Icons.call,
              size: 16,
              color: Colors.grey,
            ),
            const Text(' '),
            Text(
              recent.number,
            ),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
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
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
