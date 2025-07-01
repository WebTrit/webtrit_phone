import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoriteTile extends StatefulWidget {
  const FavoriteTile({
    super.key,
    required this.favorite,
    this.onTap,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onDelete,
  });

  final Favorite favorite;
  final Function()? onTap;
  final Function()? onAudioCallPressed;
  final Function()? onVideoCallPressed;
  final Function()? onTransferPressed;
  final Function()? onChatPressed;
  final Function()? onSendSmsPressed;
  final Function()? onViewContactPressed;
  final Function()? onCallLogPressed;
  final Function()? onDelete;

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  late final tileKey = GlobalKey();
  late final number = widget.favorite.number;

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
            Clipboard.setData(ClipboardData(text: number));
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

    return Dismissible(
      key: ObjectKey(widget.favorite),
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
        title: context.l10n.favorites_DeleteConfirmDialog_title,
        content: context.l10n.favorites_DeleteConfirmDialog_content,
      ),
      onDismissed: widget.onDelete == null ? null : (direction) => widget.onDelete!(),
      direction: DismissDirection.endToStart,
      child: ListTile(
        key: tileKey,
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: LeadingAvatar(
          username: widget.favorite.name,
          thumbnail: widget.favorite.contact.thumbnail,
          thumbnailUrl: widget.favorite.contact.thumbnailUrl,
          registered: widget.favorite.contact.registered,
        ),
        title: Text(widget.favorite.name),
        subtitle: Text('${widget.favorite.label.capitalize}: ${widget.favorite.number}'),
        onTap: widget.onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
