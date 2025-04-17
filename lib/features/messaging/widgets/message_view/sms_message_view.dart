import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/extensions/datetime.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'message_body.dart';

class SmsMessageView extends StatefulWidget {
  const SmsMessageView({
    super.key,
    required this.userNumber,
    this.message,
    this.outboxMessage,
    this.outboxDeleteEntry,
    this.userReadedUntil,
    this.membersReadedUntil,
    required this.handleDelete,
    required this.handleResend,
    required this.handleDeleteOutboxMessage,
    this.onRendered,
  });

  final String? userNumber;
  final SmsMessage? message;
  final SmsOutboxMessageEntry? outboxMessage;
  final SmsOutboxMessageDeleteEntry? outboxDeleteEntry;

  /// Timestamp of the last message read by the user
  /// Used to display the read status of the message that user didnt see
  final DateTime? userReadedUntil;

  /// Timestamp of the last message read by the members
  /// Used to display the read status of the message sent by the user
  final DateTime? membersReadedUntil;

  /// Callback function on popup menu delete item selected
  final Function(SmsMessage refMessage) handleDelete;

  /// Callback function on popup menu resend item selected
  final Function(SmsOutboxMessageEntry refMessage) handleResend;

  /// Callback function on popup menu delete item selected
  final Function(SmsOutboxMessageEntry refMessage) handleDeleteOutboxMessage;

  /// Callback function that is called when the message is mounted by flutter framework
  /// using [PostFrameCallback] to ensure that the message is rendered before calling the function
  final Function()? onRendered;

  @override
  State<SmsMessageView> createState() => _SmsMessageViewState();
}

class _SmsMessageViewState extends State<SmsMessageView> {
  // Key to get the position of the message body to show the popup menu
  late final bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Call the onRendered callback after the message is mounted by flutter framework
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onRendered?.call());
  }

  // Get the position of the message body on the screen overlay to show the popup menu
  RelativeRect getPosition(bool isMine) {
    final RenderBox renderBox = bodyKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = const Offset(0, 0);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(offset, ancestor: overlay),
        isMine
            ? renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero) + offset, ancestor: overlay)
            : renderBox.localToGlobal(renderBox.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final message = widget.message;
    final outboxMessage = widget.outboxMessage;
    final outboxDeleteEntry = widget.outboxDeleteEntry;
    final userReadedUntil = widget.userReadedUntil;
    final membersReadedUntil = widget.membersReadedUntil;

    final content = outboxMessage?.content ?? message?.content ?? '';
    final hasContent = (content.isNotEmpty == true) && content != '-';

    final senderNumber = message?.fromPhoneNumber ?? widget.userNumber;
    final isMine = senderNumber == widget.userNumber;
    final isSended = message != null;
    final sendingFailure = outboxMessage?.failureCode;
    final isDeleted = outboxDeleteEntry != null || message?.deletedAt != null;

    var isViewedByMembers = false;
    var isViewedByUser = false;

    if (isSended && membersReadedUntil != null) isViewedByMembers = !message.createdAt.isAfter(membersReadedUntil);
    if (isSended && userReadedUntil != null) isViewedByUser = !message.createdAt.isAfter(userReadedUntil);

    final popupItems = [
      if (hasContent)
        PopupMenuItem(
          onTap: () => Clipboard.setData(ClipboardData(text: message!.content)),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_textcopy),
            leading: const Icon(Icons.copy_rounded),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleDelete(message),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_delete),
            leading: const Icon(Icons.remove),
            dense: true,
          ),
        ),
      if (sendingFailure != null)
        PopupMenuItem(
          onTap: () => widget.handleResend(outboxMessage!),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_resend),
            leading: const Icon(Icons.refresh_rounded),
            dense: true,
          ),
        ),
      if (isMine && isSended == false)
        PopupMenuItem(
          onTap: () => widget.handleDeleteOutboxMessage(outboxMessage!),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_delete),
            leading: const Icon(Icons.remove),
            dense: true,
          ),
        ),
    ];

    return GestureDetector(
      onLongPress: () async {
        // Dismiss keyboard if it's open and wait for it to close before showing the popup
        // to keep the popup in the right position
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 400));
          if (!mounted) return;
        }

        // Check if has any items to show
        if (popupItems.isEmpty) return;

        final position = getPosition(isMine);
        showMenu(context: this.context, position: position, items: popupItems);
      },
      child: Padding(
        padding: isMine
            ? const EdgeInsets.only(left: 48, right: 8, top: 4, bottom: 4)
            : const EdgeInsets.only(left: 8, right: 48, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMine) ...[
              LeadingAvatar(
                username: senderNumber?.substring(senderNumber.length - 2) ?? '',
                radius: 20,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                decoration: theme.messageDecoration(isMine, isViewedByUser),
                padding: const EdgeInsets.all(12),
                child: IntrinsicWidth(
                  child: Column(
                    key: bodyKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(senderNumber ?? '', style: theme.userNameStyle),
                      const SizedBox(height: 4),
                      if (!isDeleted) ...[
                        MessageBody(
                          text: content,
                          isMine: isMine,
                          attachments: message?.attachments ?? [],
                          outgoingAttachments: outboxMessage?.attachments ?? [],
                          style: theme.contentStyle,
                        ),
                      ],
                      if (isDeleted) ...[
                        Text(context.l10n.messaging_MessageView_deleted, style: theme.subContentStyle),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isMine && isSended) ...[
                            Text(message.sendingStatus.nameL10n(context), style: theme.subContentStyle),
                            const SizedBox(width: 2),
                          ],
                          if (isMine && !isSended)
                            if (sendingFailure != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(sendingFailure.l10n(context), style: theme.subContentStyle),
                                  Icon(Icons.warning_rounded, color: colorScheme.error, size: 12),
                                ],
                              )
                            else
                              CircularProgressTemplate(color: colorScheme.onSurface, size: 12, width: 1),
                          if (isMine && isSended && !isViewedByMembers)
                            Icon(Icons.done, color: colorScheme.tertiary, size: 12),
                          if (isMine && isViewedByMembers) Icon(Icons.done_all, color: colorScheme.tertiary, size: 12),
                          const SizedBox(width: 2),
                          if (message?.createdAt != null) Text(message!.createdAt.toHHmm, style: theme.subContentStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
