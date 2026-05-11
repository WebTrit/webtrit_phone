// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'number_actions.dart';
import 'tile_menu_button.dart';

class CallTile extends StatefulWidget {
  const CallTile({
    super.key,
    required this.leading,
    required this.name,
    this.subName,
    this.subtitleLeading,
    required this.timeLabel,
    this.durationLabel,
    this.disconnectReason,
    this.onTap,
    this.dismissible = false,
    this.dismissibleObject,
    this.dismissBackground,
    this.confirmDismiss,
    this.onDismiss,
    required this.callNumbers,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onCallFrom,
    this.copyNumber,
    this.copyCallId,
    this.onDelete,
  });

  final Widget leading;
  final String name;
  final String? subName;
  final Widget? subtitleLeading;
  final String timeLabel;
  final String? durationLabel;
  final String? disconnectReason;
  final VoidCallback? onTap;

  final bool dismissible;
  final Object? dismissibleObject;
  final Widget? dismissBackground;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final VoidCallback? onDismiss;

  final List<String> callNumbers;
  final VoidCallback? onAudioCallPressed;
  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onChatPressed;
  final VoidCallback? onSendSmsPressed;
  final VoidCallback? onViewContactPressed;
  final VoidCallback? onCallLogPressed;
  final void Function(String)? onCallFrom;
  final String? copyNumber;
  final String? copyCallId;
  final VoidCallback? onDelete;

  @override
  State<CallTile> createState() => _CallTileState();
}

class _CallTileState extends State<CallTile> {
  late final tileKey = GlobalKey();

  void showMenuPopup() {
    showMenu(
      context: context,
      position: getPosition(),
      items: buildNumberActions(
        context,
        callNumbers: widget.callNumbers,
        onAudioCallPressed: widget.onAudioCallPressed,
        onVideoCallPressed: widget.onVideoCallPressed,
        onTransferPressed: widget.onTransferPressed,
        onChatPressed: widget.onChatPressed,
        onSendSmsPressed: widget.onSendSmsPressed,
        onViewContactPressed: widget.onViewContactPressed,
        onCallLogPressed: widget.onCallLogPressed,
        onCallFrom: widget.onCallFrom,
        copyNumber: widget.copyNumber,
        copyCallId: widget.copyCallId,
        onDelete: widget.onDelete,
      ),
    );
  }

  RelativeRect getPosition() {
    final RenderBox renderBox = tileKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final screenSize = MediaQuery.of(context).size;
    final offset = Offset(screenSize.width - 16, 16);
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
    final colorScheme = themeData.colorScheme;

    final nameText = Text(
      widget.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: themeData.textTheme.titleMedium,
    );

    final subNameText = widget.subName != null
        ? Text(
            widget.subName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.labelSmall,
            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
          )
        : null;

    final disconnectText = widget.disconnectReason != null
        ? Text(
            widget.disconnectReason!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.labelSmall,
          )
        : null;

    Widget subtitleRow(Widget content) => Row(
      children: [
        if (widget.subtitleLeading != null) ...[widget.subtitleLeading!, const SizedBox(width: 4)],
        Flexible(child: content),
      ],
    );

    final contentColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (subNameText != null) ...[
          nameText,
          subtitleRow(subNameText),
          if (disconnectText != null) ...[const SizedBox(height: 2), disconnectText],
        ] else if (disconnectText == null) ...[
          subtitleRow(nameText),
        ] else ...[
          nameText,
          subtitleRow(disconnectText),
        ],
      ],
    );

    final tile = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: colorScheme.surface.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: colorScheme.secondary.withAlpha(50),
          key: tileKey,
          onTap: widget.onTap,
          onLongPress: showMenuPopup,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
            child: Row(
              children: [
                widget.leading,
                const SizedBox(width: 8),
                Expanded(child: contentColumn),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.timeLabel, style: themeData.textTheme.labelSmall),
                    if (widget.durationLabel != null) ...[
                      const SizedBox(height: 2),
                      Text(widget.durationLabel!, style: themeData.textTheme.labelSmall),
                    ],
                  ],
                ),
                const SizedBox(width: 4),
                TileMenuButton(onTap: showMenuPopup),
              ],
            ),
          ),
        ),
      ),
    );

    if (!widget.dismissible) return tile;

    return Dismissible(
      key: ObjectKey(widget.dismissibleObject ?? this),
      background: widget.dismissBackground,
      confirmDismiss: widget.confirmDismiss,
      onDismissed: widget.onDismiss == null ? null : (_) => widget.onDismiss!(),
      direction: DismissDirection.endToStart,
      child: tile,
    );
  }
}
