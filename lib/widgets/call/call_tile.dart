// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/call/number_actions.dart';

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

class CallTileActionsBar extends StatelessWidget {
  const CallTileActionsBar({super.key, required this.actions, this.onMorePressed});

  /// Primary actions to render inline (see [NumberAction.primary]).
  final List<NumberAction> actions;

  /// Opens the overflow menu with the remaining actions; hidden when null.
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        for (final action in actions)
          Expanded(
            child: _CallTileAction(icon: action.icon, label: action.label, onTap: action.onTap),
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
    this.dialIcon,
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
  final IconData? dialIcon;
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

  List<NumberAction> buildActions() => buildNumberActions(
    context,
    callNumbers: widget.callNumbers,
    onAudioCallPressed: widget.onAudioCallPressed,
    onVideoCallPressed: widget.onVideoCallPressed,
    onChatPressed: widget.onChatPressed,
    onCallLogPressed: widget.onCallLogPressed,
    onViewContactPressed: widget.onViewContactPressed,
    onTransferPressed: widget.onTransferPressed,
    onSendSmsPressed: widget.onSendSmsPressed,
    onCallFrom: widget.onCallFrom,
    copyNumber: widget.copyNumber,
    copyCallId: widget.copyCallId,
    onDelete: widget.onDelete,
  );

  /// Shows the popup menu. When [overflowOnly] is set, the primary actions that
  /// already sit in the inline bar are filtered out, so the "More" menu never
  /// repeats them. The collapsed-row affordances (long press, trailing button)
  /// pass the full set instead.
  void showMenuPopup({bool overflowOnly = false}) {
    var actions = buildActions();
    if (overflowOnly) actions = actions.where((action) => !action.primary).toList();
    final items = numberActionsToMenu(actions);
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

    final actions = buildActions();
    final primaryActions = actions.where((action) => action.primary).toList();
    final hasOverflowActions = actions.any((action) => !action.primary);

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
          onLongPress: widget.gesturesEnabled ? () => showMenuPopup() : null,
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
                          icon: Icon(widget.dialIcon ?? Icons.call, color: colorScheme.primary),
                        )
                      else if (actions.isNotEmpty)
                        TileMenuButton(onTap: () => showMenuPopup()),
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
                            actions: primaryActions,
                            onMorePressed: hasOverflowActions ? () => showMenuPopup(overflowOnly: true) : null,
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
