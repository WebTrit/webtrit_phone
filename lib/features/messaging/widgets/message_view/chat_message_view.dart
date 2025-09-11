import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/datetime.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'message_body.dart';

class ChatMessageView extends StatefulWidget {
  const ChatMessageView({
    super.key,
    required this.userId,
    this.message,
    this.outboxMessage,
    this.outboxEditEntry,
    this.outboxDeleteEntry,
    this.userReadedUntil,
    this.membersReadedUntil,
    required this.handleSetForReply,
    required this.handleSetForForward,
    required this.handleSetForEdit,
    required this.handleDelete,
    this.onRendered,
  });

  final String userId;
  final ChatMessage? message;
  final ChatOutboxMessageEntry? outboxMessage;
  final ChatOutboxMessageEditEntry? outboxEditEntry;
  final ChatOutboxMessageDeleteEntry? outboxDeleteEntry;

  /// Timestamp of the last message read by the user
  /// Used to display the read status of the message that user didnt see
  final DateTime? userReadedUntil;

  /// Timestamp of the last message read by the members
  /// Used to display the read status of the message sent by the user
  final DateTime? membersReadedUntil;

  /// Callback function on popup menu reply item selected
  final Function(ChatMessage refMessage) handleSetForReply;

  /// Callback function on popup menu forward item selected
  final Function(ChatMessage refMessage) handleSetForForward;

  /// Callback function on popup menu edit item selected
  final Function(ChatMessage refMessage) handleSetForEdit;

  /// Callback function on popup menu delete item selected
  final Function(ChatMessage refMessage) handleDelete;

  /// Callback function that is called when the message is mounted by flutter framework
  /// using [PostFrameCallback] to ensure that the message is rendered before calling the function
  final Function()? onRendered;

  @override
  State<ChatMessageView> createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
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
    final outboxEditEntry = widget.outboxEditEntry;
    final outboxDeleteEntry = widget.outboxDeleteEntry;
    final userReadedUntil = widget.userReadedUntil;
    final membersReadedUntil = widget.membersReadedUntil;

    final content = outboxEditEntry?.newContent ?? outboxMessage?.content ?? message?.content ?? '';
    final hasContent = (content.isNotEmpty == true) && content != '-';

    final senderId = message?.senderId ?? widget.userId;
    final isMine = senderId == widget.userId;
    final isSended = message != null;
    final isEdited = outboxEditEntry != null || message?.editedAt != null;
    final isDeleted = outboxDeleteEntry != null || message?.deletedAt != null;

    final isForward = message?.forwardFromId != null && message?.authorId != null;
    final isReply = message?.replyToId != null;

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
      if (isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForReply(message),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_reply),
            leading: const Icon(Icons.question_answer_outlined),
            dense: true,
          ),
        ),
      if (isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForForward(message),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_forward),
            leading: const Icon(Icons.forward_outlined),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isForward && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForEdit(message),
          child: ListTile(
            title: Text(context.l10n.messaging_MessageView_edit),
            leading: const Icon(Icons.edit_note_outlined),
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
              ContactInfoBuilder(
                sourceType: ContactSourceType.external,
                sourceId: senderId,
                builder: (context, contact, {required bool loading}) {
                  return LeadingAvatar(
                    username: contact?.displayTitle,
                    thumbnail: contact?.thumbnail,
                    thumbnailUrl: contact?.thumbnailUrl,
                    radius: 20,
                    registered: contact?.registered,
                    presenceInfo: contact?.presenceInfo,
                  );
                },
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
                      ParticipantName(
                        senderId: senderId,
                        userId: widget.userId,
                        key: Key(senderId),
                        style: theme.userNameStyle,
                      ),
                      const SizedBox(height: 4),
                      if (isReply) ...[
                        ReplyQuote(userId: widget.userId, message: message!, isMine: isMine),
                        const SizedBox(height: 4),
                      ],
                      if (isForward) ...[
                        ForwartQuote(context: context, userId: widget.userId, msg: message!, isMine: isMine),
                      ],
                      if (!isForward && !isDeleted) ...[
                        MessageBody(text: content, isMine: isMine, style: theme.contentStyle),
                      ],
                      if (isEdited && !isDeleted) ...[
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(context.l10n.messaging_MessageView_edited, style: theme.subContentStyle),
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
                          if (isMine && isSended == false)
                            CircularProgressTemplate(color: colorScheme.onSurface, size: 12, width: 1),
                          if (isMine && isSended && !isViewedByMembers)
                            Icon(Icons.done, color: colorScheme.tertiary, size: 12),
                          if (isMine && isViewedByMembers) Icon(Icons.done_all, color: colorScheme.tertiary, size: 12),
                          const SizedBox(width: 2),
                          if (message?.createdAt != null) Text(message!.createdAt.toHHmm, style: theme.subContentStyle)
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

class ReplyQuote extends StatefulWidget {
  const ReplyQuote({
    super.key,
    required this.userId,
    required this.message,
    required this.isMine,
  });

  final String userId;
  final ChatMessage message;
  final bool isMine;

  @override
  State<ReplyQuote> createState() => _ReplyQuoteState();
}

class _ReplyQuoteState extends State<ReplyQuote> {
  late final chatsRepository = context.read<ChatsRepository>();
  late final client = context.read<MessagingBloc>().state.client;

  /// Fetch the message from local
  /// If the message is not found in the local storage, it will fetch it from the server
  /// and store it in the local storage silently to other components
  /// to avoid inconsistency if message older than the current chat history
  Future<ChatMessage?> fetchMessage(int msgId, int chatId) async {
    final msg = await chatsRepository.getMessageById(msgId);
    if (msg != null) return msg;

    final channel = client.getChatChannel(chatId);
    if (channel == null) return null;

    final message = await channel.getChatMessage(msgId);
    if (message != null) {
      await chatsRepository.upsertMessage(message, silent: true);
      return message;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
        future: fetchMessage(widget.message.replyToId!, widget.message.chatId),
        builder: (context, snapshot) {
          final message = snapshot.data;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: theme.quoteDecoration(widget.isMine),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (message != null)
                      ParticipantName(
                        senderId: message.senderId,
                        userId: widget.userId,
                        key: Key(message.senderId),
                        style: theme.userNameStyle,
                      )
                    else
                      Text('...', style: theme.userNameStyle),
                    const SizedBox(width: 8),
                    Icon(Icons.reply_outlined, color: theme.contentColor, size: 14),
                  ],
                ),
                const SizedBox(height: 4),
                MessageBody(
                  text: message?.content ?? '...',
                  isMine: widget.isMine,
                  style: theme.contentStyle,
                ),
              ],
            ),
          );
        });
  }
}

class ForwartQuote extends StatelessWidget {
  const ForwartQuote({
    super.key,
    required this.context,
    required this.userId,
    required this.msg,
    required this.isMine,
  });

  final BuildContext context;
  final String userId;
  final ChatMessage msg;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: theme.quoteDecoration(isMine),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: ParticipantName(senderId: msg.authorId!, userId: userId, style: theme.userNameStyle)),
              const SizedBox(width: 8),
              Icon(Icons.forward_outlined, color: theme.contentColor, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          MessageBody(text: msg.content, isMine: isMine, style: theme.contentStyle),
        ],
      ),
    );
  }
}
