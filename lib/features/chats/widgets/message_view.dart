import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
    required this.userId,
    required this.message,
    required this.messageWidth,
    required this.showName,
    required this.handleSetForReply,
    required this.handleSetForForward,
    required this.handleSetForEdit,
    required this.handleDelete,
  });

  final String userId;
  final types.TextMessage message;
  final int messageWidth;
  final bool showName;

  final Function(ChatMessage refMessage) handleSetForReply;
  final Function(ChatMessage refMessage) handleSetForForward;
  final Function(ChatMessage refMessage) handleSetForEdit;
  final Function(ChatMessage refMessage) handleDelete;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final chatsRepository = context.read<ChatsRepository>();
  late final client = context.read<ChatsBloc>().state.client;

  static final previewsCache = LruMap<int, types.PreviewData>(maximumSize: 500);

  void handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
    setState(() => previewsCache[message.text.hashCode] = previewData);
  }

  types.TextMessage messageWithPreview(types.TextMessage message) {
    if (previewsCache.containsKey(message.text.hashCode)) {
      return message.copyWith(previewData: previewsCache[message.text.hashCode]) as types.TextMessage;
    }
    return message;
  }

  Future<ChatMessage?> fetchMessage(int msgId, int chatId) async {
    final msg = await chatsRepository.getMessageById(msgId);
    if (msg != null) return msg;

    final channel = client.getChatChannel(chatId);
    if (channel == null) return null;

    final req = await channel.push('message:get:$msgId', {}).future;
    if (req.isOk) {
      final msg = ChatMessage.fromMap(req.response);
      await chatsRepository.upsertMessage(msg, silent: true);
      return msg;
    }

    return null;
  }

  RelativeRect getPosition(bool isMine) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = Offset(isMine ? -48 : 48, 16);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiMessage = widget.message;
    final chatMessage = widget.message.chatMessage;

    final isEdited = uiMessage.isEdited;
    final isDeleted = uiMessage.isDeleted;
    final isSended = chatMessage?.id != null;
    final isMine = chatMessage == null || chatMessage.senderId == widget.userId;
    final isForward = chatMessage?.forwardFromId != null && chatMessage?.authorId != null;
    final isReply = chatMessage?.replyToId != null;
    final isViewed = chatMessage?.viewedAt != null;

    final senderId = chatMessage?.senderId ?? widget.userId;
    final hasContent = (chatMessage?.content.isNotEmpty == true) && chatMessage?.content != '-';

    final popupItems = [
      if (hasContent)
        MessageMenuItem(
            text: context.l10n.chats_MessageView_textcopy,
            icon: const Icon(Icons.copy_rounded),
            onTap: () => Clipboard.setData(ClipboardData(text: chatMessage!.content))),
      if (isSended && !isDeleted)
        MessageMenuItem(
          text: context.l10n.chats_MessageView_reply,
          icon: const Icon(Icons.question_answer_outlined),
          onTap: () => widget.handleSetForReply(chatMessage!),
        ),
      if (isSended && !isDeleted)
        MessageMenuItem(
          text: context.l10n.chats_MessageView_forward,
          icon: const Icon(Icons.forward_outlined),
          onTap: () => widget.handleSetForForward(chatMessage!),
        ),
      if (isMine && isSended && !isForward && !isDeleted)
        MessageMenuItem(
          text: context.l10n.chats_MessageView_edit,
          icon: const Icon(Icons.edit_note_outlined),
          onTap: () => widget.handleSetForEdit(chatMessage!),
        ),
      if (isMine && isSended && !isDeleted)
        MessageMenuItem(
          text: context.l10n.chats_MessageView_delete,
          icon: const Icon(Icons.remove),
          onTap: () => widget.handleDelete(chatMessage!),
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
      child: Container(
        padding: const EdgeInsets.all(12),
        // 0.01 is for background press recognition
        color: !isViewed ? Colors.blueGrey.withOpacity(0.4) : Colors.blueGrey.withOpacity(0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isReply) ...[
              replyQuote(chatMessage!),
              const SizedBox(height: 8),
            ],
            if (isForward) ...[
              forwardQuote(chatMessage!),
              const SizedBox(height: 8),
              ParticipantName(senderId: senderId, userId: widget.userId),
              Text(context.l10n.chats_MessageView_forwarded, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (!isForward && !isDeleted)
              TextMessage(
                emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
                hideBackgroundOnEmojiMessages: false,
                message: messageWithPreview(uiMessage),
                showName: true,
                usePreviewData: true,
                onPreviewDataFetched: handlePreviewDataFetched,
                options: const TextMessageOptions(isTextSelectable: false),
                nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
              ),
            if (isEdited && !isDeleted) ...[
              Text(context.l10n.chats_MessageView_edited, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (isMine && (chatMessage?.viaSms ?? false) && !isDeleted) ...[
              const Text('[sms]', style: TextStyle(color: Colors.white, fontSize: 12)),
              if (chatMessage?.smsOutState != null)
                Text('[${chatMessage?.smsOutState?.name}]', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (isDeleted) ...[
              ParticipantName(senderId: senderId, userId: widget.userId),
              Text(context.l10n.chats_MessageView_deleted, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (chatMessage?.viewedAt != null && isMine) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_red_eye_outlined, color: Colors.blue[200], size: 10),
                  const SizedBox(width: 4),
                  if (chatMessage?.viewedAt != null)
                    Text(
                      DateFormat('HH:mm').format(chatMessage!.viewedAt!),
                      style: TextStyle(color: Colors.blue[200], fontSize: 10),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget replyQuote(ChatMessage chatMessage) {
    return FutureBuilder(
        future: fetchMessage(chatMessage.replyToId!, chatMessage.chatId),
        builder: (context, snapshot) {
          final msg = snapshot.data;

          final textMessage = types.TextMessage(
            author: types.User(id: msg?.senderId ?? '-1', firstName: msg?.senderId ?? 'loading...'),
            id: msg?.idKey ?? '-1',
            remoteId: msg?.id.toString(),
            text: msg?.content ?? 'loading...',
            showStatus: false,
            createdAt: msg?.createdAt.millisecondsSinceEpoch,
          );

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 32,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextMessage(
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              hideBackgroundOnEmojiMessages: false,
              message: messageWithPreview(textMessage),
              showName: true,
              usePreviewData: true,
              onPreviewDataFetched: handlePreviewDataFetched,
              options: const TextMessageOptions(isTextSelectable: false),
              nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
            ),
          );
        });
  }

  Widget forwardQuote(ChatMessage msg) {
    final textMessage = types.TextMessage(
      author: types.User(id: msg.authorId!, firstName: msg.authorId),
      id: msg.idKey,
      remoteId: msg.id.toString(),
      text: msg.content,
      showStatus: false,
      createdAt: msg.createdAt.millisecondsSinceEpoch,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 32,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextMessage(
        emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
        hideBackgroundOnEmojiMessages: false,
        message: messageWithPreview(textMessage),
        showName: true,
        usePreviewData: true,
        onPreviewDataFetched: handlePreviewDataFetched,
        options: const TextMessageOptions(isTextSelectable: false),
        nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
      ),
    );
  }
}

class MessageMenuItem extends PopupMenuItem {
  MessageMenuItem({
    super.key,
    super.value,
    super.onTap,
    super.enabled = true,
    super.textStyle,
    required String text,
    required Widget icon,
  }) : super(
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: icon),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(text)),
            ],
          ),
          height: 0,
          padding: EdgeInsets.zero,
        );
}
