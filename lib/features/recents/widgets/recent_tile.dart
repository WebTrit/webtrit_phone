// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recents.dart';

class RecentTile extends StatefulWidget {
  const RecentTile({
    super.key,
    required this.recent,
    required this.callNumbers,
    this.dateFormat,
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
  final DateFormat? dateFormat;
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
  State<RecentTile> createState() => _RecentTileState();
}

class _RecentTileState extends State<RecentTile> {
  late final tileKey = GlobalKey();
  late final dateFormat = widget.dateFormat ?? DateFormat();
  late final callLogEntry = widget.recent.callLogEntry;
  late final contact = widget.recent.contact;
  late final callNumber = callLogEntry.number;

  List<PopupMenuEntry> get actions => [
        if (widget.onAudioCallPressed != null)
          PopupMenuItem(
            onTap: widget.onAudioCallPressed,
            child: Text(context.l10n.numberActions_audioCall),
          ),
        if (widget.onVideoCallPressed != null)
          PopupMenuItem(
            onTap: widget.onVideoCallPressed,
            child: Text(context.l10n.numberActions_videoCall),
          ),
        if (widget.callNumbers.length > 1)
          for (final number in widget.callNumbers)
            PopupMenuItem(
              onTap: () => widget.onCallFrom?.call(number),
              child: Text(context.l10n.numberActions_callFrom(number)),
            ),
        if (widget.onTransferPressed != null)
          PopupMenuItem(
            onTap: widget.onTransferPressed,
            child: Text(context.l10n.numberActions_transfer),
          ),
        if (widget.onChatPressed != null)
          PopupMenuItem(
            onTap: widget.onChatPressed,
            child: Text(context.l10n.numberActions_chat),
          ),
        if (widget.onSendSmsPressed != null)
          PopupMenuItem(
            onTap: widget.onSendSmsPressed,
            child: Text(context.l10n.numberActions_sendSms),
          ),
        if (widget.onViewContactPressed != null)
          PopupMenuItem(
            onTap: widget.onViewContactPressed,
            child: Text(context.l10n.numberActions_viewContact),
          ),
        if (widget.onCallLogPressed != null)
          PopupMenuItem(
            onTap: widget.onCallLogPressed,
            child: Text(context.l10n.numberActions_callLog),
          ),
        PopupMenuItem(
          onTap: () {
            Clipboard.setData(ClipboardData(text: callNumber));
          },
          child: Text(context.l10n.numberActions_copyNumber),
        ),
        if (widget.onDelete != null)
          PopupMenuItem(
            onTap: widget.onDelete,
            child: Text(context.l10n.numberActions_delete),
          ),
      ];

  void onLongPress() {
    final position = getPosition();
    showMenu(context: context, position: position, items: actions);
  }

  RelativeRect getPosition() {
    final RenderBox renderBox = tileKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final screenSize = MediaQuery.of(context).size;
    late Offset offset = Offset(screenSize.width - 16, 16);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(offset, ancestor: overlay),
        renderBox.localToGlobal(renderBox.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final presenceSource = PresenceViewParams.of(context).viewSource;

    return Dismissible(
      key: ObjectKey(widget.recent),
      background: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete_outline),
        ),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.recents_DeleteConfirmDialog_title,
        content: context.l10n.recents_DeleteConfirmDialog_content,
      ),
      onDismissed: widget.onDelete == null ? null : (direction) => widget.onDelete!(),
      direction: DismissDirection.endToStart,
      child: ListTile(
        key: tileKey,
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        leading: LeadingAvatar(
          username: widget.recent.name,
          thumbnail: contact?.thumbnail,
          thumbnailUrl: contact?.thumbnailUrl,
          registered: contact?.registered,
          presenceInfo: contact?.presenceInfo,
        ),
        trailing: Text(
          dateFormat.format(callLogEntry.createdTime),
          style: themeData.textTheme.bodySmall,
        ),
        title: Text(
          switch (presenceSource) {
            PresenceViewSource.sipPresence => '${widget.recent.name} ${contact?.presenceInfo.primaryStatusIcon ?? ''}',
            PresenceViewSource.contactInfo => widget.recent.name,
          },
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
                callNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: widget.onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
