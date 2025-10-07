// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import 'package:webtrit_phone/features/recents/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CdrTile extends StatefulWidget {
  const CdrTile({
    super.key,
    required this.cdr,
    this.contact,
    required this.callNumbers,
    this.onTap,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onCallFrom,
  });

  final CdrRecord cdr;
  final Contact? contact;
  final List<String> callNumbers;
  final Function()? onTap;
  final Function()? onAudioCallPressed;
  final Function()? onVideoCallPressed;
  final Function()? onTransferPressed;
  final Function()? onChatPressed;
  final Function()? onSendSmsPressed;
  final Function()? onViewContactPressed;
  final Function()? onCallLogPressed;
  final Function(String)? onCallFrom;

  @override
  State<CdrTile> createState() => _CdrTileState();
}

class _CdrTileState extends State<CdrTile> {
  late final tileKey = GlobalKey();

  CdrRecord get cdr => widget.cdr;
  Contact? get contact => widget.contact;
  String get callNumber => widget.cdr.participant;

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

    return ListTile(
      key: tileKey,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      leading: LeadingAvatar(
        username: contact?.maybeName ?? callNumber,
        thumbnail: contact?.thumbnail,
        thumbnailUrl: contact?.thumbnailUrl,
        registered: contact?.registered,
      ),
      trailing: Column(
        children: [
          Text(
            cdr.connectTime.toLocal().timeOrDate,
            style: themeData.textTheme.bodySmall,
          ),
          const SizedBox(width: 4),
          Text(cdr.duration.format()),
        ],
      ),
      title: Text(
        contact?.maybeName ?? callNumber,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Icon(
            cdr.direction.icon(cdr.status == CdrStatus.accepted),
            size: 16,
            color: cdr.direction == CallDirection.incoming ? Colors.blue : Colors.green,
          ),
          SizedBox(width: 4),
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
    );
  }
}
