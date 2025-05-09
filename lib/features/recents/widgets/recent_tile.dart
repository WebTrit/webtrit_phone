import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recents.dart';

class RecentTile extends StatelessWidget {
  const RecentTile({
    super.key,
    required this.recent,
    required this.chatsEnabled,
    this.dateFormat,
    this.onTap,
    this.onLongPress,
    this.onInfoPressed,
    this.onMessagePressed,
    this.onDeleted,
  });

  final Recent recent;
  final bool chatsEnabled;
  final DateFormat? dateFormat;

  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onInfoPressed;
  final GestureTapCallback? onMessagePressed;
  final void Function(Recent)? onDeleted;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final onDeleted = this.onDeleted;
    final dateFormat = this.dateFormat ?? DateFormat();

    final callLogEntry = recent.callLogEntry;
    final contact = recent.contact;

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
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        leading: LeadingAvatar(
          username: recent.name,
          thumbnail: contact?.thumbnail,
          thumbnailUrl: contact?.thumbnailUrl,
          registered: contact?.registered,
        ),
        trailing: GestureDetector(
          onTap: () => debugPrint('obsorbt trailing tap'),
          child: Container(
            height: double.maxFinite,
            color: themeData.colorScheme.surfaceBright.withValues(alpha: 0.1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(dateFormat.format(callLogEntry.createdTime)),
                const SizedBox(width: 4),
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: onInfoPressed,
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.info_outlined),
                  ),
                ),
                if (chatsEnabled)
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: onMessagePressed,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.messenger_outline,
                        color: onMessagePressed == null ? Colors.grey : null,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        title: Text(
          recent.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Icon(
              callLogEntry.direction.icon(callLogEntry.isComplete),
              size: 16,
              color: callLogEntry.isComplete
                  ? (callLogEntry.direction == CallDirection.incoming ? Colors.blue : Colors.green)
                  : Colors.red,
            ),
            const Text(' '),
            Icon(
              callLogEntry.video ? Icons.videocam : Icons.call,
              size: 16,
              color: Colors.grey,
            ),
            const Text(' '),
            Flexible(
              child: Text(
                callLogEntry.number,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
