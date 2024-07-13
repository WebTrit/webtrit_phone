import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/features/call/widgets/popup_menu.dart';
import 'package:webtrit_phone/features/features.dart';
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

  Future<ChatMessage?> fetchMessage(int id) async {
    return await chatsRepository.getMessageById(id);
  }

  @override
  Widget build(BuildContext context) {
    ChatMessage? realMessage;
    if (widget.message.metadata != null && widget.message.metadata!.containsKey('message')) {
      realMessage = widget.message.metadata!['message'] as ChatMessage;
    }

    final isEdited = widget.message.metadata != null && widget.message.metadata!['edited'] == true;
    final isDeleted = widget.message.metadata != null && widget.message.metadata!['deleted'] == true;
    final isSended = realMessage?.id != null;
    final isMine = realMessage == null || realMessage.senderId == widget.userId;
    final isForwarded = realMessage?.forwardFromId != null && realMessage?.authorId != null;
    final isReply = realMessage?.replyToId != null;

    return CallPopupMenuButton(
      items: [
        if (isSended && !isDeleted)
          CallPopupMenuItem(
            text: 'Reply',
            icon: const Icon(Icons.reply),
            onTap: () => widget.handleSetForReply(realMessage!),
          ),
        if (isSended && !isDeleted)
          CallPopupMenuItem(
            text: 'Forward',
            icon: const Icon(Icons.forward),
            onTap: () => widget.handleSetForForward(realMessage!),
          ),
        if (isMine && isSended && !isForwarded && !isDeleted)
          CallPopupMenuItem(
            text: 'Edit',
            icon: const Icon(Icons.edit),
            onTap: () => widget.handleSetForEdit(realMessage!),
          ),
        if (isMine && isSended && !isDeleted)
          CallPopupMenuItem(
            text: 'Delete',
            icon: const Icon(Icons.remove),
            onTap: () => widget.handleDelete(realMessage!),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isReply) ...[
              replySegment(realMessage!),
              const SizedBox(height: 8),
            ],
            if (isForwarded) ...[
              forwardSegment(realMessage!),
              const SizedBox(height: 8),
              const Text('[forwarded]', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (!isForwarded)
              TextMessage(
                emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
                hideBackgroundOnEmojiMessages: false,
                message: messageWithPreview(widget.message),
                showName: !isMine,
                usePreviewData: true,
                onPreviewDataFetched: handlePreviewDataFetched,
                options: const TextMessageOptions(isTextSelectable: false),
              ),
            if (isEdited) ...[
              const SizedBox(height: 8),
              const Text('[edited]', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }

  Widget replySegment(ChatMessage realMessage) {
    return FutureBuilder(
        future: fetchMessage(realMessage.replyToId!),
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
              emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
              hideBackgroundOnEmojiMessages: false,
              message: messageWithPreview(textMessage),
              showName: true,
              usePreviewData: true,
              onPreviewDataFetched: handlePreviewDataFetched,
              options: const TextMessageOptions(isTextSelectable: false),
            ),
          );
        });
  }

  Widget forwardSegment(ChatMessage msg) {
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
        emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
        hideBackgroundOnEmojiMessages: false,
        message: messageWithPreview(textMessage),
        showName: true,
        usePreviewData: true,
        onPreviewDataFetched: handlePreviewDataFetched,
        options: const TextMessageOptions(isTextSelectable: false),
      ),
    );
  }
}
