// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class TileMenuButton extends StatelessWidget {
  const TileMenuButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface.withAlpha(1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.more_vert, size: 20, color: themeData.textTheme.labelMedium?.color),
      ),
    );
  }
}

List<PopupMenuEntry<dynamic>> buildNumberActions(
  BuildContext context, {
  required List<String> callNumbers,
  VoidCallback? onAudioCallPressed,
  VoidCallback? onVideoCallPressed,
  VoidCallback? onTransferPressed,
  VoidCallback? onChatPressed,
  VoidCallback? onSendSmsPressed,
  VoidCallback? onViewContactPressed,
  VoidCallback? onCallLogPressed,
  void Function(String)? onCallFrom,
  String? copyNumber,
  String? copyCallId,
  VoidCallback? onDelete,
}) {
  final l10n = context.l10n;
  return [
    if (onAudioCallPressed != null) PopupMenuItem(onTap: onAudioCallPressed, child: Text(l10n.numberActions_audioCall)),
    if (onVideoCallPressed != null) PopupMenuItem(onTap: onVideoCallPressed, child: Text(l10n.numberActions_videoCall)),
    if (callNumbers.length > 1 && onCallFrom != null)
      for (final number in callNumbers)
        PopupMenuItem(onTap: () => onCallFrom.call(number), child: Text(l10n.numberActions_callFrom(number))),
    if (onTransferPressed != null) PopupMenuItem(onTap: onTransferPressed, child: Text(l10n.numberActions_transfer)),
    if (onChatPressed != null) PopupMenuItem(onTap: onChatPressed, child: Text(l10n.numberActions_chat)),
    if (onSendSmsPressed != null) PopupMenuItem(onTap: onSendSmsPressed, child: Text(l10n.numberActions_sendSms)),
    if (onViewContactPressed != null)
      PopupMenuItem(onTap: onViewContactPressed, child: Text(l10n.numberActions_viewContact)),
    if (onCallLogPressed != null) PopupMenuItem(onTap: onCallLogPressed, child: Text(l10n.numberActions_callLog)),
    if (copyNumber != null)
      PopupMenuItem(
        onTap: () => Clipboard.setData(ClipboardData(text: copyNumber)),
        child: Text(l10n.numberActions_copyNumber),
      ),
    if (copyCallId != null)
      PopupMenuItem(
        onTap: () => Clipboard.setData(ClipboardData(text: copyCallId)),
        child: Text(l10n.numberActions_copyCallId),
      ),
    if (onDelete != null) PopupMenuItem(onTap: onDelete, child: Text(l10n.numberActions_delete)),
  ];
}

class CallTileActionsBar extends StatelessWidget {
  const CallTileActionsBar({
    super.key,
    this.onVideoCallPressed,
    this.onChatPressed,
    this.onCallLogPressed,
    this.onViewContactPressed,
    required this.onMorePressed,
  });

  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallLogPressed;
  final VoidCallback? onViewContactPressed;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        if (onVideoCallPressed != null)
          Expanded(
            child: _CallTileAction(
              icon: Icons.videocam_outlined,
              label: l10n.numberActions_videoCall,
              onTap: onVideoCallPressed!,
            ),
          ),
        if (onChatPressed != null)
          Expanded(
            child: _CallTileAction(
              icon: Icons.chat_outlined,
              label: l10n.callTileActions_message,
              onTap: onChatPressed!,
            ),
          ),
        if (onCallLogPressed != null)
          Expanded(
            child: _CallTileAction(icon: Icons.history, label: l10n.callTileActions_history, onTap: onCallLogPressed!),
          ),
        if (onViewContactPressed != null)
          Expanded(
            child: _CallTileAction(
              icon: Icons.person_outline,
              label: l10n.callTileActions_contact,
              onTap: onViewContactPressed!,
            ),
          ),
        if (onMorePressed != null)
          Expanded(
            child: _CallTileAction(icon: Icons.more_horiz, label: l10n.callTileActions_more, onTap: onMorePressed!),
          ),
      ],
    );
  }
}

class _CallTileAction extends StatelessWidget {
  const _CallTileAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: themeData.colorScheme.primary),
            const SizedBox(height: 2),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: themeData.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class CallTile extends StatefulWidget {
  const CallTile({
    super.key,
    required this.leading,
    required this.name,
    this.subName,
    this.subtitleLeading,
    this.timeLabel,
    this.durationLabel,
    this.disconnectReason,
    this.onTap,
    this.expanded = false,
    this.onDialPressed,
    this.gesturesEnabled = true,
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
  final String? timeLabel;
  final String? durationLabel;
  final String? disconnectReason;
  final VoidCallback? onTap;
  final bool expanded;
  final VoidCallback? onDialPressed;
  final bool gesturesEnabled;

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

  /// Mirrors the gating of [buildNumberActions] so menu affordances (the
  /// trailing button and the More action) are hidden when the menu is empty.
  bool get hasMenuActions =>
      widget.onAudioCallPressed != null ||
      widget.onVideoCallPressed != null ||
      (widget.callNumbers.length > 1 && widget.onCallFrom != null) ||
      widget.onTransferPressed != null ||
      widget.onChatPressed != null ||
      widget.onSendSmsPressed != null ||
      widget.onViewContactPressed != null ||
      widget.onCallLogPressed != null ||
      widget.copyNumber != null ||
      widget.copyCallId != null ||
      widget.onDelete != null;

  void showMenuPopup() {
    final items = buildNumberActions(
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
    );
    if (items.isEmpty) return;

    showMenu(context: context, position: getPosition(), items: items);
  }

  RelativeRect getPosition() {
    final RenderBox renderBox = tileKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    return RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset(renderBox.size.width, 0), ancestor: overlay),
        renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero), ancestor: overlay),
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
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: colorScheme.secondary.withAlpha(50),
          key: tileKey,
          onTap: widget.gesturesEnabled ? widget.onTap : null,
          onLongPress: widget.gesturesEnabled ? showMenuPopup : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    widget.leading,
                    const SizedBox(width: 8),
                    Expanded(child: contentColumn),
                    if (widget.timeLabel != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.timeLabel!, style: themeData.textTheme.labelSmall),
                          if (widget.durationLabel != null) ...[
                            const SizedBox(height: 2),
                            Text(widget.durationLabel!, style: themeData.textTheme.labelSmall),
                          ],
                        ],
                      ),
                    const SizedBox(width: 4),
                    if (widget.gesturesEnabled)
                      if (widget.onDialPressed != null)
                        IconButton(
                          onPressed: widget.onDialPressed,
                          icon: Icon(Icons.call, color: colorScheme.primary),
                        )
                      else if (hasMenuActions)
                        TileMenuButton(onTap: showMenuPopup),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: widget.expanded && widget.gesturesEnabled
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8),
                          child: CallTileActionsBar(
                            onVideoCallPressed: widget.onVideoCallPressed,
                            onChatPressed: widget.onChatPressed,
                            onCallLogPressed: widget.onCallLogPressed,
                            onViewContactPressed: widget.onViewContactPressed,
                            onMorePressed: hasMenuActions ? showMenuPopup : null,
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
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
