import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/localization.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recents.dart';

class RecentTile extends StatelessWidget {
  const RecentTile({
    super.key,
    required this.recent,
    this.onTap,
    this.onLongPress,
    this.onInfoPressed,
    this.onDeleted,
  });

  final Recent recent;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onInfoPressed;
  final void Function(Recent)? onDeleted;

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
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.recents_DeleteConfirmDialog_title,
        content: context.l10n.recents_DeleteConfirmDialog_content,
      ),
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
              onPressed: onInfoPressed,
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
}
